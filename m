Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79A5C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A895020714
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hH+kc7t4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgH0Tls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgH0Tlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 15:41:47 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F19C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 12:41:47 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id t185so4282954pfd.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 12:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n1Qwu/XvsgELXtbnoKiEGwTeI5Cm7GPhhnM6wHJRuAQ=;
        b=hH+kc7t4rkHW2B7yQQSI0nNjyISC8NRr+mxd0KVyt6ZqqWRtSniCXaOfWKparL+r0B
         RQB9WF3XkF4mSC0UeF3l8FszJN93YjT5GdTHcXULz4ypWC1HaxEHkRZcT2jTQSWZRRxm
         bLbpCbJ4jPEfFbP4SqN+QjIWa8JpqEk8Q82lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n1Qwu/XvsgELXtbnoKiEGwTeI5Cm7GPhhnM6wHJRuAQ=;
        b=naK+NDMZ+GesKsh0jsdlYb/cR19vOk7S1KKjO+Kl0S5Z5rFAF8fOYaGStwTk1E8/t8
         Lk/2AO6npQNW320omRfqTZB7oJxT4wS4TpwyWR2X18RckSxbnJ8iIQypBwymLJXtPPOd
         i1ntRVJWbFrvA94abloHmKAn4SscUJFEuOWRn3Ax30dfhMP67oxhzpf2C6/rRbM8xJYW
         /5DWqfDYSpswL8PuoKXqrG4LxP06YGcljmQ4yusCprfH0d9ya86yPmVbPvijuNJOabeY
         +a+fFRyZmGzw8xBBOPHl3tu8TCOZ7Gic2lIIDK2Zlh6hTvUTxDVUpIHYrR0vu/ygpZEe
         w6pw==
X-Gm-Message-State: AOAM531axfub1kBiCtWfF2db9+NUIzOAVVQGLS7vN1qjylTPoxjYH6jG
        xvFBwHs+rafmsLY9NOa21lMEzw==
X-Google-Smtp-Source: ABdhPJyOrJY3pQq1L2iejXSIkVKIwmtSPctwcc4JQlhf6KuiGFvcU76N2UM8y/G1wZWIaI/bHQdQNg==
X-Received: by 2002:a62:3583:: with SMTP id c125mr17402856pfa.1.1598557307051;
        Thu, 27 Aug 2020 12:41:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n68sm3453245pfn.145.2020.08.27.12.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 12:41:46 -0700 (PDT)
Date:   Thu, 27 Aug 2020 12:41:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
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
Message-ID: <202008271240.8D47596B0@keescook>
References: <20200825135838.2938771-1-ndesaulniers@google.com>
 <CAK7LNAQXo5-5W6hvNMEVPBPf3tRWaf-pQdSR-0OHyi4RCGhjsQ@mail.gmail.com>
 <d56bf7b93f7a28c4a90e4e16fd412e6934704346.camel@perches.com>
 <CAKwvOd=YrVtPsB7HYPO0N=K7QJm9KstayqqeYQERSaGtGy2Bjg@mail.gmail.com>
 <CAK7LNAQKwOo=Oas+7Du9+neSm=Ev6pxdPV7ges7eEEpW+jh8Ug@mail.gmail.com>
 <202008261627.7B2B02A@keescook>
 <CAHp75VfniSw3AFTyyDk2OoAChGx7S6wF7sZKpJXNHmk97BoRXA@mail.gmail.com>
 <202008271126.2C397BF6D@keescook>
 <98787c53f0577952be3f0ec0f7e58d618a165c33.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98787c53f0577952be3f0ec0f7e58d618a165c33.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 12:37:03PM -0700, Joe Perches wrote:
> On Thu, 2020-08-27 at 11:30 -0700, Kees Cook wrote:
> 
> > Most of the uses of strcpy() in the kernel are just copying between two
> > known-at-compile-time NUL-terminated character arrays. We had wanted to
> > introduce stracpy() for this, but Linus objected to yet more string
> > functions.
> 
> https://lore.kernel.org/kernel-hardening/24bb53c57767c1c2a8f266c305a670f7@sk2.org/T/
> 
> I still think stracpy is a good idea.
> 
> Maybe when the strcpy/strlcpy uses are removed
> it'll be more acceptable.
> 
> And here's a cocci script to convert most of them.
> https://lore.kernel.org/kernel-hardening/b9bb5550b264d4b29b2b20f7ff8b1b40d20def6a.camel@perches.com/

Yeah, thanks again for that. Most of this is very mechanical. (strncpy is not, unfortunately)

-- 
Kees Cook
