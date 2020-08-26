Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC199C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7ED820786
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="YoGfd8WV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgHZKec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 06:34:32 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:35753 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728097AbgHZKeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:34:24 -0400
IronPort-SDR: bEmQOhqt/RVxLi8qrohUeFGjfx0whtkFiSe1ttPZpq4EcaXgFr+tqdg/9IC2o55+gIU2+xMrXu
 W8kYusvoryu1zFuqp/JtyXxfIVRr3odfjStCrRuzAkTy63L2fO9reiKbigD5sgisHRtOACFh8u
 9sosAKachGbqLC7+PMpjLmpOmsdHgTs1oL4aDuDpmizQnKiWO5Uz5RIXZvpXg+oLw3mkd0AxuY
 WE4pVmDlEDyrSnh1agSz3cZ49Ux0GGk4UbtYijLyHi8PEhvaX18/9S4HR78BSVXl9jFkEmP9pM
 Klk=
X-IronPort-AV: E=Sophos;i="5.76,355,1592863200"; 
   d="scan'208";a="13606017"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 26 Aug 2020 12:34:23 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 26 Aug 2020 12:34:23 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 26 Aug 2020 12:34:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1598438063; x=1629974063;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5i7iaEu0vG5/R+/iniXaInjvHokJLmGCBFxiqsZuCqU=;
  b=YoGfd8WVBLYhBafhkzyNnNKyR8tsgFYqgze5bQTYr3wecGXkNuNRLKsg
   T1Ug6LYuq+LelRxYm0PvzGlxvXum9z7nxtoKqcflbchcjLrFI9b7amCOD
   i8TsHL+fdrf7zp0GRzoHNGDAWvi2sP/63b/uiQD/L+sD2iL+ksHcjv3I1
   MAKymo+szoZ19gTLOlvzivu94Ehq2mS6tk9IsoxKsA3sZ6jgLrbZ2XZcR
   1l/fU0UKR52+L/QqcisZ72bqFYS6komaBVHZJBFKdHIbylSdwkPBkxVx6
   H//jOJrMmPnrqmMkvuLcMlerjjSbAtcBXt5B4I6+yiA2kkazZLG/1oveL
   A==;
IronPort-SDR: Y9y7BnNWEoeJNq87gCXjrHv2slBRkRaCfVKhZtx7kYL028KH3Lsq/tmXFZcTdv08VGICqco1Mt
 gK5UhlG0YfM+SYfejE6Fwo2R0D3GH+7dyFRouGHcBef6LNiqpPpK1o+9PkPWPH5HQ+QHpGBwO/
 /+tnlpQeDteBZcpJ9plyEqKM+AvOZZLkCbndcJRUFDDc9k2N0j2n6P5glNc35rPRvdNbOa1b8p
 o2mEOYGgHmVPGW6eRpkooAocwSjtz+wrd+Vm7rzHWJVrUewUtgPz9vXZpmYDjhJB0QLsRk9yzD
 4gw=
X-IronPort-AV: E=Sophos;i="5.76,355,1592863200"; 
   d="scan'208";a="13606016"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 26 Aug 2020 12:34:23 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 77D98280070;
        Wed, 26 Aug 2020 12:34:23 +0200 (CEST)
Message-ID: <0ea726119e761368e63fa90d1d3077ff2e44739a.camel@ew.tq-group.com>
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
Date:   Wed, 26 Aug 2020 12:34:21 +0200
In-Reply-To: <53f5f17735fc2f0ca061a321969bbb131e55efff.camel@ew.tq-group.com>
References: <20200824091013.20640-1-matthias.schiffer@ew.tq-group.com>
         <20200824091013.20640-2-matthias.schiffer@ew.tq-group.com>
         <CAOMZO5DSX1pf3xxo=CGvgPmHcjMJoWFx74grVJBckSmjtF-RGg@mail.gmail.com>
         <4b7d57738ce8e2130c4740a0f3f973fbaf60a7cf.camel@ew.tq-group.com>
         <CAOMZO5DYrkEb_G+EYAGrc+qjSsbjRdeBUU3tJUfkU6tjgNm_7g@mail.gmail.com>
         <7a59492e46f34d213b83f7182c7db73954c5a9c7.camel@ew.tq-group.com>
         <CAOMZO5CP=wtJ5ZScyb0NrRMW0FR0FAGVKRFq9JpFcAoZppn_bA@mail.gmail.com>
         <53f5f17735fc2f0ca061a321969bbb131e55efff.camel@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-26 at 12:32 +0200, Matthias Schiffer wrote:
> On Tue, 2020-08-25 at 14:16 -0300, Fabio Estevam wrote:
> > On Tue, Aug 25, 2020 at 11:40 AM Matthias Schiffer
> > <matthias.schiffer@ew.tq-group.com> wrote:
> > 
> > > Makes sense. Does the following logic sound correct?
> > > 
> > > - If num-cs is set, use that (and add it to the docs)
> > 
> > I would not add num-cs to the docs. As far as I can see there is no
> > imx dts that uses num-cs currently.
> 
> But the previous platform data that was removed in 8cdcd8aeee281
> ("spi:
> imx/fsl-lpspi: Convert to GPIO descriptors") set different values for
> different boards. So maybe some DTS should be using num-cs?
> 
> 
> > 
> > > - If num-cs is unset, use the number of cs-gpios
> > > - If num-cs is unset and no cs-gpios are defined, use a driver-
> > > provided
> > > default
> > > 
> > > 
> > > I'm not sure if 3 is a particularly useful default either, but it
> > > seems
> > > it was chosen to accommodate boards that previously set this via
> > > platform data. All SoCs I've checked (i.MX6Q/DL, i.MX6UL, i.MX7)
> > > have 4
> > > internal CS pins per ECSPI instance, so maybe the driver should
> > > use
> > > that as its default instead?
> > 
> > I think it is time to get rid of i.MX board files. I will try to
> > work
> > on this when I have a chance.
> > 
> > bout using 4 as default chip select number, please also check some
> > older SoCs like imx25, imx35, imx51, imx53, etc
> 
> Hmm, I just checked i.MX28, and it has only 3 chip selects per
> instance.

Ah sorry, I got confused, the i.MX28 has a different SPI IP.

