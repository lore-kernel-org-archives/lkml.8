Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389CAC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 05:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132AA20663
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 05:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgCRF14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 01:27:56 -0400
Received: from mga17.intel.com ([192.55.52.151]:55088 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbgCRF14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 01:27:56 -0400
IronPort-SDR: zw2HLDlMOcu2DBo3Yy2tZdFq6JirdkSixExbqtuwI08s1f0Tdnom/cV5NFMh5fGur7zgR1K8IU
 LvPhWCY9mIqQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 22:27:56 -0700
IronPort-SDR: uZEuCHI+tEzJyoqs0pj1nsWFmlhiL3CqHyjZh9IskV9mrJQUfPSjNCQIs+AwzKnKtdhWXFt1tu
 TFHnYSwAOQvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,566,1574150400"; 
   d="scan'208";a="263274199"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.140]) ([10.254.212.140])
  by orsmga002.jf.intel.com with ESMTP; 17 Mar 2020 22:27:54 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: silence a RCU-list debugging warning
To:     Qian Cai <cai@lca.pw>, jroedel@suse.de
References: <20200317150326.1659-1-cai@lca.pw>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <36b9e69b-ee3f-c17d-1788-64448ce8bc14@linux.intel.com>
Date:   Wed, 18 Mar 2020 13:27:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200317150326.1659-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/17 23:03, Qian Cai wrote:
> dmar_find_atsr() calls list_for_each_entry_rcu() outside of an RCU read
> side critical section but with dmar_global_lock held. Silence this
> false positive.
> 
>   drivers/iommu/intel-iommu.c:4504 RCU-list traversed in non-reader section!!
>   1 lock held by swapper/0/1:
>   #0: ffffffff9755bee8 (dmar_global_lock){+.+.}, at: intel_iommu_init+0x1a6/0xe19
> 
>   Call Trace:
>    dump_stack+0xa4/0xfe
>    lockdep_rcu_suspicious+0xeb/0xf5
>    dmar_find_atsr+0x1ab/0x1c0
>    dmar_parse_one_atsr+0x64/0x220
>    dmar_walk_remapping_entries+0x130/0x380
>    dmar_table_init+0x166/0x243
>    intel_iommu_init+0x1ab/0xe19
>    pci_iommu_init+0x1a/0x44
>    do_one_initcall+0xae/0x4d0
>    kernel_init_freeable+0x412/0x4c5
>    kernel_init+0x19/0x193
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

How about changing the commit subject to
"iommu/vt-d: Silence RCU-list debugging warning in dmar_find_atsr()"?

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel-iommu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 4be549478691..ef0a5246700e 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -4501,7 +4501,8 @@ static struct dmar_atsr_unit *dmar_find_atsr(struct acpi_dmar_atsr *atsr)
>   	struct dmar_atsr_unit *atsru;
>   	struct acpi_dmar_atsr *tmp;
>   
> -	list_for_each_entry_rcu(atsru, &dmar_atsr_units, list) {
> +	list_for_each_entry_rcu(atsru, &dmar_atsr_units, list,
> +				dmar_rcu_check()) {
>   		tmp = (struct acpi_dmar_atsr *)atsru->hdr;
>   		if (atsr->segment != tmp->segment)
>   			continue;
> 
