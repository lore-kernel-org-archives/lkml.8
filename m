Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D151AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 16:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A94D6204EA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 16:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Bd2bFT0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgHNQyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 12:54:08 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:14488 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbgHNQyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 12:54:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597424047; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=0agT3+BVjCUaOQoCutKPeNabu7umEQg+D+MeTbkr8i4=; b=Bd2bFT0ZIclpmzCJHoiP2gZ2AFdd0uggYKxA6S2bCDlnXNx+DwniJRawHps0g8SyleJLxi4K
 SuOASjEV9BgZi6n8rsy5tcBOv5aBsTJUDFo/mq1/og3D7Q8whYBMBA1zc16kl0+18bOZuzEs
 WAODWxwbnd33b6XLRddXbyWJeC8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f36c1ae3f2ce11020983f5a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 14 Aug 2020 16:54:06
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E1B08C4339C; Fri, 14 Aug 2020 16:54:05 +0000 (UTC)
Received: from asutoshd-linux1.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: asutoshd)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6C86AC433C9;
        Fri, 14 Aug 2020 16:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6C86AC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=asutoshd@codeaurora.org
Date:   Fri, 14 Aug 2020 09:54:02 -0700
From:   Asutosh Das <asutoshd@codeaurora.org>
To:     Bean Huo <huobean@gmail.com>
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] scsi: ufs: remove several redundant goto
 statements
Message-ID: <20200814165402.GB1217@asutoshd-linux1.qualcomm.com>
References: <20200814095034.20709-1-huobean@gmail.com>
 <20200814095034.20709-3-huobean@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200814095034.20709-3-huobean@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14 2020 at 02:50 -0700, Bean Huo wrote:
>From: Bean Huo <beanhuo@micron.com>
>
>Signed-off-by: Bean Huo <beanhuo@micron.com>

Reviewed-by: Asutosh Das <asutoshd@codeaurora.org>

>---
> drivers/scsi/ufs/ufshcd.c | 25 +++++--------------------
> 1 file changed, 5 insertions(+), 20 deletions(-)
>
>diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>index e3663b85e8ee..79b216c012d3 100644
>--- a/drivers/scsi/ufs/ufshcd.c
>+++ b/drivers/scsi/ufs/ufshcd.c
>@@ -4256,10 +4256,8 @@ int ufshcd_make_hba_operational(struct ufs_hba *hba)
> 		dev_err(hba->dev,
> 			"Host controller not ready to process requests");
> 		err = -EIO;
>-		goto out;
> 	}
>
>-out:
> 	return err;
> }
> EXPORT_SYMBOL_GPL(ufshcd_make_hba_operational);
>@@ -5542,10 +5540,8 @@ static bool ufshcd_quirk_dl_nac_errors(struct ufs_hba *hba)
> 			hba->saved_err &= ~UIC_ERROR;
> 		/* clear NAC error */
> 		hba->saved_uic_err &= ~UFSHCD_UIC_DL_NAC_RECEIVED_ERROR;
>-		if (!hba->saved_uic_err) {
>+		if (!hba->saved_uic_err)
> 			err_handling = false;
>-			goto out;
>-		}
> 	}
> out:
> 	spin_unlock_irqrestore(hba->host->host_lock, flags);
>@@ -7604,12 +7600,10 @@ static int ufshcd_config_vreg(struct device *dev,
> 		if (vreg->min_uV && vreg->max_uV) {
> 			min_uV = on ? vreg->min_uV : 0;
> 			ret = regulator_set_voltage(reg, min_uV, vreg->max_uV);
>-			if (ret) {
>+			if (ret)
> 				dev_err(dev,
> 					"%s: %s set voltage failed, err=%d\n",
> 					__func__, name, ret);
>-				goto out;
>-			}
> 		}
> 	}
> out:
>@@ -7672,8 +7666,6 @@ static int ufshcd_setup_vreg(struct ufs_hba *hba, bool on)
> 		goto out;
>
> 	ret = ufshcd_toggle_vreg(dev, info->vccq2, on);
>-	if (ret)
>-		goto out;
>
> out:
> 	if (ret) {
>@@ -7719,10 +7711,8 @@ static int ufshcd_init_vreg(struct ufs_hba *hba)
> 		goto out;
>
> 	ret = ufshcd_get_vreg(dev, info->vccq);
>-	if (ret)
>-		goto out;
>-
>-	ret = ufshcd_get_vreg(dev, info->vccq2);
>+	if (!ret)
>+		ret = ufshcd_get_vreg(dev, info->vccq2);
> out:
> 	return ret;
> }
>@@ -7866,12 +7856,7 @@ static int ufshcd_variant_hba_init(struct ufs_hba *hba)
>
> 	err = ufshcd_vops_setup_regulators(hba, true);
> 	if (err)
>-		goto out_exit;
>-
>-	goto out;
>-
>-out_exit:
>-	ufshcd_vops_exit(hba);
>+		ufshcd_vops_exit(hba);
> out:
> 	if (err)
> 		dev_err(hba->dev, "%s: variant %s init failed err %d\n",
>-- 
>2.17.1
>
