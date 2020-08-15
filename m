Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9160C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B76DB205CB
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbgHOWFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:05:54 -0400
Received: from smtprelay0123.hostedemail.com ([216.40.44.123]:45948 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729955AbgHOWFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:05:50 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id B2B4A80118C0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 03:17:28 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 80CFF100E7B6F;
        Sat, 15 Aug 2020 03:17:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bath02_460df3327002
X-Filterd-Recvd-Size: 1566
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Sat, 15 Aug 2020 03:17:27 +0000 (UTC)
Message-ID: <bc2ca9785cb7cf86c59c8922269d2dfc077ec3cc.camel@perches.com>
Subject: Re: [PATCH] genksyms: keywords: Use __restrict not _restrict
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 14 Aug 2020 20:17:26 -0700
In-Reply-To: <CAHk-=wjjHN32BXdqu1iP8WSZoqdGPDDiqVLUbBgYG+=JO3MJCw@mail.gmail.com>
References: <15f52e9b0e50296aba35871bc1575a684c4a258a.camel@perches.com>
         <CAKwvOd=8C94K-9VCqdCn9FXiyfDhKxMu=4AGem1bGgp8m6z0fw@mail.gmail.com>
         <CAHk-=wjjHN32BXdqu1iP8WSZoqdGPDDiqVLUbBgYG+=JO3MJCw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-08-14 at 20:05 -0700, Linus Torvalds wrote:
> On Fri, Aug 14, 2020 at 7:14 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> > What's KAO? Urban dictionary has no entry. :^P
> 
> It goes back to 2003 and the original keywords.gperf file, see
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=46bd1da672d66ccd8a639d3c1f8a166048cca608
> 
> from the BK history conversion.
> 
> It might be Kai Germaschewski's tagger name?

I think it was Keith Owens.


