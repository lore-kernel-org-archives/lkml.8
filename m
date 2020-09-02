Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82889C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39AF4207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B911asU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgIBSYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIBSYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:24:53 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B423DC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 11:24:52 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id db4so59500qvb.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 11:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=toj5XDYJGTsAAc7YZakLaUE+SItkLOgxz+rwVKGxyVk=;
        b=B911asU341cmhWVtC9To5PWjxe+txwCyyfK7C4/76MicjwEZ38sIeb5CjhWGtLhoEv
         acXSrE81jWFvaq5LdkoioopHHB3dmVKJtxQ4Ej+wNLZ/Wkwqs3tZEApxxDOaaB6Q7GT8
         LkUQNtIhQ64IGiIVeDeT32kH+HmuKYFs7wAX7PhcnDR1YstH+lJcTNAbkih5qLHDjepF
         7/+A+3W2felZG8bFRt8e776C5g7vtdwrW8leCVEXqpC8TQzotcpDnEOmB13hmh6RmINp
         o347+OX/JUSKYKSow/UB2JofrFJjfYKbk7xO1+BOcpohrJpleuPver95BtJ6BxfjxLj8
         +viw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=toj5XDYJGTsAAc7YZakLaUE+SItkLOgxz+rwVKGxyVk=;
        b=rOZjgglAIIOuuzDn3xWwe8y+hGmHzRLGVLd3pbr/2/CztJuSSRuc+ZnE23GwcvRQjR
         tA+5JY2qKRRkAqvjQuGYebElJHrmTPQQxDU3IvAAb1OnEcgEd+ZzYLkqtlU/5gycxEHo
         4Bcu3mG+ILGTq+UT4rqJb2CFraFcnf5jHbWcrVsTZXUagErE2sk8/0PGG0bEKhnwPhwR
         qKl4WDkwp38NNAdfVES+6aB/gv/VabLMTY3x+do16PjBqxctd54cPaiaXxq7JtNyATNN
         zGEjT18gOYoBlj85r8WyBeIXWv0vBpCI3EIUFpgN8gLsEijmjlXbrEtEcC9qSZX77dNM
         Rvfw==
X-Gm-Message-State: AOAM532JceQq3LdAeqyTyUJEUuVNVUB2/oQnMZdoDs7uK5sViY9UOjgM
        ZahHWglvnAP1mX0pXIgIDv4=
X-Google-Smtp-Source: ABdhPJwAX4NvrHQEhGQLeAaLGZfcQmy0/R+2yhxwjj3BVdYPZY9dUj8MkxZnxJvefE0w3wQRLvATuQ==
X-Received: by 2002:a0c:f704:: with SMTP id w4mr7899061qvn.79.1599071091841;
        Wed, 02 Sep 2020 11:24:51 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k6sm163427qti.23.2020.09.02.11.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 11:24:51 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 2 Sep 2020 14:24:49 -0400
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
        Will Deacon <will@kernel.org>, nadav.amit@gmail.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH v2] x86/asm: Replace __force_order with memory clobber
Message-ID: <20200902182449.GA3586123@rani.riverdale.lan>
References: <20200823212550.3377591-1-nivedita@alum.mit.edu>
 <20200902153346.3296117-1-nivedita@alum.mit.edu>
 <CANiq72=jwj0xocJ7iAkntbnHDQphL79XcPREz1qpW0yqrMsz4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiq72=jwj0xocJ7iAkntbnHDQphL79XcPREz1qpW0yqrMsz4g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 08:19:25PM +0200, Miguel Ojeda wrote:
> On Wed, Sep 2, 2020 at 5:33 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > + * The compiler should not reorder volatile asm, however older versions of GCC
> > + * had a bug (which was fixed in 8.1, 7.3 and 6.5) where they could sometimes
> > + * reorder volatile asm. The write functions are not a problem since they have
> > + * memory clobbers preventing reordering. To prevent reads from being reordered
> > + * with respect to writes, use a dummy memory operand.
> 
> I see you added the information to the commit message, but I'd still
> reword this to something like:

Ah sorry, I forgot to change the comment in the source as well.

> 
> "The compiler should not reorder volatile asm, however GCC 4.9.x and
> 5.x have a bug where they could sometimes reorder volatile asm. The
> bug was fixed in 8.1, 7.3 and 6.5. The write functions are not a
> problem since they have memory clobbers preventing reordering. To
> prevent reads from being reordered with respect to writes, use a dummy
> memory operand."
> 
> The important point is that 4.9.x and 5.x *have* the bug and that is
> the reason for having the hack. In the old wording it seems like the
> bug is no more. Then one wonders why the hack is still there (i.e.
> perhaps because we don't trust it, perhaps to support the rest of the
> minor versions which are newer, perhaps to avoid regressions, perhaps
> only the comment was updated, etc.).
> 
> Cheers,
> Miguel
