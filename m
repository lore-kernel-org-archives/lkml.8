Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D004C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 07:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9C9208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 07:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EMW3AHx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgCEH5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 02:57:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57626 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgCEH5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 02:57:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nU62n5QYJOKYOHbc6ZvACdnGhlJJokPCVj9KKxy8Vvw=; b=EMW3AHx0cCw7tymIImwZ6EeuhB
        /tfF71jGfrjOy1L8ek2aaiSPj+1qUlxirNpyKK8fe85L9VhpgVBbncq/GRo9m6fSheHGLXnB7Bmru
        D/sHF/UdaK/yg7gyqmy2TlpQ28dcDwrN91D+Ko6XnPwDq54CNclCrR+HccKH1WGUt89qyeyiYaZtA
        fHw8gIiErrRi2qc2kaeUqB8DSI3n2lW7Id0ZLZmohc8i6jd9jkQXIfRWVviqJon7lBAoxCftP2ovr
        n3wQTeAoLDOWbtow2yJrq1V7YOYIB0ubtG5tEfbnYU660A2W4iJrpoDluRuuXuEQe8zeyLoOSV+iC
        Hf9Y4mdQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9lO4-0005bA-RS; Thu, 05 Mar 2020 07:57:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DB38930066E;
        Thu,  5 Mar 2020 08:55:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B9B3D23D4FA08; Thu,  5 Mar 2020 08:57:42 +0100 (CET)
Date:   Thu, 5 Mar 2020 08:57:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xi Wang <xii@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Paul Turner <pjt@google.com>
Subject: Re: [PATCH] sched: watchdog: Touch kernel watchdog in sched code
Message-ID: <20200305075742.GR2596@hirez.programming.kicks-ass.net>
References: <20200304213941.112303-1-xii@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304213941.112303-1-xii@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 01:39:41PM -0800, Xi Wang wrote:
> The main purpose of kernel watchdog is to test whether scheduler can
> still schedule tasks on a cpu. In order to reduce latency from
> periodically invoking watchdog reset in thread context, we can simply
> touch watchdog from pick_next_task in scheduler. Compared to actually
> resetting watchdog from cpu stop / migration threads, we lose coverage
> on: a migration thread actually get picked and we actually context
> switch to the migration thread. Both steps are heavily protected by
> kernel locks and unlikely to silently fail. Thus the change would
> provide the same level of protection with less overhead.
> 
> The new way vs the old way to touch the watchdogs is configurable
> from:
> 
> /proc/sys/kernel/watchdog_touch_in_thread_interval
> 
> The value means:
> 0: Always touch watchdog from pick_next_task
> 1: Always touch watchdog from migration thread
> N (N>0): Touch watchdog from migration thread once in every N
>          invocations, and touch watchdog from pick_next_task for
>          other invocations.
> 

This is configurable madness. What are we really trying to do here?
