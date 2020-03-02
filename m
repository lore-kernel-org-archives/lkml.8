Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B9EC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 22:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C9A21775
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 22:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0zMyqz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgCBWVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 17:21:41 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:35578 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgCBWVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 17:21:40 -0500
Received: by mail-vk1-f195.google.com with SMTP id r5so319175vkf.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 14:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H/ZXePw08jIq7OBB1YUZ7Aye4n93ozY+7PwFaAkmQrs=;
        b=e0zMyqz+F+6zRjoWtD/mmEgf34GKDHSCQlnC/uFR2APNtgaNTLYdn/QIN8teuoIAIM
         rff9jQj/X45gNaRymYGKIMomIBf61QRu0cSWCxImAgLP2bGNh7kxVBOw9RxTu3c/ObV9
         w6VlRCQMySed3qvqkTtidujVwrsaEQIQO2ye2MqYmi/E97frP8ZV4KBO/a6zgm7b5gDy
         fi7YE9kwimD1YdzUI/ow0fLyrYA4zPh63n6XoJUb7TrsyOTHqtwjnkvWjMfi560AYAe1
         nhM+BOAVhrxNIhnQoGdJw164oDxtFr1/SVpWWMI74s4/mGAfgAiiY3xH+RUsO/p6kIBU
         d1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H/ZXePw08jIq7OBB1YUZ7Aye4n93ozY+7PwFaAkmQrs=;
        b=nJOW2FhcIiqDvJo6e19NVJZELFG4yGfMLd6CaOxuLiHoB6JvqpgxuegQuWgbH7tKGa
         YKCS+wa2jqUv2ckRRq3XaDMQiTMsMqEbKdb/xyqMwiOwQ/I5iC+JsP9IJngQKyDqkfFK
         eaVtXsd/vB6XxRhDpkZO3QxEHiHY1fC8KgEPki8Xu/wx41jact29UKO2WwmWYMIUeYF2
         PpCxyiyoD8xXHGsZt+u7BPxqilQuKzePC4UeQt1zjJBQDksI3Y0seLHaPVhJHkKkIvh4
         hujHoKCQI6H2AfsbdZrXHpDwfHoeWxaa3/dQvd6/4BDm/EUq2L+I5Rmx0fB2h+2L3lAY
         izig==
X-Gm-Message-State: ANhLgQ1HCYKuYeVfxEZK2XIandCFabKa5ZAiFBq5Ti0smYdXKDv9LVDr
        Kp3QCN1rti5W1rmrd7EVPHB4E+hNfMiPNRkS460=
X-Google-Smtp-Source: ADFU+vtgTWEvlHrNTmJtHyKDJof9QYg21GqyVkzf3O6lrAwFQuvxk7BBzUe3gFp1CedXXmdr/MQo9bYXpNXIavJAaGY=
X-Received: by 2002:a1f:284:: with SMTP id 126mr151121vkc.16.1583187699557;
 Mon, 02 Mar 2020 14:21:39 -0800 (PST)
MIME-Version: 1.0
References: <20200227210454.18217-1-alistair.francis@wdc.com> <20200228095748.uu4sqkz6y477eabc@sirius.home.kraxel.org>
In-Reply-To: <20200228095748.uu4sqkz6y477eabc@sirius.home.kraxel.org>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Mon, 2 Mar 2020 14:14:02 -0800
Message-ID: <CAKmqyKOTjyRL9vxZrZW8Q+yBM0n-Nw-o-Cn3dUDDfAAa7Nswrg@mail.gmail.com>
Subject: Re: [PATCH] drm/bochs: Remove vga write
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Alistair Francis <alistair.francis@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org, daniel@ffwll.ch,
        airlied@linux.ie, Khem Raj <raj.khem@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 1:57 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Thu, Feb 27, 2020 at 01:04:54PM -0800, Alistair Francis wrote:
> > The QEMU model for the Bochs display has no VGA memory section at offset
> > 0x400 [1]. By writing to this register Linux can create a write to
> > unassigned memory which depending on machine and architecture can result
> > in a store fault.
> >
> > I don't see any reference to this address at OSDev [2] or in the Bochs
> > source code.
> >
> > Removing this write still allows graphics to work inside QEMU with
> > the bochs-display.
>
> It's not that simple.  The driver also handles the qemu stdvga (-device
> VGA, -device secondary-vga) which *does* need the vga port write.
> There is no way for the guest to figure whenever the device is
> secondary-vga or bochs-display.
>
> So how about fixing things on the host side?  Does qemu patch below
> help?

That patch looks like it will fix the problem, but it doesn't seem
like the correct fix. I would rather avoid adding a large chunk of
dummy I/O to handle the two devices.

>
> Maybe another possible approach is to enable/disable vga access per
> arch.  On x86 this doesn't cause any problems.  I guess you are on
> risc-v?

I would prefer this option. I do see this on RISC-V, but I suspect the
issue will appear on other architectures (although how they handle I/O
failures in QEMU is a different story).

Can I just do the VGA write if x86?

Alistair

>
> cheers,
>   Gerd
>
> diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
> index 62085f9fc063..e93e838243b8 100644
> --- a/hw/display/bochs-display.c
> +++ b/hw/display/bochs-display.c
> @@ -151,6 +151,26 @@ static const MemoryRegionOps bochs_display_qext_ops = {
>      .endianness = DEVICE_LITTLE_ENDIAN,
>  };
>
> +static uint64_t dummy_read(void *ptr, hwaddr addr, unsigned size)
> +{
> +    return -1;
> +}
> +
> +static void dummy_write(void *ptr, hwaddr addr,
> +                        uint64_t val, unsigned size)
> +{
> +}
> +
> +static const MemoryRegionOps dummy_ops = {
> +    .read = dummy_read,
> +    .write = dummy_write,
> +    .valid.min_access_size = 1,
> +    .valid.max_access_size = 4,
> +    .impl.min_access_size = 1,
> +    .impl.max_access_size = 1,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
>  static int bochs_display_get_mode(BochsDisplayState *s,
>                                     BochsDisplayMode *mode)
>  {
> @@ -284,8 +304,8 @@ static void bochs_display_realize(PCIDevice *dev, Error **errp)
>      memory_region_init_io(&s->qext, obj, &bochs_display_qext_ops, s,
>                            "qemu extended regs", PCI_VGA_QEXT_SIZE);
>
> -    memory_region_init(&s->mmio, obj, "bochs-display-mmio",
> -                       PCI_VGA_MMIO_SIZE);
> +    memory_region_init_io(&s->mmio, obj, &dummy_ops, NULL,
> +                          "bochs-display-mmio", PCI_VGA_MMIO_SIZE);
>      memory_region_add_subregion(&s->mmio, PCI_VGA_BOCHS_OFFSET, &s->vbe);
>      memory_region_add_subregion(&s->mmio, PCI_VGA_QEXT_OFFSET, &s->qext);
>
>
