Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD3FCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D24FE20657
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387783AbgEMN3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:29:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729309AbgEMN3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:29:25 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C87D20657;
        Wed, 13 May 2020 13:29:23 +0000 (UTC)
Date:   Wed, 13 May 2020 09:29:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [tracing] 06e0a548ba:
 WARNING:at_kernel/trace/ring_buffer.c:#ring_buffer_iter_peek
Message-ID: <20200513092922.6d79f6ee@gandalf.local.home>
In-Reply-To: <20200513091906.GA12720@tuxmaker.boeblingen.de.ibm.com>
References: <20200429090508.GG5770@shao2-debian>
        <20200513091906.GA12720@tuxmaker.boeblingen.de.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 11:19:06 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> Did you had a chance to look into this? I can easily reproduce this both on x86
> and s390 by doing:
> 
> cd /sys/kernel/tracing
> cat /dev/zero >/dev/null & # generate some load
> echo function >current_tracer
> # wait a few seconds to fill the buffer
> cat trace
> 
> Usually it will print the warn after a few seconds.
> 
> I haven't digged through all the ring buffer code yet, so i thought i might ask
> whether you have an idea what's going on.

Can you send me the config for where you can reproduce it on x86?

The iterator now doesn't stop the ring buffer when it iterates, and is
doing so over a live buffer (but should be able to handle it). It's
triggering something I thought wasn't suppose to happen (which must be
happening).

Perhaps with your config I'd be able to reproduce it.

-- Steve
