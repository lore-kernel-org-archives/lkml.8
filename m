Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5FBC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 04:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAE4206E9
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 04:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CBqdE1a0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgDDEvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 00:51:55 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55420 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgDDEvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 00:51:54 -0400
Received: by mail-pj1-f68.google.com with SMTP id fh8so3997951pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 21:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VtnwtgiEvNaRy9Qnd0vNktO6BIuGes3v4sHlRKc0K68=;
        b=CBqdE1a0bFq2j4uwHqNbXQoeHno/z1H39dYGxSKI8UfnLBq+xXaKHCrO+ydqqf2xqC
         orL5mq9dZcF5EvxGKVwk2SWK3neKuXXFsoDtGakEetvK/IhmdSC+yBorFYxU0iNhZMfo
         e+GGP86L/6gDYPBM5e0gPu4fX0MCZKl6kXKwzsH1TMLAEQSpvp19SazdEQmJ7aakIa34
         JVDzIqTCMxHhtGQyUIAreDcIA3WvrCNT02KtFW3A08a+0xCtUSm6ZopDu9DWjL9dwF51
         t3vXzDKY79mrKvv4YIEXbgMoBb6lXt8yLPynA8EIp1SzhNRBI+0xYnlR+v53buQ8pysn
         y3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VtnwtgiEvNaRy9Qnd0vNktO6BIuGes3v4sHlRKc0K68=;
        b=XZuSEH3qHGbJA1JLLZhpJ+lzafCcjuHd7SkqjNyStULsqo+ZVnPXSH1kqtjqsQG0Wa
         njKwa4q/b9HMnSaSLSba1GY1MBFYtD/IW/R+PBREe/wxqeylc+W+ucq1PtjK5J30hjD3
         oBAGykLs5SEkc23BVkrXnVzlLBrRm9f9Hx8ADZqJWlF3VP/pORh1UGTvFWeh3NJbdohZ
         F72qgcL967ifM//TPmbdr43qNPf8FHjqZAaz2EHazI094SBpID7eP79tWoO6DzVQ9CGF
         FEeo9BSe6heP3lDRweYLov1uw9MFeYfcxLpd1jiICZ5njWbzJHWSR9Y9KEejqZKSO2CE
         j7og==
X-Gm-Message-State: AGi0PuatBpgUTuya20/f/eOITO1+GoDhPKgX/EQ3I6qS0V28GXoYCXSG
        nq0smRczq6sAIegGxbk1cfhsgA==
X-Google-Smtp-Source: APiQypJZTcuOltwGMD3uc8rx+ZllhMqM10gylCbIh72vhT54Kd0crfqfhxZ9wvYwfd71IYsigKRXqQ==
X-Received: by 2002:a17:90a:ba93:: with SMTP id t19mr13501086pjr.67.1585975912420;
        Fri, 03 Apr 2020 21:51:52 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id e126sm6773681pfa.122.2020.04.03.21.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 21:51:51 -0700 (PDT)
Date:   Fri, 3 Apr 2020 21:51:49 -0700
From:   Fangrui Song <maskray@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sandeep Patil <sspatil@google.com>
Subject: Re: [PATCH] kbuild: mkcompile_h: Include $LD version in /proc/version
Message-ID: <20200404045149.ot22fmotljg7aim4@google.com>
References: <202004020117.6E434C035@keescook>
 <CAK7LNAQGTAgtADfY4H-k8X1J9nTMeOWvo8ZFfrUSHQUbhgcLKw@mail.gmail.com>
 <CAKwvOdnO_-jiQzCmy7pQNMGmZsgD9J=PYXVzOQ1NF1+u44MsOA@mail.gmail.com>
 <202004021129.F688E2D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202004021129.F688E2D@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-02, Kees Cook wrote:
>On Thu, Apr 02, 2020 at 11:22:02AM -0700, Nick Desaulniers wrote:
>> With Kees patch + Masahiro's diff applied:
>> $ cat /proc/version
>> Linux version 5.6.0-rc7-next-20200330+ (ndesaulniers@<hostname
>> scrubbed>) (clang version 11.0.0 (git@github.com:llvm/llvm-project.git
>> 6d71daed03ced011cd25f4e4f4122a368fdc757d), LLD 11.0.0
>> (git@github.com:llvm/llvm-project.git
>> 6d71daed03ced011cd25f4e4f4122a368fdc757d)) #167 SMP Thu Apr 2 11:17:36
>> PDT 2020
>>
>> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
>
>Awesome! Thanks for testing. :)
>
>> We could actually use this in Android for a VTS test I've, uh, been
>> meaning to write.  Also, LOL at scrubbing the "compatible with" part,
>> reminds me of user agent strings in the browser, which are god awful.
>
>Heh, yeah. That's there because (actually, I think _you_ told me this
>when I asked during the ClangBuiltLinux summit) other tools scanned the
>LD version string for the binutils-specific bits. For this, since it's
>newly added to the kernel /proc/version, nothing is already expecting to
>find an LD string, and it looked super weird in there if I left it
>as-is. Hence, scrub!
>
>-Kees

Thanks for the patch! This is a great idea. The linker version may be
more useful if link-time optimizations or future post link-time
optimizations are enabled. The linker will do code generation just like
the compiler and there will be lots of variety. The LD version can
become more useful in the future.

> +  LD_VERSION=$($LD -v | head -n1 | sed 's/(compatible with [^)]*)//' \

This User-Agent style hack reminds me of https://reviews.llvm.org/D31199
... Looks like nobody had posted patch to teach libtool about LLD yet!
So, I just posted a patch. It should appear on
https://lists.gnu.org/archive/html/libtool-patches/2020-04/index.html in
less than 15 minutes.


As what Nathan has just said

> With this patch + Masahiro's fold in:

Reviewed-by: Fangrui Song <maskray@google.com>
