Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3882AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1742D24672
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbgA0Ptv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 10:49:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:40000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728783AbgA0Ptv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 10:49:51 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E84F22527;
        Mon, 27 Jan 2020 15:49:50 +0000 (UTC)
Date:   Mon, 27 Jan 2020 10:49:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'linux-kernel' <linux-kernel@vger.kernel.org>
Subject: Re: sched/fair: Long delays starting RT processes on idle cpu.
Message-ID: <20200127104948.59eac75a@gandalf.local.home>
In-Reply-To: <13797bbe87b64f34877b89a5bbdb6d03@AcuMS.aculab.com>
References: <13797bbe87b64f34877b89a5bbdb6d03@AcuMS.aculab.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2020 15:39:24 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> I'd have thought that the processor should wake up much faster than that.
> I can't see the memory write that is paired with the monitor/mwait.
> Does it need a strong barrier?

You may want to prevent the CPU from going into a deep C state. 90us is
something I would expect if the CPU is in a deep C state (I've seen
much longer wake up times due to deep C state).

Boot the kernel with idle=poll and see if you can trigger the same
latency. If not, then you know it's the CPU going into a deep C state
that is causing your latency.

-- Steve
