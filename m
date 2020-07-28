Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C755C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 18:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFC9B2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 18:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Q8b9c3XZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732153AbgG1SHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 14:07:02 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:57466 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728625AbgG1SHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 14:07:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595959621; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=wH1XeUIpKUi87lDduI+MZ/7qwzN50GTis63htVEvvHE=; b=Q8b9c3XZ/D6wgsgUjNzfE0FzS+C8MX7vwHMZFoGQq06LVNCubsnr3aqv1pAJGu4K+0YAKOCB
 UzigY6sUhcNrEKS3ST7XlzrLVR5bADmzI6bGuaCTAPVNhPzh9vU592cWa/xqbKAFgRrThrcY
 vpA/B+6D8Kifij3hISY+9YhFYuA=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5f206935c7e7bf09e06380a2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Jul 2020 18:06:45
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 563CAC433A0; Tue, 28 Jul 2020 18:06:45 +0000 (UTC)
Received: from [192.168.8.168] (cpe-70-95-149-85.san.res.rr.com [70.95.149.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: asutoshd)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8BA89C433C6;
        Tue, 28 Jul 2020 18:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8BA89C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=asutoshd@codeaurora.org
Subject: Re: [PATCH v7 7/8] scsi: ufs: Move dumps in IRQ handler to error
 handler
To:     Can Guo <cang@codeaurora.org>, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, rnayak@codeaurora.org,
        sh425.lee@samsung.com, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1595912460-8860-1-git-send-email-cang@codeaurora.org>
 <1595912460-8860-8-git-send-email-cang@codeaurora.org>
From:   "Asutosh Das (asd)" <asutoshd@codeaurora.org>
Message-ID: <7e5e942d-449b-bd52-32da-7f5beed116b7@codeaurora.org>
Date:   Tue, 28 Jul 2020 11:06:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595912460-8860-8-git-send-email-cang@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/2020 10:00 PM, Can Guo wrote:
> Sometime dumps in IRQ handler are heavy enough to cause system stability
> issues, move them to error handler.
> 
> Signed-off-by: Can Guo <cang@codeaurora.org>
> ---
>   drivers/scsi/ufs/ufshcd.c | 31 +++++++++++++++----------------
>   1 file changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index c480823..b2bafa3 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -5682,6 +5682,21 @@ static void ufshcd_err_handler(struct work_struct *work)
>   				    UFSHCD_UIC_DL_TCx_REPLAY_ERROR))))
>   		needs_reset = true;
>   
> +	if (hba->saved_err & (INT_FATAL_ERRORS | UIC_ERROR |
> +			      UFSHCD_UIC_HIBERN8_MASK)) {
> +		bool pr_prdt = !!(hba->saved_err & SYSTEM_BUS_FATAL_ERROR);
> +
> +		dev_err(hba->dev, "%s: saved_err 0x%x saved_uic_err 0x%x\n",
> +				__func__, hba->saved_err, hba->saved_uic_err);
> +		spin_unlock_irqrestore(hba->host->host_lock, flags);
> +		ufshcd_print_host_state(hba);
> +		ufshcd_print_pwr_info(hba);
> +		ufshcd_print_host_regs(hba);
> +		ufshcd_print_tmrs(hba, hba->outstanding_tasks);
> +		ufshcd_print_trs(hba, hba->outstanding_reqs, pr_prdt);
> +		spin_lock_irqsave(hba->host->host_lock, flags);
> +	}
> +
>   	/*
>   	 * if host reset is required then skip clearing the pending
>   	 * transfers forcefully because they will get cleared during
> @@ -5900,22 +5915,6 @@ static irqreturn_t ufshcd_check_errors(struct ufs_hba *hba)
>   
>   		/* block commands from scsi mid-layer */
>   		ufshcd_scsi_block_requests(hba);
> -
> -		/* dump controller state before resetting */
> -		if (hba->saved_err & (INT_FATAL_ERRORS | UIC_ERROR)) {
> -			bool pr_prdt = !!(hba->saved_err &
> -					SYSTEM_BUS_FATAL_ERROR);
> -
> -			dev_err(hba->dev, "%s: saved_err 0x%x saved_uic_err 0x%x\n",
> -					__func__, hba->saved_err,
> -					hba->saved_uic_err);
> -
> -			ufshcd_print_host_regs(hba);
> -			ufshcd_print_pwr_info(hba);
How about keep the above prints and move the tmrs and trs to eh?
Sometimes in system instability, the eh may not get a chance to run 
even. Still the above prints would provide some clues.
> -			ufshcd_print_tmrs(hba, hba->outstanding_tasks);
> -			ufshcd_print_trs(hba, hba->outstanding_reqs,
> -					pr_prdt);
> -		}
>   		ufshcd_schedule_eh_work(hba);
>   		retval |= IRQ_HANDLED;
>   	}
> 


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
Linux Foundation Collaborative Project
