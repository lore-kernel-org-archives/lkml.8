Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE433C38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 957652078E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQ/O+ntB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbgDQNaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 09:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729760AbgDQNaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 09:30:09 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0753FC061A0C;
        Fri, 17 Apr 2020 06:30:09 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id np9so1111758pjb.4;
        Fri, 17 Apr 2020 06:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nFgweoCUYArCXLmSHj7utk/sJee8v5C3lAv/i/FUx1w=;
        b=aQ/O+ntBegnk4W/OtDVTQdM4s+mxMi7A8JViJmfe29zvDuQt0zk42IrTp7ToBwGbVF
         DauR3aFC+v6gd/oKXGFiiRcQ1gVAWfUhtnu7Q+FkyJMcSw/HJWQSSQTwpvT6OJrEuy0T
         JaC8XuDhCGdeBk2KSmCbgzSiPTy99v9Je1TKz2vm2KpoKb5fzea81zTJ77MneecLE50l
         6qKEsk8qvhTWDT6D9MchWi6sTRcMo/5C3UkLUQuzSAiRqSWZFDC/2N8DIp/qnD9w3awD
         eumK9M4xPbbyGkLk1DdAMRbqx4PtdcjJL2heo8l4yAvDoYhopXWeaFn19wmcY2JAuxfv
         LVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nFgweoCUYArCXLmSHj7utk/sJee8v5C3lAv/i/FUx1w=;
        b=DrF3bcECOyGVyTsFCz9aHgpdj6AqogtHVGGHpCVH1p/XP0yn6Dx9GrecnNhZ9dM4ob
         sSw8XHPuXZh9b7yU0Jmip9w7kMzmH4pkjM+VuJMvPEwVPvAldLRxhCWKoOex4L+rpJqt
         d6uage5HmKCiaIvT4AN2rI/DCZ45msQkVhQQnYrBv+lfrhTQMINAIQJMqsUb8G+gcG5S
         of+kOeyZRE64PHs6MJLP+sbAXBPTHg3Y8XUCQ3IauV77gO2XN1vPYgJbLOfrwod6RWN5
         bJg77k5ZcieGpgVZrfj1J+6IFIGR/QGqcywK1ZLSFw5djxfwb9i5CNIoPPBcGkyiVgBC
         /Jqg==
X-Gm-Message-State: AGi0PuZI5s4oZvcTSZSjv1JVM4ubK+dEQZz8iOOMlNpZN9/a83eVtyfm
        K6jaP+iSF0Cdd7018t4l36Y1BQi7r+2yTsJE9KVbIFbEcAQ8fg==
X-Google-Smtp-Source: APiQypIZ41rif2TPiH8bwogCPUbaADou1ObpE2/vh5ht0/qzSKIPn21jVVJoMoAC9WuAoeZkf5wP9nXkACbqxJueQko=
X-Received: by 2002:a17:902:9306:: with SMTP id bc6mr3415223plb.255.1587130208465;
 Fri, 17 Apr 2020 06:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200401080348.5128-1-hdegoede@redhat.com>
In-Reply-To: <20200401080348.5128-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Apr 2020 16:30:00 +0300
Message-ID: <CAHp75VcO=cePNRmJGmvGPcD=CBD9kkXJyKqK7yMKNYrpKWSwuw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: touchscreen_dmi: Add info for the MP-man
 MPWIN895CL tablet
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 11:03 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Add touchscreen info for the MP-man MPWIN895CL tablet.
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/touchscreen_dmi.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> index 6ec8923dec1a..931814e62454 100644
> --- a/drivers/platform/x86/touchscreen_dmi.c
> +++ b/drivers/platform/x86/touchscreen_dmi.c
> @@ -373,6 +373,23 @@ static const struct ts_dmi_data jumper_ezpad_mini3_data = {
>         .properties     = jumper_ezpad_mini3_props,
>  };
>
> +static const struct property_entry mpman_mpwin895cl_props[] = {
> +       PROPERTY_ENTRY_U32("touchscreen-min-x", 3),
> +       PROPERTY_ENTRY_U32("touchscreen-min-y", 9),
> +       PROPERTY_ENTRY_U32("touchscreen-size-x", 1728),
> +       PROPERTY_ENTRY_U32("touchscreen-size-y", 1150),
> +       PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
> +       PROPERTY_ENTRY_STRING("firmware-name", "gsl3680-mpman-mpwin895cl.fw"),
> +       PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> +       PROPERTY_ENTRY_BOOL("silead,home-button"),
> +       { }
> +};
> +
> +static const struct ts_dmi_data mpman_mpwin895cl_data = {
> +       .acpi_name      = "MSSL1680:00",
> +       .properties     = mpman_mpwin895cl_props,
> +};
> +
>  static const struct property_entry myria_my8307_props[] = {
>         PROPERTY_ENTRY_U32("touchscreen-size-x", 1720),
>         PROPERTY_ENTRY_U32("touchscreen-size-y", 1140),
> @@ -908,6 +925,14 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "FlexBook edge11 - M-FBE11"),
>                 },
>         },
> +       {
> +               /* MP Man MPWIN895CL */
> +               .driver_data = (void *)&mpman_mpwin895cl_data,
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "MPMAN"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "MPWIN8900CL"),
> +               },
> +       },
>         {
>                 /* Myria MY8307 */
>                 .driver_data = (void *)&myria_my8307_data,
> --
> 2.26.0
>


-- 
With Best Regards,
Andy Shevchenko
