Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32AEC35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 03:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 943C02080C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 03:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbgBKDPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 22:15:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:60792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgBKDPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 22:15:23 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCB0720714;
        Tue, 11 Feb 2020 03:15:22 +0000 (UTC)
Date:   Mon, 10 Feb 2020 22:15:21 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yiwei Zhang <zzyiwei@google.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add gpu memory tracepoints
Message-ID: <20200210221521.59928416@rorschach.local.home>
In-Reply-To: <CAKT=dDm+UKqa7j744iTsvYs+jqrdOHpTqdksRUjDe-6vqkigew@mail.gmail.com>
References: <20200211011631.7619-1-zzyiwei@google.com>
        <20200210211951.1633c7d0@rorschach.local.home>
        <CAKT=dDm+UKqa7j744iTsvYs+jqrdOHpTqdksRUjDe-6vqkigew@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2020 19:05:35 -0800
Yiwei Zhang <zzyiwei@google.com> wrote:

> Thanks for the prompt reply!
> 
> The tracepoint proposed here is for tracking global gpu memory usage
> total counter and per-process gpu memory usage total counter. The
> tracepoint is for gfx drivers who have implemented gpu memory tracking
> system. The tracepoint expects the de-duplication of the shared memory
> is done inside the tracking system.
> 
> On Android, the graphics driver has implemented gpu memory tracking.
> First, we'd like to profiler GPU memory with this tracepoint. Second,
> we implement eBPF programs and attach to this tracepoint for tracking
> GPU memory at runtime on production devices. However, the tracepoint +
> eBPF approach requires the tracepoint to be upstreamed so that it's
> considered a stable interface which Android common kernel can carry it
> forever.


Then it needs to live in the drivers/gpu directory. kernel/trace is for
tracing infrastructure and not for adding trace points.

-- Steve
