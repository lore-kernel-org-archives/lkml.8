Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D59CC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F5E2469D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgB0N2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:28:49 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39566 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729249AbgB0N2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:28:47 -0500
Received: by mail-ot1-f67.google.com with SMTP id x97so268081ota.6;
        Thu, 27 Feb 2020 05:28:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=//cTzY2jobbRh8YsJlOJYjMBENtlYHf1uI24D6DEJ4A=;
        b=UuQe/jD0rU4YGh/LRlHuKqyIn7lzPh2TfSIDWFgim2wh3gVZqZAaCPBmVcpHH+n4mG
         w0JmM4LxDSZzwFKkFtoVPZzNB2r7SVcj3jlHmk4xR4mrw/X5k8nuEpogNP2GwZyVW0Oi
         TQqAmPP0HQY8XeV6k7yYP9DrzfVBcGTIGFQBYMpfVA7sFgCNu4rKK1u1IP9eli2rkesV
         dZC9JguyZl6SBWPOD6ecM6wo9N3Hz9N4b7u6BIRyyoGmgqLQzZuViGpifnwkoIPOl+lh
         rLQziIVJmtPYL3n8C35YtEyaWKUcu9nHyXoRvhOJ6oxFxEGncs47uZOtQccdDC01926V
         Q14A==
X-Gm-Message-State: APjAAAV3DQHxx8z6yV4L7/HybHFqyas9Jx4j04a0dT4PeU9SyJEB6TLk
        7bECRnd4RFPNZDpG1ga82lIA3+7P8AA2ecZZzLE=
X-Google-Smtp-Source: APXvYqwoav7VAvRpxWespYQXROtXYAxxR/lhJ9BIHxTAy4kvVi44lWZOsMb2I0GiCyANrGW+f7BSim4VRrTCfMC2XRg=
X-Received: by 2002:a05:6830:10e:: with SMTP id i14mr3308619otp.39.1582810125298;
 Thu, 27 Feb 2020 05:28:45 -0800 (PST)
MIME-Version: 1.0
References: <68219a85-295d-7b7c-9658-c3045bbcbaeb@free.fr> <f53767e0-e533-74bc-2967-e2cc4c3df15e@free.fr>
In-Reply-To: <f53767e0-e533-74bc-2967-e2cc4c3df15e@free.fr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 27 Feb 2020 14:28:32 +0100
Message-ID: <CAMuHMdWA3CwABeiV0whvuThVYSZvVi_KNAKdNEFyM0h9fAnTOw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/2] devres: Provide new helper for devm functions
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Russell King <linux@armlinux.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Wed, Feb 26, 2020 at 4:55 PM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
> Provide a simple wrapper for devres_alloc / devres_add.
>
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

With the grammar fixed, as per below:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -685,6 +685,34 @@ int devres_release_group(struct device *dev, void *id)
>  }
>  EXPORT_SYMBOL_GPL(devres_release_group);
>
> +/**
> + * devm_add - allocate and register new device resource
> + * @dev: device to add resource to
> + * @func: resource release function
> + * @arg: resource data
> + * @size: resource data size
> + *
> + * Simple wrapper for devres_alloc / devres_add.
> + * Release the resource if the allocation fails.

Releases ... failed.

> + *
> + * RETURNS:
> + * 0 if the allocation succeeds, -ENOMEM otherwise.

"0 on success" would avoid any discussion about "succeeds" or "succeeded" ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
