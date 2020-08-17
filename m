Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17041C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 04:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 006152072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 04:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgHQETa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 00:19:30 -0400
Received: from smtprelay0019.hostedemail.com ([216.40.44.19]:41620 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725765AbgHQET1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 00:19:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 93D9C181D302B;
        Mon, 17 Aug 2020 04:19:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rest34_300d56527013
X-Filterd-Recvd-Size: 1414
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon, 17 Aug 2020 04:19:25 +0000 (UTC)
Message-ID: <7d0be10602e31e334ff41299c06f537880c55bd0.camel@perches.com>
Subject: Re: [PATCH] Makefile: Yes. Finally remove
 '-Wdeclaration-after-statement'
From:   Joe Perches <joe@perches.com>
To:     Michael Witten <mfwitten@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Date:   Sun, 16 Aug 2020 21:19:23 -0700
In-Reply-To: <23e2e6c2d3a24954bccb67a3186019b9@gmail.com>
References: <c6fda26e8d134264b04fadc3386d6c32@gmail.com>
         <61f8da080e5fac1bc23cdd68c43f199029c0a788.camel@perches.com>
         <23e2e6c2d3a24954bccb67a3186019b9@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-17 at 03:37 +0000, Michael Witten wrote:
> Matters of  style should  probably not be  enforced by  the build
> infrastructure; style is a matter for the maintainer to enforce:

I rather doubt style advice should be taken from someone who
right justifies fixed pitch block text.

cheers, Joe

