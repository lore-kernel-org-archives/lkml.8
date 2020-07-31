Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6AFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D90B820829
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPAK5/n5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732154AbgGaJgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgGaJgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:36:46 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C29C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 02:36:46 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id j8so18711375ioe.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 02:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Ctv9OxMxq6ftNiYmBAiJ3RsrGDjO8BVv2UOeR56SSI=;
        b=ZPAK5/n5sNePzDkzOOb1uwKDsGgIghcMbjqgn6gZ8Tt9tuu28u7/sGdePPDIQt9dWY
         8cfsEC4wFu3h3P7xL4AXIShUZ6aHJruyWRWeRYN957ZoMRG3FCzWoSnhO2g/8l7UDOOz
         k6TbHfVW2XMOJn1PRzaA2JnjqGHmKI+yZXCJB11XWwVn+9ZnU6iVhuGG+Hn9hbJ9J0HH
         PjPAUxVWScd4497dOKDDJmkZOFH8eAi8U5U3z4CJ5Gc1d8Pob7z9EKgiem58itUXtOaR
         kxZBZK8qPcUYQ9+uRLqK+7F6KgwyVFb4xs6sXsunViIPo/MY53tpU9UPI7PFxZACN0wN
         B89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Ctv9OxMxq6ftNiYmBAiJ3RsrGDjO8BVv2UOeR56SSI=;
        b=uPTss+q8Gj47EfTXxb1J+AUutFIrbmks2avlbtCoIP5NPRaIwlxHCozg2WPoI5Q5ky
         hFr4iMLSb381lKHgz6xBamKdju2dneKl0JKT8BtLG6oEPwWH64zMSqMtdRXDL9k5J/jm
         3UbOac8d0Uab4tpb3YDQadE3TH1FL2pl+IxvHXKa74wJZGY+XFSoqhWNvgYqr+2MESK2
         oLsEI3Ef3hDmFDQsGv4epWeW5BWSoPhJqxp8NAqA8i27p++bJQsbe+ZaZPDKnT1zbSWV
         ad7hNjQXjk0DY/LdMcQdyAQv1onj4X9oMhRR/kGHxN1OeqxSHRvjvWnmwvv390djGbR4
         yBGw==
X-Gm-Message-State: AOAM532UdpGchuLXJYoA9CJ0nTNP1pWl3QSrkGaJHyDSZkKJ7/zm6cSt
        kE2zhQVB8yv3+r0b5PUC5bYp/B1ksohF8mJiaQ==
X-Google-Smtp-Source: ABdhPJxt7Tqwx10lzKkpsVBd8Jqs36TFDKDhD0cvsydxFvLcc9hhzFh8S7no5QthfNccs/9eZ3IjTsaC/otyudAcaqU=
X-Received: by 2002:a6b:b215:: with SMTP id b21mr2687836iof.43.1596188205758;
 Fri, 31 Jul 2020 02:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <1596097609-14118-1-git-send-email-kernelfans@gmail.com> <CAKwvOdnThb=Sv2v1K3w0DAJBZFiEp2Z0Y=NbQ9kEuK1nsQqJBw@mail.gmail.com>
In-Reply-To: <CAKwvOdnThb=Sv2v1K3w0DAJBZFiEp2Z0Y=NbQ9kEuK1nsQqJBw@mail.gmail.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 31 Jul 2020 17:36:34 +0800
Message-ID: <CAFgQCTsYTwpv6oCGLH5JTjt+1jPAZ7XjBm6sDoCPRnjrRPhvTQ@mail.gmail.com>
Subject: Re: [PATCH] x86/purgatory: strip debug info
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Steve Wahl <steve.wahl@hpe.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 7:11 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Jul 30, 2020 at 1:27 AM Pingfan Liu <kernelfans@gmail.com> wrote:
> >
> > It is useless to keep debug info in purgatory. And discarding them saves
> > about 200K space.
> >
> > Original:
> >   259080  kexec-purgatory.o
> > Stripped:
> >    29152  kexec-purgatory.o
> >
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Arvind Sankar <nivedita@alum.mit.edu>
> > Cc: Steve Wahl <steve.wahl@hpe.com>
> > Cc: linux-kernel@vger.kernel.org
> > To: x86@kernel.org
>
> I don't see any code in
> arch/x86/purgatory/
> arch/x86/include/asm/purgatory.h
> include/linux/purgatory.h
> include/uapi/linux/kexec.h
> kernel/kexec*
> include/linux/kexec.h
> include/linux/crash_dump.h
> kernel/crash_dump.c
> arch/x86/kernel/crash*
> https://github.com/horms/kexec-tools/tree/master/kexec/arch/x86_64
> that mentions any kind of debug info section.  I'm not sure what you'd
> do with the debug info anyway for this binary.  So I suspect this
> information should ok to discard.
>
> This works, but it might be faster to build to not generate the
> compile info in the first place via compile flag `-g0`, which could be
> added `ifdef CONFIG_DEBUG_INFO` or even just unconditionally.  That
> way we're not doing additional work to generate debug info, then
> additional work to throw it away.
What about:
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 088bd76..7e1ad9e 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -32,7 +32,7 @@ KCOV_INSTRUMENT := n
 # make up the standalone purgatory.ro

 PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
-PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss
+PURGATORY_CFLAGS := -mcmodel=large -ffreestanding
-fno-zero-initialized-in-bss -g0
 PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
 PURGATORY_CFLAGS += $(call cc-option,-fno-stack-protector)

Thanks,
Pingfan
