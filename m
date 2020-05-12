Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B06C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CC6D20736
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589276961;
	bh=Tck1QbPoKSNuE9nZmTrBvvoOWhkyXgjLULV7ge0ZvIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PJwdzrozD7mPKkkk7XYz5TFF11RYBVLxSCrXsgd8GVohuqSV/24HABvzUSzA+dYyF
	 Hld0RG2aY6knBA+Axtg6AhZfpiC/CkCbNd2d8uFOSK2qzrhLkRPIDs8VgMqD+Y17ZR
	 kA9549gdO5W4mY5RrPqdx6rSUjK9b1dJ4s0ZBQh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgELJtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 05:49:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgELJtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 05:49:20 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DC6920661;
        Tue, 12 May 2020 09:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589276959;
        bh=Tck1QbPoKSNuE9nZmTrBvvoOWhkyXgjLULV7ge0ZvIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jh+LSg6VPa1MQ6q+ZGZVLbQY+ZBvIal79s0CfMgjL827H0GsZJgsFOs1n3w9OJ5/3
         Rsnbie0JyPTEDAX74xpv0pQU6VM+gaTFmjurtsTOBZLRJVmt3GVETJ/l2CgeiE78dk
         cBnJkMffGIyY7wCbMFRwzFyZCXWWOZmqcGYRUaG4=
Date:   Tue, 12 May 2020 10:49:15 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, elver@google.com, tglx@linutronix.de,
        paulmck@kernel.org, mingo@kernel.org
Subject: Re: [PATCH v5 17/18] READ_ONCE: Use data_race() to avoid KCSAN
 instrumentation
Message-ID: <20200512094914.GA3021@willie-the-truck>
References: <20200511204150.27858-1-will@kernel.org>
 <20200511204150.27858-18-will@kernel.org>
 <20200512082306.GF2978@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512082306.GF2978@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 10:23:06AM +0200, Peter Zijlstra wrote:
> On Mon, May 11, 2020 at 09:41:49PM +0100, Will Deacon wrote:
> 
> > +	data_race(({ __WRITE_ONCE(*__xp, val); 0; }));			\
> 
> That had me blink for a little, I see how we got there, but urgh.

I tried for a while to see if data_race() could act differently if the
expression was type-compatible with 'void' and, while I got something that
mostly worked, it would fire unexpectedly in a few places where the
expression was most definitely not void (e.g. dereferencing a vma pointer)
so I gave up :(

> Anyway, it's all in *much* better shape now than it was, so no real
> copmlaints.

Thanks.

Will
