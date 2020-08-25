Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570AFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BBBC2067C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9PsfJra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgHYJN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 05:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgHYJNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 05:13:55 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A2CC061574;
        Tue, 25 Aug 2020 02:13:55 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id v2so9803958ilq.4;
        Tue, 25 Aug 2020 02:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e5ThzYEzbweOX9AK40FRPwqF+0B+9KjoG4gy6j07O+s=;
        b=D9PsfJraNVZZzczEmo/ImHzAeNSbSBg1Vx9KnI2s0VqFH1ieYZjtEMg5NEKTW2iTg4
         lzLstK3DIPmSgykX1sOF0Mnz92NSHb8xnoHxnsnNywoN4bpAF7HLqzjPR9HHDMuZjfD4
         UMpryXfkdTuMiqCBJkdsqjX95CwLFCswo86UaJWMDyGDBlX76ASIFti4yOsGnYX6c2PD
         poy0zZ/dZ05EftN0S0znrJGKEzgPmd7Uajaap7r1we9xk6YOL2ZAXN+fvvufZfGfhI6Q
         kVtFj6Ottl5408EvM+tAUv2IEIMYfBOJ7N0WIJIFMVHvjhkTVaOUGZfsQk2w1pZDDil6
         C9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e5ThzYEzbweOX9AK40FRPwqF+0B+9KjoG4gy6j07O+s=;
        b=noBqyjPXFZbfbjUGZMVG69GHoYIjz1B0oaJqPRaDxahJIPokYHExa2Mi9MH0LvYQ8P
         c33VCaf63XGun9m/0pQqkww7jXI9fDgc9X4TRFifi8V3Tow7v+33e/Nz+fmqp6TXDhiM
         4PBIYggs++iLz+2A9EQThlIPI3tY7zMUWRUf7eBQrYIRcktTTuuKbIuma2fGkaIqEir0
         jdbjtbXdh3Aeq0TNPmf9HcHl8rhAEafTbnbbHc3q2R3UIazXPDFgVpPsFiawbUgPtPi4
         6B3c7o2PnUnJpfA2tEZKSlIV0Nsy4Ud6g3LBQkTOU/R4PUKoFeIBs5+CnSKIzLo6XfF1
         kjJw==
X-Gm-Message-State: AOAM5316E6Kxv0olsWhfLnCebKD8HJs3ZRUfWkCfX1zilQr0y5qeglOr
        tOq8htlmAgiexAQY+TSfVfBjPZTODW3OXPDtG9Q=
X-Google-Smtp-Source: ABdhPJxkGE/Ak8QiOBhgh/v/E2MCch1eEax9ocriOCg/LnbS6Ir9UtiHnywVsetJ+GNbQXQDybROB7SgftwxChw5bXw=
X-Received: by 2002:a92:d386:: with SMTP id o6mr8500809ilo.292.1598346834380;
 Tue, 25 Aug 2020 02:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <1597910022-22617-1-git-send-email-gene.chen.richtek@gmail.com>
 <1597910022-22617-2-git-send-email-gene.chen.richtek@gmail.com>
 <20200820114524.GC5854@sirena.org.uk> <CAE+NS34WuWnT7zvsHhaciWVLT2y0wpwt0wXAp3UmjEuJ2its6A@mail.gmail.com>
 <20200824110458.GB4676@sirena.org.uk>
In-Reply-To: <20200824110458.GB4676@sirena.org.uk>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Tue, 25 Aug 2020 17:13:43 +0800
Message-ID: <CAE+NS36ZK2pq8CAcmiqiUf6Ph5RET5aO4nUPFUd-EDHVEuharA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] regulator: mt6360: Add support for MT6360 regulator
To:     Mark Brown <broonie@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, robh+dt@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Gene Chen <gene_chen@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=8824=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:05=E5=AF=AB=E9=81=93=EF=BC=9A



>
> On Mon, Aug 24, 2020 at 06:23:19PM +0800, Gene Chen wrote:
> > Mark Brown <broonie@kernel.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=8820=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=887:45=E5=AF=AB=E9=81=93=EF=BC=9A
>
> > > This device only exists in the context of a single parent device, the=
re
> > > should be no need for a compatible string here - this is just a detai=
l
> > > of how Linux does things.  The MFD should just instntiate the platfor=
m
> > > device.
>
> > Trying to autoload module without of_id_table will cause run-time error=
:
> > ueventd: LoadWithAliases was unable to load
> > of:NregulatorT(null)Cmediatek,mt6360-regulator
>
> You shouldn't have this described in the device tree at all, like I say
> the MFD should just instantiate the platform device.

After I replace of_device_id by platform_device_id as below, I can
autoload module.
But I can't get of_node to parse init_data.
Should I use dev->parent->of_node and set
regulator_desc.regulator_node to parse each regulator definition in
device tree?

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index e995220..444dc8e 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -328,7 +328,7 @@ static const struct mfd_cell mt6360_devs[] =3D {
        OF_MFD_CELL("mt6360-led", mt6360_led_resources,
                    NULL, 0, 0, "mediatek,mt6360-led"),
        OF_MFD_CELL("mt6360-regulator", mt6360_regulator_resources,
-                   NULL, 0, 0, "mediatek,mt6360-regulator"),
+                   NULL, 0, 0, NULL),
        OF_MFD_CELL("mt6360-tcpc", NULL,
                    NULL, 0, 0, "mediatek,mt6360-tcpc"),
 };
diff --git a/drivers/regulator/mt6360-regulator.c
b/drivers/regulator/mt6360-regulator.c
index 97c16a2..d525bf1 100644
--- a/drivers/regulator/mt6360-regulator.c
+++ b/drivers/regulator/mt6360-regulator.c
@@ -438,11 +438,18 @@ static int mt6360_regulator_probe(struct
platform_device *pdev)
        return 0;
 }

+static const struct platform_device_id mt6360_regulator_id[] =3D {
+       { "mt6360-regulator", },
+       { },
+};
+MODULE_DEVICE_TABLE(platform, mt6360_regulator_id);
+
 static struct platform_driver mt6360_regulator_driver =3D {
        .driver =3D {
                .name =3D "mt6360-regulator",
        },
        .probe =3D mt6360_regulator_probe,
+       .id_table =3D mt6360_regulator_id,
 };
