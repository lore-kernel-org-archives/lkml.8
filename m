Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6991AC4BA2D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336F820658
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgBZXZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 18:25:07 -0500
Received: from smtprelay0094.hostedemail.com ([216.40.44.94]:59350 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727910AbgBZXZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 18:25:06 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id EFA36100E7B43;
        Wed, 26 Feb 2020 23:25:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: error50_4912417d1f308
X-Filterd-Recvd-Size: 2340
Received: from XPS-9350 (47-209-22-207.mmlkcmtc01.res.dyn.suddenlink.net [47.209.22.207])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Wed, 26 Feb 2020 23:25:01 +0000 (UTC)
Message-ID: <8b9eaca3ab7b05db8b5562284484a24d44bf6cce.camel@perches.com>
Subject: Re: [PATCH] Documentation/llvm: add documentation on building w/
 Clang/LLVM
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Date:   Wed, 26 Feb 2020 15:23:31 -0800
In-Reply-To: <CAKwvOdmSix2hgDGsvcAzVD9L5XmM8tPDMyrdXmZjcvGXu_TMSQ@mail.gmail.com>
References: <20200224174129.2664-1-ndesaulniers@google.com>
         <202002242003.870E5F80@keescook>
         <20200225041643.GA17425@ubuntu-m2-xlarge-x86>
         <CAKwvOdn0_EETGtBVhbRKMPqv2K04Z1N4PuOZDZ6++Ejbi9-B-w@mail.gmail.com>
         <202002251353.25A016CD@keescook>
         <3b7b2b366220c9ba39ebc241ba22c0304f0d61b0.camel@perches.com>
         <CAKwvOdmSix2hgDGsvcAzVD9L5XmM8tPDMyrdXmZjcvGXu_TMSQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-02-26 at 15:18 -0800, Nick Desaulniers wrote:
> On Tue, Feb 25, 2020 at 2:21 PM Joe Perches <joe@perches.com> wrote:
> > On Tue, 2020-02-25 at 13:56 -0800, Kees Cook wrote:
> > > I think we should take a specific version stand as the
> > > "minimum" version. Being able to build x86 defconfig is a good minimum
> > > IMO.
> > 
> > Agree.
> > 
> > It's odd to say that clang 4 is fine for arm when it's
> > not fine for x86.  It's also reasonable to expect arm
> > users to upgrade their compiler to a more recent version
> > when the only cost is a very small bit of time.
> 
> That's a very x86 centric point of view.

Really?

How many code generation improvements and possible defects
have been corrected between clang 4 and clang 10 for arm?

I presume more than a few.

