Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D772EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFCE420A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgFPNpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 09:45:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:49226 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727966AbgFPNpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 09:45:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6B659B18F;
        Tue, 16 Jun 2020 13:45:13 +0000 (UTC)
Date:   Tue, 16 Jun 2020 15:45:07 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v2 20/24] dyndbg: WIP towards debug-print-class based
 callsite controls
Message-ID: <20200616134507.GO31238@alley>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
 <20200613155738.2249399-21-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200613155738.2249399-21-jim.cromie@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2020-06-13 09:57:34, Jim Cromie wrote:
> There are *lots* of ad-hoc debug printing solutions in kernel,
> this is a 1st attempt at providing a common mechanism for many of them.

I agree that it might make sense to provide some common mechanism.


> Basically, there are 2 styles of debug printing:
> - levels, with increasing verbosity, 1-10 forex
> - bits/flags, independently controlling separate groups of dprints
> 
> This patch does bits/flags only.
> 
> proposed API:
> 
> Usage model is for a module developer to create N exclusive subsets of
> pr_debug()s by changing some of them to pr_debug_n(1,) .. pr_debug_n(N,).
> Each callsite must be a single print-class, with 0 default.
> 
> No multi-type classification ala pr_debug_M(1|2, ...) is contemplated.
> 
>   Qfoo() { echo module foo $* >/proc/dynamic_debug/control }
>   Qfoo +p  		# all groups, including default 0
>   Qfoo mflags 1 +p	# only group 1
>   Qfoo mflags 12 +p	# TBD[1]: groups 1 or 2
>   Qfoo mflags 0 +p	# ignored atm TBD[2]
>   Qfoo mflags af +p	# TBD[3]: groups a or f (10 or 15)

My problem with this approach is that it is too generic. Each class
would have different meaning in each subsystem.

It might help to replace any existing variants. But it would be hard
for developers debugging the code. They would need to study/remember
the meaning of these groups for particular subsystems. They would
need to set different values for different messages.

Could you please provide more details about the potential users?
Would be possible to find some common patterns and common
meaning of the groups?

Best Regards,
Petr
