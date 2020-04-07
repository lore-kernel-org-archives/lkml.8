Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7720C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 17:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F264206BE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 17:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="qTZRxyhU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgDGR4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 13:56:18 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:40435 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgDGR4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 13:56:18 -0400
Received: by mail-il1-f195.google.com with SMTP id j9so4114237ilr.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 10:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hvJ5mj6gXn9DT9sfAhJ2ChcXw2JKTkzR1Wi3heZ02Ig=;
        b=qTZRxyhUBvB8r8DzHaWWJ9MSkCYfWnA/YinvGgDEnyptSg0zjB0/eCP2yHOV2WjPXa
         3zcyfee9oNK+lHnTa6A3PHTDDz622tb9gN7uO/wJX3PdQ1wvuhq194yRokWbyMys6zAK
         30jTu88B+/XQA7bnfLiRVfk2XJkQqKk+3eRkfQ5U/EyXBJSQ6JMlVIrCvR84HRzfIWF5
         /zxuXnctRaRDBUaAcJKvzCmKtb91dDR2wuGS6k9Y6Ege0ucIHqUmqDskDjVLmsA7NoHu
         Zh4c+JRkLlSCrKkbHG6wGo7tmH27RgIzta7u2Jl33xGUzLHsUewKCZbRrYWQavGaSoKG
         5p5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hvJ5mj6gXn9DT9sfAhJ2ChcXw2JKTkzR1Wi3heZ02Ig=;
        b=FRVfsRJnetgClBkIgfaGJa36XEwvwYdhhzTStvG5WxizrAjqgmKkvd8kXmt7+6w9JU
         H0sRyjBpcDatjHu+IlsWBuvOJfBR0LQqx94FSGdL+Saqng7/nfx6ZFlA2EKDLqBfraJv
         Ev4A+glHczqwNexWsLsK6OlsUO04mQwTG60ZuX0VwZV6ZdaBJlrteajNz11DcmeVSrh4
         2/OIzuE60Ojo493hteZoTqJoqzNHBXyE0ieBsst7ja7EZDA3ilHQr/YXeBkIY0voO2yI
         Q12mZxdUmkq0mbxcYvJ03jleWyzOvl1jqMitENPKmKVcAIvmTqwe/ZcWhIC9Hrqm0XPb
         usqA==
X-Gm-Message-State: AGi0PuYzPrzU8PwYWsRT6uycvTwZUfMARyCy0Zk5EKDtNCS1T7EnJV3K
        ARNsv8oCOtKLa+29PJwsZwTm50jdvLps9uMoVu8pNg==
X-Google-Smtp-Source: APiQypI9kHAW/Yf4ewikrQLJhKlEmtovKsYuKq0dAYyDV6qBZS9zeRcMhoJQHnsQruqzQ/9zX3VsH99VKX7ok+8qJBA=
X-Received: by 2002:a92:d11:: with SMTP id 17mr3753627iln.145.1586282177536;
 Tue, 07 Apr 2020 10:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200407011259.GA72735@juliacomputing.com> <8f95e8b4-415f-1652-bb02-0a7c631c72ac@intel.com>
 <CABV8kRw1TQsqs+z43bSfZ5isctuFGMB4g_ztDYihiiXHcy4nVA@mail.gmail.com> <5208ad1e-cd9b-d57e-15b0-0ca935fccacd@intel.com>
In-Reply-To: <5208ad1e-cd9b-d57e-15b0-0ca935fccacd@intel.com>
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Tue, 7 Apr 2020 13:55:40 -0400
Message-ID: <CABV8kRzfR32+MpAvTAPHCN902WtHSxySujcO2yAB3OT0caVDJg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/arch_prctl: Add ARCH_SET_XCR0 to set XCR0 per-thread
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        Kyle Huey <khuey@kylehuey.com>,
        "Robert O'Callahan" <robert@ocallahan.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 12:27 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> >> How does this work with things like xstateregs_[gs]et() where the format
> >> of the kernel buffer and thus the kernel XCR0 is exposed as part of our
> >> ABI?  With this patch, wouldn't a debugger app see a state buffer that
> >> looks invalid?
> >
> > Since those operate on the in-kernel buffer of these, which
> > in this patch always uses the unmodified XCR0, ptracers
> > should not observe a difference.
>
> Those operate on *BOTH* kernel and userspace buffers.  They copy between
> them.  That's kinda the point. :)

Right, what I meant was that in this patch the kernel level
xsaves that populates the struct fpu always runs with
an unmodified XCR0, so the contents of the xsave area
in struct fpu does not change layout (this is the major
change in this patch over v1). Are you referring to a ptracer
which runs with a modified XCR0, and assumes that the
value it gets back from ptrace will have an XSTATE_BV
equal to its own observed XCR0 and thus get confused
about the layout of the buffer (or potentially have not copied
all of the relevant xstate because it calculated a wrong buffer
size)? If so, I think that's just a buggy ptracer. The kernel's
xfeature mask is available via ptrace and a well-behaved
ptracer should use that (e.g. gdb does, though it looks like
it then also assumes that the xstate has no holes, so it
potentially gets the layout wrong anyway).

In general, I don't really want the modified XCR0 to affect
anything other than the particular instructions that depend
on it and maybe the signal frame (though as I said before,
I'm open to either here).

If I misunderstood what you were trying to say, I apologize.

> I suspect the patch thus far is only the tip of the iceberg.  I'd really
> suggest doing some more thorough audits of all of the locations in the
> kernel that touch the fpu buffer *or* that call XSAVE/XRSTOR.  I'm
> pretty sure that audit hasn't been done or the ptrace example would have
> been found already.

Yes, good idea. I will do this again. That said, I'm hoping that
the general principle to use the kernel layout, except perhaps
in the signal frame will hold and thus not require modification.

> But, it's also not my daily go-to for debugging.

Luckily rr is fast enough (after much work) that there's almost
never a reason not to use it. Our developers essentially use
it exclusively (rather than raw gdb), and our users send us rr
traces as bug reports. It's basically become our one-stop-shop
for all things debugging on Linux.
