Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAD6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA21322BEA
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596227917;
	bh=UiAvZEfW3ClxCu672wov0jKI+ccwVPoNvJXKh0xHAJo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=aHnOYUFFpWbVHRQ2840Kldf7frvcNcRnO2nqkeWO8LfddG7c2la8pUp2UjhH+TATb
	 R+twap2mUxjcNpwKDWJGqd24gVYPc773cUg00h0CFm6fqqS7aIIWy0ESS7Z0sDIHhv
	 FKpVJNbT6h0Kq/isH61G8zRN4A/9SdWRyjYQiXj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgGaUig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:38:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728664AbgGaUif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 16:38:35 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A64D21744;
        Fri, 31 Jul 2020 20:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596227915;
        bh=UiAvZEfW3ClxCu672wov0jKI+ccwVPoNvJXKh0xHAJo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lUcEV892FuJYWdVHY3viR2kP5fT2UK8Ok7pZf/aOtcjX3Q8Zrah2XJKol5BQvNAv1
         LwOj1KJ0/MPNsKDfSMxuEXql/HeNFCOF43vAa7L5HZOQn5a9ShHvC9omyWTbpX+XQl
         +u/k6UkMv7PkY0+ebx24Y4uZh6N+nW0WLI6U4Ijg=
Date:   Fri, 31 Jul 2020 13:38:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     paulmck@kernel.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, hannes@cmpxchg.org, willy@infradead.org,
        urezki@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Raw spinlocks and memory allocation
Message-Id: <20200731133834.517fdfee99b7ed2239f576aa@linux-foundation.org>
In-Reply-To: <20200730231205.GA11265@paulmck-ThinkPad-P72>
References: <20200730231205.GA11265@paulmck-ThinkPad-P72>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jul 2020 16:12:05 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:

> So, may we add a GFP_ flag that will cause kmalloc() and friends to return
> NULL when they would otherwise need to acquire their non-raw spinlock?
> This avoids adding any overhead to the slab-allocator fastpaths, but
> allows callback invocation to reduce cache misses without having to
> restructure some existing callers of call_rcu() and potential future
> callers of kfree_rcu().

We have eight free gfp_t bits so that isn't a problem.

Adding a test-n-branch to the kmalloc() fastpath may well be a concern.

Which of mm/sl?b.c are affected?

A doesnt-need-to-really-work protopatch would help us understand the
potential cost?
