Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72B3C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A18DC20578
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="S9mqBrBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbgHYHWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 03:22:31 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:12666 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729363AbgHYHW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 03:22:28 -0400
IronPort-SDR: eNmFQX5PpPmcEviaQ2tfOjEkWWdWkKRzvrImmUXl5mVRrlUFPtqZ1wE+lK5yUYBsvhcmqsJCih
 WZDOx5VMYDnh/viACzRfE1Tkh+vbv8SOTGngblCPqnNJLtiYDqHBsS5aA5nttEjVzxD8QJC3I7
 ex0xbFCkwsEMSF4s6ua0kKt75D+5gMj+RgDujclKkAP8wBUQcuoyiwyYCv9HyUg4fj5mw8T5nS
 YdSyBiigWoxxCAXJ4Z56l3KNpG2OmZkMQYvXTzJvIQI35XhVFRjkMSh1p9SzyhUAXp+PfZ4NFG
 UCs=
X-IronPort-AV: E=Sophos;i="5.76,351,1592863200"; 
   d="scan'208";a="13583860"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 25 Aug 2020 09:22:25 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 25 Aug 2020 09:22:25 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 25 Aug 2020 09:22:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1598340145; x=1629876145;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4N6dkL/kwNBk8VB5tEU1JJE9/9Y0/PoteI2pocptzkY=;
  b=S9mqBrBKlNgb+0T+IF2kdpiiEGgikcqmK+2fhaPMQJBD4DIq/WyVeZUY
   hk8Uc7pGbgtT8T0BxzUrOWgSdvR3pbcNFDU/uHEqRutJi94N0uOETQEe3
   TZOW8vs4lTYu+W0Vs9DTPtJgkis5DHAzYDcHO4XNtIqflxmKkfxpqw86G
   4HVkmztL4Vayzhc17aZ/7uLrlikyPvTs04c+TcCWzM1ZxBFP6HxJka2oC
   4N/Fb24BOEWifJHAHJUFk9wPPpD1fePf3eNrUr6kcFi4DDfLnm7qSZd94
   6KWM+/iLV9kkdgWoUbtmvWeXFh+8DBSNy2OwowGeZwTC6lEnHHNCTGCRu
   A==;
IronPort-SDR: Mo8sm6JNKdJHPOvnPGZCJUM1pHbd62JlnrYNHSQgJoCMunDMl/YvYKBGo/yinevAYV9fXAP/dm
 /N+Bn7rRGKn+6l2bl09VCsiCxkYyPE2Y/rmrtBKTia197y7YgLR10w/PNaGf9dGkJUOGd/1rFn
 8qBVKRuQKPewSYPNAY1bruwsF8E7N67Z/3slrcCdP1CmsG2HAdsoMrjAhx63ZU6m5BDP5Eg+zg
 Z/TbokoBRUguSjMRQNg/JF5yOx52odm/yjXG0ZnZI5tB3Bia0cYgNTus5WzDoZWHYBc6fbdP0X
 YMg=
X-IronPort-AV: E=Sophos;i="5.76,351,1592863200"; 
   d="scan'208";a="13583859"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 25 Aug 2020 09:22:25 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 87F0B280065;
        Tue, 25 Aug 2020 09:22:25 +0200 (CEST)
Message-ID: <4b7d57738ce8e2130c4740a0f3f973fbaf60a7cf.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: [PATCH 2/2] ARM: dts: imx6qdl: tqma6: minor fixes
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 25 Aug 2020 09:22:23 +0200
In-Reply-To: <CAOMZO5DSX1pf3xxo=CGvgPmHcjMJoWFx74grVJBckSmjtF-RGg@mail.gmail.com>
References: <20200824091013.20640-1-matthias.schiffer@ew.tq-group.com>
         <20200824091013.20640-2-matthias.schiffer@ew.tq-group.com>
         <CAOMZO5DSX1pf3xxo=CGvgPmHcjMJoWFx74grVJBckSmjtF-RGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-24 at 18:36 -0300, Fabio Estevam wrote:
> Hi Matthias,
> 
> On Mon, Aug 24, 2020 at 6:10 AM Matthias Schiffer
> <matthias.schiffer@ew.tq-group.com> wrote:
> 
> > diff --git a/arch/arm/boot/dts/imx6qdl-tqma6.dtsi
> > b/arch/arm/boot/dts/imx6qdl-tqma6.dtsi
> > index 9513020ddd1a..7aaae83c1fae 100644
> > --- a/arch/arm/boot/dts/imx6qdl-tqma6.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl-tqma6.dtsi
> > @@ -20,7 +20,7 @@
> >  &ecspi1 {
> >         pinctrl-names = "default";
> >         pinctrl-0 = <&pinctrl_ecspi1>;
> > -       fsl,spi-num-chipselects = <1>;
> > +       num-cs = <1>;
> 
> You could simply remove fsl,spi-num-chipselects without passing num-
> cs.
> 
> The spi core is able to count the number of chipselects passed via
> cs-gpios in the device tree.

Hmm, unless I'm overlooking something, this is not going to work:

- spi_get_gpio_descs() sets num_chipselect to the maximum of the
num_chipselect set in the driver and the number of cs-gpios

- spi_imx_probe() sets num_chipselect to 3 if not specified in the
device tree

So I think we would end up with 3 instead of 1 chipselect.


Kind regards,
Matthias

