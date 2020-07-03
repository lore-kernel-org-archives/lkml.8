Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D07C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 808B620870
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ilCOu9gY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgGCOA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 10:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgGCOAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 10:00:25 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65244C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 07:00:25 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id h1so7045462vkn.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 07:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x5F3VEjoP3FKUljXbLKCPFmED7t6N7RsImdk24VNfSc=;
        b=ilCOu9gYBMdqPI/WloUGvxq/+wnGHnQ1ZAHN1ZxENszq7GPp9XNKx9zUBnE+fK9TgU
         kQxMN49VEXWiecCYQDAL/WKl0bVLcsUEfsmWRF1OqyDngNlhJxLHKL5br824jjZHpUjJ
         7hdtRocMgi9/yp6SHT51EkOw9NH2gxFvrwG3GVZa6/L7YD+wxw1rIg9Gl4V8GOyMVAaE
         cpP+FflthlLgMOCHyBLj9hCGNiq5UWE+L7Cd0KnzVOHXaoX++5r96myY1zSsJ810tV+B
         fijJbiHJsmfDJ/u/k7Z4OHk1777RqOIaN0m4d2ZRnvaostA+caNpfnc2Ov0C5PnO46BU
         +LoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x5F3VEjoP3FKUljXbLKCPFmED7t6N7RsImdk24VNfSc=;
        b=HSPU4AemdqG0j1GCNvpVnN5qrC/ao5L2uCKWTwffviuZVPEU9pLtUXCi+ork/6BgJs
         ULFDs8YftiKWZcbMU3AjfSBeQ1sYZIeNMK2QFwAU46HQR2RviTBTF/s+PBKDK3DgMR7V
         1utPfvNlUtV59CpsbBz2N0XIpQs6Z3Z0F4hCypd34RbY06/GtT+k2u55lDRK4RNd6d45
         SBgRpG91yfk+F23IKcWInPWdSxdqa78HyItA5+ig4iAJfHdaBlp+hAGimCBxS+VIjVn6
         DO+q0TAYIhc30rU/dtcQNczUbeA0K3nljeVTAXMs0LEsOgqRufAJv+s3+sqe0BI7g+Px
         xuGw==
X-Gm-Message-State: AOAM531T8Uc+0acoPu3VMZTRdjp7HHnP3IlFXy/Pz/4ztGArJ8Ie+TV4
        Kli6lFioNlaFSuk0Ceyq02Zstnz8DfAWGJjR2aqXIw==
X-Google-Smtp-Source: ABdhPJwx16TCC0yxwEDEAWqU8RVaCCWww0gPA4ZSJHucJ6hbfJede4vfqOlpKj94dbBKxrLzf14j6uvN3giH1XMSxM4=
X-Received: by 2002:a1f:3f05:: with SMTP id m5mr1556534vka.92.1593784823956;
 Fri, 03 Jul 2020 07:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200702221237.2517080-1-abhishekbh@google.com>
 <e7bc00fc-fe53-800e-8439-f1fbdca5dd26@redhat.com> <CAN_oZf2t+gUqXe19Yo1mTzAgk2xNhssE-9p58EvH-gw5jpuvzA@mail.gmail.com>
 <CA+noqoj6u9n_KKohZw+QCpD-Qj0EgoCXaPEsryD7ABZ7QpqQfg@mail.gmail.com> <20200703114037.GD2999146@linux.ibm.com>
In-Reply-To: <20200703114037.GD2999146@linux.ibm.com>
From:   Doug Anderson <dianders@google.com>
Date:   Fri, 3 Jul 2020 07:00:11 -0700
Message-ID: <CAD=FV=XRbrFqSbR619h+9HXNyrYNbqfBF2e-+iUZco9qQ8Wokg@mail.gmail.com>
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

On Fri, Jul 3, 2020 at 4:40 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Thu, Jul 02, 2020 at 11:43:47PM -0700, Abhishek Bhardwaj wrote:
> > We have tried to steer away from kernel command line args for a few reasons.
> >
> > I am paraphrasing my colleague Doug's argument here (CC'ed him as well) -
> >
> > - The command line args are getting unwieldy. Kernel command line
> > parameters are not a scalable way to set kernel config. It's intended
> > as a super limited way for the bootloader to pass info to the kernel
> > and also as a way for end users who are not compiling the kernel
> > themselves to tweak kernel behavior.
>
> Why cannot you simply add this option to CONFIG_CMDLINE at your kernel build
> scripts?

At least in the past I've seen that 'CONFIG_CMDLINE' interacts badly
with the bootloader provided command line in some architectures.  In
days of yore I tried to post a patch to fix this, at least on ARM
targets, but it never seemed to go anywhere upstream.  I'm going to
assume this is still a problem because I still see an ANDROID tagged
patch in the Chrome OS 5.4 tree:

In any case, as per my previous arguments, stuffing lots of config
into the cmdline is a bit clunky and doesn't scale well.  You end up
with a really long run on command line and it's hard to tell where one
config option ends and the next one starts and if the same concept is
there more than one time it's hard to tell and something might cancel
out a previous config option or maybe it won't and by the time you end
up finishing this it's hard to tell where you started.  :-)


> > - Also, we know we want this setting from the start. This is a
> > definite smell that it deserves to be a compile time thing rather than
> > adding extra code + whatever miniscule time at runtime to pass an
> > extra arg.
>
> This might be a compile time thing in your environment, but not
> necessarily it must be the same in others. For instance, what option
> should distro kernels select?

Nothing prevents people from continuing to use the command line
options if they want, right?  This just allows a different default.
So if a distro is security focused and decided that it wanted a slower
/ more secure default then it could ship that way but individual users
could still override, right?


> > I think this was what CONFIGS were intended for. I'm happy to add all
> > this to the commit message once it's approved in spirit by the
> > maintainers.
> >
> > On Thu, Jul 2, 2020 at 8:18 PM Anthony Steinhauser
> > <asteinhauser@google.com> wrote:
> > >
> > > Yes, this probably requires an explanation why the change is necessary
> > > or useful. Without that it is difficult to give some meaningful
> > > feedback.
> >
> >
> >
> > --
> > Abhishek
>
> --
> Sincerely yours,
> Mike.
