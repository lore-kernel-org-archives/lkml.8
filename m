Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676E4C433EA
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AD7220657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbgGOI6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:58:18 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33423 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgGOI6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:58:17 -0400
Received: by mail-ot1-f65.google.com with SMTP id h13so907207otr.0;
        Wed, 15 Jul 2020 01:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yeMnyF7ItkVPbtYZTSOeFcZrCITQGIgmunPb5COo8ho=;
        b=R4M+O0MjMDArVRKXd7UQt7y3MDfYzPTANI1v/cGy1orlhCkU0PESHPy43NcpEm8XtK
         rtanPa9nCZPbrdFnG22rkUkfDFOJsRjPUukD750qiR3p2hfoiyROzmIbHGWTMHx3QbN7
         W40H7fvk1f6c2cqs72Z4iRmhwYaFElws9uk4V+jDyTRgpE6d9A13E0PGHGBb+tkA5dmI
         pJnP3z7gPaovorYf9HwzovLpxbx+y3SjppOoMAySIqde8dGe2ukQoPFlxiS4s9NdcVyC
         t56RLxhrtCQrPPH/cdsdRtHIRr1YTbVg0XjJVGSWk3+MAtKWCl29MfoEJbj3lTgzUzVH
         yXSQ==
X-Gm-Message-State: AOAM5303alQVFXIRTEXSkEco2tpvnZvb1efT3NKHLXhliaV4CRQlddNo
        NAXW27ogmJqrNq4r/KS/DZfCm85QnyUhCUF/0bs=
X-Google-Smtp-Source: ABdhPJwZdiDSNrdcxQGeLvb5RpjI9g0hXGtsKjnc7+qJE0VqWxy8FJ9B6iVyumYToIoYSRNEJs0YhVphNnDk0kqWCsY=
X-Received: by 2002:a9d:2646:: with SMTP id a64mr7395517otb.107.1594803496888;
 Wed, 15 Jul 2020 01:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200714123419.3390-1-aford173@gmail.com> <20200714123419.3390-2-aford173@gmail.com>
In-Reply-To: <20200714123419.3390-2-aford173@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Jul 2020 10:58:05 +0200
Message-ID: <CAMuHMdVS6Hf344EbyroGCWR_yxtO3DZh=JUJhauy5OeVG2hajA@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] dt-bindings: arm: renesas: Document beacon-rzg2m
To:     Adam Ford <aford173@gmail.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 2:34 PM Adam Ford <aford173@gmail.com> wrote:
> Beacon EmbeddedWorks in introducing a development kit based on the
> Renesas RZ/G2M platform.  This patch adds the entry to the bindings
> list.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.9, with the typo pointed out
by Sergei fixed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
