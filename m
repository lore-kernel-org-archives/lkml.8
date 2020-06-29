Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAAFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5297D206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbHbF76T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbgF2TSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731950AbgF2TRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:17:43 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3E7C030F32
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:52:13 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id v19so13320259qtq.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zVHoQQL1LMsjUx4guRxFxG91mzY8eSh+1dSHVIjtlAw=;
        b=AbHbF76TqmAMD6PPzsJCCJLquGawD17crfO8756wqiYD2QTDJqwM1V4JoCk4fahs9P
         hmwMMQIXhWDBt9WTcm/8eBOhR2JJs+r4Nlb18DFOVbOhjKz4G/A221gd0mLpR2K/W6fN
         Y/8lxIgiV7xoK2zNetBqhe38al2oz7padgN2vH4YN6u97FI56v51Z/uxdOQOaM4ZzqF5
         O5HCXyHcS949k0Oxm5RJNn1KN4iWUsha1uLN55/0mgOHiNZs+tSNa7MLR65Xa8cPCgVw
         HJNlWG4C1+cVOXqUHSDPkhd55CoJC3JLP0frt+de4d9SuyGKB4RLReP7fbTIE888tWuP
         XMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=zVHoQQL1LMsjUx4guRxFxG91mzY8eSh+1dSHVIjtlAw=;
        b=C4lob7syRDRBqszsIdLv25W7b997AA07ski+ewCSI2OHV3y2mhJj84mqERYcCT5b1A
         wOrK1sfAUJOd93o29GzEeL7CqQU8gzB8MkQYwgEuksjbOb5a0FE0oJ88JaaUoopcRdeH
         NbBXwaLkzHZ5mpB5ftCm8/+Oyw4ur95zjBK93ScMTVo6+Xw5291ojrILHLk3Ygjw2Qhh
         XsiPBascE9Fqk3i5EImhvHgqN3G2MrgSOgdtjO1lmPmiTkw1kW/hKMqUelSxfaFj8xs6
         k4Zq/HoixK6cFaoO6YzL+RRP28l6FD6Q5eVzaT+JIv2+UNBQ4gug85nevmgWC/8CDm+V
         /sfg==
X-Gm-Message-State: AOAM531hywLebhYnpnW6NO4mDVC8W1xIX8mWWBr2BFpdI8mWY1pPTizK
        wrEdEKzp/0IiPq3XstJ2xpc=
X-Google-Smtp-Source: ABdhPJwy1vikItqkvahrY4JF8s/d4g/QtX4Rsl8mDkBv4CAPplOG1B4GSDPQ+xdeh/9E/MRX/up7UQ==
X-Received: by 2002:ac8:3496:: with SMTP id w22mr16740693qtb.147.1593449532575;
        Mon, 29 Jun 2020 09:52:12 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id g145sm398035qke.17.2020.06.29.09.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 09:52:12 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 29 Jun 2020 12:52:10 -0400
To:     Kees Cook <keescook@chromium.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] x86/boot: Remove runtime relocations from
 head_{32,64}.S
Message-ID: <20200629165210.GC900899@rani.riverdale.lan>
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200629140928.858507-7-nivedita@alum.mit.edu>
 <202006290905.7531731A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202006290905.7531731A@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 09:06:07AM -0700, Kees Cook wrote:
> On Mon, Jun 29, 2020 at 10:09:27AM -0400, Arvind Sankar wrote:
> > The BFD linker generates runtime relocations for z_input_len and
> > z_output_len, even though they are absolute symbols.
> > 
> > This is fixed for binutils-2.35 [1]. Work around this for earlier
> > versions by defining two variables input_len and output_len in addition
> > to the symbols, and use them via position-independent references.
> > 
> > This eliminates the last two runtime relocations in the head code and
> > allows us to drop the -z noreloc-overflow flag to the linker.
> > 
> > [1] https://sourceware.org/bugzilla/show_bug.cgi?id=25754
> > 
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> > Reviewed-by: Fangrui Song <maskray@google.com>
> > ---
> >  arch/x86/boot/compressed/Makefile  |  8 --------
> >  arch/x86/boot/compressed/head_32.S | 17 ++++++++---------
> >  arch/x86/boot/compressed/head_64.S |  4 ++--
> >  arch/x86/boot/compressed/mkpiggy.c |  6 ++++++
> >  4 files changed, 16 insertions(+), 19 deletions(-)
> 
> I continue to really enjoy the smaller code. Anything that makes
> mkpiggy.c smaller is a win. :)
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> -- 
> Kees Cook

It doesn't actually reduce the size? mkpiggy.c _could_ I think be
replaced with some carefully written shell code, but this doesn't do
anything like that.
