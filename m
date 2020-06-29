Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECD7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DF86206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388191AbgF2Vjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:39:43 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37988 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgF2Vj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:39:27 -0400
Received: by mail-ot1-f66.google.com with SMTP id t18so4012679otq.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zBbJxAzHeFyLdRCFi71uGQynNKf0vLXIcN1SXOmKrT8=;
        b=bMGlmGXzjenIRxiHnOnDbGL2xu/NrevWJ6SsG6z1ODtO8BtzyUVNoladPLcNzdxYRK
         n3yQRNCn9QkocJD2O3lUSSrTgddvlV6eOTg//Etv/K615BOC4abSLHYPkb9TEe2+o/3F
         iUUpIDp2rsnm8zntu0Xpfp4gFNUvck+fOQXjdUMZF0Ee6aKIOlbEumihG80ccPoNUeiC
         pPL7zsBc9A+QsIi3s11M/cqDp8Eg9O7HUGvuoEM7EjRnCXEFiS4Vtcj5BlKGtl883Zcf
         wVdN7Np2V0OV/gN/ZMe0Ue5+o6UoDIoOqx5FCS8dT/KB83FDZJWtNaIiM+ivN5j8T+80
         3E/g==
X-Gm-Message-State: AOAM532X99p0pbKqiI0MjuqOS96FXemnp/eYQkOan+1TnP8wBRCSBBwo
        8AVQ8tjNgdPH92cfT4plDvssBmZrTNJ91MQbVJOtLntx
X-Google-Smtp-Source: ABdhPJz6OhN5KSx5Kp+XvyEP7Va5vy1Fq+Axch0lFYKWJrYB344O97OtuAZIJgD6Icc0ZowIhsZA16Hh4uG0BzkcxuE=
X-Received: by 2002:a05:6830:1451:: with SMTP id w17mr2546318otp.250.1593466766769;
 Mon, 29 Jun 2020 14:39:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590880333.git.fthain@telegraphics.com.au> <CAMuHMdVb2C7asip_-_zbc3JP+nqn6siKqmikOK98tM5=2BYqcQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVb2C7asip_-_zbc3JP+nqn6siKqmikOK98tM5=2BYqcQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 29 Jun 2020 23:39:14 +0200
Message-ID: <CAMuHMdVOPFF-9QMYnbxDeWQVFBVVbDVxeYKV8z=cUNxL_dFOLg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Mac IOP driver fixes
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 31, 2020 at 10:41 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Sun, May 31, 2020 at 1:16 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> > This patch series has several bug fixes for the IOP driver and some
> > improvements to the debug level log messages.
>
> Thanks for your series!
>
> > Geert, please consider pushing these fixes for v5.8, if not the
> > whole series.
>
> I'm afraid it's a bit too late for that, as I expect the v5.8 merge window
> to open tonight.  Unless the fix is for a regression in v5.7.

Queued in the m68k for-v5.9 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
