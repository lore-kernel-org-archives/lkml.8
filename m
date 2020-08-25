Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421F5C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D0D120665
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="szXKpbW6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgHYOYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHYOYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 10:24:16 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50CAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 07:24:15 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w25so13998798ljo.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 07:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nXQjU6OEFoB3/boXeRzXBJsBgW4XWcKUgixiYsXTEJo=;
        b=szXKpbW63POBP0IDXkHNpXWjBWBeJdeQX9Z/yfahammWxTplNTc2Sm3ME/ZiKBfXin
         wbUJ/HdgMJvu//SSLay4FqQy99hcy267TXCOlIrawMCGn01DSblBT0zSeeDbUtjDhK+7
         Xl9RjAAT+QQgVdBpoQtNVEBeiVouOrpdNx0sNKx+5BQ17XJSdbwiN7mTn0A2eWeRmu9S
         SBN+ovPZPCkhwrLG+M+2/IrZhV+iQiygbNR9UKEuxX+JjI34WuyU9tGoBCky8oTzhuik
         XXiLoUO/ZpA+4CM+BxXyNHjyLKqy2fvCrcR/y6GiJEEga9OrCH0wBZ5qXUTJIdBjm3rW
         kPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nXQjU6OEFoB3/boXeRzXBJsBgW4XWcKUgixiYsXTEJo=;
        b=T2jsI0UotUp4NPm4hOIXMdViwPVkGmpa8XL8wRSBYCr7Dxv3SbP0o0h6Mtr/ye3RNc
         QF5RMnDC2YHzldJudfVm4rOi10UCjCERn8QFTiJXi8Vf/bwMI0tTAXVjx2leeZExDZ/0
         Y69GTXv3f4UQIuzfVxaTtlXklFL6qXoNfgYZ/Ep8HOedx2UXbe09YxmlN2MiSxPKCMr1
         fKAEhh1lJg1OU64ITyruUx5amVdnoeAndZl4U+wOwjiOhBUoBWP04npEoUDB7fLkCN3j
         rnHv+M5Pq96AlY3R/Wf8RblwE/4yf0OCUXIFlf4mRL66BYIgk+gypaY/23YZvM2BzUry
         AOQg==
X-Gm-Message-State: AOAM530+/RJPyN6F76IWN7Gl6uYpz+FqGET1j+X3muSgDPJZ+h9pXl1/
        +pFbFiKj7rjGeslBU+V7AkovAJqa6xMH75vgOAk=
X-Google-Smtp-Source: ABdhPJxBj1sEXsKUamx0YZrSBtWQjJ74+3rp3RhFUpdmOvR7HsforetI3GkKVTUY7N4/ds4cxGBGp7yoG09mDtHd2lo=
X-Received: by 2002:a2e:1417:: with SMTP id u23mr5286032ljd.44.1598365454126;
 Tue, 25 Aug 2020 07:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200824091013.20640-1-matthias.schiffer@ew.tq-group.com>
 <20200824091013.20640-2-matthias.schiffer@ew.tq-group.com>
 <CAOMZO5DSX1pf3xxo=CGvgPmHcjMJoWFx74grVJBckSmjtF-RGg@mail.gmail.com> <4b7d57738ce8e2130c4740a0f3f973fbaf60a7cf.camel@ew.tq-group.com>
In-Reply-To: <4b7d57738ce8e2130c4740a0f3f973fbaf60a7cf.camel@ew.tq-group.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 25 Aug 2020 11:24:02 -0300
Message-ID: <CAOMZO5DYrkEb_G+EYAGrc+qjSsbjRdeBUU3tJUfkU6tjgNm_7g@mail.gmail.com>
Subject: Re: (EXT) Re: [PATCH 2/2] ARM: dts: imx6qdl: tqma6: minor fixes
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Tue, Aug 25, 2020 at 4:22 AM Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:

> Hmm, unless I'm overlooking something, this is not going to work:
>
> - spi_get_gpio_descs() sets num_chipselect to the maximum of the
> num_chipselect set in the driver and the number of cs-gpios
>
> - spi_imx_probe() sets num_chipselect to 3 if not specified in the
> device tree
>
> So I think we would end up with 3 instead of 1 chipselect.

Oh, this has changed recently in 8cdcd8aeee281 ("spi: imx/fsl-lpspi:
Convert to GPIO descriptors"):
....

-       } else {
-               u32 num_cs;
-
-               if (!of_property_read_u32(np, "num-cs", &num_cs))
-                       master->num_chipselect = num_cs;
-               /* If not preset, default value of 1 is used */

Initially, if num-cs was not present the default value for num_chipselect was 1.

-       }
+       /*
+        * Get number of chip selects from device properties. This can be
+        * coming from device tree or boardfiles, if it is not defined,
+        * a default value of 3 chip selects will be used, as all the legacy
+        * board files have <= 3 chip selects.
+        */
+       if (!device_property_read_u32(&pdev->dev, "num-cs", &val))
+               master->num_chipselect = val;
+       else
+               master->num_chipselect = 3;

Now it became 3.

I think this is a driver issue and we should fix the driver instead of
requiring to pass num-cs to the device tree.


num-cs is not even documented in the spi-imx binding.
