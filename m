Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28002C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05A0520675
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589223870;
	bh=Bbw/osf+Dls0dYfvg/iUr2Q1C/9vYXrPOIGuh4A5DfU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JvzXcceH066GSCnla2N1ZK79ZMYylDMV2kHpxgejrjjCsDYthrJgnmZV3jAa+mZgZ
	 WOQjh7iGz3I56tqGX8c51MkYxRMYEwNix3wlha6A3d63JtgTeW9uSkfVeGDFqCwi6Z
	 YA1rfai8snHeDu+KcLeY12kBU5a7CGg2YNzoErXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731292AbgEKTE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 15:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731263AbgEKTE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:04:28 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEC4C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 12:04:28 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 188so8453069lfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 12:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YzsKJVzyv809UlovZpoNnJ1plerWdeBBXFFvRwVCLfU=;
        b=Aityn5qwpqm1WDEUGTp+1nV456XmvV8CfFEmW41oj4/bMkwJhVeEng5HZPhERMEjHU
         nCY9cggNS6UjKU4dGM6tzdYgB+qfI9VUHZ+DaRJy6199MAVi3dYOMOGDK92kbBygXWj9
         X+8s8UBqSDnkYdebJ7Q86uwTiep2ZsMcMt2rA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YzsKJVzyv809UlovZpoNnJ1plerWdeBBXFFvRwVCLfU=;
        b=Lf53/13rpQQQ9ePSBBxmNqxSoWHMkcU/OQ6UTQY0kv6BMfFU9dNB/NF428XM1glygd
         8Wtw9eR58Kfz6KAUGhYYAdcvki/8owhzKaLIn3PjeDZc/R4CkBfZWISKlHmQ9ESYe35A
         mwrEW5p4FMktJHwdn3UFacYf+aW+tjiIIhohiiEKlzRF8fXnjEm2mM4H+wf60/X2KG4u
         z+jG02XvX7UoOYW025WcRme/vo9XO/NXPrJPgm6eHVyA6q+1foqtahY6BHf33xxc5VFS
         McvIdljgtg/vF4oGnyFbvME/DOmux5TPpgoP2Ymr8GyCoH2tNlekaDakhu3N8E520AyP
         K47g==
X-Gm-Message-State: AOAM533r5wJUcwB/HN1W+EjT289wcKtS//Ra6U7d5eReyubwG3/x3l46
        XZFtuL8jiJZBFBLJSnpKiZMQlI8InVY=
X-Google-Smtp-Source: ABdhPJyS1XWaqaHux1LMnMiinLlJW+wZD8f59hn6tffAeW3HfTf9Ema5E0K47haNVRQ7JlSavY+yBQ==
X-Received: by 2002:ac2:4354:: with SMTP id o20mr3094608lfl.102.1589223866538;
        Mon, 11 May 2020 12:04:26 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id o204sm12034279lff.64.2020.05.11.12.04.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 12:04:25 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id e25so10777048ljg.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 12:04:25 -0700 (PDT)
X-Received: by 2002:a2e:9a54:: with SMTP id k20mr11892212ljj.265.1589223865222;
 Mon, 11 May 2020 12:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-81c83c19-6f5d-4ed1-a0bb-26accf4b7d3a@palmerdabbelt-glaptop1>
 <CAHk-=win0EVU_GuO=GuJu3Ck0WG1B3+ub-CjncM3B1G9x5d9cw@mail.gmail.com> <mvmr1vqkhxb.fsf@suse.de>
In-Reply-To: <mvmr1vqkhxb.fsf@suse.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 May 2020 12:04:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj8Cks7L2H9ToNWEMmqECYEfX0uyCXpW1OsZ+NAooi2Cw@mail.gmail.com>
Message-ID: <CAHk-=wj8Cks7L2H9ToNWEMmqECYEfX0uyCXpW1OsZ+NAooi2Cw@mail.gmail.com>
Subject: Re: [GIT PULL] RISC-V Fixes for 5.7-rc5
To:     Andreas Schwab <schwab@suse.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 1:13 AM Andreas Schwab <schwab@suse.de> wrote:
>
> On Mai 09 2020, Linus Torvalds wrote:
>
> > glibc depending on kernel version is WRONG. It's bogus. You can't do
> > feature detection based on kernel version, it's fundamentally broken.
> >
> > So I really would prefer to see glibc fixed not to do that stupid
> > thing, instead of adding pointless vdso notes to the kernel.
>
> I'm not aware of any discussion or bug report on this issue.  Any
> pointer?

We've discussed it informally several times, but that really is just
"I remember mentioning this before" than anything else.

Basically, testing kernel versions is pretty much always a bug. You
_will_ get it wrong, sometimes spectacularly (we've had programs
literally break when the major number changed, because they only
checked the minor number).

Other times you'll get it wrong in subtler ways - testing for features
by version number is wrong, if that feature is then disabled by a
config option (a lot of new kernel features work that way).

Or, the already mentioned "distros often port back features to their
older kernels". The latest example of that is Wireguard being ported
back to Ubuntu 20.04 - using kernel version 5.4, even though WG was
actually upstreamed in 5.6.

So the whole "look at kernel version to determine if it does X" is
simply fundamentally wrong.

Why is glibc doing it in the first place? Is it some historical thing
that is simply irrelevant on RISC-V simply because RISC-V doesn't have
that kind of history, perhaps?

                 Linus
