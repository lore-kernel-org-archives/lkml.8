Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05634C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C55E82084D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N0qyCgPZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgG3WOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgG3WOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 18:14:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D369DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 15:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EI0QIOCzp+qWnYU0toMUiNBAwFGSW7ZQP3YlT17aTx0=; b=N0qyCgPZ4uHeSXaFAMovbTcsJZ
        xcBBMCrKD2z4afVmltk83O97iovOHfwlMA4Sh8L4L5yq7DWyxDZPtcjReTDvAO2hgkvz8VKWMrpSU
        VTdLW8ilYZ3sRG/B9OBHVhLIqwZUy4xCOsuwPM5UwUJzOQAwTZNLmFQbcwT6z9lylQXnXe/Ce2XDi
        MudA/MqFefBKMqL1njXsxqDCjb+ZPHYDbO2QWo6cDIA1USju2/CF1q7TxlA6mtHcKog7d6Mo0uqb7
        LOCNHZxL15oSBx+N11hBlWlYOG7rIvyVUWOq7F08NDdevZZzanyWqofFzJW2mf3O1xkb22ig5foyG
        2q4i5UWw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1Gol-0005WK-LV; Thu, 30 Jul 2020 22:14:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 62BB030066E;
        Fri, 31 Jul 2020 00:14:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D83CE235CA5D4; Fri, 31 Jul 2020 00:14:23 +0200 (CEST)
Date:   Fri, 31 Jul 2020 00:14:23 +0200
From:   peterz@infradead.org
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        =?iso-8859-1?Q?Genevi=E8ve?= Bastien <gbastien@versatic.net>,
        Wang Nan <wangnan0@huawei.com>,
        Jeremie Galarneau <jgalar@efficios.com>
Subject: Re: [PATCH 0/6] perf tools: Add wallclock time conversion support
Message-ID: <20200730221423.GH2638@hirez.programming.kicks-ass.net>
References: <20200730213950.1503773-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730213950.1503773-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 11:39:44PM +0200, Jiri Olsa wrote:

> The patchset is adding the ability to display TOD/wallclock timestamp
> in 'perf script' output and in 'perf data convert --to-ctf' subcommand,
> so the converted CTF data contain TOD/wallclock timestamps.

But why? Wallclock is a horrible piece of crap. Why would you want to do
this?
