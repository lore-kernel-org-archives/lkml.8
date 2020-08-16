Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DB9C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 17:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14DFD20578
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 17:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbgHPR46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 13:56:58 -0400
Received: from smtprelay0152.hostedemail.com ([216.40.44.152]:55694 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726855AbgHPR45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 13:56:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 180E0180A9F31;
        Sun, 16 Aug 2020 17:56:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: drop82_3e0ba4527010
X-Filterd-Recvd-Size: 1614
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Sun, 16 Aug 2020 17:56:54 +0000 (UTC)
Message-ID: <61f8da080e5fac1bc23cdd68c43f199029c0a788.camel@perches.com>
Subject: Re: [PATCH] Makefile: Yes. Finally remove
 '-Wdeclaration-after-statement'
From:   Joe Perches <joe@perches.com>
To:     Michael Witten <mfwitten@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Date:   Sun, 16 Aug 2020 10:56:53 -0700
In-Reply-To: <c6fda26e8d134264b04fadc3386d6c32@gmail.com>
References: <c6fda26e8d134264b04fadc3386d6c32@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-08-16 at 16:35 +0000, Michael Witten wrote:
> Requiring every declaration to be at the top of a block is an
> antiquated, vestigial naivete from a time when C was just a
> glorified abstraction over conventional patterns in assembly
> programming.

I rather prefer block declarations instead of
sprinkling declarations around with code.

> We are not just programming anymore. We are now encoding our
> very thoughts, and thus we need this expressiveness in order
> to capture those thoughts with sufficient clarity.

So how does this removal have anything to do with
expressiveness and clarity?


