Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AF2C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB87220658
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgICO54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:57:56 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:24457 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729135AbgICOJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:09:42 -0400
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; 
   d="scan'208";a="465940153"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 16:09:16 +0200
Date:   Thu, 3 Sep 2020 16:09:16 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>
cc:     linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@inria.fr>
Subject: SD_LOAD_BALANCE
Message-ID: <alpine.DEB.2.22.394.2009031605190.2496@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uses of SD_LOAD_BALANCE were removed in commit e669ac8ab952 (first
released in v5.8), with the comment:

The SD_LOAD_BALANCE flag is set unconditionally for all domains in
sd_init().

I have the impression that this was not quite true.  The NUMA domain was
not initialized with sd_init, and didn't have the SD_LOAD_BALANCE flag
set.  The effect is that in v5.8, the for_each_domain loop in
select_task_rq_fair can always end up at the global NUMA domain, and thus
consider any pair of waking cpu (cpu) and previous cpus of the wakee
(prev_cpu) as arguments to wake_affine.  Up to v5.7, this was only
possible if cpu and prev_cpu were together in some lower level domain, ie
sharing the LLC.  The effect is that in v5.8 wake_affine can often end up
choosing as a target a core that does not share the LLC with the core
where the thread ran previously.  Threads then move around a lot between
the different sockets.

Was this intentional?

The effect can be seen in the traces of the parsec vips benchmark at the
following URL:

https://pages.lip6.fr/Julia.Lawall/vips.pdf

The first two graphs (complete run and small fragment) are Linux v5.7 and
the next two are Linux v5.8.  The machine has 160 hardware threads
organized in 4 sockets and the colors are by socket.  In the small
fragment for v5.7 (second graph), one can see that a given pid pretty much
stays on the same socket, while in the corresponding fragment for v5.8
(fourth graph), the pids move around between the sockets.  The x's
describe the unblocks that result in a migration.  A pink x means that the
migration is in the same socket, while a blue x means that the migration
is to another socket. It's not apparent from the graphs, but by adding
some tracing, it seems that the new socket is always the one of the core
that handles the wakeup.

I haven't yet studied the early part of the execution of vips in detail,
but I suspect that the same issue causes all of the threads to be
initially on the same socket in v5.7, while in v5.8 they are more quickly
dispersed to other sockets.

My impression from the parsec and the NAS benchmarks is that the v5.8
performance is a bit better than v5.7, probably because of getting more
threads to more different sockets earlier, but other benchmarks might
rely more on locality and might react less well to threads moving around
so much in this way.

julia
