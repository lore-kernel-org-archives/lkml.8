Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFEEC10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C73222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbgCKNvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 09:51:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729591AbgCKNvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 09:51:35 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF96720873;
        Wed, 11 Mar 2020 13:51:33 +0000 (UTC)
Date:   Wed, 11 Mar 2020 09:51:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] sched/rt: cpupri_find: Implement fallback
 mechanism for !fit case
Message-ID: <20200311095131.4db2bebc@gandalf.local.home>
In-Reply-To: <20200310142219.syxzn5ljpdxqtbgx@e107158-lin.cambridge.arm.com>
References: <20200302132721.8353-1-qais.yousef@arm.com>
        <20200302132721.8353-2-qais.yousef@arm.com>
        <20200304112739.7b99677e@gandalf.local.home>
        <20200304173925.43xq4wztummxgs3x@e107158-lin.cambridge.arm.com>
        <20200304135404.146c56eb@gandalf.local.home>
        <20200304200153.c4e2p7qnko54pejt@e107158-lin.cambridge.arm.com>
        <20200305124324.42x6ehjxbnjkklnh@e107158-lin.cambridge.arm.com>
        <20200310142219.syxzn5ljpdxqtbgx@e107158-lin.cambridge.arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020 14:22:20 +0000
Qais Yousef <qais.yousef@arm.com> wrote:

> This patch was already picked by Ingo, which I'm fine (and slightly prefer) the
> current version. But for the sake of completeness here's patch that falls back
> to a full 2nd scan.
> 
> Steve, can you please ping Peter/Ingo if you prefer the below version to be
> picked up instead? It is based on tip/sched/core and should apply on top of the
> picked up series.

Yeah, after looking at it for a bit, I think this is probably the best
"best effort" we can have without getting too complex or allocating more
memory.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Peter or Ingo, want to pick this patch up too?

-- Steve
