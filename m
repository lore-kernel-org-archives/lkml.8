Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4A0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09FA520707
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgFOHou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:44:50 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37915 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgFOHot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:44:49 -0400
Received: by mail-oi1-f195.google.com with SMTP id c194so15066359oig.5;
        Mon, 15 Jun 2020 00:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g7HSRBtIscec4N9hHxu04aSpplZKyU3tippIaNppmSg=;
        b=l9T5C5TmgmGG6zXN24MHxHqXoTz/vpM7lt7WmUiCM7ltmeu2oMH5FcaHwMeKOyHzka
         mvO5WyptpdMqNdBl8PfPeB6hygFI7yxbqHByGwOXfwCpcy+wtZ9s32vy1hH3rxRlsq6d
         9ab7cGQepZaOysjppL3468TU/VIdDToSKIg2tWqUywSy73O3/8JpiZM/f7UqSnl7XhPs
         9ZRymMbF2bL6meh15DBKbhOZDaKPTR+WpRxuwtvhETpdg4El0YBi7sk/45TsY2q+lysP
         P3MfcrU5izPmJFbQByvP9y33omVRBNFzHX5BOAg6UbfmZ5JIszjN0+mHY97GwIAB3HyT
         ErrQ==
X-Gm-Message-State: AOAM532lrdwGKl0nsQyJQlaqKgkMOcZRzgOil1JQvDQuB8Xag8aH/5qv
        06E9PhYuPPeenuSBRSK6pQUxKJj8wv+3wlfetyDTLbzN
X-Google-Smtp-Source: ABdhPJwhcqwihmHcPw9qGGHeGhiGPk2xzMM9pbklFB00L7oxmEsT1RUI7WK6dRbU54Zng0i6JA/NZccN58WFJDfkDM0=
X-Received: by 2002:a54:4006:: with SMTP id x6mr7654697oie.148.1592207088042;
 Mon, 15 Jun 2020 00:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200615073533.1809-1-geert@linux-m68k.org>
In-Reply-To: <20200615073533.1809-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 15 Jun 2020 09:44:36 +0200
Message-ID: <CAMuHMdWh9w_50uPhFYZ26GOfp=Uv_DCg94M1GN9cuizz2+GxJQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.8-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 9:39 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v5.8-rc1[1] compared to v5.7[2].
>
> Summarized:
>   - build errors: +4/-4
>   - build warnings: +66/-42
>
> Note that there may be false regressions, as some logs are incomplete.
> Still, they're build errors/warnings.
>
> Happy fixing! ;-)
>
> Thanks to the linux-next team for providing the build service.
>
> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/b3a9e3b9622ae10064826dccb4f7a52bd88c7407/ (192 out of 194 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162/ (all 194 configs)
>
>
> *** ERRORS ***
>
> 4 error regressions:
>   + error: arch/sparc/kernel/head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text':  => (.head.text+0x5100), (.head.text+0x5040)
>   + error: arch/sparc/kernel/head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o:  => (.init.text+0xa4)
>   + error: arch/sparc/kernel/process_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0x4), (.fixup+0xc)
>   + error: arch/sparc/kernel/signal_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0x28), (.fixup+0x1c), (.fixup+0x4), (.fixup+0x10), (.fixup+0x34)

sparc-allmodconfig

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
