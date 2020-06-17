Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADD5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 15:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7618521527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 15:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592409347;
	bh=tcU+d+66c89RPrE5Yb8McFDq6KZnOf2wcySz0B2cMdM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=wHhN5771bP3cqkECTpaei8DSIIm53Kt4/iPJT/b37n3JflO3V0H9EIbnNSn9C9i8M
	 SCPYaL3Wc+t5htN+NRFwQrwKkRRFo1wQD8Gm5nNz4C24iSVvXKxFDqqVGP65+zVg1G
	 nHaPjQyefSaGDRcQV8eXLZF/rSa9E0V+BOBsl6I0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgFQPzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 11:55:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbgFQPzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 11:55:45 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0AD1214DB;
        Wed, 17 Jun 2020 15:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592409345;
        bh=tcU+d+66c89RPrE5Yb8McFDq6KZnOf2wcySz0B2cMdM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bIcNkACRNrMoRISVfJe/GkcTz83/4jJlz8vF3XM7Ijeidra8UbGOXnzHMvkHrULYS
         aT2cT9/UucUu0H7kFTX+bB+6E5Akpbpgrughnzqufg5zMKRNcm2ALjsQS9XHDOmHLn
         U2w4K0gG++Naxr1SQVGggtKiY1CGEcaKe6h0WGkA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D5A7F3522653; Wed, 17 Jun 2020 08:55:44 -0700 (PDT)
Date:   Wed, 17 Jun 2020 08:55:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] kcsan: Minor cleanups
Message-ID: <20200617155544.GA10347@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200616123625.188905-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616123625.188905-1-elver@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 02:36:21PM +0200, Marco Elver wrote:
> Minor KCSAN cleanups, none of which should affect functionality.

Hearing no objections, I have queued and pushed all four, thank you!

						Thanx, Paul

> Marco Elver (4):
>   kcsan: Silence -Wmissing-prototypes warning with W=1
>   kcsan: Rename test.c to selftest.c
>   kcsan: Remove existing special atomic rules
>   kcsan: Add jiffies test to test suite
> 
>  kernel/kcsan/Makefile               |  2 +-
>  kernel/kcsan/atomic.h               |  6 ++----
>  kernel/kcsan/core.c                 |  9 +++++++++
>  kernel/kcsan/kcsan-test.c           | 23 +++++++++++++++++++++++
>  kernel/kcsan/{test.c => selftest.c} |  0
>  5 files changed, 35 insertions(+), 5 deletions(-)
>  rename kernel/kcsan/{test.c => selftest.c} (100%)
> 
> -- 
> 2.27.0.290.gba653c62da-goog
> 
