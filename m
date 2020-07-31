Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A53C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 21:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B10322B3F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 21:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596230962;
	bh=ZLbhjQCA6Lr7WPMvsYnug+Z6zWPo3a5RksC7e/DM1fA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=P5zbNnOGZNWC76819tIjlKDbhxH+p8OqIdqXqr6Lgw1urs9N7EMSLTfY3jdokFe8C
	 2vhG7t25/087JueuIkCO1RjPBYIUSrWWZWV+jN66OLVOQJ3naSxIyN4UykQei2jrm6
	 z2TlCc4UlPkngK3qFdiHB9RBhB9cD+pjsjh7e9BA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgGaV3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 17:29:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbgGaV3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 17:29:20 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E11572087C;
        Fri, 31 Jul 2020 21:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596230960;
        bh=ZLbhjQCA6Lr7WPMvsYnug+Z6zWPo3a5RksC7e/DM1fA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q1vafZGOKmYfsr5pJBTDVcEEjUwbni9ZQ9kgigWtjQQpQodJ2WQuh0chgAAKqBz5Q
         5s7pikAA9/q8ZMKsGa13LalkyHBux3OH0KlU/kFwgf3F0vSalf7cAC0h72fiyKGhzK
         pI/uGrmtvYemcBN36TA8mNVTcQjafUFR6dALa0+8=
Date:   Fri, 31 Jul 2020 14:29:19 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     paulmck@kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        hannes@cmpxchg.org, urezki@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: Raw spinlocks and memory allocation
Message-Id: <20200731142919.36c4c741189426db0f8b8514@linux-foundation.org>
In-Reply-To: <20200731212457.GS9247@paulmck-ThinkPad-P72>
References: <20200730231205.GA11265@paulmck-ThinkPad-P72>
        <20200731133834.517fdfee99b7ed2239f576aa@linux-foundation.org>
        <20200731204855.GR9247@paulmck-ThinkPad-P72>
        <20200731205933.GT23808@casper.infradead.org>
        <20200731212457.GS9247@paulmck-ThinkPad-P72>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jul 2020 14:24:57 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:

> The reason for this restriction is that in -rt, the spin_lock(&zone->lock)
> in rmqueue_bulk() can sleep.

So if there is runtime overhead, this overhead could be restricted to
-rt kernels with suitable ifdefs?
