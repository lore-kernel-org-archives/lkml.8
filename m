Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B73DC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D54AE2078A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="NHj7gPHQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgH1KCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 06:02:10 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:36618 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728922AbgH1KCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 06:02:09 -0400
X-Greylist: delayed 1060 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Aug 2020 06:02:08 EDT
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07S9c5Qk008076;
        Fri, 28 Aug 2020 04:44:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=5I2uMXhLoA701I3inj6ToWiNdrxZKdiI/z4bLw39qiE=;
 b=NHj7gPHQ9gH0ND3W4ait84qKoxLWmVuSiIwvjUkLxdmfmqlW/nR54NwRIoN8LNs1guw0
 dHbF1BVn3xLlTszyMF3Dr5SfaAsbKarsX/sOWCuW4wGy9UBN4iq8cutP5M+L5fb1ajQs
 GhvDmomXFA1tDNpWV6KSFg3jCVJ9VACVAUH+cP8I3s5OUhuFz+B4BdosskGL5YciEY0j
 kt8JKcIUX46B8qqGLs4zV/70jKkFzui+5fVRXU61n1RD4CRg7zOzKoMG7B9JeWRISIwf
 5DgPb6KJbszBP0/IiwUOq0ERNaxCfaRRwCnv7ZTXSOc6Ml4jA//Una3EVXws75iG4wq/ qg== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 332yspgk7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 28 Aug 2020 04:44:12 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 28 Aug
 2020 10:44:10 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 28 Aug 2020 10:44:10 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 487CA2C3;
        Fri, 28 Aug 2020 09:44:10 +0000 (UTC)
Date:   Fri, 28 Aug 2020 09:44:10 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/3] mfd: madera: Simplify with dev_err_probe()
Message-ID: <20200828094410.GI10899@ediswmail.ad.cirrus.com>
References: <20200826144935.10067-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200826144935.10067-1-krzk@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=791 mlxscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1011 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008280074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 04:49:33PM +0200, Krzysztof Kozlowski wrote:
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
