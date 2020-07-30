Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A22C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 02:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71E7622B40
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 02:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EOzMxx4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgG3Cik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 22:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgG3Cik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 22:38:40 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA916C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 19:38:39 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b186so3896734pfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 19:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tcmPGs7MKumNVJXJtJmYK47UvkeMX0T9PRyhLwXMI88=;
        b=EOzMxx4mk1fL6jFk1/nn5K/RtZI0yinkK78ylqvwfC7Ypi8Le/WWw3YxDq2c7npuv/
         QfPlw7OrkFSA6OYqrDG8t5vrxqIVSW6rknofmrVemTKmoK6Oy8kaPxLAwQ34V31qpY5S
         AemXndca2ZTPHAcswYlTW2mCUDxkeDyxOs5FY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tcmPGs7MKumNVJXJtJmYK47UvkeMX0T9PRyhLwXMI88=;
        b=krg1aYaHH+hUwk7pQ0B+2bJ+Q0XSVdn9VdfhQfUyJlpqYDbBpQRTcNDCYCsXfQO8v8
         JNOr1RFGfAnh8GolShIT2yiYvOclwiaXGhV5fRcoaMsdiCvuKoNzR7+xKu7VEh+IXZfG
         Vsjn56AXz+YhSBxmgPGIbF0NH/hqu494pGFM2XNqdepPy2XZu4v7thCgxROQp+3K97Nm
         eGVZIyRkYRNpemFZChfV5Oo1/hEOmXfFjNpTyLONX61T+Yvj9Hp5g431hBdsDkC0AsKs
         VU5swhH7ZQIui8qO7JtXiVjq9xFudqROfsJbynKbqBPDwcZ4xNCg3NN0AGIBeCsQWPd5
         MSbg==
X-Gm-Message-State: AOAM533bvJhxTdBs6eRfReINgEjuUkkiP+c9/yeq+OjvhMpBTo9qUILa
        oGcxdjzYXJ0hgpghLz/3v3LFGw==
X-Google-Smtp-Source: ABdhPJytumzeyOwK2ZCiIGiEj8lLEigjjPaLQcc8sIy6eRu2zl14fh+bsI9WjvxqplRX5h/DiYL35A==
X-Received: by 2002:a63:165c:: with SMTP id 28mr2409576pgw.453.1596076719167;
        Wed, 29 Jul 2020 19:38:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r7sm2164264pfl.186.2020.07.29.19.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 19:38:38 -0700 (PDT)
Date:   Wed, 29 Jul 2020 19:38:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH-next v5 0/7] x86/boot: Remove run-time relocations from
 compressed kernel
Message-ID: <202007291937.061A4FE76@keescook>
References: <CAKwvOdnTbatx8VB-rJSzyFPwfYnkMYK28yLBn1G+hUu8dyfYRA@mail.gmail.com>
 <20200717201801.3661843-1-nivedita@alum.mit.edu>
 <202007291502.18DC4C0F@keescook>
 <20200729222341.GA684483@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729222341.GA684483@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 06:23:41PM -0400, Arvind Sankar wrote:
> On Wed, Jul 29, 2020 at 03:04:43PM -0700, Kees Cook wrote:
> > On Fri, Jul 17, 2020 at 04:17:54PM -0400, Arvind Sankar wrote:
> > > Same as v5 previously posted, but rebased onto next-20200717.
> > > 
> > > v5: https://lore.kernel.org/lkml/20200715004133.1430068-1-nivedita@alum.mit.edu/
> > 
> > BTW, some bits of feedback on process:
> > 
> > - please don't re-use version numbers, this is confusing :)
> 
> This was a special case as there were no actual changes in this version.

It ended up missing some review tags, etc.

> > - please fix whatever is happening with the "In-Reply-To:" headers, the
> >   threading is extremely hard to understand (each patch isn't a reply to
> >   the cover letter, and everything is a reply to a single earlier email)
> 
> I think this is because I'm passing --in-reply-to to format-patch.
> Seems like I should specify that in send-email instead, hopefully that
> will fix the threading.

Ah yes, I think would do it -- it overrides the normal threading that
send-email does. Usually --in-reply-to is for a single email.

Thanks for checking!

-- 
Kees Cook
