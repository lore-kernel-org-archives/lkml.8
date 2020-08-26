Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6580AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 23:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F519207CD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 23:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgHZX5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 19:57:51 -0400
Received: from smtprelay0132.hostedemail.com ([216.40.44.132]:48980 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726238AbgHZX5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 19:57:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 132A318000BE0;
        Wed, 26 Aug 2020 23:57:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ocean54_1a016df27068
X-Filterd-Recvd-Size: 3604
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Wed, 26 Aug 2020 23:57:42 +0000 (UTC)
Message-ID: <77428f28620d4e5ecad1556396f2b0f8f0daef41.camel@perches.com>
Subject: Re: [PATCH v3] lib/string.c: implement stpcpy
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
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
Date:   Wed, 26 Aug 2020 16:57:41 -0700
In-Reply-To: <202008261627.7B2B02A@keescook>
References: <20200825135838.2938771-1-ndesaulniers@google.com>
         <CAK7LNAQXo5-5W6hvNMEVPBPf3tRWaf-pQdSR-0OHyi4RCGhjsQ@mail.gmail.com>
         <d56bf7b93f7a28c4a90e4e16fd412e6934704346.camel@perches.com>
         <CAKwvOd=YrVtPsB7HYPO0N=K7QJm9KstayqqeYQERSaGtGy2Bjg@mail.gmail.com>
         <CAK7LNAQKwOo=Oas+7Du9+neSm=Ev6pxdPV7ges7eEEpW+jh8Ug@mail.gmail.com>
         <202008261627.7B2B02A@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-26 at 16:38 -0700, Kees Cook wrote:
> On Thu, Aug 27, 2020 at 07:59:45AM +0900, Masahiro Yamada wrote:
[]
> > OK, then stpcpy(), strcpy() and sprintf()
> > have the same level of unsafety.
> 
> Yes. And even snprintf() is dangerous because its return value is how
> much it WOULD have written, which when (commonly) used as an offset for
> further pointer writes, causes OOB writes too. :(
> https://github.com/KSPP/linux/issues/105
> 
> > strcpy() is used everywhere.
> 
> Yes. It's very frustrating, but it's not an excuse to continue
> using it nor introducing more bad APIs.
> 
> $ git grep '\bstrcpy\b' | wc -l
> 2212
> $ git grep '\bstrncpy\b' | wc -l
> 751
> $ git grep '\bstrlcpy\b' | wc -l
> 1712
> 
> $ git grep '\bstrscpy\b' | wc -l
> 1066
> 
> https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy
> https://github.com/KSPP/linux/issues/88
> 
> https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
> https://github.com/KSPP/linux/issues/89
> 
> https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> https://github.com/KSPP/linux/issues/90
> 
> We have no way right now to block the addition of deprecated API usage,
> which makes ever catching up on this replacement very challenging.

These could be added to checkpatch's deprecated_api test.
---
 scripts/checkpatch.pl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 149518d2a6a7..f9ccb2a63a95 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -605,6 +605,9 @@ foreach my $entry (@mode_permission_funcs) {
 $mode_perms_search = "(?:${mode_perms_search})";
 
 our %deprecated_apis = (
+	"strcpy"				=> "strscpy",
+	"strncpy"				=> "strscpy",
+	"strlcpy"				=> "strscpy",
 	"synchronize_rcu_bh"			=> "synchronize_rcu",
 	"synchronize_rcu_bh_expedited"		=> "synchronize_rcu_expedited",
 	"call_rcu_bh"				=> "call_rcu",


