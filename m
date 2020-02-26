Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD929C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FECA20732
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgBZJBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:01:49 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37775 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgBZJBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:01:49 -0500
Received: by mail-oi1-f194.google.com with SMTP id q84so2299860oic.4;
        Wed, 26 Feb 2020 01:01:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=macTDBjGsJBFAkzTEbnQgMgA+V2t6di5RYgPeZ4V0yA=;
        b=hTWUuvBZps7CewVa9mBfqWRcqnS9pZNCBGDqzJTgDsCB9yt4urdSUod4478a2L2yqZ
         NL/ANKdG3GjbN1syU6LYLEGvHfDoNEiu/VCNkkEcLZiLZ+Ms88tUg8Lz2g6w15SGsRrV
         i/y7vX0buGyOARcLoEUQDeG6w/RbJr3XaiYjYL+/vWiqi5U6IstDor7pPu72vpNmFdB6
         Pk6Ux1E431wdVU9W1mJzItQfw93CqrsoyS+DiJ9ZvrLMq1w6hgrpvcU6YG6dhmB8isos
         CycrcHQg1a02iCJmX/VoA3XnjFxmbjzAHXNUHnNFLcDlXfb2F23jBKounGGkwVus0wHS
         WU6Q==
X-Gm-Message-State: APjAAAXRIukChcEIEsgR9w92TGrKDQT7P+RLbXR8NQ9OOoRB2IphkwOp
        FDcseQgD/BG1VLtMAb4jJPv4VuGq4NZNSRggtow=
X-Google-Smtp-Source: APXvYqxuvWrnnimHmJRDmJnHdfeLfZFnSg6/2kwxH/4IHrPk6O5KDZUWT9JQpCHHVSAThSVnnkmQH3FUUZDcTvnskKc=
X-Received: by 2002:aca:c4d2:: with SMTP id u201mr2289731oif.54.1582707708187;
 Wed, 26 Feb 2020 01:01:48 -0800 (PST)
MIME-Version: 1.0
References: <1582567352-4664-1-git-send-email-isaacm@codeaurora.org>
In-Reply-To: <1582567352-4664-1-git-send-email-isaacm@codeaurora.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Feb 2020 10:01:37 +0100
Message-ID: <CAMuHMdU-dHU2cjfGHS1c1p-mEfHWb70Ltm697up=ej8-jET=fg@mail.gmail.com>
Subject: Re: [PATCH] of: of_reserved_mem: Increase limit on number of reserved regions
To:     "Isaac J. Manjarres" <isaacm@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Patrick Daly <pdaly@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lmark@codeaurora.org, Pratik Patel <pratikp@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Isaac,

On Mon, Feb 24, 2020 at 7:03 PM Isaac J. Manjarres
<isaacm@codeaurora.org> wrote:
> From: Patrick Daly <pdaly@codeaurora.org>
>
> Certain SoCs need to support a large amount of reserved memory
> regions. For example, Qualcomm's SM8150 SoC requires that 20
> regions of memory be reserved for a variety of reasons (e.g.
> loading a peripheral subsystem's firmware image into a
> particular space).
>
> When adding more reserved memory regions to cater to different
> usecases, the remaining number of reserved memory regions--12
> to be exact--becomes too small. Thus, double the existing
> limit of reserved memory regions.
>
> Signed-off-by: Patrick Daly <pdaly@codeaurora.org>
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>

Thanks for your patch!

> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -22,7 +22,7 @@
>  #include <linux/slab.h>
>  #include <linux/memblock.h>
>
> -#define MAX_RESERVED_REGIONS   32
> +#define MAX_RESERVED_REGIONS   64
>  static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
>  static int reserved_mem_count;

This increases the size of reserved_mem[] by 896 (32-bit), 1280 (32-bit LPAE),
or 1792 (64-bit) bytes. While some systems don't need reserved memory
regions at all, and may be RAM-limited.

Perhaps this array can be replaced by some dynamically increasing
structure?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
