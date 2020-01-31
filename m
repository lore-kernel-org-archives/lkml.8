Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E327AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 17:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5443206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 17:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbgAaRvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 12:51:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:44028 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbgAaRvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 12:51:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C5661AD95;
        Fri, 31 Jan 2020 17:51:07 +0000 (UTC)
Date:   Fri, 31 Jan 2020 09:40:56 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     josh@joshtriplett.org, linux-kernel@vger.kernel.org,
        will@kernel.org, peterz@infradead.org
Subject: Re: [PATCH RFC locktorture] Print ratio of acquisitions, not failures
Message-ID: <20200131174055.slzlp33qeefbzgdw@linux-p48b>
References: <20200123172707.GA24441@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200123172707.GA24441@paulmck-ThinkPad-P72>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jan 2020, Paul E. McKenney wrote:

>The __torture_print_stats() function in locktorture.c carefully
>initializes local variable "min" to statp[0].n_lock_acquired, but
>then compares it to statp[i].n_lock_fail.  Given that the .n_lock_fail
>field should normally be zero, and given the initialization, it seems
>reasonable to display the maximum and minimum number acquisitions
>instead of miscomputing the maximum and minimum number of failures.
>This commit therefore switches from failures to acquisitions.

This makes sense, thanks!

>
>Reported-by: Will Deacon <will@kernel.org>
>Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>Cc: Davidlohr Bueso <dave@stgolabs.net>
>Cc: Josh Triplett <josh@joshtriplett.org>
>Cc: Peter Zijlstra <peterz@infradead.org>

Acked-by: Davidlohr Bueso <dbueso@suse.de>
