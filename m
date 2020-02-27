Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F66C76560
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4733324656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="dR3lnFyh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732629AbgB0Oh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:37:59 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:11808 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732209AbgB0N4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:56:50 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RDuC7d029248;
        Thu, 27 Feb 2020 07:56:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=amPxsDfm7SqjfykuCL5pbWIfRVa+H79NoUbKNKQcYwo=;
 b=dR3lnFyhMbd0Qb1zP/ziQMoQOlw4VTMPRg5csSA5OMHH/lGbcAo8Bfzxgoc7VSXhId08
 J0uqRFweXWSmZ5PvpXZ9NjaG+fSRENUZmKKocRd8FRpoxObE+Xbs8WiMDmkBWmrtaY7m
 jrMGoDuVajPXLPU7bFwBJK//Ip53b7/AFi+Hqm0NjfKxrHK1ktF63vCHOR2a13liDilt
 2n59FAzSSiwN5esy/1zFaxkAZXETnDKONOu0mdTEX9g0x7UfI4ScPHszBCBvGI2/5Npl
 fu9+/AxD0eYYOSgpnq7UXamQ7SPPV3ZSfhS55nFzcHMcKjafzn35f1Anq/sCXPMJjk2P Jg== 
Authentication-Results: ppops.net;
        spf=pass smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([5.172.152.52])
        by mx0b-001ae601.pphosted.com with ESMTP id 2ydcmbbkp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 27 Feb 2020 07:56:42 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Thu, 27 Feb
 2020 13:56:41 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Thu, 27 Feb 2020 13:56:41 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0F33445D;
        Thu, 27 Feb 2020 13:56:41 +0000 (UTC)
Date:   Thu, 27 Feb 2020 13:56:41 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2 2/2] mfd: wm8994: Fix unbalanced calls to
 regulator_bulk_disable()
Message-ID: <20200227135641.GJ108283@ediswmail.ad.cirrus.com>
References: <20200226100802.16384-1-m.szyprowski@samsung.com>
 <CGME20200226100815eucas1p2f4448e3dea078bfc58a8acdc70340c11@eucas1p2.samsung.com>
 <20200226100802.16384-2-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200226100802.16384-2-m.szyprowski@samsung.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 mlxlogscore=556 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 11:08:02AM +0100, Marek Szyprowski wrote:
> When runtime PM is enabled, regulators are being controlled by the
> driver's suspend and resume callbacks. They are also unconditionally
> enabled at driver's probe(), and disabled in remove() functions. Add
> more calls to runtime PM framework to ensure that the device's runtime
> PM state matches the regulators state:
> 1. at the end of probe() function: set runtime PM state to active, so
> there will be no spurious call to resume();
> 2. in remove(), ensure that resume() is called before disabling runtime PM
> management and unconditionally disabling the regulators.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
