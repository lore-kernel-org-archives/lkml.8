Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB81DC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 17:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD20120715
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 17:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cBtNeyqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgGERdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 13:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgGERdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 13:33:18 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DEBC061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 10:33:18 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id u133so5902331vsc.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 10:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NH4cxtxR/0Y+0jd20+PjD1WA5GndkCwRRncZwLqJz/Y=;
        b=cBtNeyqn5hA3Hs6uOMcN8BnCpapf+zMTGlaqH1FWDWYFrfu917OH7GL5rYJ9wLP1PP
         LlmrlKllWoO9+6OG29oaT26G5eQbt/VWCWSS9ZLjtv6d6T7sCi53lQ57vqHgzf2fvYbn
         vG8P0CIrwIrL9CHJPbS8FiPv+DBCSKCrd96a0j2Dqrc8oHiPuWiCSXPwukrTL7UmaCZ6
         hQC6DKiBkNVKenjFt2b1UskkhDfAIKlCan9PUyv3aF1f5lpjsuOXwA7OvTYYKY1r6L6h
         JbjlR4KNyjwQIrewxSAUFJxzZ+lxiRtQEfuBPm6XGB/rcgkXIM2OiGsHqXQA99klU0rA
         arDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NH4cxtxR/0Y+0jd20+PjD1WA5GndkCwRRncZwLqJz/Y=;
        b=FLwpw5JvHoTucSZ1lXxePBxb+2gjlLubEiX+bfCo12C6ggrRotjmqxSK5CyKkOqAjr
         gW5Yd2daDAKit6wFW9ZTVdeVKTJE23LmTGqljVa0B0OubfmSJ/6rOLy9Pm1MW9I9ulxO
         JblvKUeVJoCRhfA3mk+PG+7Oq5sTEW08z5s6CvwOEDPwIXXJvy3CR5nRb3ozbkjmjIe2
         tmaHfxxtc0kE1cYd4EjOSxRcNlP8v5Q/1cd0zi5iHOYQ8HgMUotsAkSgsMcQ56vrO312
         jgtPheZRbmr3FZCzNfuKT5KrUTto2ZKR5dRS1Fb3hoKbU+AlUdO68o2v/EZLV9Rm3LL+
         holg==
X-Gm-Message-State: AOAM5311CZVr2PDdDaz6DXaWe9y2OepeYBanRTpx+QaNPKL884Yf5TMZ
        B5keh/GxAtLm7AUxDZMrrYiurf1BBFxJa6Hz7La37A==
X-Google-Smtp-Source: ABdhPJwKaTAf2DJ5wehjojXsf+2XEtlGsgniyFYkG9ZLXq5HNDgFsDtk+ZeA7JhiEFX22LsG+PIWxQDneHQjm4efPkU=
X-Received: by 2002:a05:6102:249:: with SMTP id a9mr4341305vsq.198.1593970397025;
 Sun, 05 Jul 2020 10:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200702221237.2517080-1-abhishekbh@google.com>
 <e7bc00fc-fe53-800e-8439-f1fbdca5dd26@redhat.com> <CAN_oZf2t+gUqXe19Yo1mTzAgk2xNhssE-9p58EvH-gw5jpuvzA@mail.gmail.com>
 <CA+noqoj6u9n_KKohZw+QCpD-Qj0EgoCXaPEsryD7ABZ7QpqQfg@mail.gmail.com>
 <20200703114037.GD2999146@linux.ibm.com> <CAD=FV=XRbrFqSbR619h+9HXNyrYNbqfBF2e-+iUZco9qQ8Wokg@mail.gmail.com>
 <20200705152304.GE2999146@linux.ibm.com>
In-Reply-To: <20200705152304.GE2999146@linux.ibm.com>
From:   Doug Anderson <dianders@google.com>
Date:   Sun, 5 Jul 2020 10:33:04 -0700
Message-ID: <CAD=FV=XJNUVAGJp0UDHNd1uOiLX_=Z6Td_SBrVvhZ04SYSqn2A@mail.gmail.com>
Subject: Re: [PATCH v3] x86/speculation/l1tf: Add KConfig for setting the L1D
 cache flush mode
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Abhishek Bhardwaj <abhishekbh@google.com>,
        Anthony Steinhauser <asteinhauser@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
        x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jul 5, 2020 at 8:23 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Fri, Jul 03, 2020 at 07:00:11AM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, Jul 3, 2020 at 4:40 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > >
> > > On Thu, Jul 02, 2020 at 11:43:47PM -0700, Abhishek Bhardwaj wrote:
> > > > We have tried to steer away from kernel command line args for a few reasons.
> > > >
> > > > I am paraphrasing my colleague Doug's argument here (CC'ed him as well) -
> > > >
> > > > - The command line args are getting unwieldy. Kernel command line
> > > > parameters are not a scalable way to set kernel config. It's intended
> > > > as a super limited way for the bootloader to pass info to the kernel
> > > > and also as a way for end users who are not compiling the kernel
> > > > themselves to tweak kernel behavior.
> > >
> > > Why cannot you simply add this option to CONFIG_CMDLINE at your kernel build
> > > scripts?
> >
> > At least in the past I've seen that 'CONFIG_CMDLINE' interacts badly
> > with the bootloader provided command line in some architectures.  In
> > days of yore I tried to post a patch to fix this, at least on ARM
> > targets, but it never seemed to go anywhere upstream.  I'm going to
> > assume this is still a problem because I still see an ANDROID tagged
> > patch in the Chrome OS 5.4 tree:
>
> I presume a patch subject should have been here :)
> Anyway, bad iteraction of CONFIG_CMDLINE with bootloader command line
> seems like a bug to me and a bug need to be fixed.

Sure.  In the Chrome OS 5.4 tree, this is commit 016c3a09a573
("ANDROID: arm64: copy CONFIG_CMDLINE_EXTEND from ARM").  Here's a
link too:

https://chromium.googlesource.com/chromiumos/third_party/kernel/+/016c3a09a573

...written in 2014.  :-)  Ah funny.  It looks like to make this work
we're carrying around something based on my old patch, too (from
2012)!  :-P  Commit 5eaa3f55d381 ("ANDROID: of: Support
CONFIG_CMDLINE_EXTEND config option"), or (as a link):

https://chromium.googlesource.com/chromiumos/third_party/kernel/+/5eaa3f55d381

IIRC without stuff like those patches then, on ARM (and ARM64)
hardware anyway, you get _either_ the command line from the bootloader
or the command line from the kernel.  So I guess I wasn't quite
remembering it correctly and it wasn't a bad interaction with the
bootloader but just generally that on ARM kernels on mainline there
just isn't a concept of extending the command line.

Certainly someone could make an extra effort to get the above patches
landed in mainline, but (trying to remember from ~8 years ago) I think
I dropped trying to do that because it was pointed out to me that it
was better not to jam so much stuff into the command line.

...and yes, the fact that we're carrying those patches in the Chrome
OS tree means we _could_ just use them on Chrome OS, but I'd rather
not.  Right now we only have them there because we merged in the
ANDROID tree and I'm not aware of any Chrome OS users.  In general I
prefer not to rely on patches that are not in mainline.


> > In any case, as per my previous arguments, stuffing lots of config
> > into the cmdline is a bit clunky and doesn't scale well.  You end up
> > with a really long run on command line and it's hard to tell where one
> > config option ends and the next one starts and if the same concept is
> > there more than one time it's hard to tell and something might cancel
> > out a previous config option or maybe it won't and by the time you end
> > up finishing this it's hard to tell where you started.  :-)
>
> Configuration options may also have weird interactions between them and
> addition of #ifdef means that most of the non-default paths won't get as
> good test coverage as the default one.
>
> And the proposed #ifdef maze does not look pretty at all...
>
> > > > - Also, we know we want this setting from the start. This is a
> > > > definite smell that it deserves to be a compile time thing rather than
> > > > adding extra code + whatever miniscule time at runtime to pass an
> > > > extra arg.
> > >
> > > This might be a compile time thing in your environment, but not
> > > necessarily it must be the same in others. For instance, what option
> > > should distro kernels select?
> >
> > Nothing prevents people from continuing to use the command line
> > options if they want, right?  This just allows a different default.
> > So if a distro is security focused and decided that it wanted a slower
> > / more secure default then it could ship that way but individual users
> > could still override, right?
>
> Well, nothing prevents you from continuing to use the command line as
> well ;-)
>
> I can see why whould you want an ability to select compile time default
> for an option, but I'm really not thrilled by the added ifdefery.

Sounds like the right solution here is to clean up the patch to make
it not so hard to follow and it looks like there's already a
suggestion for that.  :-)

-Doug
