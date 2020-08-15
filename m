Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530FBC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30817206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IpPDEUCj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgHOVx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbgHOVwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:43 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B110AC0A3BE5
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 09:34:17 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d22so6032267pfn.5
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 09:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zJX37WRUVbMU5pJLki7rAUhX9uBKXYYVUdVs+LildKI=;
        b=IpPDEUCjv38MHmQCN4xlwtZPYWyGXgrzrlene0jwicF8nC6bOQLRDf6JsqAZXPcSHM
         Ia3GGX+Ri5jyykiM54fdWTzoYRRHzlFZhHRbnarJjgroY1BTzFbBGDfFhk0imqbjsO8m
         594cDxoJl1B4YBWdYONF4W0lkqmH+sF0aDmCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zJX37WRUVbMU5pJLki7rAUhX9uBKXYYVUdVs+LildKI=;
        b=FMVJuVstnlazQ+0BzMpfd6dj5GmnFW/grjkzfH5bpI/zgkA5aLE1vm+somh4tT0Cc9
         Alg9XRkwliPNDtxgHPGAcEiblcnfmUKLnY8ozpSVN0oGpRtEZuwVWPECzeZoIJLdjaCR
         T1PAwewlRa36+7f04o+hexFNYtVkK3HS3AAhpH9zW5Ugi+EnXkd/WFmzZwS7bsNKGeop
         6tQeKC9u2hfPw3zA8t0+1ztOAiYUJLMGSv4XNzJxWwXSQ442itu3NiTowJF5wmMYOjIm
         no9XtzZDaCBMhgi1JCPC5xpvQcW+07FEQJ/Sn/P4loj7AtR5s8XmDx1qv/J59IE9JFFg
         XXMg==
X-Gm-Message-State: AOAM5314GsoQkrBJVU+pM9h8s9qecKtzHV0TeRGz+qsCSO0wvoxT/T8Y
        iIfky9trMUSAIXwH2qVHvSF14w==
X-Google-Smtp-Source: ABdhPJwxkXH54KOfuvV0sE3T/mUrFUJnBitO40SmY2gNDM+3Db0P2007Ysnhlcqr0odkVg6XM30umg==
X-Received: by 2002:a63:4a4c:: with SMTP id j12mr5198869pgl.115.1597509257153;
        Sat, 15 Aug 2020 09:34:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f27sm12433808pfk.217.2020.08.15.09.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 09:34:16 -0700 (PDT)
Date:   Sat, 15 Aug 2020 09:34:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        =?iso-8859-1?Q?D=E1vid_Bolvansk=FD?= <david.bolvansky@gmail.com>,
        Eli Friedman <efriedma@quicinc.com>, stable@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Joe Perches <joe@perches.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Daniel Axtens <dja@axtens.net>, Ingo Molnar <mingo@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] lib/string.c: implement stpcpy
Message-ID: <202008150921.B70721A359@keescook>
References: <20200815014006.GB99152@rani.riverdale.lan>
 <20200815020946.1538085-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200815020946.1538085-1-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 07:09:44PM -0700, Nick Desaulniers wrote:
> LLVM implemented a recent "libcall optimization" that lowers calls to
> `sprintf(dest, "%s", str)` where the return value is used to
> `stpcpy(dest, str) - dest`. This generally avoids the machinery involved
> in parsing format strings.  Calling `sprintf` with overlapping arguments
> was clarified in ISO C99 and POSIX.1-2001 to be undefined behavior.
> 
> `stpcpy` is just like `strcpy` except it returns the pointer to the new
> tail of `dest`. This allows you to chain multiple calls to `stpcpy` in
> one statement.

O_O What?

No; this is a _terrible_ API: there is no bounds checking, there are no
buffer sizes. Anything using the example sprintf() pattern is _already_
wrong and must be removed from the kernel. (Yes, I realize that the
kernel is *filled* with this bad assumption that "I'll never write more
than PAGE_SIZE bytes to this buffer", but that's both theoretically
wrong ("640k is enough for anybody") and has been known to be wrong in
practice too (e.g. when suddenly your writing routine is reachable by
splice(2) and you may not have a PAGE_SIZE buffer).

But we cannot _add_ another dangerous string API. We're already in a
terrible mess trying to remove strcpy[1], strlcpy[2], and strncpy[3]. This
needs to be addressed up by removing the unbounded sprintf() uses. (And
to do so without introducing bugs related to using snprintf() when
scnprintf() is expected[4].)

-Kees

[1] https://github.com/KSPP/linux/issues/88
[2] https://github.com/KSPP/linux/issues/89
[3] https://github.com/KSPP/linux/issues/90
[4] https://lore.kernel.org/lkml/20200810092100.GA42813@2f5448a72a42/

-- 
Kees Cook
