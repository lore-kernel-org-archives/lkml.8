Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6F6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C33E20720
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbgGFPkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:40:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729286AbgGFPkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:40:21 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F00722070C;
        Mon,  6 Jul 2020 15:40:19 +0000 (UTC)
Date:   Mon, 6 Jul 2020 11:40:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Willy Tarreau <w@1wt.eu>,
        ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>, torvalds@linux-foundation.org
Subject: Re: [Tech-board-discuss] [PATCH] CodingStyle: Inclusive Terminology
Message-ID: <20200706114018.216570ae@oasis.local.home>
In-Reply-To: <20200706152210.GA53508@rani.riverdale.lan>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
        <20200705045505.GA2962@1wt.eu>
        <20200706152210.GA53508@rani.riverdale.lan>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jul 2020 11:22:10 -0400
Arvind Sankar <nivedita@alum.mit.edu> wrote:

> Though I'm not sure if blueprint translates literally into other
> languages, it did actually have a logical reason, viz engineering
> drawings used to be blue/white. But logical reasons don't have to exist.
> In the case of colors, for example, using red-black tree doesn't exclude
> blind people, precisely because there is no logical reason for using the
> colors red and black, or even colors at all, so it's not as if you gain
> any additional insight into the structure if you are able to see the
> colors. It just needs _some_ arbitrary labels for distinguishing two
> classes of nodes, it could just as well have been named A-B tree or 0-1
> tree or whatever. I don't think there is any concise way to label them
> that conveys anything useful about how they're used in the data
> structure -- you just have to learn about the structure and how it's
> used. This isn't the case with whitelist/blacklist, where those colors
> actually have connotations about what the two lists mean.

When I learned about R-B trees in my algorithms class decades ago, I
distinctly remember the text book saying something about how the red
and black names were meaningless. Just know that the nodes are
different in how you go about sorting or injecting a new node into the
tree. So yes, it could have been blue and yellow, or 1 and 0, or Bob
and Alice. The colors were just a way of labeling in order to
differentiate the two types of nodes, and I am not worried that people
are going to take offense to them.

-- Steve

