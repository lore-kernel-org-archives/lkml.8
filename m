Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBB2C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37ABA2080D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgGQIyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:54:40 -0400
Received: from foss.arm.com ([217.140.110.172]:37186 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgGQIyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:54:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB88B30E;
        Fri, 17 Jul 2020 01:54:39 -0700 (PDT)
Received: from [10.57.35.46] (unknown [10.57.35.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE1A63F718;
        Fri, 17 Jul 2020 01:54:37 -0700 (PDT)
Subject: Re: [PATCH] iommu/arm-smmu-v3: remove the approach of MSI polling for
 CMD SYNC
To:     Barry Song <song.bao.hua@hisilicon.com>, will@kernel.org,
        joro@8bytes.org
Cc:     linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Prime Zeng <prime.zeng@hisilicon.com>
References: <20200716230709.32820-1-song.bao.hua@hisilicon.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <35b54698-bd43-a8fc-00db-94ee0dfc789f@arm.com>
Date:   Fri, 17 Jul 2020 09:54:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716230709.32820-1-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-17 00:07, Barry Song wrote:
> Before commit 587e6c10a7ce ("iommu/arm-smmu-v3: Reduce contention during
> command-queue insertion"), msi polling perhaps performed better since
> it could run outside the spin_lock_irqsave() while the code polling cons
> reg was running in the lock.
> 
> But after the great reorganization of smmu queue, neither of these two
> polling methods are running in a spinlock. And real tests show polling
> cons reg via sev means smaller latency. It is probably because polling
> by msi will ask hardware to write memory but sev polling depends on the
> update of register only.
> 
> Using 16 threads to run netperf on hns3 100G NIC with UDP packet size
> in 32768bytes and set iommu to strict, TX throughput can improve from
> 25227.74Mbps to 27145.59Mbps by this patch. In this case, SMMU is super
> busy as hns3 sends map/unmap requests extremely frequently.

How many different systems and SMMU implementations are those numbers 
representative of? Given that we may have cases where the SMMU can use 
MSIs but can't use SEV, so would have to fall back to inefficient 
busy-polling, I'd be wary of removing this entirely. Allowing particular 
platforms or SMMU implementations to suppress MSI functionality if they 
know for sure it makes sense seems like a safer bet.

Robin.

> Cc: Prime Zeng <prime.zeng@hisilicon.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>   drivers/iommu/arm-smmu-v3.c | 46 +------------------------------------
>   1 file changed, 1 insertion(+), 45 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index f578677a5c41..e55282a636c8 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -964,12 +964,7 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>   		cmd[1] |= FIELD_PREP(CMDQ_PRI_1_RESP, ent->pri.resp);
>   		break;
>   	case CMDQ_OP_CMD_SYNC:
> -		if (ent->sync.msiaddr) {
> -			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_IRQ);
> -			cmd[1] |= ent->sync.msiaddr & CMDQ_SYNC_1_MSIADDR_MASK;
> -		} else {
> -			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
> -		}
> +		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
>   		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH);
>   		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
>   		break;
> @@ -983,21 +978,10 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>   static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
>   					 u32 prod)
>   {
> -	struct arm_smmu_queue *q = &smmu->cmdq.q;
>   	struct arm_smmu_cmdq_ent ent = {
>   		.opcode = CMDQ_OP_CMD_SYNC,
>   	};
>   
> -	/*
> -	 * Beware that Hi16xx adds an extra 32 bits of goodness to its MSI
> -	 * payload, so the write will zero the entire command on that platform.
> -	 */
> -	if (smmu->features & ARM_SMMU_FEAT_MSI &&
> -	    smmu->features & ARM_SMMU_FEAT_COHERENCY) {
> -		ent.sync.msiaddr = q->base_dma + Q_IDX(&q->llq, prod) *
> -				   q->ent_dwords * 8;
> -	}
> -
>   	arm_smmu_cmdq_build_cmd(cmd, &ent);
>   }
>   
> @@ -1251,30 +1235,6 @@ static int arm_smmu_cmdq_poll_until_not_full(struct arm_smmu_device *smmu,
>   	return ret;
>   }
>   
> -/*
> - * Wait until the SMMU signals a CMD_SYNC completion MSI.
> - * Must be called with the cmdq lock held in some capacity.
> - */
> -static int __arm_smmu_cmdq_poll_until_msi(struct arm_smmu_device *smmu,
> -					  struct arm_smmu_ll_queue *llq)
> -{
> -	int ret = 0;
> -	struct arm_smmu_queue_poll qp;
> -	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
> -	u32 *cmd = (u32 *)(Q_ENT(&cmdq->q, llq->prod));
> -
> -	queue_poll_init(smmu, &qp);
> -
> -	/*
> -	 * The MSI won't generate an event, since it's being written back
> -	 * into the command queue.
> -	 */
> -	qp.wfe = false;
> -	smp_cond_load_relaxed(cmd, !VAL || (ret = queue_poll(&qp)));
> -	llq->cons = ret ? llq->prod : queue_inc_prod_n(llq, 1);
> -	return ret;
> -}
> -
>   /*
>    * Wait until the SMMU cons index passes llq->prod.
>    * Must be called with the cmdq lock held in some capacity.
> @@ -1332,10 +1292,6 @@ static int __arm_smmu_cmdq_poll_until_consumed(struct arm_smmu_device *smmu,
>   static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
>   					 struct arm_smmu_ll_queue *llq)
>   {
> -	if (smmu->features & ARM_SMMU_FEAT_MSI &&
> -	    smmu->features & ARM_SMMU_FEAT_COHERENCY)
> -		return __arm_smmu_cmdq_poll_until_msi(smmu, llq);
> -
>   	return __arm_smmu_cmdq_poll_until_consumed(smmu, llq);
>   }
>   
> 
