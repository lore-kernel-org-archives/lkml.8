Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94565C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A6862137B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgFPLmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:42:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:35224 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgFPLmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 07:42:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 84606ADD3;
        Tue, 16 Jun 2020 11:42:01 +0000 (UTC)
Date:   Tue, 16 Jun 2020 13:41:56 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux@rasmusvillemoes.dk, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Orson Zhai <orson.zhai@unisoc.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 17/24] dyndbg: add user-flag, negating-flags, and
 filtering on flags
Message-ID: <20200616114156.GL31238@alley>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
 <20200613155738.2249399-18-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200613155738.2249399-18-jim.cromie@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2020-06-13 09:57:31, Jim Cromie wrote:
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
> The 'u' flag lets the user assemble an arbitary set of callsites.
> Then using filter flags, user can activate the 'u' set.
> 
>   #> echo 'file foo.c +u; file bar.c +u' > control   # and repeat
>   #> echo 'u+p' > control

What was the motivation for this please?
Is it common to manipulate the same set of callsites again and again?
Do you have any usecase, please?

Best Regards,
Petr
