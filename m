Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838BDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7444921744
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbgHDPVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 11:21:32 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:58967 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728586AbgHDPVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 11:21:30 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MlO5j-1kS5p72cbl-00losF for <linux-kernel@vger.kernel.org>; Tue, 04 Aug
 2020 17:21:28 +0200
Received: by mail-qk1-f171.google.com with SMTP id j187so38658939qke.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 08:21:28 -0700 (PDT)
X-Gm-Message-State: AOAM5334Pgh1SnXVwvrMEj3zNiDmf90NkHNaaiAjIdp0jbo3kdvJNq7a
        ZRbqAJY5aQrolhKEyooxw2oAwjpa5sIB6A6I2bI=
X-Google-Smtp-Source: ABdhPJyqR0JKD5WDdjJqXHl8+I3VYl4t/sxpgkVHxu1mBIUS/nvjYG2flIcP3gNxVNV1hEKxNSOlftY4i52/6nHhByE=
X-Received: by 2002:a37:b942:: with SMTP id j63mr21276071qkf.138.1596554487389;
 Tue, 04 Aug 2020 08:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200804135817.5495-1-daniel.gutson@eclypsium.com>
In-Reply-To: <20200804135817.5495-1-daniel.gutson@eclypsium.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 4 Aug 2020 17:21:11 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0_fJ0BfD5Qvxdo0s7CbjPWaGA8QTgYhbXR=omafOHH4Q@mail.gmail.com>
Message-ID: <CAK8P3a0_fJ0BfD5Qvxdo0s7CbjPWaGA8QTgYhbXR=omafOHH4Q@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: intel-spi: Do not try to make the SPI flash
 chip writable
To:     Daniel Gutson <daniel.gutson@eclypsium.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        Richard Hughes <hughsient@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:STqhhJfpKKAK1AB/cFdrob5M4IvFeQWpA4bOHXV4mM6Ky2fCFY9
 KFK6/aftGsefuj5OzXIgY1IRlf+P7MDe5EwEssDXULhxrpwrJLiUbNngnibIO6b6IB6f9+e
 YdaudE2gs3plsYiAAX4hAdvkIcmuETtKHtEME8Oqp8Z272dXW753uNE1VZcUJJJsGoQC13C
 ALYF99GdJSvVfnNKS9YRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hi2JWcJe3uQ=:Q/FrI38f8hF24m6ccsXapv
 i3FIC8JBK+7DDaTShcqMkAt5tXcysjRoWOkkNLOiUuqm/On5RD7YIZrIPm0uCoui8cVAXfG3d
 FaJxdjfEi5JTGKmkYyrUCcgh2A2AROx6VYTOuxdX0h9Xdw5WeSVqMJHko7dT2RnrDDfQgYJyY
 XYkVqtfuM8R0+i2HoRZcU8rVlajVkj8kvGjVSqBh6VIplcwN0KaWyKdBbHYIw3Ujw8za/l07M
 plXLQz//n2er4Mq/A+MXZYNSS/U+llUQLupXUQTqkCCI2qL7PSGgY5hvaFRUJIDIY4KAT31Nd
 NWdBas5B8+7S7ob80K4lnlkHDd3rKpTUkEEP0YkWdwWPL+RtvVjTehG+AWBzipG/W1j/OF+/w
 VVW25ldlCHrIevLx6rW2DqyMb8JvPOS+fYaX1Gwcsi6CTt1UUHFIlwglgVYIGyfurSLwTPneE
 xKrjXGDcmd/gf+U33BVI4GPsXE3gucAd6t/ydkCr8KiQg3eSEVR3R74PY0mJdyu57pHNWmRB2
 o6a0xShsNQm2JVs0NUuQWmAZ09sGYaOvQEaE0e7MhBZFpdB2IrMcdRIYHYTZVMDvdm1pWc/Ep
 5iHtMqCZVmSGrSkU+tJcA7Cf7/BqL/RdgfjeXo8BVeIa5kL/vnsOOKWI0dkcYIlKKq0KW+DWR
 Jhbv62G2a1LDPdcgqdvND7FCmLkSkCB3nbrvo1gJH4HmvM6uZawCnZJpN+EPyZsKybp0dibw1
 mnmCHYvz34nEu5TALp/vT57eJj8NW3k5c5+krGu50Lz8O5SEcbJ5GMuz0BdvaoXzjco/nTnbt
 eHMUzdJpv+QAjojjYH5/zmIbsHxBheFreKiEh4+jqisLdoo3pfkXkPm509wCs5IjZDrBf8l
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 4, 2020 at 3:58 PM Daniel Gutson
<daniel.gutson@eclypsium.com> wrote:
>
> Context, the intel-spi has a module argument that controls
> whether the driver attempts to turn the SPI flash chip writeable.
> The default value is FALSE (don't try to make it writeable).
> However, this flag applies only for a number of devices, coming from the
> platform driver, whereas the devices detected through the PCI driver
> (intel-spi-pci) are not subject to this check since the configuration
> takes place in intel-spi-pci which doesn't have an argument.

This is still factually incorrect, as explained at least three times
now.

Please either make the same change for both the Bay Trail
platform driver and the PCI driver, or explain why you want them to
be different rather than incorrectly claiming that you change them to
be the same.

If you want the BIOS setting to always take precedence over the
module argument, logical change would be to also include
the corresponding change for bay trail and do:

--- a/drivers/mtd/spi-nor/controllers/intel-spi.c
+++ b/drivers/mtd/spi-nor/controllers/intel-spi.c
@@ -324,19 +324,6 @@ static int intel_spi_init(struct intel_spi *ispi)
                ispi->nregions = BYT_FREG_NUM;
                ispi->pr_num = BYT_PR_NUM;
                ispi->swseq_reg = true;
-
-               if (writeable) {
-                       /* Disable write protection */
-                       val = readl(ispi->base + BYT_BCR);
-                       if (!(val & BYT_BCR_WPD)) {
-                               val |= BYT_BCR_WPD;
-                               writel(val, ispi->base + BYT_BCR);
-                               val = readl(ispi->base + BYT_BCR);
-                       }
-
-                       ispi->writeable = !!(val & BYT_BCR_WPD);
-               }
-
                break;

        case INTEL_SPI_LPT:
