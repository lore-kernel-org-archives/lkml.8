Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7FEC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 399F12242E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWDJszts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgGNOP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgGNOPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:15:54 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD11C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 07:15:54 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id a32so12881347qtb.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 07:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P372NUKZoZ0/nvzVGUuc2s28GruKsUnveXwN5n0Gdac=;
        b=fWDJsztsy4vHZnJcfhEoivjuDuvY9H6HC+F2NhBdj1E4joBeLZ17Rt2HLiHKkMFDXM
         BEDbI36VlLMjke+//jmvYPPhNaqi8L7grwEbXPWyvIbZi67K67WAP7/wN+BDoLR6p4tG
         a5/VDto9JJkkBPm8pXSB98z6lnDQtm7IcPJ9RVBxX7kS4EpJTJm7OcqyxLdSXygdfRle
         HWvnRjI33sVvNOLATWzYQIjCoOuXmjkeifyMq008/6crfbDFxzZM9FxRAnb05k909OG4
         AfYJH1kIQaTW+Dw7IQlaudr5Ug6C28xe/jvARrfLBSz3Iyd3XFa66+jxqH776YyDgMuw
         XS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=P372NUKZoZ0/nvzVGUuc2s28GruKsUnveXwN5n0Gdac=;
        b=pBDom9CzUR8YxsYkNlo3tZvB7cDbOaLV7pc9W5bh/V/31G0K8J4mFyP0Aq6ht3cLOr
         eYvwjiNYGX6Nvhd1FVZbZh4F/+j+XEqckzGyrVM1HGwNgBNwVwP5vzhsQ9W7YuEiV4EJ
         8b5Zdi9YVsLYgmjPyI7drfI7z02P9/LIqkWQ3IdRYJ9RxglBldIZsBw3bet0e//Z9DBh
         Y7G4jB3hq6uQcurZACNby2pPdPMKhbk2vO86lBXYAuFvrZUuy10FXC2VmppPWxeda4WH
         dQq3DomlyRg70QqVrrBZaOBJrAyLDN9Hv65Zy9b1NHzoLGGjSqxb6ptSvz6p9hVPoqjF
         Jxsg==
X-Gm-Message-State: AOAM5306lML0SDIQC8+qMaJv/qENfWWnk9y/9wF4ppHM6qHFX7tq4kIN
        slBA5Wv+e0PxClFxTkHghGU=
X-Google-Smtp-Source: ABdhPJz2n202z1wIcS/YMaunLV4uw0Y5CM/DIPtulElHJdQPSUW6gzU+fr1d3mKFvywCsjIuQUqdPA==
X-Received: by 2002:ac8:544d:: with SMTP id d13mr4915886qtq.375.1594736152547;
        Tue, 14 Jul 2020 07:15:52 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 19sm22696233qke.44.2020.07.14.07.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 07:15:51 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 14 Jul 2020 10:15:50 -0400
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] x86/boot: Remove runtime relocations from
 compressed kernel
Message-ID: <20200714141550.GA329060@rani.riverdale.lan>
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200714023836.2310569-1-nivedita@alum.mit.edu>
 <CA+icZUXSPfybFtzQB3wKn9spQmEPnQu_iGPWkRisAmRQbJLWXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+icZUXSPfybFtzQB3wKn9spQmEPnQu_iGPWkRisAmRQbJLWXA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 03:15:49PM +0200, Sedat Dilek wrote:
> 
> How to test this series without building a full new kernel?
> 
> make $make_opts vmlinux
> 
> - Sedat -
> 

Not sure I understood the question: you do have to build a full new
kernel with this patch series to test it. Since the changes are to the
compressed kernel, you would need to make bzImage, which is the end
product of the full kernel build.

Thanks.
