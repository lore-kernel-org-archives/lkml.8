Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5EFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69A624125
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="RPcGX5BC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgAWJ1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 04:27:02 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:6782 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725785AbgAWJ1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 04:27:01 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00N9NiUa015513;
        Thu, 23 Jan 2020 03:26:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=aQuqEAXvS/SXq1MmpZY3fWZYE9htc+lnY2Egj+TmxLU=;
 b=RPcGX5BCnlKG7e/pWWO3T3oHvuue4pNpHL/MFLGB2wLexznDJqF6IVYh93ezGOQMqS0+
 L2Zr6yJJBd9Kp1d4hs4VU1L6VwYlvJHpK+Kwd3c/GXHAEGwPUMRU+qwdgnnVONnmEF/5
 N5J0BWy6jNdvBGlXqmH29CkfSxIZK6/+W+bhSMPu1HlmLN1GaJxqSJmY9Y8fzFQer0im
 0/mHidFrPhe5THtoa/KXKPKThOUNWRdKv+02ldIjDraCoQaejBhzfc56IaJMhxcDFdiM
 hKACSNPpQtuaOc6ZZGPtsuNVqRxTZc9ZWxbhazm/lMba/oLWihb7K9Y1Fwqj4BiNjsWV ig== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([5.172.152.52])
        by mx0a-001ae601.pphosted.com with ESMTP id 2xm0a8yjrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Jan 2020 03:26:58 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Thu, 23 Jan
 2020 09:26:39 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Thu, 23 Jan 2020 09:26:39 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DCE202D4;
        Thu, 23 Jan 2020 09:26:39 +0000 (UTC)
Date:   Thu, 23 Jan 2020 09:26:39 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <lee.jones@linaro.org>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH RESEND 1/2] regulator: arizona-ldo1: Improve handling of
 regulator unbinding
Message-ID: <20200123092639.GC4098@ediswmail.ad.cirrus.com>
References: <20200122110842.10702-1-ckeepax@opensource.cirrus.com>
 <20200122131149.GE3833@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200122131149.GE3833@sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=2
 bulkscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=971
 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001230079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 01:11:49PM +0000, Mark Brown wrote:
> On Wed, Jan 22, 2020 at 11:08:41AM +0000, Charles Keepax wrote:
> 
> > The current unbinding process for Madera has some issues. The trouble
> > is runtime PM is disabled as the first step of the process, but
> 
> Why not just leave runtime PM active until all the subdevices are gone?
> This is a really bad hack and it's going to be fragile.
> 

Admittedly I am not super fond of this solution either. But
leaving the PM runtime active is basically what this patch does
(well the mfd part). Leaving the PM runtime enabled means access
to the DCVDD regulator is required during the remove process,
which in turn means you need to put that regulator after the
other devices are removed but before DCVDD is removed. Currently
the only place we can do that is in the LDO remove, as per this
patch.

Other options that might be viable, pending input for yourself
and Lee:

1) We could look at adding a partial remove function to MFD.
Currently I can only call mfd_remove_devices which nobbles all
the devices. If I could make calls to remove specific devices I
could do one call to remove everything except DCVDD, do the put,
then remove the regulator.

2) We could look at adding some sort of pre-remove callback into
MFD, and the regulator put could go in there rather than the
regulator remove, as per this patch. Although this feels a little
like the same thing as this patch, just dressed up a little
differently.

3) We could look at doing something in regmap IRQ to change when
it does PM runtime calls, it is regmap doing runtime gets when
drivers remove IRQs that causes the issue. But my accessment was
that what regmap is doing makes perfect sense, so I don't think
this is a good approach.

> > +static int madera_ldo1_remove(struct platform_device *pdev)
> > +{
> > +	struct madera *madera = dev_get_drvdata(pdev->dev.parent);
> > +
> > +	if (madera->internal_dcvdd) {
> > +		regulator_disable(madera->dcvdd);
> > +		regulator_put(madera->dcvdd);
> > +	}
> 
> This is going to break bisection since it will result in double
> disables, it'd be fine to do the MFD change first since that'd just
> leak a reference to enable on a regulator which is about to be discarded
> entirely anyway but this reordering (and whatever other changes you've
> done since v1) means you add a double free.

Apologies yes that is a good point. If no one minds, and we end
up sticking with this approach, I feel it might best to squash
them both back into one patch?

Thanks,
Charles
