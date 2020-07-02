Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E3AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 042682067D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kjtd2wG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgGBIOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgGBIOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 04:14:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14361C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 01:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DCacNRD1uL4bMLWk5ZZs0zu8Jt+SbmcnTXgs/UtoZFQ=; b=Kjtd2wG6X/EuMYB7A5r5jGda3Z
        EkTHseW8tbmoRD0/dGNCzxtcd0WS3x/rjcsjNotzrVUt79avnhL6F40MAsjDVgRRcncBlZDUT3sIu
        3UJFco/GWvVE8DNN3zlXLxf7OG88s8HN1vZEHaVM+wOvcvnDgKTzn0PrE5Bt9wxAs4uRd8cm1LiMA
        FxNIYZLln7PLgVpKsRo9dvLua6VD8XK6JVBpZBdXyH/zoiuAKyvOLKzR2kXrW5TS+mgqxmJMCmVei
        UxrqpSgJxPUSZ/YiZisDfPCS8VfV+9FjaXF2MmJiAJ7ZEhoJPzxH5gMgcdStBXTyDg0aVPub65K+6
        9FGBSmzA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jquMN-0007pF-7N; Thu, 02 Jul 2020 08:14:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5CA513011B2;
        Thu,  2 Jul 2020 10:14:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 25BEE264F8CB1; Thu,  2 Jul 2020 10:14:18 +0200 (CEST)
Date:   Thu, 2 Jul 2020 10:14:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] proc: add support detach proccess's autogroup
Message-ID: <20200702081418.GZ4781@hirez.programming.kicks-ass.net>
References: <20200702052039.GA2824@192.168.3.9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702052039.GA2824@192.168.3.9>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 01:20:43PM +0800, Weiping Zhang wrote:
> Since setid will create a autogroup for that process, there is no
> way to detach a process from that autogroup, this patch add a new interface
> to detach a process from its autogroup. You can write anything to
> /proc/<pid>/autogroup_detach to do that.

This is indeed what the patch does; but it fails to tell me why. Why do
we want this? Why should I care about your patch :-)

Please, always explain why you want things done, that can also help us
consider if the proposed solution is the right one.
