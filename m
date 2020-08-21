Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB3AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EFDC2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gaPnkgpr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgHUT6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgHUT4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:56:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85FBC061573;
        Fri, 21 Aug 2020 12:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BN55ErogQ3phnIHH8Zm42eA6QwhldaEoRNqesYPn+jo=; b=gaPnkgprWrM0XYk7nb2X8+2I5l
        c6ruzrsLrcyCHvA3gYAboWs4eynSBFR2tVCbQ3g3eGf8/IFLgseWVFxT7ucNFU2Ha0FKhz4ylDMyk
        w97f7aDZebpCfDPl5e8LoPFQz6vWX8fSOhszxq2deYs81IHpCJ6LDfTXW43Ii+ILHHt4qpr/O7GRM
        hOo08htFbP9UlbARFbLmVbl6icD1K7zOwPl4YhyueLQqU/ETuQqpHf8mMqD5ATdHUYm1iyMapVPbQ
        nVkUnrojnAGvg6SX/QVcPetPdflPq9XygRHqkbtYfu6OpWe2isibGCwIEl/nT4yPEgK/PV9OLfBNC
        2IwhKhiA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9D9W-0006ix-W7; Fri, 21 Aug 2020 19:56:45 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 99F90980DF7; Fri, 21 Aug 2020 21:56:41 +0200 (CEST)
Date:   Fri, 21 Aug 2020 21:56:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Waiman Long <longman@redhat.com>
Subject: Re: [RFC v7 00/19] lockdep: Support deadlock detection for recursive
 read locks
Message-ID: <20200821195641.GV3982@worktop.programming.kicks-ass.net>
References: <20200807074238.1632519-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807074238.1632519-1-boqun.feng@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 03:42:19PM +0800, Boqun Feng wrote:
> Hi Peter and Waiman,
> 
> As promised, this is the updated version of my previous lockdep patchset
> for recursive read lock support. It's based on v5.8. Previous versions
> can be found at:

OK, this all looks really nice.

I've stuck it in my locking/core branch for testing, I've had to fix a
few minor rejects (my bad for being to slow), made a few minor edits and
fixed that one masking thing.

It seems to boot with the selftests all green, haven't done much else
with it yet, we'll see.

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core

Thanks!
