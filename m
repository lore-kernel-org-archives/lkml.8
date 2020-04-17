Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B79C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3230F20715
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cI0+m7FY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbgDQTxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730590AbgDQTxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:53:35 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CC1C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 12:53:35 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id q8so762466pgq.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 12:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LsrPPfYxwItsmip54/tCqhEs0XC/U9zLPh4nWIbHOOU=;
        b=cI0+m7FYdP7wOyBGGE2O+tjvQpcrM1isTtp7DTmJOMQNIjDLN3pWSqJGZvMY5kUPCF
         4U8up179+ywtoPROaUW3U6un7dkXJF4PP8kbI7Pad3xfZtozpkDO4EhWdReH2INb1g1r
         W06xifEx+SAY2kfrV8qYKn0tgQBzg2AhcO1+iqtzf+xgdqtdoNJ9X0m8xFnR6pWQ+G9b
         XNimhsJay/34n0BTs6PR7AuamlIPxNo/LCstFyifq6zJ+h/ygoRNzFc4w+8N0X61jcwf
         hCQd2iWAP0BaToXCqdsB6Q7gxquUpDTRxGYicYI2g9+D9rRD31WztYZ63f74mKnqmASb
         bBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LsrPPfYxwItsmip54/tCqhEs0XC/U9zLPh4nWIbHOOU=;
        b=okSvgWQG/evZzOrGQUwtxk6vvBdW3Y6haIn5R+GC/dBQU6xOxDP7PFHEVqzEi9pQul
         xx7Y6dmDiIgHWcaBjvGfFkX0L83yvTIjGfX/A07kp1vsm9fzWzFc7lFweShstsLrM7LC
         rFbW5/43Ku8T3iDldMAjDG/1U8fO1EUmKzOS+kx60Xt/pG+diKoPalOi/OcUdZiQJpmI
         bqKfnQkRUE8u/pUOJrZx+Ee5qtb+/5tbxWqig+0mNXVMBq3PLANmR2jcXY20aEB9jClP
         ZZUlRkLMg8XrcMm7pStnNlHGH1kdwjQjyFdYqltJ5VwtJnsWvGyms7lNCvdCRsArBVtJ
         F7pA==
X-Gm-Message-State: AGi0Pua+ZKNoArSRTr2hn+A0bcRpsvUrB151LyZnXrhRHJ0GhL2yUyiZ
        YCtEyvwa8ghS1p4//uEuL6mZ1G9/Zeq78/QxvPjfYA==
X-Google-Smtp-Source: APiQypJ5gBGmFAiT4EcjPfO/OjbBuWXhKZR1YcczYp689seOkVzDpb+sjiOFpGoL6aINKZVgR2gDYYFxr7U4rWEVLoA=
X-Received: by 2002:a63:6604:: with SMTP id a4mr4415486pgc.381.1587153214766;
 Fri, 17 Apr 2020 12:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200415074842.GA31016@zn.tnic> <alpine.LSU.2.21.2004151445520.11688@wotan.suse.de>
 <20200415231930.19755bc7@sf> <20200417075739.GA7322@zn.tnic>
 <20200417080726.GS2424@tucnak> <20200417084224.GB7322@zn.tnic>
 <20200417085859.GU2424@tucnak> <20200417090909.GC7322@zn.tnic>
 <CAKwvOdnFXPBJsAUD++HtYS5JiR2KmX73M5GAUe-tvX-JYV7DaA@mail.gmail.com>
 <CAKwvOdmNwNwa6rMC27-QZq8VDrYdTQeQqss-bAwF1EMmnAHxdw@mail.gmail.com>
 <20200417190607.GY2424@tucnak> <CAKwvOdkkbWgWmNthq5KijCdtatM9PEAaCknaq8US9w4qaDuwug@mail.gmail.com>
In-Reply-To: <CAKwvOdkkbWgWmNthq5KijCdtatM9PEAaCknaq8US9w4qaDuwug@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 17 Apr 2020 12:53:22 -0700
Message-ID: <CAKwvOdnpZuNG66gR0kqeG3v2x3rQSV+bZU8NK+vRcQ9FS9pNbw@mail.gmail.com>
Subject: Re: [PATCH v2] x86: fix early boot crash on gcc-10
To:     Jakub Jelinek <jakub@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        Michael Matz <matz@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 12:49 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Ah seems we do have __attribute__((no_selector))

Sigh, can't type today.  __attribute__((no_stack_protector)).  I'll
send a patch along for that.

> (https://reviews.llvm.org/D46300,
> https://releases.llvm.org/7.0.0/tools/clang/docs/AttributeReference.html#no-stack-protector-clang-no-stack-protector-clang-no-stack-protector)
> which differs from GCC attribute name.
-- 
Thanks,
~Nick Desaulniers
