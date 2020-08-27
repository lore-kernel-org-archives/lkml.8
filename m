Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2577BC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 02:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0563C2078D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 02:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VTsTUaMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgH0Cdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 22:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgH0Cds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 22:33:48 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29409C0612A1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 19:33:48 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id p11so2302914pfn.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 19:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x1FlPbUtnes2qpBqooOcQ2o2d41W/mH568giujPfLVI=;
        b=VTsTUaMyrMj7HlpV8WjY9eaJs9bbslyL/CMOWABNQiMOMxZQVnhtIV7v7m7WC0iGHG
         Qd+0/hNkV31AEpGQNr4lzlSAqaJYt1Xp6MqTHPXAv8OOma7V40Hy2H6h2mAxYPlikbZh
         69kf7ajL0MFOS+EvUVKANFuWShEOp+JAZqDco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x1FlPbUtnes2qpBqooOcQ2o2d41W/mH568giujPfLVI=;
        b=fSPnYI/lQIvzGr4R4VM109t9NVv6GouE0ykiP8rTnD0XXjyhe5kevnzPwlqKLGfMQO
         hWSqSg4mxMJg8yq/LEkOYe9zkkZMFWNDDvzzP9xOyfhNZkQ+lbyJtmckN5NOp3Tl/8wt
         aMi+aWwfbJoh9EYCmRb1CDZftbBiP1j4qqugevaHfoCuOnVzym2hXtCJEh048lYFPm89
         d+Wq+A2gZMt52p1YSfPIaGkWjsYQZoO8Mz1tHFJ50zniF+v+rh/YyVzMxPc9z24+VyBz
         F9tNWd8D93oA4bwfweMkAg0uAWfINPlD/BqJ0+5PKXB5V0nf5mqbBxg/4I2L+/S+w8o8
         LKdA==
X-Gm-Message-State: AOAM531DthS7ZpdrJ1qCJm2sWs51lY/lCt9sk0Jd1xjO4Q4ObRAuF/PJ
        BcYJxqhI+nQEfbhpAftikJ7wpQ==
X-Google-Smtp-Source: ABdhPJxo49wRKyhwgJZQXq4XKNwknZcjy90W5IsV6wiIB6JdRjRcNWuJs1Grn2t/TJvPNTEPt6r3iA==
X-Received: by 2002:a63:36c6:: with SMTP id d189mr12091053pga.392.1598495627669;
        Wed, 26 Aug 2020 19:33:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v134sm572683pfc.101.2020.08.26.19.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 19:33:46 -0700 (PDT)
Date:   Wed, 26 Aug 2020 19:33:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        stable <stable@vger.kernel.org>, Andy Lavr <andy.lavr@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sami Tolvanen <samitolvanen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] lib/string.c: implement stpcpy
Message-ID: <202008261932.FF4E5C0@keescook>
References: <20200825135838.2938771-1-ndesaulniers@google.com>
 <CAK7LNAQXo5-5W6hvNMEVPBPf3tRWaf-pQdSR-0OHyi4RCGhjsQ@mail.gmail.com>
 <d56bf7b93f7a28c4a90e4e16fd412e6934704346.camel@perches.com>
 <CAKwvOd=YrVtPsB7HYPO0N=K7QJm9KstayqqeYQERSaGtGy2Bjg@mail.gmail.com>
 <CAK7LNAQKwOo=Oas+7Du9+neSm=Ev6pxdPV7ges7eEEpW+jh8Ug@mail.gmail.com>
 <202008261627.7B2B02A@keescook>
 <77428f28620d4e5ecad1556396f2b0f8f0daef41.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77428f28620d4e5ecad1556396f2b0f8f0daef41.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 04:57:41PM -0700, Joe Perches wrote:
> On Wed, 2020-08-26 at 16:38 -0700, Kees Cook wrote:
> > On Thu, Aug 27, 2020 at 07:59:45AM +0900, Masahiro Yamada wrote:
> []
> > > OK, then stpcpy(), strcpy() and sprintf()
> > > have the same level of unsafety.
> > 
> > Yes. And even snprintf() is dangerous because its return value is how
> > much it WOULD have written, which when (commonly) used as an offset for
> > further pointer writes, causes OOB writes too. :(
> > https://github.com/KSPP/linux/issues/105
> > 
> > > strcpy() is used everywhere.
> > 
> > Yes. It's very frustrating, but it's not an excuse to continue
> > using it nor introducing more bad APIs.
> > 
> > $ git grep '\bstrcpy\b' | wc -l
> > 2212
> > $ git grep '\bstrncpy\b' | wc -l
> > 751
> > $ git grep '\bstrlcpy\b' | wc -l
> > 1712
> > 
> > $ git grep '\bstrscpy\b' | wc -l
> > 1066
> > 
> > https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy
> > https://github.com/KSPP/linux/issues/88
> > 
> > https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
> > https://github.com/KSPP/linux/issues/89
> > 
> > https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> > https://github.com/KSPP/linux/issues/90
> > 
> > We have no way right now to block the addition of deprecated API usage,
> > which makes ever catching up on this replacement very challenging.
> 
> These could be added to checkpatch's deprecated_api test.
> ---
>  scripts/checkpatch.pl | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 149518d2a6a7..f9ccb2a63a95 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -605,6 +605,9 @@ foreach my $entry (@mode_permission_funcs) {
>  $mode_perms_search = "(?:${mode_perms_search})";
>  
>  our %deprecated_apis = (
> +	"strcpy"				=> "strscpy",
> +	"strncpy"				=> "strscpy",
> +	"strlcpy"				=> "strscpy",
>  	"synchronize_rcu_bh"			=> "synchronize_rcu",
>  	"synchronize_rcu_bh_expedited"		=> "synchronize_rcu_expedited",
>  	"call_rcu_bh"				=> "call_rcu",
> 
> 

Good idea, yeah. We, unfortunately, need to leave strncpy() off this
list for now because it's not *strictly* deprecated (see the notes in
bug report[1]), but the others can be.

[1] https://github.com/KSPP/linux/issues/89

-- 
Kees Cook
