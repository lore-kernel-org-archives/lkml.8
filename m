Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0337EC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7A432075B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="B5Z2w4Lg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgH1PtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:49:07 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:41448 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725894AbgH1PtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 11:49:01 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07SFfUVB020212;
        Fri, 28 Aug 2020 10:48:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=OKFazoGL7MkLzQd7yCPqdh5EaX1fgkTSclCd2PlnrPI=;
 b=B5Z2w4LgvfQvjooRHstKWW1S2QGPlXC3Cr61yxerxcE64xEmx3ptJtz6eS0JvmGV4Tfv
 3RxhYFBGmUelTy7qRkvtenB1QLVIjyciVVxRVTRI4eEOfB2G0Gwcllzdw1MtVEoYJsAV
 YFXgMTQnHRRy8UYijno/64xzkbjNPYOki/oLl7tq/c7X+myDHN8me8yX3TxUZF71Wtr7
 gbTzOQkcmUkoxz5bQWhwIOvKA3WyJXNXaYLRKE05d3Oar42iq3Q0adIVoS0539YsjGSB
 cwlUrLKCEPkUBqoPDD7BhFUhb46JIm2g0ardjc+eU0eW/J56Dq9OD/hA9PHbHTaorOHL oA== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 332ysph1x0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 28 Aug 2020 10:48:44 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 28 Aug
 2020 16:48:43 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 28 Aug 2020 16:48:43 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5BF622A1;
        Fri, 28 Aug 2020 15:48:43 +0000 (UTC)
Date:   Fri, 28 Aug 2020 15:48:43 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
CC:     <broonie@kernel.org>, <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <m.szyprowski@samsung.com>,
        <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 1/2] ASoC: wm8994: Skip setting of the WM8994_MICBIAS
 register for WM1811
Message-ID: <20200828154843.GJ10899@ediswmail.ad.cirrus.com>
References: <CGME20200827173411eucas1p1283200677c5e077c5e07af938934eb5d@eucas1p1.samsung.com>
 <20200827173357.31891-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200827173357.31891-1-s.nawrocki@samsung.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=602 mlxscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008280119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 07:33:56PM +0200, Sylwester Nawrocki wrote:
> The WM8994_MICBIAS register is not available in the WM1811 CODEC so skip
> initialization of that register for that device.
> This suppresses an error during boot:
> "wm8994-codec: ASoC: error at snd_soc_component_update_bits on wm8994-codec"
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
