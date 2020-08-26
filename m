Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4325BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B3162080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="aHOapJ/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgHZKcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 06:32:32 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:48669 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbgHZKcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:32:21 -0400
IronPort-SDR: 9OZKk8jEcvCf/m3dpFJVwSgODe4S/NTgM3/BJZwc+totVibwYjJskgkHIvH1luqMNDHkMlI4mG
 zgIlbku+Y8eVt0IikwZWK+8XhVAfuuhKfvo6Ykxhyaft6JuOexl8+hqdSIl5NVP1hXwUYj/llX
 S9Mpzl0lQ8EnZP5QpWa7B2qjdM1zHr9E+qiXNuF//7nrNIEtiTi98bUk0+cgpPYPIbLWHAkd+y
 Ey93PlVoyr/4vvUSnPoGqUh+eUd1OoVQeFv4fVl+ket3cgLTjv0cxIWJmbgrBGi0KCaLtL26GJ
 i24=
X-IronPort-AV: E=Sophos;i="5.76,355,1592863200"; 
   d="scan'208";a="13605981"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 26 Aug 2020 12:32:19 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 26 Aug 2020 12:32:19 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 26 Aug 2020 12:32:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1598437939; x=1629973939;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mkEkX1GM1xbLiXkLbImdPglocH+IeXx6MxzXdXmSuoQ=;
  b=aHOapJ/zO9nEki7v7TnwPsS+h5yF6dMfYpoCz7nMFPhgXVt57jJp3gvm
   B1IH2vznv7YhNG3U0pd5ex5+BqQd2NkyxNP0CzE+ZS+Hk286HOIjqWRuJ
   qvlGBrulS8FVddQszJtWFnl7Ois8VRJQek7K7DiKE4GVNEWj7254/fF/m
   TLwlO5Eij84qVg/stvnBtQOEJQHOlUN4MeaPs4bbmpQy77l2ycOf70PtJ
   6rltUbvoVBDt+O9In/roV7A143w5TX3x7QDf1njCQxZFLyBKLDuwYS9gi
   8r/xEWF1YlOZofGI9CRAffjzjsNMukrN55vDoOcHOtlJnywwPWru8hkOM
   g==;
IronPort-SDR: YJeyxRPZU91peRDZT+5Vm5Z4NR4Ycx+N+xtKloknBbXfhabJim5XpCZLDn9YzBXcE4nYPq0kKu
 y0rzgEi0Y0MefjCCBwAjS/YRoF3JNbxoOFeAuEU++hmnORUiwzvBVX1dWNqGDUFw7TjwBVclyb
 8F8TaH874gCnt/7gCtT0UTlWf4KmIlz3pQLYsR+kcF1wCVqJOe64CdoYyB71/kJLAzFMirSRCE
 hz+NXVb+ZIsWJkOPbfYo7W8qH2UqejHbxLKhqnojoD0cK07w2E9bm9/V8PqkTJf7QS//C+PVLB
 7kA=
X-IronPort-AV: E=Sophos;i="5.76,355,1592863200"; 
   d="scan'208";a="13605980"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 26 Aug 2020 12:32:19 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id B4B6A2800A2;
        Wed, 26 Aug 2020 12:32:19 +0200 (CEST)
Message-ID: <53f5f17735fc2f0ca061a321969bbb131e55efff.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: (EXT) Re: (EXT) Re: [PATCH 2/2] ARM: dts: imx6qdl:
 tqma6: minor fixes
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 26 Aug 2020 12:32:17 +0200
In-Reply-To: <CAOMZO5CP=wtJ5ZScyb0NrRMW0FR0FAGVKRFq9JpFcAoZppn_bA@mail.gmail.com>
References: <20200824091013.20640-1-matthias.schiffer@ew.tq-group.com>
         <20200824091013.20640-2-matthias.schiffer@ew.tq-group.com>
         <CAOMZO5DSX1pf3xxo=CGvgPmHcjMJoWFx74grVJBckSmjtF-RGg@mail.gmail.com>
         <4b7d57738ce8e2130c4740a0f3f973fbaf60a7cf.camel@ew.tq-group.com>
         <CAOMZO5DYrkEb_G+EYAGrc+qjSsbjRdeBUU3tJUfkU6tjgNm_7g@mail.gmail.com>
         <7a59492e46f34d213b83f7182c7db73954c5a9c7.camel@ew.tq-group.com>
         <CAOMZO5CP=wtJ5ZScyb0NrRMW0FR0FAGVKRFq9JpFcAoZppn_bA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-08-25 at 14:16 -0300, Fabio Estevam wrote:
> On Tue, Aug 25, 2020 at 11:40 AM Matthias Schiffer
> <matthias.schiffer@ew.tq-group.com> wrote:
> 
> > Makes sense. Does the following logic sound correct?
> > 
> > - If num-cs is set, use that (and add it to the docs)
> 
> I would not add num-cs to the docs. As far as I can see there is no
> imx dts that uses num-cs currently.

But the previous platform data that was removed in 8cdcd8aeee281 ("spi:
imx/fsl-lpspi: Convert to GPIO descriptors") set different values for
different boards. So maybe some DTS should be using num-cs?


> 
> > - If num-cs is unset, use the number of cs-gpios
> > - If num-cs is unset and no cs-gpios are defined, use a driver-
> > provided
> > default
> > 
> > 
> > I'm not sure if 3 is a particularly useful default either, but it
> > seems
> > it was chosen to accommodate boards that previously set this via
> > platform data. All SoCs I've checked (i.MX6Q/DL, i.MX6UL, i.MX7)
> > have 4
> > internal CS pins per ECSPI instance, so maybe the driver should use
> > that as its default instead?
> 
> I think it is time to get rid of i.MX board files. I will try to work
> on this when I have a chance.
> 
> bout using 4 as default chip select number, please also check some
> older SoCs like imx25, imx35, imx51, imx53, etc

Hmm, I just checked i.MX28, and it has only 3 chip selects per
instance.

