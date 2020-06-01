Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE7DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C3D2073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591041389;
	bh=GijrLkViV6QtAWQ+T67migLsAfjmTP/v3m7vsAE8gDQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PhtM+W5esSDL5cJKz5KFRuRLuBCSaJDtPKwdPhIVblPBDEB9G+K6Pujhtuh/WG6vo
	 jRbBMEoLP96wXJ/pG2b9FHVhSgWLvki+Ooh0/nG5wHwNt+w0Enp7xf7ceNNID/C/R7
	 PXJLLyzY6w/1FF64P5GltAYNYjmTZKkf1Y8/M79s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgFAT42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 15:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgFAT42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 15:56:28 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC647C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 12:56:27 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id x22so4669408lfd.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 12:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HDL8HqCoSdHZQSQzIjnUZyIe5bA7GhgjxVOc6cThlMc=;
        b=XRSmM2EgjG1KOb3jI0dYUmw88ZCSAs9wCuRG3ks8PpZK7HFYmAq6buyRofcCNPYRIh
         s5rD1iG6C0BKM3IPzGDvxFSmBu1rBlK6QoVPcB6gvNJGNmuu0CvUk3nnmJdR5wbvHUuK
         x7MLFJ8oNG1soFzd1O3Mfw1HrpIFSqep7WMJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HDL8HqCoSdHZQSQzIjnUZyIe5bA7GhgjxVOc6cThlMc=;
        b=K5SDvpZeFHuWTaA/qFu053uHgH6SgxR6L9X+VN5QYzl2HPJGIFE5fXveZmjI2Cx3SS
         UeB7ozmCCd5XHZbCI8EdtKfBf9RgeD0TpaO5k0E8+iB7H+v6ElsUWRq6GIP52zx2Q7KK
         edP1YU4kmSVG4Jic79KZrnknt09B5/vTwGqkWzkm/obga0nryBiq5N921Li/1rMtkGy1
         dw+IYLV/OFZi4JRjZVGMZrtRq1qkCBGn7utKaYYGeEIO4tKZcH2YrHTRjGa5pPMwUAmW
         fEM7M/Wc4jNgE6PwUBwCiZt6HvdwQTBOfzl/1QJ6PvxAeTymI57h7K6qZHcAg43mL8tI
         YPYA==
X-Gm-Message-State: AOAM530mmLlTRiPVRYwuPWNVi2MxVNELa42FIhJnOYT6Wroa0cAizhi1
        AxSzASq8H1hSlycHmBldhIcN9yvbnSM=
X-Google-Smtp-Source: ABdhPJxmNoc22DYgCPlun24BqdJJvC9YukMXkrri++/6VzxApTGpnZHlyNWvj2wvVEuMzlTqZ9SEig==
X-Received: by 2002:ac2:54b4:: with SMTP id w20mr12034695lfk.48.1591041384597;
        Mon, 01 Jun 2020 12:56:24 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 10sm101182ljw.134.2020.06.01.12.56.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 12:56:23 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id z6so9652884ljm.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 12:56:23 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr4660105ljn.70.1591041383289;
 Mon, 01 Jun 2020 12:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200601130806.GA746506@gmail.com>
In-Reply-To: <20200601130806.GA746506@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Jun 2020 12:56:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgmXOFyiu6jZ8Dj8OAU7c0T0q-6RLygKC2tMiNfL7MQjQ@mail.gmail.com>
Message-ID: <CAHk-=wgmXOFyiu6jZ8Dj8OAU7c0T0q-6RLygKC2tMiNfL7MQjQ@mail.gmail.com>
Subject: Re: [GIT PULL] kprobes updates for v5.8
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 6:08 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>  include/linux/compiler.h            | 53 +++++++++++++++++++++++

I have pulled this, but do we really want to add this to a header file
that is _so_ core that it gets included for basically every single
file built?

I don't even see those instrumentation_begin/end() things used
anywhere right now.

It seems excessive. That 53 lines is maybe not a lot, but it pushed
that header file to over 12kB, and while it's mostly comments, it's
extra IO and parsing basically for _every_ single file compiled in the
kernel.

For what appears to be absolutely zero upside right now, and I really
don't see why this should be in such a core header file!

I don't even see this as having anything at all to do with
"compiler.h" in the first place.

I really think we should think twice about making core header files
bigger like this. No, we're nowhere the disaster that C++ project
headers are, but tokenization and parsing is actually a pretty big
part of the build costs (which may surprise some people who think it's
all the fancy optimizations that cost a lot of CPU time).

                  Linus
