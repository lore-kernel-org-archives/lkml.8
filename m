Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BB9C54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EF0120673
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ccmZgk3p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730743AbgELPHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:07:05 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:59786 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726610AbgELPHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:07:02 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04CF1em8023749;
        Tue, 12 May 2020 10:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=D95AZ6qA+hhDwF46fVfOwPe7tq0kH/15sfSGGHy9jgU=;
 b=ccmZgk3pRYxdkno8BKHE8OcQdAoymYQY3W6ZE7F/fujlj20yQPrwh4pP2dtjiJkXcutE
 x+GxD06zsgc6CaVgBMTIOvF/Z6/XxdenPHp/+kRBpi6AO33AokRqx2+LpmiIvr6QOXYy
 XBB2m8pf6cYvpRCP0W9crGdAHax63YcmEK+YB4huDNu+PXAc91G22eljg2qrEAbUS3Q+
 NksC13mFuPm+kHLn6A6FQw71M7XKBvVZ2FsPiM/+vA0tfR1Vo/vY3cp1/x0bS+1zD3o6
 F812NA1qNYa4cERbBZqJ1cDHMwgm236TKA1n4VQCYvE1Ghzc6tM9C/rErlJRKhJ+5gs5 Yw== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 30wrxq5009-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 May 2020 10:06:37 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 12 May
 2020 16:06:36 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Tue, 12 May 2020 16:06:36 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 73E972C6;
        Tue, 12 May 2020 15:06:36 +0000 (UTC)
Date:   Tue, 12 May 2020 15:06:36 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Rob Herring <robh@kernel.org>
CC:     <lee.jones@linaro.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <jdelvare@suse.com>,
        <linux@roeck-us.net>, <linus.walleij@linaro.org>,
        <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH v2 5/5] mfd: lochnagar: Move binding over to dtschema
Message-ID: <20200512150636.GD71940@ediswmail.ad.cirrus.com>
References: <20200504154757.17519-1-ckeepax@opensource.cirrus.com>
 <20200504154757.17519-5-ckeepax@opensource.cirrus.com>
 <20200512134949.GA14057@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200512134949.GA14057@bogus>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 mlxlogscore=986 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005120114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 08:49:49AM -0500, Rob Herring wrote:
> On Mon, May 04, 2020 at 04:47:57PM +0100, Charles Keepax wrote:
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> > 
> > Changes since v1:
> >  - Removed contains on the compatible
> >  - Moved all sub-nodes into here directly only using $ref for properties
> >  - As the regulator binding only contained subnodes that file is now deleted
> >  - Removed some pointless descriptions
> > 
> > A little nervous about the amount of clock and regulator stuff this
> > pulls into the MFD file, any comments on that welcome? Would it be worth
> > looking into something along the lines of the definitions stuff to keep
> > some of that out in the clock and regulator bindings?
> 
> It's fine like this. Other than my comments on patch 3, looks fine. 
> Respin and I'll apply.
> 

Groovy thanks for the reviews.

Thanks,
Charles
