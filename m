Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D87C49ECA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8590323103
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WDwoXxOe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbgHFIfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 04:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgHFIfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 04:35:52 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94971C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 01:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KLCbXXU3FEEkK2kFGOqzvm7OFPwa7d/ljqwYmaL9Dxo=; b=WDwoXxOenowP410hrcgMlpdl3V
        Pl2Yw8sVwgsENBuDhkRA0zoEPM6tr+5AfwhbYty1pl/vVfOjfPo61tpZ6kDZXOCHx4qgOktdWVtUV
        wo3lZ7tZ0QEkrz1mdWlKVIC40ubRLWzaEO4HNrPAdq0BXR1Z+YcHmBgfFYI1hbGyqC2Ttofiv1a/y
        gh+iZ1YfyeCJutQ/3ePjmqM/rcvtkg6q6IJEjRnT8i67uvXYp/QCJ2rZdFFPqT/e3NF6UnaANVX4A
        7BXY2tbdXOX+jstBC4BXUOuhUd2bx5lNSGEcsWhUK7YSAKknG4hu4pfHPi1Am7i7/+FfMkxPaC/ez
        Yr/T9G2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3bN9-0002f7-A0; Thu, 06 Aug 2020 08:35:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 50E0A300446;
        Thu,  6 Aug 2020 10:35:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DB8802B61F1C0; Thu,  6 Aug 2020 10:35:30 +0200 (CEST)
Date:   Thu, 6 Aug 2020 10:35:30 +0200
From:   peterz@infradead.org
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, alexey.budankov@linux.intel.com,
        adrian.hunter@intel.com, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/2] perf: Add closing sibling events' file descriptors
Message-ID: <20200806083530.GV2674@hirez.programming.kicks-ass.net>
References: <20200708151635.81239-1-alexander.shishkin@linux.intel.com>
 <20200708151635.81239-2-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708151635.81239-2-alexander.shishkin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 06:16:34PM +0300, Alexander Shishkin wrote:
> Currently, perf requires one file descriptor per event. In large groups,
> this may mean running into the limit on open file descriptors. However,
> the sibling events in a group only need file descriptors for the initial
> configuration stage, after which they may not be needed any more.
> 
> This adds an opt-in flag to the perf_event_open() syscall to retain
> sibling events after their file descriptors are closed. In this case, the
> actual events will be closed with the group leader.

So having the 1:1 relation with filedesc imposes a resource limit on
userspace.

This patch breaks that and enables a user to basically DoS the system by
creating unbound events.
