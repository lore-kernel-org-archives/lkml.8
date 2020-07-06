Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DCAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 07:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80B71206CD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 07:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ql6Xa+1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgGFHbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 03:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbgGFHbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 03:31:15 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D1DC061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 00:31:15 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j18so38130096wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 00:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ij0JRwK8ga/rncVIV9YKY5BwGhFS/NPZFYIdNVKTzqc=;
        b=ql6Xa+1gVBCsxErRijzq8GkAk+NPNDVoSojqePD/z4CAU26jaa/7uB5xGq/72Cjxdf
         3d24hdR93nqxIx0LJ7NrYnAFtEUlSM90YsNpILMJ11Qe1CkaQtzv/3rQvZmBLK+SEKqO
         FA/4Vwg0DOIpRQipFZrVoTuAI4RpxpnELJ2+OWEmwEHDSf/jUIcbWAo77Kz/Dk93DZK2
         +nhzkHcv2jonehE8ZN8EwinoOoRqZsBcrWXBnUryeCk4bqHWZOviXdU/2XAxXwdE060w
         jOeqJSbimEDQmTpIpruMkKOSp3fSbAO0AaGrWfwlrSUWWeX8q2XZDnW5hFFu/xSAc4vs
         fKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ij0JRwK8ga/rncVIV9YKY5BwGhFS/NPZFYIdNVKTzqc=;
        b=qj2e50uO7MmuPsN4EBHvOcO+/gJkCQ2DnUesCo+l2lf4HrQGM5N27AyySoESdIvxhr
         3zvYn3KD/xvY5MFDZjNLkYqWAZryRYNZRi8msCB3z8chAviQoFo/sXKlG0yFODhh+3mr
         lgBQbK5KnuXrh0UUC62kWmkDuIgx2xKlW390VI75u2krsZjUHbCUaBjJ9TRyVUFtqiEm
         1BYPUNFsQx+h/7AHt595E26ZjaAII+82Y+AUko9fZLK3blNBoYhR338qIcg1aS56Zn2P
         GEdAb4KC5eLyXZbI9zTSErrUU+GPmoXmeP1CBU0VLLi8n3XSmNXuWQHM1yhAQydrXjpP
         scOA==
X-Gm-Message-State: AOAM532ZfYGUARU7bRNlYe/flNLTCOiGUSYXCKhHGK0Nibd4EQg50m4Q
        FibSpJyTDBsXDglZZEjtdTr+0bgsQuE=
X-Google-Smtp-Source: ABdhPJwFe74liwklMNgNlDDfUptR2TDgiF8T0WWjCvFSkv/sy8CiCpkIoPKmbqGh9O9/kku8SGb+Dw==
X-Received: by 2002:a1c:bb44:: with SMTP id l65mr50526517wmf.51.1594020673878;
        Mon, 06 Jul 2020 00:31:13 -0700 (PDT)
Received: from dell ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id c15sm12304424wme.23.2020.07.06.00.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 00:31:12 -0700 (PDT)
Date:   Mon, 6 Jul 2020 08:31:11 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Carlo Caione <carlo@caione.org>
Subject: Re: [PATCH 5/5] mfd: axp20x-i2c: Do not define 'struct
 acpi_device_id' when !CONFIG_ACPI
Message-ID: <20200706073111.GD2821869@dell>
References: <20200629123215.1014747-1-lee.jones@linaro.org>
 <20200629123215.1014747-6-lee.jones@linaro.org>
 <CAGb2v66Ws4WNPZbOYQvikKoozj_2WjzS-Jq-o2VxT77=k0vODw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v66Ws4WNPZbOYQvikKoozj_2WjzS-Jq-o2VxT77=k0vODw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020, Chen-Yu Tsai wrote:

> Adding Hans to the list as he's the one that deals with all the x86
> platforms that use this series of chips.
> 
> On Mon, Jun 29, 2020 at 8:32 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > Since ACPI_PTR() is used to NULLify the value when !CONFIG_ACPI,
> > struct axp20x_i2c_acpi_match becomes defined by unused.
> >
> > This squashes the current W=1 kernel builds warning:
> >
> >  drivers/mfd/axp20x-i2c.c:82:36: warning: ‘axp20x_i2c_acpi_match’ defined but not used [-Wunused-const-variable=]
> >
> > Cc: Chen-Yu Tsai <wens@csie.org>
> > Cc: Carlo Caione <carlo@caione.org>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/mfd/axp20x-i2c.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
> > index 14f9df74f855c..3dd650125c239 100644
> > --- a/drivers/mfd/axp20x-i2c.c
> > +++ b/drivers/mfd/axp20x-i2c.c
> > @@ -79,6 +79,7 @@ static const struct i2c_device_id axp20x_i2c_id[] = {
> >  };
> >  MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);
> >
> > +#if IS_ENABLED(CONFIG_ACPI)
> >  static const struct acpi_device_id axp20x_i2c_acpi_match[] = {
> 
> I'd rather use "__maybe_unused" if possible to at least get a compile
> check, and also because "ACPI_PTR NULLifies the value" might not be
> well known to people not working on ACPI-based platforms.

FYI, I've gone back to this patch, as it seems to be the common
census across the rest of the kernel, due to the extra space saving.

The code will get compile checks when compiled with different
architectures, and I'm not sure I understand the last point you made.

> Either way,
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>

I've applied this to the patch.  Thanks.

> >         {
> >                 .id = "INT33F4",
> > @@ -87,6 +88,7 @@ static const struct acpi_device_id axp20x_i2c_acpi_match[] = {
> >         { },
> >  };
> >  MODULE_DEVICE_TABLE(acpi, axp20x_i2c_acpi_match);
> > +#endif
> >
> >  static struct i2c_driver axp20x_i2c_driver = {
> >         .driver = {
> >

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
