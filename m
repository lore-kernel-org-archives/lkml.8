Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A33CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 072A1207BC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXJTaoxh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgHYPTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbgHYPTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 11:19:14 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618D5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 08:19:14 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id k20so5643819qtq.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 08:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=brmows/DN8FB52grSh/oKVF6r30vBH02XnLaZne+j6g=;
        b=KXJTaoxhiqydETO8U5CeanAxKKm7Mei1X7IRqJmq3HIDSPh21lhkFhNVY1kJPZBxN7
         66QT0QlHVj04ubc6k0t5ymew7vwGqhWs7i1WvChHnllaka0obVnhLGzcfnbKYKbdxC2Y
         wicQCkKFdpcJZiHbidS/yyHZsk5Y+OZ3aqi6Fm8uKdJMnONtst1DLYF31Zz96QGXr97X
         kairB7r2gx7dh1IYqN/v4mYoWkTSuejp/63vAHtcJ03JnOMArtvcck8Jh98dUwlm1CnZ
         nZxWzvE7SYIsYWSRyipLwq2NegNY6KKjHNcoyWXYW2VYzKdC6J8R4pwpwKQw8HcfP+Th
         yE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=brmows/DN8FB52grSh/oKVF6r30vBH02XnLaZne+j6g=;
        b=e87K2cVF5ITcZVTCSFIUCc41EQFjhkbalml6t8OBJJGnMIdDmBrnIoHQOmvr8mHdDz
         LKtk9eJBaXKcSys19XIsOgoM1Xf4gAYZ/I64fnuYSd/oXWngDS6d7jZF8SsxefJCiZWq
         yttxL7V1Wl98c5vRMKdfrJ4bro7nVOFvPvE3qFrUgdl8Al9YDfk8usVN31gSY0X5kILH
         kIM8ppIgsxotw3e0EmSVGpl9zGatl6Qz6ya9d7CbBPDw7KMYGUg9yK1LfRUZlZtvp5DW
         QPfzSq7ddEkO1M+/q6WcoURpesS0knfZZpfVXmocIlAhqEJnjgFslsnW/5qMW9vXBhYD
         wnGg==
X-Gm-Message-State: AOAM530LYMmkd4TDP2onOoLtiXzKQwWAxcIvJ3TWWTF3OoMpmWxh7AK4
        B+pIo+JbVPqJPrzKFML5UZcnYAFT+wRoQg==
X-Google-Smtp-Source: ABdhPJwzXkGvFcpHJDTZPxyxGsSgLZJgI14zJolzg9xxdW5i+CsXjL7zhEU3xYVLundRpXPAQPLYFg==
X-Received: by 2002:ac8:614b:: with SMTP id d11mr9820027qtm.271.1598368753547;
        Tue, 25 Aug 2020 08:19:13 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x57sm13726902qtc.61.2020.08.25.08.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 08:19:12 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 25 Aug 2020 11:19:10 -0400
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] x86/asm: Replace __force_order with memory clobber
Message-ID: <20200825151910.GA786059@rani.riverdale.lan>
References: <20200823011652.GA1910689@rani.riverdale.lan>
 <20200823212550.3377591-1-nivedita@alum.mit.edu>
 <CANiq72kWaS=8rDQ81cCY3021=1J5yFfJk8FHBQEjhtssRFoVcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiq72kWaS=8rDQ81cCY3021=1J5yFfJk8FHBQEjhtssRFoVcQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 09:13:34PM +0200, Miguel Ojeda wrote:
> Hi Arvind,
> 
> On Sun, Aug 23, 2020 at 11:25 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > - Using a dummy input operand with an arbitrary constant address for the
> >   read functions, instead of a global variable. This will prevent reads
> >   from being reordered across writes, while allowing memory loads to be
> >   cached/reordered across CRn reads, which should be safe.
> 
> Assuming no surprises from compilers, this looks better than dealing
> with different code for each compiler.
> 
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82602
> 
> A lore link to the other discussion would be nice here for context.
> 

Ok.

> > + * The compiler should not reorder volatile asm, however older versions of GCC
> > + * had a bug (which was fixed in 8.1, 7.3 and 6.5) where they could sometimes
> 
> I'd mention the state of GCC 5 here.
> 

Ok.

> > + * reorder volatile asm. The write functions are not a problem since they have
> > + * memory clobbers preventing reordering. To prevent reads from being reordered
> > + * with respect to writes, use a dummy memory operand.
> >   */
> > -extern unsigned long __force_order;
> > +
> 
> Spurious newline?
> 

This was intentional, but I can remove it if people don't like the extra
whitespace.

I'll wait a few days for additional review comments before sending v2.

Thanks.
