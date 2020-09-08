Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909E1C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A11220732
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fSSVFqkN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732041AbgIHRNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:13:16 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:52459 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726660AbgIHRNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:13:04 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id ec913daf
        for <linux-kernel@vger.kernel.org>;
        Tue, 8 Sep 2020 16:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=nYsjvTY+XcGAaXbY+ccHFh7T5nY=; b=fSSVFq
        kNf41kZKWRzyG8Gc4F8w0kkN+OvbfSHJfCZ7TtZFMsyveek6/hZNvsRMy8BsF7DJ
        mjSMFWz8Anri/b/GdUixt3ES0wPawOZTB7is3ckAbJ6PayNeMevWdRf9U4Tf392z
        16WDh3QOzq9Ugi7uSBW4RjaCdIkGbTRPStTdZzX5DAvSG8m02Q6vGpbhBRQtK9zC
        xtLkWDT5l9QQlagzqF8OtU7jen63PjShXL3g4kMnPGLjydBWltXKsS7CXrMFfXYx
        jhHf4qEsaUVFOv/AEl1XIIVLrqfw2ZO3iJi6CUi6b8tD4oQ6XJa1FECSwUaH1ZD5
        EKB7l9fVwhikWMhw==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 351848e7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 8 Sep 2020 16:44:03 +0000 (UTC)
Received: by mail-io1-f53.google.com with SMTP id r9so147666ioa.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 10:12:57 -0700 (PDT)
X-Gm-Message-State: AOAM531aQ0/djyoIswT5XXok76kESuMZwVt/LbspYuFnx27nkVFPyd4+
        5x1NeY+pTVrVk1IjRHk2GCcMtdghdoORO2IPMBY=
X-Google-Smtp-Source: ABdhPJwHl4f73BY8+k6TNTKn30y+8UEhxQUT7y0hwN77i1py461VioAFctTLDvsSLLbNaESI6Yg6/O8XB/1atHAde8U=
X-Received: by 2002:a6b:b98a:: with SMTP id j132mr21806732iof.67.1599585176932;
 Tue, 08 Sep 2020 10:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200907094843.1949-1-Jason@zx2c4.com> <20200907100647.GB10657@zn.tnic>
 <22617e57e541e460fac09db04fdb370f8e96e8ef.camel@linux.intel.com>
In-Reply-To: <22617e57e541e460fac09db04fdb370f8e96e8ef.camel@linux.intel.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 8 Sep 2020 19:12:44 +0200
X-Gmail-Original-Message-ID: <CAHmME9rh8N-Qui2KVxGP33Aar5tao_obA70XKwR2x5Qp1AytTw@mail.gmail.com>
Message-ID: <CAHmME9rh8N-Qui2KVxGP33Aar5tao_obA70XKwR2x5Qp1AytTw@mail.gmail.com>
Subject: Re: [PATCH] x86/msr: do not warn on writes to OC_MAILBOX
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Borislav Petkov <bp@suse.de>, kitsunyan <kitsunyan@airmail.cc>,
        "Brown, Len" <len.brown@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 7:10 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Mon, 2020-09-07 at 12:06 +0200, Borislav Petkov wrote:
> > + Srinivas.
> > + kitsunyan.
> >
> > On Mon, Sep 07, 2020 at 11:48:43AM +0200, Jason A. Donenfeld wrote:
> > > Popular tools, like intel-undervolt, use MSR 0x150 to control the
> > > CPU
> > > voltage offset. In fact, evidently the intel_turbo_max_3 driver in-
> > > tree
> > > also uses this MSR. So, teach the kernel's MSR list about this, so
> > > that
> > > intel-undervolt and other such tools don't spew warnings to dmesg,
> > > while
> > > unifying the constant used throughout the kernel.
> > >
>
> [...]
>
> > > -   if (reg == MSR_IA32_ENERGY_PERF_BIAS)
> > > +   switch (reg) {
> > > +   case MSR_IA32_ENERGY_PERF_BIAS:
> There is already sysfs interface for it.
>
> > > +   case MSR_IA32_OC_MAILBOX:
> > >             return 0;
> > > +   }
> > >
>
> [...]
>
> > Actually, we added the filtering to catch exactly such misuses and,
> > lemme check what is the proper word now... /me checks, aha, adding
> > new
> > MSRs to the "passlist" is the wrong thing to do.
> >
> > Srinivas, can you pls convert this in-tree driver to use a proper
> > sysfs
> > interface for that mailbox MSR and also work with the intel-undervolt
> > author - I hope I have the right person CCed from the git repo on
> > github
> > - to come up with a proper interface so that we can drop this MSR use
> > too.
>
> Overclocking is not architectural I/F and is supported by some special
> CPU skews. I can't find any public document to specify the commands
> which can be used via this OC mailbox. I have to check internally to
> see if there is any. To add a proper sysfs interface we have to make
> sure that we are not allowing some random commands to hardware and
> crash the system.

Well you can definitely crash the system this way -- undervolting can
result in all sorts of nice glitching. You might be able to even
programmatically undervolt to compromise the kernel in clever ways (a
lockdown bypass, I guess, but who cares).

That's why I initially suggested this was pretty squarely in the realm
of hobbyists and should just be added to that whitelist.
