Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C12C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 23:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845F82468E
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 23:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbgB2XrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 18:47:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:59344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbgB2XrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 18:47:24 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 211C820828;
        Sat, 29 Feb 2020 23:47:23 +0000 (UTC)
Date:   Sat, 29 Feb 2020 18:47:19 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof =?UTF-8?B?RHJvYmnFhHNraQ==?= 
        <k.drobinski@camlintechnologies.com>,
        Pawel Lenkow <p.lenkow@camlintechnologies.com>,
        John Ogness <john.ogness@linutronix.de>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Regression in v4.19.106 breaking waking up of readers of
 /proc/kmsg and /dev/kmsg
Message-ID: <20200229184719.714dee74@oasis.local.home>
In-Reply-To: <20200229033253.GA212847@google.com>
References: <aa0732c6-5c4e-8a8b-a1c1-75ebe3dca05b@camlintechnologies.com>
        <20200227123633.GB962932@kroah.com>
        <42d3ce5c-5ffe-8e17-32a3-5127a6c7c7d8@camlintechnologies.com>
        <e9358218-98c9-2866-8f40-5955d093dc1b@camlintechnologies.com>
        <20200228031306.GO122464@google.com>
        <20200228100416.6bwathdtopwat5wy@pathway.suse.cz>
        <20200228105836.GA2913504@kroah.com>
        <20200228113214.kew4xi5tkbo7bpou@pathway.suse.cz>
        <20200228130217.rj6qge2en26bdp7b@pathway.suse.cz>
        <20200228205334.GF101220@mit.edu>
        <20200229033253.GA212847@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Feb 2020 12:32:53 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> > What do folks think?  
> 
> Well, my 5 cents, there is nothing that prevents "too-early"
> printk_deferred() calls in the future. From that POV I'd probably
> prefer to "forbid" printk_deffered() to touch per-CPU deferred
> machinery until it's not "too early" anymore. Similar to what we
> do in printk_safe::queue_flush_work().

I agree that printk_deferred() should handle being called too early.
But the issue is with per_cpu variables correct? Not the irq_work?

We could add a flag in init/main.c after setup_per_cpu_areas() and then
just have printk_deferred() act like a normal printk(). At that point,
there shouldn't be an issue in calling printk() directly, is there?

-- Steve
