Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F93C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D624207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgCaTCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:02:23 -0400
Received: from smtprelay0162.hostedemail.com ([216.40.44.162]:33844 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726295AbgCaTCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:02:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id CDAFE182CF668;
        Tue, 31 Mar 2020 19:02:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: stamp41_31887f240cb3a
X-Filterd-Recvd-Size: 1891
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Tue, 31 Mar 2020 19:02:20 +0000 (UTC)
Message-ID: <ae25b7b1efcfe4eda9465c4fb4712ede928a33c4.camel@perches.com>
Subject: Re: [PATCH] compiler.h: fix error in BUILD_BUG_ON() reporting
From:   Joe Perches <joe@perches.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Santos <daniel.santos@pobox.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ian Abbott <abbotti@mev.co.uk>
Date:   Tue, 31 Mar 2020 12:00:25 -0700
In-Reply-To: <123d3606-cebf-4261-4b04-7d53d1fcdb07@prevas.dk>
References: <20200331112637.25047-1-vegard.nossum@oracle.com>
         <dc53b8704ec674cba636b41d7f55bf507a7bd7aa.camel@perches.com>
         <123d3606-cebf-4261-4b04-7d53d1fcdb07@prevas.dk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-31 at 20:56 +0200, Rasmus Villemoes wrote:
> On 31/03/2020 20.20, Joe Perches wrote:
> > On Tue, 2020-03-31 at 13:26 +0200, Vegard Nossum wrote:
> > >  #define compiletime_assert(condition, msg) \
> > > -	_compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
> > > +	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> > 
> > This might be better using something like __LINE__ ## _ ## __COUNTER__
> > 
> > as line # is somewhat useful to identify the specific assert in a file.
> > 
> 
> Eh, if the assert fires, doesn't the compiler's diagnostics already
> contain all kinds of location information?

I presume if that were enough,
neither __LINE__ nor __COUNTER__
would be useful.


