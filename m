Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B97C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70CBA206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CtdmmabV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbgFHLb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 07:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729310AbgFHLb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 07:31:26 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94069C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 04:31:25 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u5so8628720pgn.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 04:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fq1SK02WOrCT5rlC2v98CL1GYrwK/7RtzpRCqIrahIg=;
        b=CtdmmabVdAHRLQhMnnI7e1zKm5Oyf5yJBf/YEgecfeFSo3uVlQDp0YILQGxrtUKAwF
         NNbyc80pTYgZ3k9WYTcqqSJlHKn3XncarVnaz/jCdFvlqvDkh++fUEAWcQGwaa/eOxop
         p+5Lx1TE74ba93PYnCG9k+ZWoyixeEQcmEuVvovvUhe5uHFKZtgay6iPLrlqUexZ2NMz
         aOjsY8wScuIPAy0ljhX9v0xrK5LOXauD2G+EyRizdCOQnIwl5O8VpzBtanE+L1eyc5Kz
         7hMYVJ5ptv1JrNB4YBemHEAkC1PRVU43QZH6leH0w7e2jdXuw7FcTp4vK1gjOSndNY5X
         +JjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fq1SK02WOrCT5rlC2v98CL1GYrwK/7RtzpRCqIrahIg=;
        b=cDDUlnQ0z6ZKkG7ohEohNKgxbX4od9BFqckkhIU3N1YLd0R2i/ioptum8amaCQYbM5
         DlTE+cCWYD53GrjR23no3qhUgSH4B6ViLs3qWS8PSdXdNfFYRe2fhQ7K/Zy45ZzEvgkJ
         /5jhAvvabGKjgsPyxQxcUq7UMTw4EtpqOZ71DUDd43ujjl9aRtn+ressFPI+fFrAYCkz
         0GujxlnX9X6iXSE7vrqMgKkQcvY1H64YuUTlwgrFN2I4CM2MqVyO5IKJF3bzvZU8RgC+
         SaGJisGW2i6KbfXOZ2OIYGV4oV+eSKUI4KmnQuDIb90SLOfwu9Vw+nwAm6zchXikyQv7
         TYJA==
X-Gm-Message-State: AOAM530h+TaAk4exHQJojqwtcANVnffkIYdK0YhlZIOrAgIAc+kO673G
        9K9GDKyizJPLPgEWyjEVMoj3b7feIVJk+wxBZxHNjg==
X-Google-Smtp-Source: ABdhPJxz+ZC84XRUuUb/QrblrjtqNhY/pccUTBIaDfJ9rCoP6SqikG4oGeAu9XK0IFh783MM79HlHM9VpKFrBDjn3iU=
X-Received: by 2002:a63:e454:: with SMTP id i20mr19869829pgk.440.1591615884766;
 Mon, 08 Jun 2020 04:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <e3b30905-4497-29b4-4636-a313283dbc56@i-love.sakura.ne.jp>
 <20200528065603.3596-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200528110646.GC11286@linux-b0ei> <e0d6c04f-7601-51e7-c969-300e938dedc0@i-love.sakura.ne.jp>
 <CAHk-=wgz=7MGxxX-tmMmdCsKyYJkuyxNc-4uLP=e_eEV=OzUaw@mail.gmail.com>
 <CAHk-=wjW+_pjJzVRMuCbLhbWLkvEQVYJoXVBYGNW2PUgtX1fDw@mail.gmail.com>
 <13b0a475-e70e-c490-d34d-0c7a34facf7c@i-love.sakura.ne.jp>
 <CAHk-=wjj9ooYACNvO2P_Gr_=aN0g=iEqtg0TwBJo18wbn4gthg@mail.gmail.com>
 <6116ed2e-cee1-d82f-6b68-ddb1bbb6abe2@i-love.sakura.ne.jp>
 <CAHk-=wiVQUo_RJAaivHU5MFdznNOX4GKgJH1xrFc83e9oLnuvQ@mail.gmail.com>
 <19d377d3-8037-8090-0f99-447f72cc1d8c@i-love.sakura.ne.jp>
 <38df9737-3c04-dca2-0df4-115a9c1634e5@i-love.sakura.ne.jp> <CACT4Y+Z58Z8u1g8SBy-i1WxLMrdmXvggsLFAhfbLc8D=uffPyA@mail.gmail.com>
In-Reply-To: <CACT4Y+Z58Z8u1g8SBy-i1WxLMrdmXvggsLFAhfbLc8D=uffPyA@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 8 Jun 2020 13:31:13 +0200
Message-ID: <CAAeHK+x+rcxLdN+xw-QGi8-3T+89X+WHpZUUsOco3u58t=Z15A@mail.gmail.com>
Subject: Re: [PATCH v2] twist: allow converting pr_devel()/pr_debug() into snprintf()
To:     Dmitry Vyukov <dvyukov@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 9:48 AM 'Dmitry Vyukov' via syzkaller
<syzkaller@googlegroups.com> wrote:
>
> On Fri, May 29, 2020 at 3:27 PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >
> > Hello, Dmitry.
> >
> > Linus is asking me to avoid build-time switching based on kernel config options,
> > and is suggesting me to use boot-time switching based on boot-config file feature
> > (which is available since 5.6). I have several concerns about use of boot-config file
> > feature in syzkaller.
> >
> > (1) To use boot-config file, syzkaller will need to add "bootconfig" option
> >     to the kernel command line. This will be doable by patching
> >     https://github.com/google/syzkaller/tree/master/dashboard/config/ *.cmdline
> >     files.
>
> Hello Tetsuo,
>
> Yes, command line arguments are easily changeable. Please send pull
> requests to syzkaller, if you want to change something.
>
>
> > (2) The boot-config file is embedded into initramfs file. Since syzkaller builds
> >     kernels with almost-allyesconfig, booting syzkaller kernels do not require
> >     initramfs for loading kernel modules needed for mounting the root partition.
> >     In fact, according to "unexpected kernel reboot" report which contains boot messages,
> >     I can't find "Unpacking initramfs..." message. It seems that syzkaller kernels do not
> >     use initramfs file.
> >
> >     Is it possible for syzkaller to enforce performing steps for creating an initramfs,
> >     embedding the boot-config file
> >     ( https://www.kernel.org/doc/html/latest/admin-guide/bootconfig.html#boot-kernel-with-a-boot-config),
> >     and loading that initramfs whenever booting the syzkaller kernels?
> >     By the way, I do worry that people forget to perform these steps when they do
> >     their tests without asking syzbot...
>
> I think we have some confusion between syzkaller and syzbot here.
> syzkaller itself does not enforce/require any kernel configuration,
> hardware nor use or not use of initramfs. In fact, qemu VM type
> supports initramfs today. Or syzkaller can work with bare machines
> where all setup is up to the user.
> syzbot is just one deployment of syzkaller with a particular
> configuration/hardware.
>
> If this feature is useful for any linux kernel fuzzing, then we need
> to have a plan for all users and setups.
>
> And, yes, an additional context is kernel developers reproducing bugs.
> Not all of them may be happy about any additional steps, nor will
> follow them.
>
> Answering your question, syzkaller can do some sanity checking of the
> provided machine/kernel and reject working with it. If you tell me
> what exactly needs to be checked, I can think where this code should
> go.
> However, again, I am not sure if one is using, say, Android phones and
> they don't envision use of initramfs, then what?
>
> For syzbot, the build happens here:
> https://github.com/google/syzkaller/blob/7751efd04aebb07bc82b5c0e8eeaca07be1ae112/pkg/build/linux.go#L72
> I don't know if initramfs is supported with GCE machines and what
> exactly is required.
>
>
> > (3) Since syzkaller keeps track of "kernel tree", "commit of the kernel tree", and
> >     "commit of the syzkaller tree" in order to guarantee reproducibility, it would be
> >     possible to identify the "your-config" file used for tools/bootconfig/bootconfig
> >     command. But since "#syz test" command currently accepts only "kernel tree" and
> >     "commit of the kernel tree" arguments, we might fail to use intended "your-config"
> >     file when doing reproducibility test. Can syzbot solve this concern?
>
> Most likely it's possible.

FTR, there's https://github.com/google/syzkaller/issues/1611 filed for this.

>
> > (4) Of course, "your-config" file would not change so frequently, but "#syz test" command
> >     relies on external file in "syzkaller tree" makes it impossible to try different
> >     configuration when I have to ask syzbot to test. (Since I don't have hardware which
> >     syzbot is reporting problems, I have to ask syzbot when I can't reproduce the problem
> >     in my environment.)
> >
> >     https://syzkaller.appspot.com/text?tag=Patch&x=135f254a100000 is an example of
> >     need to enforce CONFIG_DEBUG_INFO_BTF=n in order to workaround build failure during
> >     "#syz test" command. If we bring "which twist options should be enabled" to an external
> >     boot-config file, I can't ask syzbot to try different twist options (except directly
> >     patching the kernel source which handles "which twist options should be enabled").
> >     Can syzbot solve this concern?
>
> The CONFIG_DEBUG_INFO_BTF relates to build config. This can't be
> solved during boot, right? So what is the relation?
>
> > (5) Anything else?
>
> Reading:
> https://www.kernel.org/doc/html/latest/admin-guide/bootconfig.html#boot-kernel-with-a-boot-config
> It seems that boot config is just a more complex way to provide
> command line arguments. syzbot already supports command line
> arguments, and it looks much simpler and no additional work required.
> Why do we want to use boot config?
>
> Next quarter we will be additionally busy with interns, so I can't
> promise any time availability for syzbot improvements. But pull
> requests are welcome.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller/CACT4Y%2BZ58Z8u1g8SBy-i1WxLMrdmXvggsLFAhfbLc8D%3DuffPyA%40mail.gmail.com.
