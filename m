Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF52C2BA18
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 07:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E85120719
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 07:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="E0e8cult"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgDFHRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 03:17:03 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38476 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgDFHRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 03:17:02 -0400
Received: by mail-qk1-f193.google.com with SMTP id h14so15179211qke.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 00:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oB5EwWkuYfJgFInVNSAKK2AQewxxq5G9p5vadiA9m9w=;
        b=E0e8cult3VLYeIc6b5jikP2f5NAeMplnnu3dOxICNaBPwLmOdOghfEQFOyy+o5l9+d
         5OdU0CzX6CQvtLshnWdaAJLHFJE2qmTAYHkDHgkRCISS+jITR2RJkL5VWd1BbxakDuw1
         OHQTLs7G3mAt70WpSxqGpIo5rMYCRfDI1+s8lZAN7GCbyovYohTS/MxGUi6LG20vzo7t
         eokqfH53hLI2XfkOFl5wP3diugaIC0d2M4Lzznlg9oXGtcsSa2Dq2SW9JNi3qw3va1KQ
         VFRvYvQkCk55eCiMkV1Iene+3lorDip9qU9JhGJUOWBidNP1NzYAIRdUAlWuiAWlGR7E
         ucwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oB5EwWkuYfJgFInVNSAKK2AQewxxq5G9p5vadiA9m9w=;
        b=AzeYxAriiJ4OuXq5DnN3Eb0qJzFsld6GMhC5BVQ5hmIJceZlt4yRj0us1MiaIO878V
         VeozGiHyeryMYiNiAFac88iNIBqoTFr77U1OYir4U79JneLdh7WkH9+r63lVNRnHd9Es
         FTsiaoJdOxLx7P9+2PkqYzD/EJSbkCSX6DhAGInSs0dg4+3ESdeafOPn83HKbzu7bDkS
         CrqKY7Bjhmy6w4Y3zlEHkYb5OmQDNtGDZQ38bQiiBmmbADNil0z4aO0t3MdRgpCdYdHQ
         Ds5LqqeJ1+QWoZHzX8yQV7rI0ocP/jDQwrW5otl8s62Q/XOd6MN5iDV7VBCXT1p5MJ0m
         3w9w==
X-Gm-Message-State: AGi0PuaxzCgIhsxPdVQfD7aRjemOyIchIFZIco7Ul2/f1jVbS+wRt1LV
        6M7t5faW8gzvDkl3cdPhG8rk/udF8TEjcKoBUByNEg==
X-Google-Smtp-Source: APiQypKVUuqZ5QsidR7frE5tgG9pEagty5rI65ouHB07YUDxmKa8JecpN7uaP+389U6F+6oFNEqWtYM24INBYvzI008=
X-Received: by 2002:a37:a2c8:: with SMTP id l191mr20425473qke.120.1586157421644;
 Mon, 06 Apr 2020 00:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200401174937.3969599-1-bmasney@redhat.com>
In-Reply-To: <20200401174937.3969599-1-bmasney@redhat.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 6 Apr 2020 09:16:50 +0200
Message-ID: <CAMpxmJVzUPcRe=8MoHdsq_LNdZVT5rvPjF+38BmRTGU_zh-6LA@mail.gmail.com>
Subject: Re: [PATCH] drivers: gpio: xgene-sb: set valid IRQ type in to_irq()
To:     Brian Masney <bmasney@redhat.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, dhoward@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 1 kwi 2020 o 19:49 Brian Masney <bmasney@redhat.com> napisa=C5=82=
(a):
>
> xgene-sb is setup to be a hierarchical IRQ chip with the GIC as the
> parent chip. xgene_gpio_sb_to_irq() currently sets the default IRQ type
> to IRQ_TYPE_NONE, which the GIC loudly complains about with a WARN_ON().
> Let's set the initial default to a sane value (IRQ_TYPE_EDGE_RISING)
> that was determined by decoding the ACPI tables on affected hardware:
>
>     Device (_SB.GPSB)
>     {
>         Name (_HID, "APMC0D15")  // _HID: Hardware ID
>         Name (_CID, "APMC0D15")  // _CID: Compatible ID
>         Name (_UID, "GPIOSB")  // _UID: Unique ID
>         ...
>         Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settin=
gs
>         {
>             ...
>             Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, =
)
>             {
>                 0x00000048,
>             }
>             ...
>         }
>     }
>
> This can be overridden later as needed with irq_set_irq_type().
>
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
>  drivers/gpio/gpio-xgene-sb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-xgene-sb.c b/drivers/gpio/gpio-xgene-sb.c
> index 25d86441666e..b45bfa9baa26 100644
> --- a/drivers/gpio/gpio-xgene-sb.c
> +++ b/drivers/gpio/gpio-xgene-sb.c
> @@ -122,7 +122,7 @@ static int xgene_gpio_sb_to_irq(struct gpio_chip *gc,=
 u32 gpio)
>         fwspec.fwnode =3D gc->parent->fwnode;
>         fwspec.param_count =3D 2;
>         fwspec.param[0] =3D GPIO_TO_HWIRQ(priv, gpio);
> -       fwspec.param[1] =3D IRQ_TYPE_NONE;
> +       fwspec.param[1] =3D IRQ_TYPE_EDGE_RISING;
>         return irq_create_fwspec_mapping(&fwspec);
>  }
>
> --
> 2.25.1
>

Patch applied, thanks!

Bartosz
