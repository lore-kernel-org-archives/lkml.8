Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A51AC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 07:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E505C20757
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 07:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgEDHLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 03:11:25 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46454 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbgEDHLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 03:11:24 -0400
Received: by mail-ot1-f65.google.com with SMTP id z25so8024653otq.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 00:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rfkxILgR6gYq3zL8Nxb8d3GiP3wwKG2LbudzQQF7WbU=;
        b=oOfOSSr/dGmYh+jgyKl4faHKwXMWHkL4It14ig4D+xNsjyb8fJTiEs6WntlJ106M/8
         MhQbUQDWNt/6+jc1D8Y34o1AP+Kgt9pkvgAwwo0pD8Kq1Rp5vi70iFCil04knWNtC/G7
         KYW7ONL8p/ynSVAkpvyfxsgBqJAa+rPofwhzUxCkE/A2WLYXIOZFQ/ki9XXA7yWqTZwX
         GitnNCnuiSr/VuvOkwQP3TWFVw0aTuVDjZ+3DJneTV5ELj5AfWAGWQvDfK4hRM1pDgPs
         tmbEFjcQBpviVfs15700KoLFTCQFzzRJO02xFzUlGwGVVvLUnnUwh4LV784rxjYUnfck
         JuEw==
X-Gm-Message-State: AGi0Pub5s+YFPDTcH+4NcEuMRqUd73kFr8NgcpXeEpMnKw+VJOaQ7JOr
        x/3x0BVas0DPulUXxfip6UpRnPuN8aOFQ6wI3z4=
X-Google-Smtp-Source: APiQypJPMgeWBRUiVyeVnkIiZGgJNdYK9YfY571As0RfWeLMVNq4WlAgY4mBZ80+C3ouKbzMSZ5KFVm7VZsG8Eqtf1M=
X-Received: by 2002:a9d:7d85:: with SMTP id j5mr12499692otn.107.1588576283223;
 Mon, 04 May 2020 00:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <1585568499-21585-1-git-send-email-amit.kachhap@arm.com>
In-Reply-To: <1585568499-21585-1-git-send-email-amit.kachhap@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 May 2020 09:11:12 +0200
Message-ID: <CAMuHMdWxTtFxgpabeK3L4Ev4zgZ6r=_c+5MBVYd7ZAHbNYxm=Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] init/kconfig: Add LD_VERSION Kconfig
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

On Mon, Mar 30, 2020 at 1:42 PM Amit Daniel Kachhap
<amit.kachhap@arm.com> wrote:
> This option can be used in Kconfig files to compare the ld version
> and enable/disable incompatible config options if required.
>
> This option is used in the subsequent patch along with GCC_VERSION to
> filter out an incompatible feature.
>
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>

> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -17,6 +17,10 @@ config GCC_VERSION
>         default $(shell,$(srctree)/scripts/gcc-version.sh $(CC)) if CC_IS_GCC
>         default 0
>
> +config LD_VERSION
> +       int
> +       default $(shell,$(LD) --version | $(srctree)/scripts/ld-version.sh)
> +
>  config CC_IS_CLANG
>         def_bool $(success,$(CC) --version | head -n 1 | grep -q clang)

.config: warning: symbol value '2.01827e+11' invalid for LD_VERSION

Seen with the or32 compiler on kisskb, e.g.
http://kisskb.ellerman.id.au/kisskb/buildresult/14226173/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
