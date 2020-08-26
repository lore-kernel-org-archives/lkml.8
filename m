Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A30C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 523B920737
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GMh32vhu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgHZVB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 17:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgHZVB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 17:01:27 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68816C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 14:01:27 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l191so1758169pgd.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 14:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ST8dKNdOof+9XS/A31fGeNIF5SQDK78dDGmv82m13dI=;
        b=GMh32vhusoiee9C6rCRWa+FEMY1RGx+CFmbamQMLaMAqITQ8ZIk9RFKLcj2u3odAfm
         0U8hbFsRxWPUxg37NFILz7c8ZPAv3DnDSIYrxiS1oh564HamwucVXxRXEFr9YGYc3Xjl
         KvdJ78Hn2STOnufWqrelp+EXLZnd8jTegIsyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ST8dKNdOof+9XS/A31fGeNIF5SQDK78dDGmv82m13dI=;
        b=eXsgsH8NZt5fuQUJm297pd9cwPhksOQrP9WIAHhn8D/OxN8j5ZeYOkDp8K1ePusowA
         qE6dRbomGuL39/bQQz5OVzmugcbn/FMFwmANHbdJS4KA0DpJ2qWhotC+o7xV8LdDChmQ
         4x8mmc2BHT9/KPGYeaP8IEiSe+StZDnRnf3hVQdE8N23Rp4TCI8ljqJBZx0/2tsUwc0Z
         +7gP2a85xLAfU8CN2iZ+1TRvbOG70CL7TotjsAYHjg02B+Tpwt3qKP7F6jwGZpN+lXfD
         mq32982O9z5a/qOWaW0T0HLaMi5EL9HMiqJR9r+taCdztb3SNcEzUe0ScV03sGCqgUX+
         jfog==
X-Gm-Message-State: AOAM533+g8+rrQqB0cKhD/hPaqE2f1n/3kpDaPWwRFz/S34NKfA+Lrdj
        /ixlE7Zt2TaI1Jzwq3BnNEC5fA==
X-Google-Smtp-Source: ABdhPJyV+pECqVc0Zgk7V2rxpU0hewkqfdwFyUb9UGQIQ+H23mpIGm5teMRRoGegRm7a7VkTkFLhhw==
X-Received: by 2002:a62:fc97:: with SMTP id e145mr4133562pfh.15.1598475686888;
        Wed, 26 Aug 2020 14:01:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m4sm74595pfh.129.2020.08.26.14.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 14:01:25 -0700 (PDT)
Date:   Wed, 26 Aug 2020 14:01:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] compiler-clang: add build check for clang 10.0.1
Message-ID: <202008261356.B31349A@keescook>
References: <20200826201420.3414123-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826201420.3414123-1-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 01:14:19PM -0700, Nick Desaulniers wrote:
> During Plumbers 2020, we voted to just support the latest release of
> Clang for now.  Add a compile time check for this.
> 
> Older clang's may work, but we will likely drop workarounds for older
> versions.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/9
> Link: https://github.com/ClangBuiltLinux/linux/issues/941
> Suggested-by: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  include/linux/compiler-clang.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index cee0c728d39a..7338d3ffd240 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -3,6 +3,14 @@
>  #error "Please don't include <linux/compiler-clang.h> directly, include <linux/compiler.h> instead."
>  #endif
>  
> +#define CLANG_VERSION (__clang_major__ * 10000	\
> +		     + __clang_minor__ * 100	\
> +		     + __clang_patchlevel__)
> +
> +#if CLANG_VERSION < 100001
> +# error Sorry, your compiler is too old - please upgrade it.

Perhaps a bike-shed suggestion, but I think we should make this message
as specific (and helpful) as possible:

# error Sorry, your version of Clang is too old - please use 10.0.1 or newer.

Then anyone seeing this has several pieces of information:

- the kernel build was attempting to use Clang
	(maybe they accidentally poked the wrong configs in a CI)
- they need 10.0.1 or better
	("upgrade to what version?" doesn't need to be dug out of documentation,
         headers, etc)

With that, yes, let's do it. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

(And likely we should improve the GCC message at the same time...)

-- 
Kees Cook
