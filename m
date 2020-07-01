Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3587C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 807842074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgGAIia convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:38:30 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36143 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbgGAIi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:38:29 -0400
Received: by mail-lj1-f193.google.com with SMTP id d17so11244504ljl.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WUTJ6qnDpSfy4+WfYopz9NblwOYu9PnCW3D7o+yiutI=;
        b=esVOOJnuIDPBL+TVJKI9V/Axb8dIiYdgVwZDmz8N+gByffMvOVE6SbinOvS2EVWzyx
         o/0V8qca//3FpR1DuHzRJ3UUEN3DHr25t9lO9Hq+IR3kWca7NPSLXjO6XfMo+2mZnYj1
         zJeks1+ox29FDXPQt7QEsYydo4SWnBKSUAgcooDZ6Y1bDnWgHUE0Zhdt7robqDKvS7v8
         yZqJVEMtenGd9xR5MfgepAI/B0JEoMjH0mICZp8f3VmDZG3We92Yzs5B0MWZQ7DKgyxx
         esxBYWpvYMPrfijjk9SGLPzHRI5QQhl5AQr4pq/MmR8R6VbCZUIaVcN6M3WF9dC6oR4s
         fL9g==
X-Gm-Message-State: AOAM530bc+76TQZ4R2G41Yu+ihQTXpx8LW+O+S7wP+GBhjgd9CUq39lU
        kH3DOQAyYr8qjJbDW3h4n7xHtmGXMvU=
X-Google-Smtp-Source: ABdhPJyLeBv3sELJfyIpwEaKGPEi36O7iZW4f233xeZMSoCyqt5ljaaFFlEGcVBZw3hpbJqB3t+aMw==
X-Received: by 2002:a2e:9907:: with SMTP id v7mr183992lji.359.1593592706860;
        Wed, 01 Jul 2020 01:38:26 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id e13sm1591544ljo.6.2020.07.01.01.38.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 01:38:26 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id s9so25894032ljm.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:38:26 -0700 (PDT)
X-Received: by 2002:a05:651c:30b:: with SMTP id a11mr7694728ljp.47.1593592706346;
 Wed, 01 Jul 2020 01:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200629123215.1014747-1-lee.jones@linaro.org>
 <20200629123215.1014747-6-lee.jones@linaro.org> <20200701065957.GO1179328@dell>
In-Reply-To: <20200701065957.GO1179328@dell>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 1 Jul 2020 16:38:14 +0800
X-Gmail-Original-Message-ID: <CAGb2v65b0Xx0CVdp0U+mg5AMkAaWh6hcvXMQ_ZAHbY=zb=3Hiw@mail.gmail.com>
Message-ID: <CAGb2v65b0Xx0CVdp0U+mg5AMkAaWh6hcvXMQ_ZAHbY=zb=3Hiw@mail.gmail.com>
Subject: Re: [PATCH v2] mfd: axp20x-i2c: Tell the compiler that ACPI functions
 may not be used
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

On Wed, Jul 1, 2020 at 3:00 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> ... as is the case when !CONFIG_ACPI.
>
> This squashes the current W=1 kernel builds warning:
>
>  drivers/mfd/axp20x-i2c.c:82:36: warning: ‘axp20x_i2c_acpi_match’ defined but not used [-Wunused-const-variable=]
>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Carlo Caione <carlo@caione.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>

>
> diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
> index 14f9df74f855c..7d08c06de7afc 100644
> --- a/drivers/mfd/axp20x-i2c.c
> +++ b/drivers/mfd/axp20x-i2c.c
> @@ -79,7 +79,7 @@ static const struct i2c_device_id axp20x_i2c_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);
>
> -static const struct acpi_device_id axp20x_i2c_acpi_match[] = {
> +static const struct acpi_device_id __maybe_unused axp20x_i2c_acpi_match[] = {
>         {
>                 .id = "INT33F4",
>                 .driver_data = AXP288_ID,
