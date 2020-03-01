Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C550C3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 18:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4E9246C8
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 18:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgCASST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 13:18:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:34352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgCASSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 13:18:18 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8586246C8;
        Sun,  1 Mar 2020 18:18:17 +0000 (UTC)
Date:   Sun, 1 Mar 2020 13:18:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] trace: Export anonymous tracing
Message-ID: <20200301131816.277dd398@oasis.local.home>
In-Reply-To: <20200301155248.4132645-1-chris@chris-wilson.co.uk>
References: <20200301155248.4132645-1-chris@chris-wilson.co.uk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  1 Mar 2020 15:52:47 +0000
Chris Wilson <chris@chris-wilson.co.uk> wrote:

> To facilitate construction of per-client event ringbuffers, in
> particular for a per-client debug and error report log, it would be
> extremely useful to create an anonymous file that can be handed to
> userspace so that it can see its and only its events. trace already
> provides a means of encapsulating the trace ringbuffer into a struct
> file that can be opened via the tracefs, and so with a couple of minor
> tweaks can provide the same access via an anonymous inode.

I'm curious to why we need it to be anonymous. Why not allow them to be
visible from the tracing directory. This could allow for easier
debugging. Note, the trace instances have ref counters thus they can't
be removed if something has a reference to it.

Also, all the global functions require kernel doc comments to explain
how they work and what they are for.

-- Steve


> 
> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  include/linux/trace.h |   4 ++
>  kernel/trace/trace.c  | 142 ++++++++++++++++++++++++++++++------------
>  2 files changed, 105 insertions(+), 41 deletions(-)
>
