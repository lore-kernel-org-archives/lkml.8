Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7387C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A4D92076C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="bsL2mm9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgDUNQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:16:44 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:39440 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728337AbgDUNQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:16:43 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03LDBHuf013669;
        Tue, 21 Apr 2020 08:15:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=eQSksNnr16lv473MUndY75YiFvq7xp0brkXvXdv6kL0=;
 b=bsL2mm9fuCYb7w8ukaP/lJEpAicOMG/62nKFIXRJiItvsAejwDb8ZUTrqs2rTRwRVjvr
 YYYCt0axmdKqoCNMXAUWRJLwu4pgxTDvPFpglkIicGdxh3YxiUwUCWQDorQHEXAClom8
 1fxHf9dIRm2ZZaJiqm/MQjnYejeUfPHE7LxZgfqiR6rb8E5XD4cxYskY90E9718xCVNk
 77dwr67UykuFNckrXG1h/z648JM9on0+FHVpcJDuodIMEdEvXEnu3DnRMysd6F1yFQlf
 Ed6s3Ht/cCbQ5Vc8rqZOKsq1y5QMS1na3BAOjLb5aE/toR8hP2KNk/jsNDKd4+/lOJaU 6g== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 30fwyqmxnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Apr 2020 08:15:46 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 21 Apr
 2020 14:15:43 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Tue, 21 Apr 2020 14:15:43 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6756D2AB;
        Tue, 21 Apr 2020 13:15:43 +0000 (UTC)
Date:   Tue, 21 Apr 2020 13:15:43 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kstewart@linuxfoundation.org>,
        <allison@lohutok.net>, <tglx@linutronix.de>, <info@metux.net>,
        <ckeepax@opensource.wolfsonmicro.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: wm8960: Fix wrong clock after suspend & resume
Message-ID: <20200421131543.GG44490@ediswmail.ad.cirrus.com>
References: <1587468525-27514-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1587468525-27514-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1011 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004210105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 07:28:45PM +0800, Shengjiu Wang wrote:
> After suspend & resume, wm8960_hw_params may be called when
> bias_level is not SND_SOC_BIAS_ON, then wm8960_configure_clocking
> is not called. But if sample rate is changed at that time, then
> the output clock rate will be not correct.
> 
> So judgement of bias_level is SND_SOC_BIAS_ON in wm8960_hw_params
> is not necessary and it causes above issue.
> 
> Fixes: 3176bf2d7ccd ("ASoC: wm8960: update pll and clock setting function")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
