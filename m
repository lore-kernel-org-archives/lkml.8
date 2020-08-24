Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130A9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA32E206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgHXS4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:56:50 -0400
Received: from smtprelay0176.hostedemail.com ([216.40.44.176]:37484 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725904AbgHXS4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:56:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id A9BF7180A7FDC;
        Mon, 24 Aug 2020 18:56:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: unit14_481660627055
X-Filterd-Recvd-Size: 1562
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Mon, 24 Aug 2020 18:56:47 +0000 (UTC)
Message-ID: <1365f4ab2a833d2cdb089064b10570dcc6e8b985.camel@perches.com>
Subject: Re: [GIT PULL] fallthrough pseudo-keyword macro conversions for
 5.9-rc3
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Aug 2020 11:56:46 -0700
In-Reply-To: <CAHk-=wh8a8crLw5Lbs7C2Mz34fAUQn1tTHWqqOXCxbXF1bc_WA@mail.gmail.com>
References: <20200824034841.GA29995@embeddedor>
         <CAHk-=wh8a8crLw5Lbs7C2Mz34fAUQn1tTHWqqOXCxbXF1bc_WA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-24 at 11:46 -0700, Linus Torvalds wrote:
> I think I'd have preferred to get this as a couple of scripts that do
> the obvious 1:1 direct conversion of the simple cases that cover 90%
> of it all, so then the manual fixups separately.

I created a script and sent it directly to you last year.

https://lore.kernel.org/lkml/9fe980f7e28242c2835ffae34914c5f68e8268a7.camel@perches.com/

I believe that Gustavo uses a different script and some
manual fixups.

It would be good if Gustavo's script was public somewhere.

