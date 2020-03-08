Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38F8C18E5B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 07:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97CF20828
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 07:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgCHHED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 03:04:03 -0400
Received: from smtprelay0242.hostedemail.com ([216.40.44.242]:42323 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725854AbgCHHED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 03:04:03 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id C87A4181D3417;
        Sun,  8 Mar 2020 07:04:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: form16_5f6d69e56317
X-Filterd-Recvd-Size: 2200
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sun,  8 Mar 2020 07:04:00 +0000 (UTC)
Message-ID: <259f405155a948f90229d3fc8cad928d434b46f9.camel@perches.com>
Subject: Re: [PATCH] cvt_fallthrough: A tool to convert /* fallthrough */
 comments to fallthrough;
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     clang-built-linux@googlegroups.com
Date:   Sat, 07 Mar 2020 23:02:23 -0800
In-Reply-To: <6773b7e3-8ce4-55d1-8bb7-bde6d9f6e887@embeddedor.com>
References: <b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe@perches.com>
         <576fe2ab-7937-4698-b32a-8599813d6ad1@embeddedor.com>
         <4304de54a44b7c8c22d8c2d9249d716664cf5ce8.camel@perches.com>
         <6773b7e3-8ce4-55d1-8bb7-bde6d9f6e887@embeddedor.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-03-08 at 00:46 -0600, Gustavo A. R. Silva wrote:
> 
> On 3/7/20 21:01, Joe Perches wrote:
> > On Sat, 2020-03-07 at 15:30 -0600, Gustavo A. R. Silva wrote:
> > > Some people consistently add blank lines as part of their code style,
> > > and if I were
> > > one of those people, I wouldn't like to have such lines removed.
> > 
> > It's a patch generator, it's not perfect.
> > Nothing is nor ever will be.
> 
> Wise words. The thing is that this is feedback over a proposed
> patch.
> 
> > It's quite simple to add blank lines if that's
> > what any maintainer desires.
> > 
> 
> I'm not sure if you are saying that it's not a problem to
> update your proposed patch,

It's not a problem with my proposed patch.
Consistency is good.

Nearly all uses in mm do not have blank lines
after break.

> or if you are suggesting that
> the maintainers will have the predisposition of applying
> patches that will modify their coding style and then go and
> willingly fix that. I doubt the latter, though.

If any do actually use the script, I guess we'll see.

> --
> Gustavo

