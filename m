Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D2EC3F2CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 22:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A491124699
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 22:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgCAWWb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 17:22:31 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:49586 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726525AbgCAWWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 17:22:31 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 20406408-1500050 
        for multiple; Sun, 01 Mar 2020 22:22:27 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Steven Rostedt <rostedt@goodmis.org>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20200301131816.277dd398@oasis.local.home>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20200301155248.4132645-1-chris@chris-wilson.co.uk>
 <20200301131816.277dd398@oasis.local.home>
Message-ID: <158310134594.5508.5362429296192213548@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH 1/2] trace: Export anonymous tracing
Date:   Sun, 01 Mar 2020 22:22:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Steven Rostedt (2020-03-01 18:18:16)
> On Sun,  1 Mar 2020 15:52:47 +0000
> Chris Wilson <chris@chris-wilson.co.uk> wrote:
> 
> > To facilitate construction of per-client event ringbuffers, in
> > particular for a per-client debug and error report log, it would be
> > extremely useful to create an anonymous file that can be handed to
> > userspace so that it can see its and only its events. trace already
> > provides a means of encapsulating the trace ringbuffer into a struct
> > file that can be opened via the tracefs, and so with a couple of minor
> > tweaks can provide the same access via an anonymous inode.
> 
> I'm curious to why we need it to be anonymous. Why not allow them to be
> visible from the tracing directory. This could allow for easier
> debugging. Note, the trace instances have ref counters thus they can't
> be removed if something has a reference to it.

Do you really want a few thousand (or even tens) i915-client-%d? That
does not particularly seem like it adds ease-of-use, and would need to be
restricted to the client [or root]. The intent is for the client to have
a private channel for detailed debug/error reporting of its own calls
into the kernel.
-Chris
