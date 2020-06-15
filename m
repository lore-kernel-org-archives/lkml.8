Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479C5C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2584A20679
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbgFOVV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 17:21:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgFOVV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 17:21:26 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2820520679;
        Mon, 15 Jun 2020 21:21:25 +0000 (UTC)
Date:   Mon, 15 Jun 2020 17:21:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Perches <joe@perches.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, stable@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] proc/bootconfig: Fix to use correct quotes for
 value
Message-ID: <20200615172123.1fe77f3c@oasis.local.home>
In-Reply-To: <7abefbc81fc6aaefed6bbd2117e7bc97b90babe9.camel@perches.com>
References: <159197538852.80267.10091816844311950396.stgit@devnote2>
        <159197539793.80267.10836787284189465765.stgit@devnote2>
        <20200615151139.5cc223fc@oasis.local.home>
        <7abefbc81fc6aaefed6bbd2117e7bc97b90babe9.camel@perches.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020 12:24:00 -0700
Joe Perches <joe@perches.com> wrote:

> > Hmm, shouldn't the above have the upside-down xmas tree format?
> > 
> > 	struct xbc_node *leaf, *vnode;
> > 	char *key, *end = dst + size;
> > 	const char *val;
> > 	char q;
> > 	int ret = 0;  
> 
> Please don't infect kernel sources with that style oddity.

What do you mean? It's already "infected" all over the kernel, (has
been for years!) and I kinda like it. It makes reading variables much
easier on the eyes, and as I get older, that means a lot more ;-)

-- Steve
