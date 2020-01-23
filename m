Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA82C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 12:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D5A21569
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 12:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="km/jVXLj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgAWMDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 07:03:24 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:54350 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726170AbgAWMDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 07:03:24 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00NBxpob030558;
        Thu, 23 Jan 2020 06:03:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=4V++r+G/n0fBNRVn85iOLexUiH8xVgSQNdaFDvYpwFM=;
 b=km/jVXLjiokG8osCPgBvApu1XRfim60hsK1Si3Cj/LuEItAO2qpI51+ginDGXe0vzaej
 +xme9YizsSXU6q9Uw0pmngZZWNs0JD4ODyUjgAyR0AAcqOHmGtzOKaQIAHBZ31YrbZbv
 t4+C44MdhKnzd0EOjP7He0t+tsTA6MCP5rDfcvdVpRyTJGnEPtLHmgGaR4GBGA3moYDv
 IONvhSBC53ftjK47ghK/EV698S03rfshqZGYPjLZfMdEVljTC7A94DafrfkDm6m+L6dQ
 MAsVM8x922GVDBKT09FyvOWT1WY1iByomd6NE92HAlAutk+IVRyl2JCfmziwthwkf4W8 GQ== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([5.172.152.52])
        by mx0a-001ae601.pphosted.com with ESMTP id 2xm0a8yw1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Jan 2020 06:03:19 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Thu, 23 Jan
 2020 12:02:41 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Thu, 23 Jan 2020 12:02:41 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D5C312C6;
        Thu, 23 Jan 2020 12:02:40 +0000 (UTC)
Date:   Thu, 23 Jan 2020 12:02:40 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <lee.jones@linaro.org>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH RESEND 1/2] regulator: arizona-ldo1: Improve handling of
 regulator unbinding
Message-ID: <20200123120240.GD4098@ediswmail.ad.cirrus.com>
References: <20200122110842.10702-1-ckeepax@opensource.cirrus.com>
 <20200122131149.GE3833@sirena.org.uk>
 <20200123092639.GC4098@ediswmail.ad.cirrus.com>
 <20200123114805.GA5440@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200123114805.GA5440@sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001230103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 11:48:05AM +0000, Mark Brown wrote:
> On Thu, Jan 23, 2020 at 09:26:39AM +0000, Charles Keepax wrote:
> 
> > 3) We could look at doing something in regmap IRQ to change when
> > it does PM runtime calls, it is regmap doing runtime gets when
> > drivers remove IRQs that causes the issue. But my accessment was
> > that what regmap is doing makes perfect sense, so I don't think
> > this is a good approach.
> 
> Why do you even care about the errors?  It's not like this device is
> going to get removed in a production system and the primary IRQ will be
> disabled when the core is removed, this is just something that happens
> during development isn't it?

We do have certain customers who test unbinding the driver and
complain when it throws errors. Admittedly, you are correct that
it is a little bit of a stretch to imagine a situation where this
is a massive problem in production. Best I can offer is one of
our CODECs gets into a laptop and someone wants to unbind/bind
the driver, to clear some issue or something.

Its been a while since I was looking at this issue, so I will
double check to see if the issue is purely one of error messages
or if it actually can cause problems (memory leaks or issues
rebinding). But on a personal note I would be somewhat happier if
we could come up with some acceptable way to make the driver
unbind cleanly.

I am more than happy to do the leg work if we really don't like
this solution. Do either you or Lee have any thoughts on my
selective MFD remove helpers? That seemed like the most promising
alternative solution to me.

Thanks,
Charles
