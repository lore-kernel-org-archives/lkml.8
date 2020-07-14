Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E100C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B9A0221F2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="NynHg/+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgGNJTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:19:33 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:31978 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgGNJTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:19:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594718372; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=G34pH1+jGv/zjZdCgkbH+kOlOPxiBnKrDKaAW/Rs6CE=;
 b=NynHg/+hQgS8PHZ9z2LCqGYjaW/nEsQbyYaZSO3/bTb8hr12V0P7YHIgNj5zlACHwKx7i7/c
 ed/FCLx3wCYMGVMLpbUCieF3HJAtsE04HrUlBLlgt/gqIEcy5FZeMTGFAfFzjwU4LJeetVH8
 Rz4/SXGzrKGQ4di007qZZCu/FME=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n13.prod.us-west-2.postgun.com with SMTP id
 5f0d7882ee86618575b7d3fd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 14 Jul 2020 09:18:58
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5EDC4C4339C; Tue, 14 Jul 2020 09:18:57 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 82595C433C8;
        Tue, 14 Jul 2020 09:18:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 14 Jul 2020 17:18:56 +0800
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
Subject: Re: [PATCH v1 1/2] scsi: ufs: Simplify completion timestamp for SCSI
 and query commands
In-Reply-To: <20200706060707.32608-2-stanley.chu@mediatek.com>
References: <20200706060707.32608-1-stanley.chu@mediatek.com>
 <20200706060707.32608-2-stanley.chu@mediatek.com>
Message-ID: <57a4128b5f620c2bac7c55a73074a6a7@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-06 14:07, Stanley Chu wrote:
> Simplify recording command completion time in
> __ufshcd_transfer_req_compl() by assigning lrbp->compl_time_stamp
> in an unified location.
> 
> Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>

Reviewed-by: Can Guo <cang@codeaurora.org>

> ---
>  drivers/scsi/ufs/ufshcd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 18da2d64f9fa..71e8d7c782bd 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -4881,6 +4881,7 @@ static void __ufshcd_transfer_req_compl(struct
> ufs_hba *hba,
> 
>  	for_each_set_bit(index, &completed_reqs, hba->nutrs) {
>  		lrbp = &hba->lrb[index];
> +		lrbp->compl_time_stamp = ktime_get();
>  		cmd = lrbp->cmd;
>  		if (cmd) {
>  			ufshcd_add_command_trace(hba, index, "complete");
> @@ -4889,13 +4890,11 @@ static void __ufshcd_transfer_req_compl(struct
> ufs_hba *hba,
>  			cmd->result = result;
>  			/* Mark completed command as NULL in LRB */
>  			lrbp->cmd = NULL;
> -			lrbp->compl_time_stamp = ktime_get();
>  			/* Do not touch lrbp after scsi done */
>  			cmd->scsi_done(cmd);
>  			__ufshcd_release(hba);
>  		} else if (lrbp->command_type == UTP_CMD_TYPE_DEV_MANAGE ||
>  			lrbp->command_type == UTP_CMD_TYPE_UFS_STORAGE) {
> -			lrbp->compl_time_stamp = ktime_get();
>  			if (hba->dev_cmd.complete) {
>  				ufshcd_add_command_trace(hba, index,
>  						"dev_complete");
