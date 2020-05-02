Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9918EC3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 09:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F98F2137B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 09:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gly6yMOZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgEBJbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 05:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgEBJbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 05:31:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A019C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 02:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L5IU7gLDofU3mBI/dmON/IMvflnwzIVfMkww7fo2aHE=; b=Gly6yMOZa52CzInVASHDubUAAY
        WdAk+238+rlWHsbrbqhzDnWLMRlK9I5QqfimqlvI0CYyulDvRnJ6qBQ/reGqUxIdjXlvCrhd3tLU9
        XRFj1F+K1aaWl6iAj1Gahc3uXz8uu3TDPg93CELlS4hDuqNct2Pmo8j7stk1AeFDbtMAq7X2p0uIe
        fzQIfG2mviyR5FjYQjD3bh/U7e49wE0y8V1Xjx9MBcM18qvgF6dM3KqQez4Y8p6AOXJ5/Ov18zO+K
        Z863d+ayxqNxqSGPado40BbYyJAUReqYhI44F5K5NHiTF6vu93hbu4Nqyk+gnURXL0lGp9CrPES4L
        8umgopbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUoUG-0004Ky-UN; Sat, 02 May 2020 09:31:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E3B4A300130;
        Sat,  2 May 2020 11:31:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CA3CD20AED123; Sat,  2 May 2020 11:31:05 +0200 (CEST)
Date:   Sat, 2 May 2020 11:31:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de, mingo@kernel.org,
        mgorman@techsingularity.net, bp@suse.de,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] kernel/sys: do not use tasklist_lock to set/get
 scheduling priorities
Message-ID: <20200502093105.GJ3762@hirez.programming.kicks-ass.net>
References: <20200502030539.32581-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200502030539.32581-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 08:05:39PM -0700, Davidlohr Bueso wrote:
> For both setpriority(2) and getpriority(2) there's really no need
> to be taking the tasklist_lock at all - for which both share it
> for the entirety of the syscall. The tasklist_lock does not protect
> reading/writing the p->static_prio and task lookups are already rcu
> safe, providing a stable pointer.

RCU-safe, as in, it will not crash.. However, without tasklist_lock the
thread iterations (for PRIO_PGRP/PRIO_USER) now race against fork().

That is a user observable change in behaviour.

Do we care about it? No idea, and your Changelog also doesn't provide
clue.
