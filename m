Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92364C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63051222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582300861;
	bh=ITbRrKDrqN+aE+B/tpRjh8TrcZ7Qb5orGLC5oVu6KnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yZWHfCvlbK2Tczm1/2YgQtFFz70irnYEQ+Ve5NqisQQueEha6lt9lBUHzcXmBImDe
	 9sdFbcnDutMnO5j/YC2g9SXT95JdDniqOFYrMechlUZGJSIuBQDTjQRAX3pxP5MCZT
	 bquVxkzy0DYYv/xo0Djqri8nwYUHZaWdxyDCy5WM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbgBUQBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:01:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:48556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbgBUQA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:00:59 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2D2A2067D;
        Fri, 21 Feb 2020 16:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582300859;
        bh=ITbRrKDrqN+aE+B/tpRjh8TrcZ7Qb5orGLC5oVu6KnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j41qS++6t6eNCnmNP73LXa89xPl3ZGhlzmGwSAn+v6apsDIgVNVsxCAk5yJC5c5o1
         8GUvFSHY1szfuMnQNBjq0Oz4B34tzD6jsqmvfECN36Wjx7PhZlmP/BRml0MIdr0dVl
         v/fxsksG8/y4GOMhv7MGsEJ6MSv87uSQodi1AwsE=
Date:   Fri, 21 Feb 2020 16:00:54 +0000
From:   Will Deacon <will@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Maddie Stone <maddiestone@google.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>, lkp@lists.01.org
Subject: Re: [kernel] 247f5d7caa: will-it-scale.per_process_ops 9.6%
 improvement
Message-ID: <20200221160053.GA19330@willie-the-truck>
References: <20200221115542.GL14493@shao2-debian>
 <CAG48ez0N9rTEtrA1TrL07r5Om_yK-10XO2XtsWOn3Nde0PXsZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0N9rTEtrA1TrL07r5Om_yK-10XO2XtsWOn3Nde0PXsZA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 04:55:42PM +0100, Jann Horn wrote:
> On Fri, Feb 21, 2020 at 12:56 PM kernel test robot
> <rong.a.chen@intel.com> wrote:
> > FYI, we noticed a 9.6% improvement of will-it-scale.per_process_ops due to commit:
> >
> >
> > commit: 247f5d7caa443d0ea5f1992aeda875e679e9bd35 ("kernel-hacking: Make DEBUG_{LIST,PLIST,SG,NOTIFIERS} non-debug options")
> > https://git.kernel.org/cgit/linux/kernel/git/will/linux.git debug-list
> 
> I'm guessing this might mean that the test bot had the DEBUG_LIST
> stuff enabled in its Kconfig, whereas after the rename, the default is
> used, which is off?

I thought that at first, but scrolling down in the logs of the report
I got totally confused by the softirqs and interrupts stuff.

> This seems a bit problematic if people had DEBUG_LIST enabled in their
> old kernel config and then try to reuse that config for a new kernel.
> I wonder whether it'd be acceptable to keep the options under their
> old names and let them "select" the new ones, or whether we have to
> choose between "keep the old bad name" and "discard people's old
> config flags".

I can keep DEBUG_LIST kicking around and have the options default to that.
Once I've finished updated lkdtm, I'll post this all out to the list.

Will
