Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C22AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 15:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7850C20771
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 15:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="eztbNpd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgHMPzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 11:55:36 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:64696 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726359AbgHMPzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 11:55:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597334132; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=W312BRIP0jPtrpsLY7ScP573m3/ZWBGgEgDoBjIDleg=; b=eztbNpd8zwgBNWALlbCXjh25va40F4H4nmJmMPA2MN11h0x5V5AM32w1WH/9xHEONRsPxYmt
 6tU3f1i+JjntEowTNE0rmL/Stzwp4V64xf9HFG8AH9c5n5epzdSx7DGoGT2CWeHNr7oBlxge
 Uu836YluLvgR8ZwL0LtI6I23ahk=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5f35626d2f4952907d966daf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 13 Aug 2020 15:55:25
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 682B5C433AD; Thu, 13 Aug 2020 15:55:24 +0000 (UTC)
Received: from asutoshd-linux1.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: asutoshd)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 06C4FC433C6;
        Thu, 13 Aug 2020 15:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 06C4FC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=asutoshd@codeaurora.org
Date:   Thu, 13 Aug 2020 08:55:15 -0700
From:   Asutosh Das <asutoshd@codeaurora.org>
To:     Bean Huo <huobean@gmail.com>
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] scsi: ufs: change ufshcd_comp_devman_upiu() to
 ufshcd_compose_devman_upiu()
Message-ID: <20200813155515.GB25655@asutoshd-linux1.qualcomm.com>
References: <20200812143704.30245-1-huobean@gmail.com>
 <20200812143704.30245-2-huobean@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200812143704.30245-2-huobean@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12 2020 at 07:37 -0700, Bean Huo wrote:
>From: Bean Huo <beanhuo@micron.com>
>
>ufshcd_comp_devman_upiu() alwasy make me confuse that it is a request
>completion calling function. Change it to ufshcd_compose_devman_upiu().
>
>Signed-off-by: Bean Huo <beanhuo@micron.com>
>Acked-by: Avri Altman <avri.altman@wdc.com>

Reviewed-by: Asutosh Das <asutoshd@codeaurora.org>

>---
> drivers/scsi/ufs/ufshcd.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>index 5f09cda7b21c..e3663b85e8ee 100644
>--- a/drivers/scsi/ufs/ufshcd.c
>+++ b/drivers/scsi/ufs/ufshcd.c
>@@ -2391,12 +2391,13 @@ static inline void ufshcd_prepare_utp_nop_upiu(struct ufshcd_lrb *lrbp)
> }
>
> /**
>- * ufshcd_comp_devman_upiu - UFS Protocol Information Unit(UPIU)
>+ * ufshcd_compose_devman_upiu - UFS Protocol Information Unit(UPIU)
>  *			     for Device Management Purposes
>  * @hba: per adapter instance
>  * @lrbp: pointer to local reference block
>  */
>-static int ufshcd_comp_devman_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
>+static int ufshcd_compose_devman_upiu(struct ufs_hba *hba,
>+				      struct ufshcd_lrb *lrbp)
> {
> 	u8 upiu_flags;
> 	int ret = 0;
>@@ -2590,7 +2591,7 @@ static int ufshcd_compose_dev_cmd(struct ufs_hba *hba,
> 	ufshcd_prepare_lrbp_crypto(NULL, lrbp);
> 	hba->dev_cmd.type = cmd_type;
>
>-	return ufshcd_comp_devman_upiu(hba, lrbp);
>+	return ufshcd_compose_devman_upiu(hba, lrbp);
> }
>
> static int
>-- 
>2.17.1
>
