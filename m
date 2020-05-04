Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1CEC47247
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 09:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABCAE2071C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 09:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="D6aHVIcR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgEDJzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 05:55:35 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:25940 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726666AbgEDJze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 05:55:34 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0449nnq2007402;
        Mon, 4 May 2020 04:55:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=Fm1J7g/JRIbmU3EdCnEXz28Wj6sWvMfBWuouoriZhx0=;
 b=D6aHVIcRnxg/gacD02wMrSQ1LbAbatxUoQkkkO94RqfxyFf+M1VIAR4h4S5yaRTl9qA7
 3R5RW/EXj2uRZYNpP6tsdpxxIlqR9nWt+5qdykByHZPT/kpivCwywbuT0Ku3uPLZ+ZR+
 Whq/4MUU6I9AGooiNfECPq7YsCF6HpzII0UmBb5A1D/Kwdg1wu8s/nroIc2iUwdgilPz
 kiynTQ9beBF497OqoeIBh7wov7FtruhSvtkH+6OvR4vd25fHIca2LkC4ZA8FbHbwFd7G
 Ey4p25vkTop2ufbmAmlhkxHaWWKImzZuSsAauXaLm5iIWQDApuIyZyf3csHaen3eXDbQ 1A== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 30s69330km-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 04 May 2020 04:55:10 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 4 May 2020
 10:55:08 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 4 May 2020 10:55:08 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 08A97448;
        Mon,  4 May 2020 09:55:08 +0000 (UTC)
Date:   Mon, 4 May 2020 09:55:08 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Rob Herring <robh@kernel.org>
CC:     <lee.jones@linaro.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <jdelvare@suse.com>,
        <linux@roeck-us.net>, <linus.walleij@linaro.org>,
        <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 6/6] mfd: lochnagar: Move binding over to dtschema
Message-ID: <20200504095508.GQ44490@ediswmail.ad.cirrus.com>
References: <20200427102812.23251-1-ckeepax@opensource.cirrus.com>
 <20200427102812.23251-6-ckeepax@opensource.cirrus.com>
 <20200427103614.GM44490@ediswmail.ad.cirrus.com>
 <20200501204721.GA24163@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200501204721.GA24163@bogus>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 03:47:21PM -0500, Rob Herring wrote:
> On Mon, Apr 27, 2020 at 10:36:14AM +0000, Charles Keepax wrote:
> > On Mon, Apr 27, 2020 at 11:28:12AM +0100, Charles Keepax wrote:
> > > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > > ---
> > > +            lochnagar-pinctrl {
> > > +                compatible = "cirrus,lochnagar-pinctrl";
> > > +
> > > +                gpio-controller;
> > > +                #gpio-cells = <2>;
> > > +                gpio-ranges = <&lochnagar 0 0 LOCHNAGAR2_PIN_NUM_GPIOS>;
> > > +
> > > +                pinctrl-names = "default";
> > > +                pinctrl-0 = <&pinsettings>;
> > 
> > This seems to cause the following error:
> > 
> > Documentation/devicetree/bindings/mfd/cirrus,lochnagar.example.dt.yaml:
> > lochnagar@22: lochnagar-pinctrl:pin-settings:phandle: [[4]] is not of type 'object'
> > 
> > I think the schema is correct and the problem is one of tooling,
> > I have been poking at it for a while but can't seem to find a way
> > to silence this one. Any advice would be greatly appreciated.
> 
> The problem is the "^.*$" patterns to match child node names also match 
> properties like 'phandle'. Ideally, you'd have some pattern to match on 
> for the node names.
> 
> There is work-around doing:
> 
> "^.*$":
>   if:
>     type: object
>   then:
>     properties:
>       ...
> 

I believe I did try this and run into some other problems.

> But I much prefer to see node names updated. '-pins$' is a common 
> pattern.
> 

I have no problem requiring a pins suffix on the sub-nodes. Will
add that and send a new version, fixing up your other comments as
well. Thank you for your suggestions and review.

Thanks,
Charles
