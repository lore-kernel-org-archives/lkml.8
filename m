Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DBAC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE69E20720
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PC7MFSA9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbgEKSqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 14:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727051AbgEKSqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 14:46:21 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58625C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 11:46:21 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d22so4965208pgk.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 11:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nscz4Wn57pBdv+UExt3Kccfb3G9SWzhNWKswuT0pTxo=;
        b=PC7MFSA9Clm1ql2lHJvnPaqCuYo0vwUVioU0XS8aSVEPTNHgcUDEbMmPg7C3yYyDaZ
         XWcSY8e0QBMUQXEI/PGSwjOiAyTsS22LQNgNZhu5GTOhtzZSD8BQYyNqWY9od199uJrf
         aFLYX0/g6Usyg0AXdJbnzIUij61esljtU95yMYo8L5xkVDddkHTnwb21VH28IElQOXji
         NT+6CJktLe8KvM+ZtRAlj08VXEY1AjeLDIR2nNkK1Ze7MDfHUqNJPppK7zB+xJCGgYvz
         Pa9jUNxCTKVIQhJJ9caZANX8I3IAVhBsWb4LL9O7x50SPpyO1PnXTr4G+BN0A0KyU36a
         2+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nscz4Wn57pBdv+UExt3Kccfb3G9SWzhNWKswuT0pTxo=;
        b=qab4XkHYMzc+PK1XlCjY3JKhayWCkgDERBxEWKEG8srEMvw8f1Fmtm3I4maeBbf6kg
         64yqYD4UZ+N+xcdZBJVRR/OVAjji89lOBxLjAbIS1cbVJ5NbTGU8Nhadf7K8X4KME1Ha
         8P67ND6maIpIEaej3Nns+pvOxft4zgIYWCD4B4+6hJZDrFMfBZ7LLzVSOcPC4wgZSeFM
         LBCs3p29+G8jAvwcXSXGi242G5wybE0C7pEqJeFhXCRB5aoPve7aqsMG1EKMUwsenOJ9
         kFGcbYmcYG1kwPrFIuvq8rg09wEayFWmBpnkxBDSOXaIDLlFdj7Aw7rDJYeylyax2dzy
         SAXw==
X-Gm-Message-State: AGi0PuaGnfassxnKQsH/v5uavxBmaq0n2YVBF38mEL8kz1E20l9/t9SL
        GO8zYoH99+4s3iU6Z/vRpyhTvG8w0wHo+WLmbmOgsg==
X-Google-Smtp-Source: APiQypJ19Li3TupJSjOfbTLakXv2IUNQ/VafiApmxJsvFFNNWgK/ozXlHqF8kl8Q/xk9RdoSwgJ1Ut0VgAZReOzBtOA=
X-Received: by 2002:a65:5b84:: with SMTP id i4mr16509069pgr.263.1589222780548;
 Mon, 11 May 2020 11:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200504230309.237398-1-ndesaulniers@google.com>
 <CAKwvOdmspKUknbzDn9kY2jMgkFw=Ktvst0ZtwambDOfybqJGWw@mail.gmail.com> <CAMzpN2iDottAY3p=GS0A_7XX7bpmWsmSOEcztMXNEEvcwHirjg@mail.gmail.com>
In-Reply-To: <CAMzpN2iDottAY3p=GS0A_7XX7bpmWsmSOEcztMXNEEvcwHirjg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 11 May 2020 11:46:09 -0700
Message-ID: <CAKwvOdnxV_KwC-q73e3basJvo4-9FCGeMUOrZLj5xyt6Yyeh2A@mail.gmail.com>
Subject: Re: [PATCH] x86: support i386 with Clang
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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

On Mon, May 11, 2020 at 11:09 AM Brian Gerst <brgerst@gmail.com> wrote:
> This looks like the same issue that we just discussed for bitops.h.
> Add the "b" operand size modifier to force it to use the 8-bit
> register names (and probably also needs the "w" modifier in the 16-bit
> case).

While it does feel familiar, it is slightly different.
https://godbolt.org/z/Rme4Zg
That case was both compilers validating the inline asm, yet generating
assembly that the assembler would choke on.  This case is validation
in the front end failing.

Side note: would you mind sending a review by tag for v5 of that patch
if you think it's good to go?  It does fix a regression I'd prefer
didn't ship in 5.7.
-- 
Thanks,
~Nick Desaulniers
