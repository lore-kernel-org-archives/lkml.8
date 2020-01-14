Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2073C33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 04:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74896217BA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 04:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgYe4mmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgANER2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 23:17:28 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34701 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbgANER2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 23:17:28 -0500
Received: by mail-qk1-f195.google.com with SMTP id j9so10989391qkk.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 20:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OOWT581SMcLvqtksjZAqGDB1CoHKgQ7UwVVk0O0Vz5w=;
        b=dgYe4mmonSdSZinqVmpggI4Kmkyh06SQWboomRcm3rxx/iLbThhInClzdMGY3D0dK1
         QEi/sbj06YUsLTS2l3KVU1ypM1JFqIwOvtqmIDN12VFZIxvP+BjrbW3aunLthUqKYZQX
         Kt3I3V9F+q0F4l9+81lzhsHXWlnAtzSopb10X0L4h/hoj6h7R0Qtytp/seoDR05kG8X7
         L2tztvbl/gyTqxYaQBNk/9+xfyBTEkGmWu43LajPzoOJLCHdi+JT/XeTESRZW2GtOSQp
         8Nr9bkAs5hs51FS1FncfnN8+uIxEAapp0vwmf3Aw+sJgEdA5jxm3p4vz82DzFi1Whxzt
         rgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OOWT581SMcLvqtksjZAqGDB1CoHKgQ7UwVVk0O0Vz5w=;
        b=iKfLJmyTLj05ShyiHyhQBX69Bwbfak3wnBBZ2oeQ8oQU8lFhdxj16y/AA3NgH2YyRc
         Cp+KvKsJH7jKiLRqLnzgawNVy3DzOrww8zzRqTL6Jad8puDWfoHQWe/UCiuMS7TSo8Tv
         bGVlK0BqbvM3H3ZizRJptXSBTdxAMjCz3qdphm2efVAUzaO4vIT/lFlX0QCgRsiUiTk1
         ohCeUI/8o6qDfmgw78f1U0qZ2GlZb4gs5c58dIwCQ5yWPmaAVfixF+TOAIDBuqA4Po5r
         6tqEAJHJJ1VAXMFi2CZVzgi0vdszB+92CmM0o/gzrZRZtB63V4VL4pzeH6USCF8ZSB93
         YICg==
X-Gm-Message-State: APjAAAXma80JXi8ITqCzUU53eHQT7lGOsDU37UyuSchUKtB7TqNyKE/w
        l26EUf19VDKZ4OGtvMGLURY=
X-Google-Smtp-Source: APXvYqyYlP3UFYzWoF+ESFqpLMu38Q+xYtt7QDsQx5WlOpIjxUeAo7sfKtiWWaYSjUK4mVzYVRfRkQ==
X-Received: by 2002:a37:644:: with SMTP id 65mr19916895qkg.309.1578975447132;
        Mon, 13 Jan 2020 20:17:27 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o7sm6026451qkd.119.2020.01.13.20.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 20:17:27 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 13 Jan 2020 23:17:25 -0500
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH] x86/tools/relocs: Add _etext and __end_of_kernel_reserve
 to S_REL
Message-ID: <20200114041725.GC2536335@rani.riverdale.lan>
References: <20200110202349.1881840-1-nivedita@alum.mit.edu>
 <20200110203828.GK19453@zn.tnic>
 <20200110205028.GA2012059@rani.riverdale.lan>
 <20200111130243.GA23583@zn.tnic>
 <20200111172047.GA2688392@rani.riverdale.lan>
 <20200113134306.GF13310@zn.tnic>
 <20200113161310.GA191743@rani.riverdale.lan>
 <20200113163855.GK13310@zn.tnic>
 <20200113175937.GA428553@rani.riverdale.lan>
 <20200113180826.GN13310@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200113180826.GN13310@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 07:08:26PM +0100, Borislav Petkov wrote:
> On Mon, Jan 13, 2020 at 12:59:38PM -0500, Arvind Sankar wrote:
> > How is "breaks with binutils before version 2.23" not clear enough? It
> 
> Nevermind, I'll write it myself if/when I end up applying some version
> of it. I've wasted enough time trying to get my point across.
> 

You're wasting time, because you're not _listening_ to the other guy.
There is nothing special about how to repro this bug. It can be repro'd
by building binutils-2.21.1 from source, it can be repro'd by building
with a distro that packaged 2.21 -- such as OpenSUSE 12.1 [1], it can be
repro'd by Mauro doing an Android build [2].

The common thread in all that, is that the kernel is being built with a
binutils prior to version 2.23, which is what is noted in the commit log
as it stands.

[1] https://lore.kernel.org/lkml/20200113233829.GB2000869@rani.riverdale.lan/
[2] https://lore.kernel.org/lkml/CAEQFVGbWKf2ksMrMmtymewArSF=ztNgeuieEQ3wvKrX1r759Aw@mail.gmail.com/
