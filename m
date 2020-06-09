Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80896C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B7802072F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYvYUZgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbgFIP7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgFIP7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 11:59:09 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38101C05BD1E;
        Tue,  9 Jun 2020 08:59:09 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id a13so20849814ilh.3;
        Tue, 09 Jun 2020 08:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y7SNiI5A6RVtZsHvA5zBiQnX39Ic6ndLkU+dDGZxkkE=;
        b=BYvYUZgKPOiFqhDqHbdFaVtVeJjo2pF7jf1ADysyareZY2mE4JGcQkzWaTDD40WYr9
         rFsr99M5cb58XA+NucQrVrbraWMQKkQOnByLp3ArV3tE+p6LIQpWDb5q8GXyVna1RXsH
         8XvEZItxotESA+kA9wSCI+i1eisarnUJ/tKVc/XVlldBXDeoMjuvSp6QoPHDktjB6I26
         As3IEs6xOqwP4bavd8E4NI8w0pAsUTvIZ/oewpgNE0SkevnlK7NrW75K1gn1CSOrCmei
         N4zXN0vWMHe5hLTpfmrSvAM3KYJjns0Vxnc4yE1ECaYPUXayuSn38H2DsKjFYrp4nkAD
         Nm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y7SNiI5A6RVtZsHvA5zBiQnX39Ic6ndLkU+dDGZxkkE=;
        b=EI3tZ+wXHyYjX87vgHKk6OgFrzBEe2bF01FW8zKmUBlO/3M2fVcSk0zisVl7wnFo5h
         q2wDm1s6F7e0ggXKjFeI7CAg8mjzMcKd20UZ9v/1RlsChs3gcIM41CT9T7Y/2YPUcON9
         LePa/BAsgzp09mzS7KdmK5/D2zWD8hOfOkgs88OhjWp0lUuhXsWvBD7zPZxd/or1kS9n
         DaPACdgO6Kl+ZnWEt+SeIHBlKvuPFWnBigcTmn8S+5CDAP40t+ehtZ4XTYUiVXOEpZRZ
         onq7MMipY3KZuavLzoUifc3dj2k/fyU/4iVHr8q9DuuopRneiS1S2SBG9n9nrmZCQK/V
         m5Xw==
X-Gm-Message-State: AOAM530D+tsYaGSpM7shQLvlccocguBOx8ryFPSQUtdfkptXUdR7KcuM
        ASa4nYTUD8ZXTogdb6ImkcRCXYP9B3tf0CMunnY=
X-Google-Smtp-Source: ABdhPJwrxzXrTqDvIYEv7sGYGoTfNgdI9+AwSKTngZ8wOe8qpPn+MALOTP1Ir5yJrOFe2XEpcp7yexnICas3NiVZxPk=
X-Received: by 2002:a92:914a:: with SMTP id t71mr27627735ild.200.1591718348616;
 Tue, 09 Jun 2020 08:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <1591605038-8682-1-git-send-email-dillon.minfei@gmail.com> <1591605038-8682-2-git-send-email-dillon.minfei@gmail.com>
In-Reply-To: <1591605038-8682-2-git-send-email-dillon.minfei@gmail.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Tue, 9 Jun 2020 23:58:32 +0800
Message-ID: <CAL9mu0KWq-ANkLBRv_49kGzWf_kDPjMvMeA7S4E6f5MpVtjKaw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: stm32: Setup 4M bytes reserved memory for mmap
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux@armlinux.org.uk, Vladimir Murzin <vladimir.murzin@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        allison@lohutok.net, info@metux.net, tglx@linutronix.de, hch@lst.de
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph Hellwig,

This is the patchset. for your reference.

thanks,

On Mon, Jun 8, 2020 at 4:30 PM <dillon.minfei@gmail.com> wrote:
>
> From: dillon min <dillon.minfei@gmail.com>
>
> To mmap a framebuffer or v4l2 buffer from kernel to userspace on
> no-mmu platform, we need rely on 'arm_nommu_dma_ops' from
> arch/arm/mm/dma-mapping-nommu.c , so setup 4M bytes memory
> reserved for this purpose.
>
> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> ---
>  arch/arm/boot/dts/stm32f469-disco.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
> index 9397db0c43de..082b24ee81f7 100644
> --- a/arch/arm/boot/dts/stm32f469-disco.dts
> +++ b/arch/arm/boot/dts/stm32f469-disco.dts
> @@ -65,6 +65,20 @@
>                 reg = <0x00000000 0x1000000>;
>         };
>
> +       reserved-memory {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               linux,dma {
> +                       compatible = "shared-dma-pool";
> +                       size = <0x400000>;
> +                       no-map;
> +                       linux,dma-default;
> +               };
> +
> +       };
> +
>         aliases {
>                 serial0 = &usart3;
>         };
> --
> 2.7.4
>
