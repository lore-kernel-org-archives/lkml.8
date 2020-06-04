Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B360C433E3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 07:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04CA920663
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 07:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgFDHaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 03:30:22 -0400
Received: from smtprelay0189.hostedemail.com ([216.40.44.189]:50026 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728149AbgFDH3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 03:29:41 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 73A8E7FD8D;
        Thu,  4 Jun 2020 07:29:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wren59_311223326d95
X-Filterd-Recvd-Size: 2163
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Thu,  4 Jun 2020 07:29:39 +0000 (UTC)
Message-ID: <97eb5b4e4db4b50462032b1da0788dd61ed0a30e.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Avoid missing typo suggestions
From:   Joe Perches <joe@perches.com>
To:     Maxim Uvarov <maxim.uvarov@linaro.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Whitcroft <apw@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Thu, 04 Jun 2020 00:29:36 -0700
In-Reply-To: <CAD8XO3bezWoM7Pc0VoiFgoDWTLMN6VwV1vEFL7PR=_iohV82Ag@mail.gmail.com>
References: <202006031618.DA25142@keescook>
         <a3c22bbd360d2148bf097d3c55a89ea13e07b719.camel@perches.com>
         <CAD8XO3bezWoM7Pc0VoiFgoDWTLMN6VwV1vEFL7PR=_iohV82Ag@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-06-04 at 09:55 +0300, Maxim Uvarov wrote:
> On Thu, 4 Jun 2020 at 03:39, Joe Perches <joe@perches.com> wrote:

Hi Maxim.

> > btw: My codespell dictionary file moved to
> > /usr/lib/python3/dist-packages/codespell_lib/data/dictionary.txt
> > 
> > and I had to use --codespell --codespellfile=(above) so
> > maybe there should be multiple lookups for this file
> > like the array below.
> > 
> > Are there other standard codespell dictionary locations?
> 
> It might be better to support standard and non standard locations.

It already does with the --codespellfile=<location> opti.

> I think it's better to request from codespell where his dictionary is.

Maybe a good idea, but looking at the codespell git, for
versions 1.17 on there are several standard dictionaries.
https://github.com/codespell-project/codespell/tree/v1.17.1/codespell_lib/data

> I created ticket for this:
> https://github.com/codespell-project/codespell/issues/1540

Even if codespell is updated, the script would have to deal
with older versions that don't support requesting that option.

cheers, Joe


