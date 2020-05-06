Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B345C47257
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 19:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59C1B2076D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 19:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgEFTGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 15:06:17 -0400
Received: from smtprelay0157.hostedemail.com ([216.40.44.157]:44500 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727774AbgEFTGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 15:06:16 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id BE06B182C8795;
        Wed,  6 May 2020 19:06:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: offer44_8d78196bd6428
X-Filterd-Recvd-Size: 3210
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Wed,  6 May 2020 19:06:12 +0000 (UTC)
Message-ID: <aa9e029703e184a56bcab9f0992cfff316136d16.camel@perches.com>
Subject: Re: [PATCH] clone: only use lower 32 flag bits
From:   Joe Perches <joe@perches.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Christian Kellner <christian@kellner.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Arnd Bergmann <arnd@arndb.de>, Serge Hallyn <serge@hallyn.com>,
        Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Jan Stancek <jstancek@redhat.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Florian Weimer <fw@deneb.enyo.de>, libc-alpha@sourceware.org
Date:   Wed, 06 May 2020 12:06:10 -0700
In-Reply-To: <20200505174446.204918-1-christian.brauner@ubuntu.com>
References: <20200505174446.204918-1-christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-05-05 at 19:44 +0200, Christian Brauner wrote:
> Jan reported an issue where an interaction between sign-extending clone's
> flag argument on ppc64le and the new CLONE_INTO_CGROUP feature causes
> clone() to consistently fail with EBADF.
[]
> Let's fix this by always capping the upper 32 bits for the legacy clone()
> syscall. This ensures that we can't reach clone3() only features by
> accident via legacy clone as with the sign extension case and also that
> legacy clone() works exactly like before, i.e. ignoring any unknown flags.
> This solution risks no regressions and is also pretty clean.
> 
> I've chosen u32 and not unsigned int to visually indicate that we're
> capping this to 32 bits.

Perhaps use the lower_32_bits macro?

> diff --git a/kernel/fork.c b/kernel/fork.c
[]
> @@ -2569,12 +2569,21 @@ SYSCALL_DEFINE5(clone, unsigned long, clone_flags, unsigned long, newsp,
>  		 unsigned long, tls)
>  #endif
>  {
> +	/*
> +	 * On 64 bit unsigned long can be used by userspace to
> +	 * pass flag values only useable with clone3(). So cap
> +	 * the flag argument to the lower 32 bits. This is fine,
> +	 * since legacy clone() has traditionally ignored unknown
> +	 * flag values. So don't break userspace workloads that
> +	 * (on accident or on purpose) rely on this.
> +	 */
> +	u32 flags = (u32)clone_flags;
>  	struct kernel_clone_args args = {
> -		.flags		= (clone_flags & ~CSIGNAL),
> +		.flags		= (flags & ~CSIGNAL),

so:

		.flags		= lower_32_bits(clone_flags) & ~CSIGNAL;

>  		.pidfd		= parent_tidptr,
>  		.child_tid	= child_tidptr,
>  		.parent_tid	= parent_tidptr,
> -		.exit_signal	= (clone_flags & CSIGNAL),
> +		.exit_signal	= (flags & CSIGNAL),

		.exit_signal	= lower_32_bits(clone_flags) & CSIGNAL;

>  		.stack		= newsp,
>  		.tls		= tls,
>  	};
> 
> base-commit: 0e698dfa282211e414076f9dc7e83c1c288314fd

