Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F8DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77ABB20707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="K4A081Ip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbgHZNNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:13:30 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:11356 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729177AbgHZNN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:13:26 -0400
IronPort-SDR: pFmwl+dBjkX+0lVomhiKnC0L895FpwSD9mrbpFhhSWCwUlbed90E4e+M4hocR6rJWI8E+fYOi9
 asKOJibFU0c4wM68W+/1L8tzMq0lkkhePcamptJ0BelKlSDX3EjVU2G4Cb9v8FP/7R4M1Qd/0Q
 KWCEspmLCZhGeh6nR0sK6NTVlzv0m/Oe93Xui84afs9QcniTZoQLngN9PDBMGgiEigN0CUHokT
 0TZJ05evt4mvhxH3MBFVL6QyZCGbncWMsIHJIxGoO4fYIf2Zy13ueBCxAwpRUhRGsQzYrT105d
 7ck=
X-IronPort-AV: E=Sophos;i="5.76,355,1592863200"; 
   d="scan'208";a="13609275"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 26 Aug 2020 15:13:24 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 26 Aug 2020 15:13:24 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 26 Aug 2020 15:13:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1598447604; x=1629983604;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KVe1P5ErSIxwMjJGwp2tRmMWUftzZryOsrNozm2qIy0=;
  b=K4A081IpBbZWhGUycqChqEwWmyVhD9+05oMM7EO3K6e2Jvg35Spf+nte
   Vx9s6I5plKOF9KHoS3mjoS1c+sgRnbRPluV+C3yZEcmr1HSbtOSYXI2q2
   Is6bDY0BiXrXPUUQyvxhybO2woQ2nQfJ9yDUkCmA4SYRaaqy0KfOq2Y3t
   iYL6762wSEGjcimJeK5bHDslYeZo5LcumazL0lgzAMz+aYXV0kKYIuNIX
   ImxeTvYgzIxt9a78vfkkRRG8rN40Y5EwhpoghMaqgomXzR8Unov9we4eC
   oIU2ArKFRe8sxdqzcjU1hY45W+BjxHqF+HfoqbyzeYshxXgDYQyGpDDkZ
   g==;
IronPort-SDR: 4jgI/O/kR2YJg5j4IVecx0LZX8tFwJOl/FrgdpzBRkAlC9iCV8r2+WC+OkypgW1jqQR5HEvL+o
 E0sPei3L4tYGRomn03HTtIuz0W/TMntlLzh2ThnmA1Kr3w4+9ajuOrAVLWQokj+1bmNenlxzTJ
 68ljiby78ubfWza0fEaqyJ1vsWHRcH/07ttwN8kRp3/q35cntao3xgQ34Ot0uY/MRgGYDkiFoa
 qjb9xXqjY22nLDFGZGovAAybDef+E0JHN9nFUkx07o0eacKvkNof6+6o0kFlH/y0bfhqLN9aiS
 pGo=
X-IronPort-AV: E=Sophos;i="5.76,355,1592863200"; 
   d="scan'208";a="13609274"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 26 Aug 2020 15:13:24 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 5BA71280065;
        Wed, 26 Aug 2020 15:13:24 +0200 (CEST)
Message-ID: <d433e8a47d721a65903db68c38eb1c337c81e395.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: (EXT) Re: (EXT) Re: (EXT) Re: (EXT) Re: [PATCH 2/2]
 ARM: dts: imx6qdl: tqma6: minor fixes
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 26 Aug 2020 15:13:22 +0200
In-Reply-To: <CAOMZO5B_Jm8SX9N9V5oq+LAa0Yc4CmrEp2n=2t3XUyBCtnGVTA@mail.gmail.com>
References: <20200824091013.20640-1-matthias.schiffer@ew.tq-group.com>
         <20200824091013.20640-2-matthias.schiffer@ew.tq-group.com>
         <CAOMZO5DSX1pf3xxo=CGvgPmHcjMJoWFx74grVJBckSmjtF-RGg@mail.gmail.com>
         <4b7d57738ce8e2130c4740a0f3f973fbaf60a7cf.camel@ew.tq-group.com>
         <CAOMZO5DYrkEb_G+EYAGrc+qjSsbjRdeBUU3tJUfkU6tjgNm_7g@mail.gmail.com>
         <7a59492e46f34d213b83f7182c7db73954c5a9c7.camel@ew.tq-group.com>
         <CAOMZO5CP=wtJ5ZScyb0NrRMW0FR0FAGVKRFq9JpFcAoZppn_bA@mail.gmail.com>
         <53f5f17735fc2f0ca061a321969bbb131e55efff.camel@ew.tq-group.com>
         <CAOMZO5ADeXEHWiG7Xja1W1GnahV08ZEYSkNsrOzautn2mROCNA@mail.gmail.com>
         <aa0b7ad149a7bd4e681e4ebee12ffaaab2803832.camel@ew.tq-group.com>
         <CAOMZO5B_Jm8SX9N9V5oq+LAa0Yc4CmrEp2n=2t3XUyBCtnGVTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-26 at 10:01 -0300, Fabio Estevam wrote:
> On Wed, Aug 26, 2020 at 8:54 AM Matthias Schiffer
> <matthias.schiffer@ew.tq-group.com> wrote:
> 
> > Before 8cdcd8aeee281, num_chipselect was set to 3 for spi0 and to 1
> > for
> > spi1 in arch/arm/mach-imx/mach-mx31lite.c. My understanding is that
> > it
> > would make sense to add this as num-cs to
> > arch/arm/boot/dts/imx31-lite.dts.
> 
> Or just pass cs-gpios instead?

Using GPIOs for chipselect would require different pinmuxing. Also, why
use GPIOs, when the SPI controller has this built in?

