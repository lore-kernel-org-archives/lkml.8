Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3660C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F0952067D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="bsUHdhvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731419AbgGAOWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 10:22:23 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:39108 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731202AbgGAOWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 10:22:22 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 061E2bxk004316;
        Wed, 1 Jul 2020 09:20:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=ExsFQtVb807+9WQJDiwIUxBaxcTUv6N0amDyw9On6qI=;
 b=bsUHdhvMKojMfdPsrPNpWy3ZZLZ772P0L2qb2J0N1lFa42hoJvk3kQ5wVU2U8JcT9DmZ
 3z1bl/xfrD7c1u0bXA4DSDVDv7PiIxD8gx/R6oCdW0KqLUYl9UbU1DPBIyjDPoK0NYpW
 SH4Oi0gYmolyi3WZMA7CDEdEQVHXEBuf6GPnGMqDyhEWvuq1ytgnZ/aHrnMkVHp/k/DV
 mEbIrWLFDM8Ip9L4pWWDF4iIBiPui47zAqCJ4d1Lu95UKe+GmF+NAI7BZjD3geXv+nM+
 0NQFbWU/G7WzvyCptiXAFptN9t7xvnwVh/0IXfHlwluKOKtQzQy/0+/ekZD+PFuiMm6W 0g== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 31x2hpwwba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 01 Jul 2020 09:20:34 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 1 Jul 2020
 15:20:32 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Wed, 1 Jul 2020 15:20:32 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 64FE32AB;
        Wed,  1 Jul 2020 14:20:32 +0000 (UTC)
Date:   Wed, 1 Jul 2020 14:20:32 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] ALSA: compress: fix partial_drain completion state
Message-ID: <20200701142032.GG71940@ediswmail.ad.cirrus.com>
References: <20200629134737.105993-1-vkoul@kernel.org>
 <20200629134737.105993-4-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200629134737.105993-4-vkoul@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=975 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 phishscore=0
 cotscore=-2147483648 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1011 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007010102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 07:17:37PM +0530, Vinod Koul wrote:
> On partial_drain completion we should be in SNDRV_PCM_STATE_RUNNING
> state, so set that for partially draining streams in
> snd_compr_drain_notify() and use a flag for partially draining streams
> 
> While at it, add locks for stream state change in
> snd_compr_drain_notify() as well.
> 
> Fixes: f44f2a5417b2 ("ALSA: compress: fix drain calls blocking other compress functions (v6)")
> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---

Worth noting I haven't actually tested the gapless, but keeps all
the compressed capture stuff happy.

Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
