Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC56C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C077206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731952AbgF2TRt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731953AbgF2TRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:17:43 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166F0C03079D
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:39:02 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h19so18498546ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UQmPCDX6xMOsUPe/v2T5v2xy5fsOZjivnEQOFoz/TIE=;
        b=baouVJ3gD+I0VlenNRasksMaTOgh2MD0ap27alPsbihTh5ADnaARKaags2r5XfFJ5c
         JtIoM4IUmOwFid7DFUWtaGs2a0Yu5wNGTJnPvIc8hn85KWjgwl/jujMwMWtiDm/JYQST
         DgnWEUx8VVzue5ThodBk7TiqSjJAc6E925Q77XVf0BXl1B0v2BzhZHvosxt/OKKM3x1u
         FvXuSJV91VFSnD/+He8HO9sW9Q57XG8xIyyKSJfFiLQeEgO5a9bdUtoOuiNhBRhAPksN
         vuHxq9JCCkU16SiipEqIgxS2yO42RQtUHdDZU8QH4sZirqraUc2dDsd3gfVKgd+O5W5j
         Lq/A==
X-Gm-Message-State: AOAM530BmJA6weU9cF++lCjL3RrvKkMz8rzwPFxksu5dCcVq9A1bR3Cy
        5+PwjoAcqu3pIhHRspAzTLhvtAI8IdU=
X-Google-Smtp-Source: ABdhPJzqTgTER43gmMLxrLQzPWsW2sthTWJSc0MNSxQvpzC/50ihNTlFax6crYFapvJ6G5wlF9ORHw==
X-Received: by 2002:a2e:b0da:: with SMTP id g26mr3840235ljl.299.1593445139962;
        Mon, 29 Jun 2020 08:38:59 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id u8sm11311lff.38.2020.06.29.08.38.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 08:38:59 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id f8so6267475ljc.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:38:59 -0700 (PDT)
X-Received: by 2002:a2e:890d:: with SMTP id d13mr8550620lji.75.1593445139288;
 Mon, 29 Jun 2020 08:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200629123215.1014747-1-lee.jones@linaro.org> <20200629123215.1014747-6-lee.jones@linaro.org>
In-Reply-To: <20200629123215.1014747-6-lee.jones@linaro.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 29 Jun 2020 23:38:47 +0800
X-Gmail-Original-Message-ID: <CAGb2v66Ws4WNPZbOYQvikKoozj_2WjzS-Jq-o2VxT77=k0vODw@mail.gmail.com>
Message-ID: <CAGb2v66Ws4WNPZbOYQvikKoozj_2WjzS-Jq-o2VxT77=k0vODw@mail.gmail.com>
Subject: Re: [PATCH 5/5] mfd: axp20x-i2c: Do not define 'struct
 acpi_device_id' when !CONFIG_ACPI
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Carlo Caione <carlo@caione.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Hans to the list as he's the one that deals with all the x86
platforms that use this series of chips.

On Mon, Jun 29, 2020 at 8:32 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Since ACPI_PTR() is used to NULLify the value when !CONFIG_ACPI,
> struct axp20x_i2c_acpi_match becomes defined by unused.
>
> This squashes the current W=1 kernel builds warning:
>
>  drivers/mfd/axp20x-i2c.c:82:36: warning: ‘axp20x_i2c_acpi_match’ defined but not used [-Wunused-const-variable=]
>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Carlo Caione <carlo@caione.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/axp20x-i2c.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
> index 14f9df74f855c..3dd650125c239 100644
> --- a/drivers/mfd/axp20x-i2c.c
> +++ b/drivers/mfd/axp20x-i2c.c
> @@ -79,6 +79,7 @@ static const struct i2c_device_id axp20x_i2c_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);
>
> +#if IS_ENABLED(CONFIG_ACPI)
>  static const struct acpi_device_id axp20x_i2c_acpi_match[] = {

I'd rather use "__maybe_unused" if possible to at least get a compile
check, and also because "ACPI_PTR NULLifies the value" might not be
well known to people not working on ACPI-based platforms.

Either way,

Acked-by: Chen-Yu Tsai <wens@csie.org>


>         {
>                 .id = "INT33F4",
> @@ -87,6 +88,7 @@ static const struct acpi_device_id axp20x_i2c_acpi_match[] = {
>         { },
>  };
>  MODULE_DEVICE_TABLE(acpi, axp20x_i2c_acpi_match);
> +#endif
>
>  static struct i2c_driver axp20x_i2c_driver = {
>         .driver = {
> --
> 2.25.1
>
