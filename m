Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D59C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35BC6206F1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="V2Zcmjj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgFAJyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:54:50 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:53058 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725788AbgFAJyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:54:49 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0519lPZN005215;
        Mon, 1 Jun 2020 04:54:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=RRGaQP35ZDNGRYX2W5JyMyYqAYjX6jIWRGFXCkH9Bwk=;
 b=V2Zcmjj8sqedMxpVBoMPPcF0N/EQpxkrgqomZV4SJgMQiaSWB9yggYj1Bsaz3MIA2/4j
 hPSPkbbZjorWy46bW1P/+U/Qua1JCpyEoRd3QCEmdqCJdJv51PXrQow018aQ5n9KNN8h
 IR+y+Qteu+4OEYTvzl08+n/7vkE+MAlbQgT96RlrJ5FFY9PhJmsZkXEsc7p9jowI5Zvt
 OIGDcwhqkOEHZ3ZGvHfsFHXpDCjfYPh/IkcdiIqfBprwu9CgPJ2t+SBeYXHphtPIz9R5
 YupYO86mUFWS/87IP49PMTzL8wIJM3D7OiKxnyy7GTzNGegQIH0S/YFGExXjNFM1+On9 RA== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 31bkwna7q3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 01 Jun 2020 04:54:45 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 1 Jun 2020
 10:54:44 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 1 Jun 2020 10:54:44 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id EA10B2AB;
        Mon,  1 Jun 2020 09:54:43 +0000 (UTC)
Date:   Mon, 1 Jun 2020 09:54:43 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <s.nawrocki@samsung.com>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH 2/3] mfd: madera: Fix minor formatting issues
Message-ID: <20200601095443.GJ71940@ediswmail.ad.cirrus.com>
References: <20200529155742.18399-1-ckeepax@opensource.cirrus.com>
 <20200529155742.18399-2-ckeepax@opensource.cirrus.com>
 <20200601052433.GA3714@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200601052433.GA3714@dell>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 cotscore=-2147483648 impostorscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006010072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 06:24:33AM +0100, Lee Jones wrote:
> On Fri, 29 May 2020, Charles Keepax wrote:
> 
> Still needs a commit log.
> 
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> >  drivers/mfd/madera-core.c        | 12 ++++++------
> >  drivers/mfd/madera-i2c.c         |  1 -
> >  include/linux/mfd/madera/pdata.h |  1 -
> >  3 files changed, 6 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
> > index 7e0835cb062b1..4724c1a01a39f 100644
> > --- a/drivers/mfd/madera-core.c
> > +++ b/drivers/mfd/madera-core.c
> > @@ -44,7 +44,7 @@ static const char * const madera_core_supplies[] = {
> >  };
> >  
> >  static const struct mfd_cell madera_ldo1_devs[] = {
> > -	{ .name = "madera-ldo1" },
> > +	{ .name = "madera-ldo1", },
> 
> What issue does this solve?
> 
> Why are ','s a requirement, even for single entries?
> 

Was more just a consistency thing, we seem to have ended up with
half the lines having commas and half not, happy to move them all
to not having comma's if that is your preference?

> >  };
> >  
> >  static const char * const cs47l15_supplies[] = {
> > @@ -55,8 +55,8 @@ static const char * const cs47l15_supplies[] = {
> >  
> >  static const struct mfd_cell cs47l15_devs[] = {
> >  	{ .name = "madera-pinctrl", },
> > -	{ .name = "madera-irq" },
> > -	{ .name = "madera-gpio" },
> > +	{ .name = "madera-irq", },
> > +	{ .name = "madera-gpio", },
> >  	{
> >  		.name = "madera-extcon",
> >  		.parent_supplies = cs47l15_supplies,
> > @@ -108,7 +108,7 @@ static const char * const cs47l85_supplies[] = {
> >  static const struct mfd_cell cs47l85_devs[] = {
> >  	{ .name = "madera-pinctrl", },
> >  	{ .name = "madera-irq", },
> > -	{ .name = "madera-micsupp" },
> > +	{ .name = "madera-micsupp", },
> >  	{ .name = "madera-gpio", },
> >  	{
> >  		.name = "madera-extcon",
> > @@ -155,10 +155,10 @@ static const char * const cs47l92_supplies[] = {
> >  };
> >  
> >  static const struct mfd_cell cs47l92_devs[] = {
> > -	{ .name = "madera-pinctrl" },
> > +	{ .name = "madera-pinctrl", },
> >  	{ .name = "madera-irq", },
> >  	{ .name = "madera-micsupp", },
> > -	{ .name = "madera-gpio" },
> > +	{ .name = "madera-gpio", },
> >  	{
> >  		.name = "madera-extcon",
> >  		.parent_supplies = cs47l92_supplies,
> > diff --git a/drivers/mfd/madera-i2c.c b/drivers/mfd/madera-i2c.c
> > index 6b965eb034b6c..7df5b9ba58554 100644
> > --- a/drivers/mfd/madera-i2c.c
> > +++ b/drivers/mfd/madera-i2c.c
> > @@ -88,7 +88,6 @@ static int madera_i2c_probe(struct i2c_client *i2c,
> >  	if (!madera)
> >  		return -ENOMEM;
> >  
> > -
> >  	madera->regmap = devm_regmap_init_i2c(i2c, regmap_16bit_config);
> >  	if (IS_ERR(madera->regmap)) {
> >  		ret = PTR_ERR(madera->regmap);
> > diff --git a/include/linux/mfd/madera/pdata.h b/include/linux/mfd/madera/pdata.h
> > index fa9595dd42ba5..601cbbc10370c 100644
> > --- a/include/linux/mfd/madera/pdata.h
> > +++ b/include/linux/mfd/madera/pdata.h
> > @@ -21,7 +21,6 @@
> >  
> >  struct gpio_desc;
> >  struct pinctrl_map;
> > -struct madera_codec_pdata;
> 
> This is not a formatting issue.

Fair point will split out into a separate patch.

Thanks,
Charles
