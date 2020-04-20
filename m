Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FD8C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 422AC20782
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587401536;
	bh=tX5NSBI04EVfJ6fpi/3OkfdSYcQSg6+pwH+dNbvKNrM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=U04P77fptsP2keX6Z4RuboCAVC0gewCrqSMZ0Bv4XiiNaxPjpqZVeCY+LEjmYKWcE
	 dVUX4oapXyih+m9wdRTDqSXSgslFJePYt17laTXJZi2mEDP3IG0wyklkCLZn8wUMgU
	 89ADtrE8svKbqbxgW2XmMJ8UtzAl2OgtjzEXDCNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgDTQwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726355AbgDTQwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 12:52:14 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E91FC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 09:52:14 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id l19so8247688lje.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 09:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DgzbtyUAM4NlYMJ2ldfH5ZZqB6BcgOSBDmAWxwlzsD4=;
        b=Mwm6V6tI8dML4TUgLvOCBORRkXVmUzROyVC9PfiZyNBcp8QfRdeet+ht2OPwxEXxKL
         u+s0Ie8mlP/auMO6vYzBBy5VMQl0QMNSxEGjLEzLHqiNZg+ecbusmoobgE52F+Rk2ATl
         lPpvKsg7Oa9Jtw0S4c1pyUjdHidRgVIU8n6Js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DgzbtyUAM4NlYMJ2ldfH5ZZqB6BcgOSBDmAWxwlzsD4=;
        b=t04KHLszITaTACH1ofNH31UKGGBbPSM/vIKAWZyer4r2dPGa5rnDx4x4VmeOTV1cig
         I7HhYP4q5lXbPlFHeS++WpduIrt/FMYc0RP8bHX0+cm722ssHrJP4XbspHDfuxjyt1w1
         mpa1Q8XpyhT941x6LzRLNW2/6vQg0j1EeqGG8ZO2Fw70zb1eSf6CJqJ6Wl1u472HkA31
         +mu6OCrvrB4bHqkWVhPO2A6dVtwA+cUgZt/ZdAQQo4WU7/+di+sZw3GAdnRJnP5ggLWB
         xMYNSS8xJPeBBr6rAKsxuijFinE8NpB9gggi6lFNEpRAj7wxPWje/KTcxPsF38ae7K6X
         iG+g==
X-Gm-Message-State: AGi0PuZBtEFEFMYQSxINssWBcZMeUR+YOtLCay5Wnu41SmcTqtb09VQG
        D7WTEIToro/V96tfShaIyn1CapIyCJk=
X-Google-Smtp-Source: APiQypLqaHG/0qk9TNwdv9LApamAk+DjTNpkDvqYSXXJ7m7AxyQTChAgS6O6IJQ90Mv0XKLO0WWCfg==
X-Received: by 2002:a2e:9258:: with SMTP id v24mr2154548ljg.109.1587401532597;
        Mon, 20 Apr 2020 09:52:12 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id d24sm1241049lfi.21.2020.04.20.09.52.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 09:52:11 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id y4so10746039ljn.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 09:52:11 -0700 (PDT)
X-Received: by 2002:a2e:b619:: with SMTP id r25mr11099348ljn.150.1587401531317;
 Mon, 20 Apr 2020 09:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <158730459860.31269.9496277256253823777.tglx@nanos.tec.linutronix.de>
 <158730460101.31269.5005570498545135614.tglx@nanos.tec.linutronix.de>
 <CAHk-=wjUS9b-B1n=OCBdqq3mdVTNGz0zqhGnrtMijoB5qT+96g@mail.gmail.com>
 <20200419200758.3xry3vn2a5caxapx@treble> <20200420074845.GA72554@gmail.com>
In-Reply-To: <20200420074845.GA72554@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Apr 2020 09:51:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiG=Bz57AUmbTyZYMKU6C+nZpS8P2=vFf5xAAhBzrPuTQ@mail.gmail.com>
Message-ID: <CAHk-=wiG=Bz57AUmbTyZYMKU6C+nZpS8P2=vFf5xAAhBzrPuTQ@mail.gmail.com>
Subject: Re: [GIT pull] perf/urgent for 5.7-rc2
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 12:48 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> Fortunately, much of what objtool does against vmlinux.o can be
> parallelized in a rather straightforward fashion I believe, if we build
> with -ffunction-sections.

Well, I was actually thinking about a simpler model.

By "link time" I didn't mean "after final link". Yes, there may be
reasons to do it at that point too (to do any whole-program checks),
but that wasn't what I meant.

I meant literally doing it in the $(LD) and $(AR) phases, when you
still have lots of independent object files that you are just about to
link (or archive - do we even do that any more?) into one.

Then you'd parallelize exactly the same way we do now: one object file
at a time, and with no real change of semantics.

IOW, what I was thinking that instead of doing it as part of a final
step after the CC/AS, we'd do it as a preparatory step before the
LD/AR. Same exact operation, same exact target *.o files, just shifted
in time.

             Linus
