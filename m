Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2FFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 10:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E5512070A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 10:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="F/0oEAbg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbgHDKC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 06:02:56 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:32945 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728270AbgHDKCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 06:02:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596535375; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=YAQTCZ79EPZUswUxRse5WYWCeMi7TP/yJqj2ZFCTdds=;
 b=F/0oEAbgeExxtuLwpMQE8m3HMO4kVu6M/dE7PBtP6jDdCAADIS8BERBrFv4Nh0oPQj9GG5RN
 HBwJbifyyN6cH5WUP48yrFTagQh3wqD9N/Pt8/pu0dP86GS+4U6pJfs/JPNNreI2dxNmvJWV
 33sWlnMjHBYYsF9o+gsv29o3cyg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n14.prod.us-east-1.postgun.com with SMTP id
 5f2931f276a940cda82cd66e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 04 Aug 2020 10:01:22
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7742DC43391; Tue,  4 Aug 2020 10:01:21 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 15242C433C9;
        Tue,  4 Aug 2020 10:01:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 04 Aug 2020 18:01:19 +0800
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
Subject: Re: [PATCH v4] scsi: ufs: Cleanup completed request without interrupt
 notification
In-Reply-To: <20200724140246.19434-1-stanley.chu@mediatek.com>
References: <20200724140246.19434-1-stanley.chu@mediatek.com>
Message-ID: <d4a660cc4d9157989fb45b70e7eab0e7@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-24 22:02, Stanley Chu wrote:
> If somehow no interrupt notification is raised for a completed request
> and its doorbell bit is cleared by host, UFS driver needs to cleanup
> its outstanding bit in ufshcd_abort(). Otherwise, system may behave
> abnormally by below flow:
> 
> After ufshcd_abort() returns, this request will be requeued by SCSI
> layer with its outstanding bit set. Any future completed request
> will trigger ufshcd_transfer_req_compl() to handle all "completed
> outstanding bits". In this time, the "abnormal outstanding bit"
> will be detected and the "requeued request" will be chosen to execute
> request post-processing flow. This is wrong because this request is
> still "alive".
> 
> Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
> ---
>  drivers/scsi/ufs/ufshcd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 577cc0d7487f..9d180da77488 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -6493,7 +6493,7 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
>  			/* command completed already */
>  			dev_err(hba->dev, "%s: cmd at tag %d successfully cleared from 
> DB.\n",
>  				__func__, tag);
> -			goto out;
> +			goto cleanup;
>  		} else {
>  			dev_err(hba->dev,
>  				"%s: no response from device. tag = %d, err %d\n",
> @@ -6527,6 +6527,7 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
>  		goto out;
>  	}
> 
> +cleanup:
>  	scsi_dma_unmap(cmd);
> 
>  	spin_lock_irqsave(host->host_lock, flags);

Reviewed-by: Can Guo <cang@codeaurora.org>
