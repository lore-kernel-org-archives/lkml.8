Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88D2CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B06ED205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="SiMG6Ja9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732195AbgEMIWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 04:22:35 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:52342 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726092AbgEMIWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 04:22:35 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04D8G4hp007414;
        Wed, 13 May 2020 03:21:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=SN0lZANT/vbXKgnyWwzZnLfQTVL/ShY4GaSPpGpVBkA=;
 b=SiMG6Ja9eXiMz6KeoWCSkLcdZXiCb+S/pnWR9tGUM38jdOksN8I8YnnZehotk5woAzrY
 0NN4hSkhrWxXMWUF0xbxXKXVuMUiABognHDvtwk/+nh3HzLC3/C6MplbY/LiVyUxM8FF
 zHbnoS/u91w1HtYF8aHoyeEaS8BQF0n6CQhtVACjL/vkAKJgI8cWHCAMo88IzGSK82o1
 B8lQ72rx+ij/0zrht1oUXJli5kaHcofTF+rAIK6R6GdN3MJAnX2EEZH1553pLFBFBzvi
 sys7s8FxoQ5qsC6G77iSPYfA2I8F9cYUbgvTQVIYWQf6nhp5z0Ta3sPGZAQpcJXyZxNB ZA== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3100xes1ge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 May 2020 03:21:38 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 13 May
 2020 09:21:35 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Wed, 13 May 2020 09:21:35 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6CA562C5;
        Wed, 13 May 2020 08:21:35 +0000 (UTC)
Date:   Wed, 13 May 2020 08:21:35 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <tglx@linutronix.de>, <allison@lohutok.net>,
        <info@metux.net>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: wm8962: Use force clear for WM8962_SYSCLK_ENA
 after reset
Message-ID: <20200513082135.GF71940@ediswmail.ad.cirrus.com>
References: <1589347835-20554-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1589347835-20554-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=581
 bulkscore=0 spamscore=0 clxscore=1015 cotscore=-2147483648 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005130076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 01:30:35PM +0800, Shengjiu Wang wrote:
> When CLOCKING2 is non-volatile register, we need force clear
> the WM8962_SYSCLK_ENA bit after reset, for the value in cache
> maybe 0 but in hardware it is 1. Otherwise there will issue
> as below statement in driver.
> 
> /* SYSCLK defaults to on; make sure it is off so we can safely
>  * write to registers if the device is declocked.
> 
> Fixes: c38b608504aa ("ASoC: wm8962: set CLOCKING2 as non-volatile register")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
