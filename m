Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C6BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 03:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 767F822B48
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 03:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgG3DXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 23:23:03 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:39170 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbgG3DXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 23:23:03 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 06U3MoIj007800;
        Thu, 30 Jul 2020 05:22:50 +0200
Date:   Thu, 30 Jul 2020 05:22:50 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Emese Revfy <re.emese@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: linux-next: build failure after merge of the origin tree
Message-ID: <20200730032250.GB7790@1wt.eu>
References: <20200730090828.2349e159@canb.auug.org.au>
 <CAHk-=wjK8+12i8iDC41LXfZBcMjGsF+WyW_+ncPFmrexRT0yxw@mail.gmail.com>
 <202007292007.D87DBD34B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007292007.D87DBD34B@keescook>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Wed, Jul 29, 2020 at 08:17:48PM -0700, Kees Cook wrote:
> And just another heads-up, the patch[1] (which was never sent to a public
> list) also breaks arm64 (circular header needs?):
(...)

Definitely, we've just got a report about this, I'll have a look once
I'm at the office. I'd like to check that we don't obviously break
another arch by just removing percpu. If at least shuffling them around
is sufficient that'd be nice. Otherwise we'll likely need a separate
header (which is not a bad thing for the long term).

Thanks!
Willy
