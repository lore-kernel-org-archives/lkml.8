Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EFEC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF1D620736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589222226;
	bh=KovIunH0QbOW8jeIoCbPdo34qGqD6dQaWkP0car8BDA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SKvmCWumdbIdtVvTUnXF3tLMeJTVLCSDT7w+TT6CQgfhkBnrLGWz2osGmxG/MGn3f
	 avAQDYrO8pr8pnssixxSVWQht9uoQC7bpj7GcRSEto9iqlGQh89e144abdKdf1VuRG
	 ePxcFoh096tdEqSYY5+ODgS/lVEuVmbQGicgFkMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731143AbgEKShG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 14:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729727AbgEKShF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 14:37:05 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E86AC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 11:37:05 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id v5so4296325lfp.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 11:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TcSOOR6oXnrgDwVzHY9DAIp9Hsd3wV34tn9evP5v+z4=;
        b=FzSncrNXy1YB/2+RGJSqjihsohcVlNOpC4kZBoEm+OGeIfM+XGAsJTT+B1qRU92SrI
         aTg7H/OwWHFPVMJMOI2Cayc6Gp2iyiE6NTVs/lVQT2UAXvg5ffV9770Bfy3E4tb5RABB
         Nw46F7RJ7QVkgpuB6/9awhwl4q7axpOX+QCl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TcSOOR6oXnrgDwVzHY9DAIp9Hsd3wV34tn9evP5v+z4=;
        b=FCBmmG9B0rPorbQc7xO095Yc6AEhB1c1LUUJAC20z1G/cJP8TCwJmp+tD1qWWb+kFW
         3ef2SlYSoczB41ybFJZUXOZb51CEMtLCeYFJX6sSQHOJx9ukg/lGglDmzxhQ+2rb0jl7
         o0Rd4CIS4rBmoMZtXGOBijRrO9fNKu6qNjqtW3RNfXRMzvnZ9DyFLYgWwbHPRiUE7nTA
         t9ougI6iDO4kwiRFtoFXWDJxRHqhBlX1ESd0Bchv+y0PFvpXVAFkngT97jCP/pZ79Ves
         ggHnCENI0EG0EEV+a6I2AxiZaKncTo+nJJB3pvr4T14pdAN2Mmo3IzyewHj/pwrEmFuU
         8b4A==
X-Gm-Message-State: AOAM533PdHXkSkbtRIsqHPwS8JaeAuQLHWrPVb/rqipHTEd1ktPtIY8/
        HGL7bydVtRTnS5GHuMhbF8HHrjdJ7ow=
X-Google-Smtp-Source: ABdhPJw+ZdCj9fnZs8RDnXW4bPIFt4zvI0KsW7A0vOxWpCTGD2bGrqrhEWUvec+S8CuXH800CaSTRw==
X-Received: by 2002:ac2:5215:: with SMTP id a21mr11650442lfl.13.1589222222903;
        Mon, 11 May 2020 11:37:02 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id x21sm10407413ljm.74.2020.05.11.11.37.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 11:37:00 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id e25so10679754ljg.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 11:37:00 -0700 (PDT)
X-Received: by 2002:a2e:814e:: with SMTP id t14mr11004422ljg.204.1589222219867;
 Mon, 11 May 2020 11:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200504230309.237398-1-ndesaulniers@google.com>
 <CAKwvOdmspKUknbzDn9kY2jMgkFw=Ktvst0ZtwambDOfybqJGWw@mail.gmail.com>
 <CAHk-=wif=_ZomkWJAmQRCUAMHQ72V3NEQ-OteiPE56K7KoSjbQ@mail.gmail.com> <CAHk-=whhCBvjXtRiFM2JEZ4XyBmuPprvdo5tpPVBqUhkRszxiQ@mail.gmail.com>
In-Reply-To: <CAHk-=whhCBvjXtRiFM2JEZ4XyBmuPprvdo5tpPVBqUhkRszxiQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 May 2020 11:36:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=whkz12DeKOt3iw19Ey=c5HkXH+4disNJ3DwZuSDr-Tt5w@mail.gmail.com>
Message-ID: <CAHk-=whkz12DeKOt3iw19Ey=c5HkXH+4disNJ3DwZuSDr-Tt5w@mail.gmail.com>
Subject: Re: [PATCH] x86: support i386 with Clang
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Golovin <dima@golovin.in>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 11:24 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I guess I should just test it, since I have that clang tree.

No, clang doesn't seem to handle it even with __builtin_choose_expr(),
and has that

     invalid input size for constraint 'qi'

even when it's in a side that is never chosen.

Very annoying. A lot of our magic macros are literally about "pick one
case when the others are not valid for this type".

             Linus
