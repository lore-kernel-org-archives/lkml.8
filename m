Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CE4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 576DD20748
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lG9BDioB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgHJUgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 16:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgHJUgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 16:36:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD3EC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5/YX7mbPG9aXUarjwzHhusSBv2gDsz45AkVWwrnituE=; b=lG9BDioB5fkj9M/z8owgD9Qrho
        FWBwsWB5kiD1N0Z9dsBHMW3J9def5BwwIVXlTnsgQaqKuj3ZHLiKQ1MpGuky5V1n1jUHVeNs3EgfS
        /D2SJYiMPDRiRjlzJakGkP6sj5H99jacfRWZ7LrAfJFriB6U9vR1P2T7mQjE03s/KT5zs7vkGk3Uw
        DmXSY87e66gjSHQBsBmJgbsrh5mAjf1lEZOORN4VnxYGQ5NTzdnxT/PDSdkdoCkpihqb2hPYCZi1F
        dcTqWSxrbrSB/bzG5fuYTRwR3AerDD29bm+e9uqNhSGIuBtcJX0sJNP6yixf/LFrMqbQbXPusAc9S
        5NsZ5iOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5EX2-0007kf-J7; Mon, 10 Aug 2020 20:36:33 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B71A980D39; Mon, 10 Aug 2020 22:36:32 +0200 (CEST)
Date:   Mon, 10 Aug 2020 22:36:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, alexey.budankov@linux.intel.com,
        adrian.hunter@intel.com
Subject: Re: [PATCH 1/2] perf: Add closing sibling events' file descriptors
Message-ID: <20200810203632.GF3982@worktop.programming.kicks-ass.net>
References: <20200708151635.81239-1-alexander.shishkin@linux.intel.com>
 <20200708151635.81239-2-alexander.shishkin@linux.intel.com>
 <20200806083530.GV2674@hirez.programming.kicks-ass.net>
 <20200806153205.GA1448395@tassilo.jf.intel.com>
 <875z9q1u3g.fsf@ashishki-desk.ger.corp.intel.com>
 <20200810144518.GB1448395@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810144518.GB1448395@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 07:45:18AM -0700, Andi Kleen wrote:

> Unfortunately we're kind of stuck with the old NFILE=1024 default
> even though it makes little sense on modern servers.

Why can't that be changed? It seems to me all of userspace changes all
the time; heck that system-doofus thing flushed 20+ years of sysadmin
experience down the drain, just cause. Why can't we up a file limit?
