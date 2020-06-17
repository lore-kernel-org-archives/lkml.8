Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BF8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CE3721548
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgFQWNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 18:13:33 -0400
Received: from smtprelay0248.hostedemail.com ([216.40.44.248]:44702 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726835AbgFQWNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:13:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 816CB180905DE;
        Wed, 17 Jun 2020 22:13:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: boys91_3f16e1d26e0b
X-Filterd-Recvd-Size: 2453
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Wed, 17 Jun 2020 22:13:29 +0000 (UTC)
Message-ID: <dddfef643fc5bef1ff440f18c3dd12f586195a7c.camel@perches.com>
Subject: Re: [PATCH v3 20/21] dyndbg: add user-flag, negating-flags, and
 filtering on flags
From:   Joe Perches <joe@perches.com>
To:     Jim Cromie <jim.cromie@gmail.com>, jbaron@akamai.com,
        linux-kernel@vger.kernel.org, akpm@linuxfoundation.org,
        gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org
Date:   Wed, 17 Jun 2020 15:13:28 -0700
In-Reply-To: <20200617162536.611386-23-jim.cromie@gmail.com>
References: <20200617162536.611386-1-jim.cromie@gmail.com>
         <20200617162536.611386-23-jim.cromie@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-17 at 10:25 -0600, Jim Cromie wrote:
> 1. Add a user-flag [u] which works like the [pfmlt] flags, but has no
> effect on callsite behavior; it allows incremental marking of
> arbitrary sets of callsites.
> 
> 2. Add [PFMLTU] flags, which negate their counterparts; P===!p etc.
> And in ddebug_read_flags():
>    current code does:	[pfmltu_] -> flags
>    copy it to:		[PFMLTU_] -> mask
> 
> also disallow both of a pair: ie no 'pP', no true & false.
> 
> 3. Add filtering ops into ddebug_change(), right after all the
> callsite-property selections are complete.  These filter on the
> callsite's current flagstate before applying modflags.
> 
> Why ?
> 
> The u-flag & filter flags
> 
> The 'u' flag lets the user assemble an arbitary set of callsites.
> Then using filter flags, user can activate the 'u' callsite set.
> 
>   #> echo 'file foo.c +u; file bar.c +u' > control   # and repeat
>   #> echo 'u+p' > control
> 
> Of course, you can continue to just activate your set without ever
> marking it 1st, but you could trivially add the markup as you go, then
> be able to use it as a constraint later, to undo or modify your set.

Does this set selection also allow for selection by
increasing decimal level?

Can sites be enabled for a value less than x?


