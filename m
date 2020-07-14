Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4879CC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2550921D7B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="cuuaMK8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgGNJTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:19:40 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:23848 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726431AbgGNJTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:19:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594718379; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=zlrj8wHvZscOUM1wkDSJh1QyspQdZdaCu/BwRVbN4oA=;
 b=cuuaMK8fmGw6GBTgml04qlNn0HanPwOHbl7+3aDl5KJrZUoPlZQsYd64BCikXLrd/+DEP/9R
 5A6J+oZYiYJdHAkho0jhV1xazbPaC5ORCSZl5TelGPl9Monpzq4Q73HHhftW5V2uv9Dkt46G
 8CUKYZiM4hoyoFSLpvvWgMDn75o=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f0d78a3f9ca681bd010a97c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 14 Jul 2020 09:19:31
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7E442C43387; Tue, 14 Jul 2020 09:19:30 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B8FAAC433CA;
        Tue, 14 Jul 2020 09:19:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 14 Jul 2020 17:19:29 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Stanley Chu <stanley.chu@mediatek.com>
Cc:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        avri.altman@wdc.com, alim.akhtar@samsung.com, jejb@linux.ibm.com,
        bvanassche@acm.org, beanhuo@micron.com, asutoshd@codeaurora.org,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kuohong.wang@mediatek.com, peter.wang@mediatek.com,
        chun-hung.wu@mediatek.com, andy.teng@mediatek.com,
        chaotian.jing@mediatek.com, cc.chou@mediatek.com
Subject: Re: [PATCH v1 2/2] scsi: ufs: Fix and simplify setup_xfer_req variant
 operation
In-Reply-To: <20200706060707.32608-3-stanley.chu@mediatek.com>
References: <20200706060707.32608-1-stanley.chu@mediatek.com>
 <20200706060707.32608-3-stanley.chu@mediatek.com>
Message-ID: <74cc1ad32c414762ab5d18ed8b46c26a@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-06 14:07, Stanley Chu wrote:
> Add missing "setup_xfer_req" call in ufshcd_issue_devman_upiu_cmd()
> by ufs-bsg path, and collect all "setup_xfer_req" calls to an unified
> place, i.e., ufshcd_send_command(), to simplify the driver.
> 
> Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>

Reviewed-by: Can Guo <cang@codeaurora.org>

> ---
>  drivers/scsi/ufs/ufshcd.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 71e8d7c782bd..8603b07045a6 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -1925,8 +1925,11 @@ static void
> ufshcd_clk_scaling_update_busy(struct ufs_hba *hba)
>  static inline
>  void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
>  {
> -	hba->lrb[task_tag].issue_time_stamp = ktime_get();
> -	hba->lrb[task_tag].compl_time_stamp = ktime_set(0, 0);
> +	struct ufshcd_lrb *lrbp = &hba->lrb[task_tag];
> +
> +	lrbp->issue_time_stamp = ktime_get();
> +	lrbp->compl_time_stamp = ktime_set(0, 0);
> +	ufshcd_vops_setup_xfer_req(hba, task_tag, (lrbp->cmd ? true : 
> false));
>  	ufshcd_add_command_trace(hba, task_tag, "send");
>  	ufshcd_clk_scaling_start_busy(hba);
>  	__set_bit(task_tag, &hba->outstanding_reqs);
> @@ -2544,7 +2547,6 @@ static int ufshcd_queuecommand(struct Scsi_Host
> *host, struct scsi_cmnd *cmd)
> 
>  	/* issue command to the controller */
>  	spin_lock_irqsave(hba->host->host_lock, flags);
> -	ufshcd_vops_setup_xfer_req(hba, tag, true);
>  	ufshcd_send_command(hba, tag);
>  out_unlock:
>  	spin_unlock_irqrestore(hba->host->host_lock, flags);
> @@ -2731,7 +2733,6 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba 
> *hba,
>  	/* Make sure descriptors are ready before ringing the doorbell */
>  	wmb();
>  	spin_lock_irqsave(hba->host->host_lock, flags);
> -	ufshcd_vops_setup_xfer_req(hba, tag, false);
>  	ufshcd_send_command(hba, tag);
>  	spin_unlock_irqrestore(hba->host->host_lock, flags);
