Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933FCC18E00
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5B124671
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582140420;
	bh=Yc4u2FNt1IF2IbHtsIBwT/EjGq6IDcKxgr96tmofLT0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=IDqCFIJHoYWs+UEfsEs6CVrEuh8RnwZmE45d0RVmzPiBie0GzPCZft1MltyTtp3iO
	 e4M3WPX0P9xup81xjM5gaGCSkTZaew6RbR+5PUmAxkaptmRokT8dg8T0n2tWx7oFcN
	 F731hN773v+EfAkC/2tDkEToMAZar/7GPuuXG6ZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgBST0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:26:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:46558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbgBST0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 14:26:54 -0500
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09525208E4;
        Wed, 19 Feb 2020 19:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582140414;
        bh=Yc4u2FNt1IF2IbHtsIBwT/EjGq6IDcKxgr96tmofLT0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uuO8ONawyjT+YQsnSh9q7TNz5MXsxAChG8Jkavgb1IBkTn6/nlCiavADJp69yj4uH
         Q+hOztkuyRvzY7JZQcWs5x2xWSd9ckOLENn2Kme+eE4juIf23dHrA3g1XPIBd4Asjw
         WSHuBCjriM/qQ5bLTjugv90KBVY6t7QA5HNLpseA=
Date:   Wed, 19 Feb 2020 11:26:53 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Stop kswapd early when nothing's waiting for it to
 free pages
Message-Id: <20200219112653.116de9db314dade1f6086696@linux-foundation.org>
In-Reply-To: <20200219182522.1960-1-sultan@kerneltoast.com>
References: <20200219182522.1960-1-sultan@kerneltoast.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 10:25:22 -0800 Sultan Alsawaf <sultan@kerneltoast.com> wrote:

> Keeping kswapd running when all the failed allocations that invoked it
> are satisfied incurs a high overhead due to unnecessary page eviction
> and writeback, as well as spurious VM pressure events to various
> registered shrinkers. When kswapd doesn't need to work to make an
> allocation succeed anymore, stop it prematurely to save resources.

Seems sensible.

Please fully describe the userspace-visible runtime effects of this
change?

