Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5FAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFC6E204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="AMN5fQc5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgHYOke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:40:34 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:61998 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbgHYOk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 10:40:26 -0400
IronPort-SDR: jQXFCqjRieCb7k89dSJUs7dk2aK3dg/U7sIt28ziFJy7PplBNy7fQDlZrXhJVRnc1UcUVLEVL0
 WW8FlmNRme6hgqI2GJLjSXn1cvhygYj2JhoGtZeFEuy+HybNUWFU9LyiCyAI/bqMYFEqoVv80L
 30tIA/hkHCBEeWU5VJZ0r08d7yZVp3meXhNet/DBfx9IyGCCU8LE7PkF+JLzoaeLq+RDJqFFzC
 vMGUlJJzlau1RbJMN3fS/IGkXcEvF4a4yDnSTX6Vxo/2B0VrkthedaTWs6LUUlWmTD55L2iYWl
 +/c=
X-IronPort-AV: E=Sophos;i="5.76,352,1592863200"; 
   d="scan'208";a="13593256"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 25 Aug 2020 16:40:24 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 25 Aug 2020 16:40:24 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 25 Aug 2020 16:40:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1598366424; x=1629902424;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sydRdP2v+a39i3S/V7PW3+s/8G7TCO3YNXAMHCLf95Y=;
  b=AMN5fQc5FtN3uZ+KSJ/IsTH7uBBAfo919i8FZXa3cPHzIs6mIqRF8Dwl
   ygknbiIUndX0YPgaYJqnArx7dglmubtZbtAOwSShK2THpAcZrDFT7M8KJ
   coR6TPW1ODy/msF1QcGsDSIlYcCOZL4cK3iuYSL49BTg6Xw0HCz91VqFm
   ylurN2LpnRff6tHfynmQbRafx5rMO+UwoQvpLyMvjI1DjE/7WHKGIxX8u
   e8Q9+RlNkRFlv2mm9a2Vn2G/+Ahi6n0cpef4DTzLdbLIbgcM8zGwIviue
   a1T6zIIGOn2BY9uJFE+az6JIyTR8u5J7Up4ib/m27wdEDf3SNgRffj0JS
   g==;
IronPort-SDR: 74gmj+cYDEgk0e9qj2hMNWee9DTqE0mcv8+Bp3zHQOoKWGSYjKk3Kz/yL7o+wu/7jWeC316yLs
 z+ICd4Ye8EAHf9ooF6u383zhguu0oHd8SgnnCkDwAxSV4bNrNLm8qhjE4c8/NDTCtaPbGMAnzg
 vJcibrHnApuxkMgrqUDiBMYKb+1ZDEJQoGTx+TnUDwbZsIQ4v0+lC47o2NWo6aDQm3lZ2LEXiR
 vlG8eWAhMdqMOD55fhSYK68YxTkMkxMvH0lyieN5coxtGXkRHd83jpCUEJNjLViek8B1h4ozXV
 jFM=
X-IronPort-AV: E=Sophos;i="5.76,352,1592863200"; 
   d="scan'208";a="13593255"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 25 Aug 2020 16:40:24 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id E458C280065;
        Tue, 25 Aug 2020 16:40:23 +0200 (CEST)
Message-ID: <7a59492e46f34d213b83f7182c7db73954c5a9c7.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: (EXT) Re: [PATCH 2/2] ARM: dts: imx6qdl: tqma6: minor
 fixes
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 25 Aug 2020 16:40:23 +0200
In-Reply-To: <CAOMZO5DYrkEb_G+EYAGrc+qjSsbjRdeBUU3tJUfkU6tjgNm_7g@mail.gmail.com>
References: <20200824091013.20640-1-matthias.schiffer@ew.tq-group.com>
         <20200824091013.20640-2-matthias.schiffer@ew.tq-group.com>
         <CAOMZO5DSX1pf3xxo=CGvgPmHcjMJoWFx74grVJBckSmjtF-RGg@mail.gmail.com>
         <4b7d57738ce8e2130c4740a0f3f973fbaf60a7cf.camel@ew.tq-group.com>
         <CAOMZO5DYrkEb_G+EYAGrc+qjSsbjRdeBUU3tJUfkU6tjgNm_7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-08-25 at 11:24 -0300, Fabio Estevam wrote:
> Hi Matthias,
> 
> On Tue, Aug 25, 2020 at 4:22 AM Matthias Schiffer
> <matthias.schiffer@ew.tq-group.com> wrote:
> 
> > Hmm, unless I'm overlooking something, this is not going to work:
> > 
> > - spi_get_gpio_descs() sets num_chipselect to the maximum of the
> > num_chipselect set in the driver and the number of cs-gpios
> > 
> > - spi_imx_probe() sets num_chipselect to 3 if not specified in the
> > device tree
> > 
> > So I think we would end up with 3 instead of 1 chipselect.
> 
> Oh, this has changed recently in 8cdcd8aeee281 ("spi: imx/fsl-lpspi:
> Convert to GPIO descriptors"):
> ....
> 
> -       } else {
> -               u32 num_cs;
> -
> -               if (!of_property_read_u32(np, "num-cs", &num_cs))
> -                       master->num_chipselect = num_cs;
> -               /* If not preset, default value of 1 is used */
> 
> Initially, if num-cs was not present the default value for
> num_chipselect was 1.
> 
> -       }
> +       /*
> +        * Get number of chip selects from device properties. This
> can be
> +        * coming from device tree or boardfiles, if it is not
> defined,
> +        * a default value of 3 chip selects will be used, as all the
> legacy
> +        * board files have <= 3 chip selects.
> +        */
> +       if (!device_property_read_u32(&pdev->dev, "num-cs", &val))
> +               master->num_chipselect = val;
> +       else
> +               master->num_chipselect = 3;
> 
> Now it became 3.
> 
> I think this is a driver issue and we should fix the driver instead
> of
> requiring to pass num-cs to the device tree.
> 
> 
> num-cs is not even documented in the spi-imx binding.

Makes sense. Does the following logic sound correct?

- If num-cs is set, use that (and add it to the docs)
- If num-cs is unset, use the number of cs-gpios
- If num-cs is unset and no cs-gpios are defined, use a driver-provided 
default


I'm not sure if 3 is a particularly useful default either, but it seems
it was chosen to accommodate boards that previously set this via
platform data. All SoCs I've checked (i.MX6Q/DL, i.MX6UL, i.MX7) have 4
internal CS pins per ECSPI instance, so maybe the driver should use
that as its default instead?

