Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB80C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47C992076B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgHLQKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:10:35 -0400
Received: from smtprelay0182.hostedemail.com ([216.40.44.182]:51502 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726459AbgHLQKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:10:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id C8DC01800119A;
        Wed, 12 Aug 2020 16:10:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: net16_4b0fdbe26fec
X-Filterd-Recvd-Size: 2072
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Wed, 12 Aug 2020 16:10:31 +0000 (UTC)
Message-ID: <6a424468eb61e2eb9b014817819dd4da61f2ada1.camel@perches.com>
Subject: Re: [PATCH 35/44] staging: regulator: hi6421v600-regulator: add a
 driver-specific debug macro
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Date:   Wed, 12 Aug 2020 09:10:29 -0700
In-Reply-To: <7cb10b3910e9fa3e52d36e4e416030175cc761ab.1597247164.git.mchehab+huawei@kernel.org>
References: <cover.1597247164.git.mchehab+huawei@kernel.org>
         <7cb10b3910e9fa3e52d36e4e416030175cc761ab.1597247164.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-12 at 17:56 +0200, Mauro Carvalho Chehab wrote:
> Using dev_dbg() is not too nice, as, instead of printing the
> name of the regulator, it prints "regulator.<number>", making
> harder to associate what is happening with each ldo line.
> 
> So, add a debug-specific macro, which will print the rdev's
> name, just like the regulator core.

Seems sensible, but trivially:

> diff --git a/drivers/staging/hikey9xx/hi6421v600-regulator.c b/drivers/staging/hikey9xx/hi6421v600-regulator.c
[]
> @@ -209,10 +212,10 @@ static unsigned int hi6421_spmi_regulator_get_optimum_mode(struct regulator_dev
>  	struct hi6421v600_regulator *sreg = rdev_get_drvdata(rdev);
>  
>  	if (load_uA || ((unsigned int)load_uA > sreg->eco_uA)) {
> -		dev_dbg(&rdev->dev, "%s: normal mode", __func__);
> +		rdev_dbg(rdev, "normal mode");
>  		return REGULATOR_MODE_NORMAL;
>  	} else {
> -		dev_dbg(&rdev->dev, "%s: idle mode", __func__);
> +		rdev_dbg(rdev, "idle mode");

missing terminating newlines


