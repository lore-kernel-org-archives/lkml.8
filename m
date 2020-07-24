Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F60C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54D9320737
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mjyFfMr2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgGXOdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgGXOdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:33:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1015AC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 07:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4UGTeHmPvAoHFmZA19Z82u8cRZVtr7mrJj6fR5zLp14=; b=mjyFfMr2bOGMooupG2Q67a4XZ4
        KB+gd+sOe+wnnSd1xVp/TlXVejBlDeiHDwzIXyHAlR/9BJ496wIdoB3rtbQd+dqBGqeLlzf62EY2m
        0KRXJmSt0WC0OSqmzsozpqSBZFGloHzJ+U8DzKVO3y+eKdzuSG3LR6e9JdzPtsJiRwM6pqKxYZ6eC
        XEzAriISnyEad4vd++k7eDrGD/LLX3F9ral6R7wEctDEthD7ZNviH7ul793PbzbTNxdxfMq6ciY6v
        1GM7phiodX32MU80cJLNngSeTKEvPRMJwkzUf/72JTuO+DdBFUfuXRyecNBdnnPfGwyhscvPPfRo8
        oGtVDSfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyyku-0004Rx-Sj; Fri, 24 Jul 2020 14:33:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4AFC4304E03;
        Fri, 24 Jul 2020 16:32:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3654323645594; Fri, 24 Jul 2020 16:32:58 +0200 (CEST)
Date:   Fri, 24 Jul 2020 16:32:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        like.xu@linux.intel.com
Subject: Re: [PATCH V7 07/14] perf/core: Add a new PERF_EV_CAP_COEXIST event
 capability
Message-ID: <20200724143258.GB10769@hirez.programming.kicks-ass.net>
References: <20200723171117.9918-1-kan.liang@linux.intel.com>
 <20200723171117.9918-8-kan.liang@linux.intel.com>
 <20200724105543.GV119549@hirez.programming.kicks-ass.net>
 <20200724114628.GJ43129@hirez.programming.kicks-ass.net>
 <0d33a25c-cfe4-af7f-c915-a98dba17b53b@linux.intel.com>
 <20200724135412.GA10769@hirez.programming.kicks-ass.net>
 <e04f1708-e8c0-3787-1572-443f03ab73ca@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e04f1708-e8c0-3787-1572-443f03ab73ca@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 10:19:25AM -0400, Liang, Kan wrote:
> There will be a problem for the current perf tool, which assumes that the
> leader event is the sampling event.
> 
> I will check how can we specially handle it in the perf tool.

Ah, okay. I've long lost track of how the tool works :/

Something that seems to 'work' is:
'{cycles,cpu/instructions,period=50000/}', so maybe you can make the
group modifier :S use any sampling event if there is one, and otherwise
designate the leader.

Then you can write things like:

  '{slots, metric1, metric2, cpu/cycles,freq=50000/}:S'

and then since cycles is specified as a sampling event, it will use
that.
