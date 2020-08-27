Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A048C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 02:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62CE92078D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 02:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgH0CmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 22:42:23 -0400
Received: from smtprelay0147.hostedemail.com ([216.40.44.147]:51240 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726790AbgH0CmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 22:42:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id CFED71801DBD7;
        Thu, 27 Aug 2020 02:42:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: actor37_421792427069
X-Filterd-Recvd-Size: 5155
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Thu, 27 Aug 2020 02:42:18 +0000 (UTC)
Message-ID: <e84ea9d311fe082af8a1afe2aba48303ffbb1bf1.camel@perches.com>
Subject: Re: [PATCH v3] lib/string.c: implement stpcpy
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>
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
Date:   Wed, 26 Aug 2020 19:42:17 -0700
In-Reply-To: <202008261932.FF4E5C0@keescook>
References: <20200825135838.2938771-1-ndesaulniers@google.com>
         <CAK7LNAQXo5-5W6hvNMEVPBPf3tRWaf-pQdSR-0OHyi4RCGhjsQ@mail.gmail.com>
         <d56bf7b93f7a28c4a90e4e16fd412e6934704346.camel@perches.com>
         <CAKwvOd=YrVtPsB7HYPO0N=K7QJm9KstayqqeYQERSaGtGy2Bjg@mail.gmail.com>
         <CAK7LNAQKwOo=Oas+7Du9+neSm=Ev6pxdPV7ges7eEEpW+jh8Ug@mail.gmail.com>
         <202008261627.7B2B02A@keescook>
         <77428f28620d4e5ecad1556396f2b0f8f0daef41.camel@perches.com>
         <202008261932.FF4E5C0@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-26 at 19:33 -0700, Kees Cook wrote:
> On Wed, Aug 26, 2020 at 04:57:41PM -0700, Joe Perches wrote:
> > On Wed, 2020-08-26 at 16:38 -0700, Kees Cook wrote:
> > > On Thu, Aug 27, 2020 at 07:59:45AM +0900, Masahiro Yamada wrote:
> > []
> > > > OK, then stpcpy(), strcpy() and sprintf()
> > > > have the same level of unsafety.
> > > 
> > > Yes. And even snprintf() is dangerous because its return value is how
> > > much it WOULD have written, which when (commonly) used as an offset for
> > > further pointer writes, causes OOB writes too. :(
> > > https://github.com/KSPP/linux/issues/105
> > > 
> > > > strcpy() is used everywhere.
> > > 
> > > Yes. It's very frustrating, but it's not an excuse to continue
> > > using it nor introducing more bad APIs.
> > > 
> > > $ git grep '\bstrcpy\b' | wc -l
> > > 2212
> > > $ git grep '\bstrncpy\b' | wc -l
> > > 751
> > > $ git grep '\bstrlcpy\b' | wc -l
> > > 1712
> > > 
> > > $ git grep '\bstrscpy\b' | wc -l
> > > 1066
> > > 
> > > https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy
> > > https://github.com/KSPP/linux/issues/88
> > > 
> > > https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
> > > https://github.com/KSPP/linux/issues/89
> > > 
> > > https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> > > https://github.com/KSPP/linux/issues/90
> > > 
> > > We have no way right now to block the addition of deprecated API usage,
> > > which makes ever catching up on this replacement very challenging.
> > 
> > These could be added to checkpatch's deprecated_api test.
> > ---
> >  scripts/checkpatch.pl | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 149518d2a6a7..f9ccb2a63a95 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -605,6 +605,9 @@ foreach my $entry (@mode_permission_funcs) {
> >  $mode_perms_search = "(?:${mode_perms_search})";
> >  
> >  our %deprecated_apis = (
> > +	"strcpy"				=> "strscpy",
> > +	"strncpy"				=> "strscpy",
> > +	"strlcpy"				=> "strscpy",
> >  	"synchronize_rcu_bh"			=> "synchronize_rcu",
> >  	"synchronize_rcu_bh_expedited"		=> "synchronize_rcu_expedited",
> >  	"call_rcu_bh"				=> "call_rcu",
> > 
> > 
> 
> Good idea, yeah. We, unfortunately, need to leave strncpy() off this
> list for now because it's not *strictly* deprecated (see the notes in
> bug report[1]), but the others can be.

OK, but it is in Documentation/process/deprecated.rst

strncpy() on NUL-terminated strings
-----------------------------------
Use of strncpy() does not guarantee that the destination buffer
will be NUL terminated. This can lead to various linear read overflows
and other misbehavior due to the missing termination. It also NUL-pads the
destination buffer if the source contents are shorter than the destination
buffer size, which may be a needless performance penalty for callers using
only NUL-terminated strings. The safe replacement is strscpy().
(Users of strscpy() still needing NUL-padding should instead
use strscpy_pad().)

If a caller is using non-NUL-terminated strings, strncpy() can
still be used, but destinations should be marked with the `__nonstring
<https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html>`_
attribute to avoid future compiler warnings.


