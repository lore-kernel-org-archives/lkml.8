Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFCEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 14:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD88B2078C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 14:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uoMTFB4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbgEZOrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 10:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgEZOrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 10:47:52 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466E7C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 07:47:52 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b6so20742719qkh.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 07:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DF52Yl3w2y2rZvHSbpSmCXcEBNFth4QYKFFksKvfyHA=;
        b=uoMTFB4Jq9fuHWg38dVBHhBsx0erHTJlOdrJT8Y+Zur+CTH9QlKZ/LDlXJa9U5YAEX
         WpQk/NcZ1KkxyJ4+QrkQqCcnBpIzuWWxHCzXNL+6oCsQp5HFkWDISaMRp8AATPLqyWH3
         roGY5zkVxoDaZkW3kVKC1rQIRAo1Y1671HGukCqXkTZNh1awtqAGZ9PaNzVISYlamSwX
         0kUfbcnhc2I8CF5IvNOogiub9I3OHbQp+a0LISEY23XdAeY4fKUlxsVB39Im19kUs+sX
         TVjNYfwIjSKjBbw0suCxhvMT/WoBKDstub4MKtrg5bDXS9Xtircs1G15QyjnIyoPMZ9a
         p4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=DF52Yl3w2y2rZvHSbpSmCXcEBNFth4QYKFFksKvfyHA=;
        b=IoKJ5KWgtbo0ecJJ64YecjfxX1I9YlaW5qoYJ6QSh/QshijeV3PrVUtideAOK5E0A9
         pZnf8/Is6saCVS5lEoudA/ZjY52UgyoUxA1LAsauRLmCuA2n8ILihBrBdanvLOElGXbQ
         hdvIW1KZiiciD9sVIELSv7bgydTHqSKrBCgi2/9iPggkkM7DsYr/S3OgE5P4yeck6uBt
         JhPRFnQbwe71Xs4MdAyzFWoG8mgNkhRQOApQ58pc0PY9y5uEPBJ0K6e+HoZ05FUFjxSK
         FTclgQs8yDq1kfFypgzDZGU2fs+ZBGOpq+K2jrvugHTL7qdNZWd3c5EKJ2h8VwgwoImg
         HXiQ==
X-Gm-Message-State: AOAM530bjglT0CrXKkAgFBahKl/e+/dQh+kPSI+/4qLj6iqRw4JcOIDY
        qYnRd6XMVcQachaGSviwl6M=
X-Google-Smtp-Source: ABdhPJxgaF6EiLvLMP9AVUuWiD8h4H9f1puyBPFieaz59Jb5Beh0O26mDaWvCpahZ9QLmdtMqy2zeg==
X-Received: by 2002:a37:7904:: with SMTP id u4mr1723991qkc.297.1590504471446;
        Tue, 26 May 2020 07:47:51 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id b189sm7453670qkg.110.2020.05.26.07.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 07:47:50 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 26 May 2020 10:47:48 -0400
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] x86/boot: Remove runtime relocations from
 compressed kernel
Message-ID: <20200526144748.GA2190602@rani.riverdale.lan>
References: <20200524212816.243139-1-nivedita@alum.mit.edu>
 <20200525225918.1624470-1-nivedita@alum.mit.edu>
 <CA+icZUVa8FhhwHgXn1o_hFmgqFG6-KE1F+qvkdCzQjmSSSDWDw@mail.gmail.com>
 <CAMj1kXHVFgRsbssJQD2C0GZnOgG=rMYbPGJQtiKhSw6sZj5PaA@mail.gmail.com>
 <CA+icZUWyFDgieQswvfhWemzymDh_UiVqH2uH52a+0otcr2Pd4w@mail.gmail.com>
 <CA+icZUVKRZPFX_Q8RRJnFsHrkM5VbiWUEam+6O5XSzgNaqAzPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+icZUVKRZPFX_Q8RRJnFsHrkM5VbiWUEam+6O5XSzgNaqAzPg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 02:44:29PM +0200, Sedat Dilek wrote:
> 
> Are those diffs correct when using "x86/boot: Correct relocation
> destination on old linkers"?
> 

It looks ok, but that patch (and even marking the other symbols .hidden)
should be unnecessary after this series.
