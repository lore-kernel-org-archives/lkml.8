Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A996FC2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 10:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 823DC2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 10:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="a44jU117"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgDXKoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 06:44:20 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:21668 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726289AbgDXKoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 06:44:20 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03OAfX1G017788;
        Fri, 24 Apr 2020 05:43:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=ckzgMaacDt/xdzl2oZNvVf9ixye3+oxLbiAY1sRbYH8=;
 b=a44jU117aiB02r76QL7C0iHcQu908O6P0Sbu0eV3tEQP07RSkLyAEeendPyNj160nreW
 U70CUzy7VANecEtQk/Pk0AR7V/oSM++NGRYIPhWdiaeZs3oWIZlE2gT1MBvNtiyQO2SR
 BNuS+lIVhgtMiqKP7VG5oCimWNJNkOQ5eudFRsbkUrp9CHRAqc/ijsjikG1aSCOk6k+I
 rgD8Nn21JayRE1iqkHsO8BVXV3YvV74kWTm7itNTp5Ml5sH5XQT0QXaUz8luC+yf0JY4
 vANWVPmv4DNoI2yysUlZ8OkxJmcd0dlBLQgRoDgWWczf86yiuKEBg3Eqpx2V2oyBZcg0 Ag== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 30fwyquwy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 24 Apr 2020 05:43:48 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Fri, 24 Apr
 2020 11:43:47 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Fri, 24 Apr 2020 11:43:47 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2687E2C5;
        Fri, 24 Apr 2020 10:43:47 +0000 (UTC)
Date:   Fri, 24 Apr 2020 10:43:47 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <tglx@linutronix.de>, <allison@lohutok.net>,
        <info@metux.net>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: wm8962: Force suspend/resume during system
 suspend/resume
Message-ID: <20200424104347.GJ44490@ediswmail.ad.cirrus.com>
References: <1587708727-13657-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1587708727-13657-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004240083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 02:12:07PM +0800, Shengjiu Wang wrote:
> Use force_suspend/resume to make sure clocks are disabled/enabled
> accordingly during system suspend/resume.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/codecs/wm8962.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
> index 0a2cfff44441..80332c147da9 100644
> --- a/sound/soc/codecs/wm8962.c
> +++ b/sound/soc/codecs/wm8962.c
> @@ -3854,6 +3854,8 @@ static int wm8962_runtime_suspend(struct device *dev)
>  
>  static const struct dev_pm_ops wm8962_pm = {
>  	SET_RUNTIME_PM_OPS(wm8962_runtime_suspend, wm8962_runtime_resume, NULL)
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)

I would be interested in a little more explaination of why this is
the correct fix here?

My concern is this presumably precludes the CODEC being used in any
application where it is expected to process audio during system
suspend. Admittedly, the target market for this device probably
makes that unlikely, but I am slightly uncomfortable just assuming
that will always be true.

As far as I can see the expectation is that DAPM shutdowns down
all audio streams during system suspend (except those marked to
ignore suspend, as per my above concerns) and that will cause
a pm_runtime_put on each DAPM context which I would imagine is
intended to put the CODEC into runtime suspend. I am guessing the
reason you have problems is because of the driver doing its own
pm_runtime operations in set_fll, which probably takes an extra
reference preventing the power down. Is a more complex fix
correcting the interaction with DAPM the correct solution here?

Thanks,
Charles
