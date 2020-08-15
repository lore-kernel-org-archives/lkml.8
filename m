Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74E4C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A098020657
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgHOW2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:28:38 -0400
Received: from smtprelay0035.hostedemail.com ([216.40.44.35]:48322 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726598AbgHOW2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:28:38 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave03.hostedemail.com (Postfix) with ESMTP id 8175C181CB2AE;
        Sat, 15 Aug 2020 03:42:39 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 4721B100E7B6F;
        Sat, 15 Aug 2020 03:42:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cry93_3b1331b27002
X-Filterd-Recvd-Size: 2703
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sat, 15 Aug 2020 03:42:36 +0000 (UTC)
Message-ID: <af38bf7d8e2615c2f065a2f208d67209246f7a74.camel@perches.com>
Subject: Re: [PATCH v2] lib/string.c: implement stpcpy
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     =?ISO-8859-1?Q?D=E1vid_Bolvansk=FD?= <david.bolvansky@gmail.com>,
        Eli Friedman <efriedma@quicinc.com>, stable@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Sami Tolvanen <samitolvanen@google.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Daniel Axtens <dja@axtens.net>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Date:   Fri, 14 Aug 2020 20:42:35 -0700
In-Reply-To: <20200815020946.1538085-1-ndesaulniers@google.com>
References: <20200815014006.GB99152@rani.riverdale.lan>
         <20200815020946.1538085-1-ndesaulniers@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-08-14 at 19:09 -0700, Nick Desaulniers wrote:
> LLVM implemented a recent "libcall optimization" that lowers calls to
> `sprintf(dest, "%s", str)` where the return value is used to
> `stpcpy(dest, str) - dest`. This generally avoids the machinery involved
> in parsing format strings.  Calling `sprintf` with overlapping arguments
> was clarified in ISO C99 and POSIX.1-2001 to be undefined behavior.
> 
> `stpcpy` is just like `strcpy` except it returns the pointer to the new
> tail of `dest`. This allows you to chain multiple calls to `stpcpy` in
> one statement.
[]
> diff --git a/include/linux/string.h b/include/linux/string.h
[]
> @@ -31,6 +31,9 @@ size_t strlcpy(char *, const char *, size_t);
>  #ifndef __HAVE_ARCH_STRSCPY
>  ssize_t strscpy(char *, const char *, size_t);
>  #endif
> +#ifndef __HAVE_ARCH_STPCPY
> +extern char *stpcpy(char *__restrict__, const char *__restrict__);

If __restrict__ is used, perhaps it should follow the
kernel style used by attributes like __iomem and __user

extern char *stpcpy(char __restrict *dest, const char __restrict *src);

(though I would lose the extern too)

char *stpcpy(char __restrict *dest, const char __restrict *src);


