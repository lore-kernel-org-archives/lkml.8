Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C85CC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55256208FE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgIDPx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:53:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:48412 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgIDPxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:53:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B1398AC24;
        Fri,  4 Sep 2020 15:53:24 +0000 (UTC)
Date:   Fri, 4 Sep 2020 17:53:51 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     ltp@lists.linux.it
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, lkp@lists.01.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [LTP] [PATCH v2] syscall/ptrace08: Simplify the test.
Message-ID: <20200904155351.GA13149@yuki.lan>
References: <20200904140931.10153-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904140931.10153-1-chrubis@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> +	/*
> +	 * The original fix for the kernel haven't rejected the kernel address
> +	 * right away when breakpoint was modified from userspace it was
> +	 * disabled and the EINVAL was returned when dr7 was written to enable
> +	 * it again.
> +	 */
> +	if (tst_kvercmp(4, 17, 0) < 0)
> +		deffered_check = 1;

And this should be 4.19 as the modify_user_hw_breakpoint_check() was made
uncoditional (by accident) in:

commit bd14406b78e6daa1ea3c1673bda1ffc9efdeead0
Author: Jiri Olsa <jolsa@kernel.org>
Date:   Mon Aug 27 11:12:25 2018 +0200

    perf/hw_breakpoint: Modify breakpoint even if the new attr has disabled set


-- 
Cyril Hrubis
chrubis@suse.cz
