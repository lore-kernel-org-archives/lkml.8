Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EEDC3524E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7C124656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582142895;
	bh=K/D5JbPk2+EBYp2gmQA0q9ditYqXaZ6u/jNNJaQQNeU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wL5yNyn/8S06rXwE0lekz9GtNmHJ1FqO3CBFNuofCk7hESRY7QS1dwajr8AIDZYau
	 y5wXzQfNAkWt3t6gyy0Mbs9iMp9RuPZKhc4p2/bHSohVaz+iDaYwKL3RDfiMZfhjOZ
	 cYKNJJqIlTkIs+SpIa7+CCqFvVG6N9NOXK3w2pw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgBSUIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 15:08:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:46344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgBSUIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 15:08:13 -0500
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 842F32176D;
        Wed, 19 Feb 2020 20:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582142891;
        bh=K/D5JbPk2+EBYp2gmQA0q9ditYqXaZ6u/jNNJaQQNeU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U4t0+1H9+T91595fwF5FJlrfN5hAP7b2OvyDrCSy3zwLJrvS07mTsYuEM5DXHnFGp
         4qFSz1jxRax7qvwJ19FfAf+jYHr05omtkY3xWKa9Bat7iEgGBVKKyg8tHE6D0KUotm
         JV5ctKrnTkl+82JgBHttCq5MEna+P72IO2uvUTbE=
Date:   Wed, 19 Feb 2020 12:08:10 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        rientjes@google.com, mhocko@kernel.org
Subject: Re: [Patch v4] mm/vmscan.c: remove cpu online notification for now
Message-Id: <20200219120810.c7677fa58594f5423549f59d@linux-foundation.org>
In-Reply-To: <20200218224422.3407-1-richardw.yang@linux.intel.com>
References: <20200218224422.3407-1-richardw.yang@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 06:44:22 +0800 Wei Yang <richardw.yang@linux.intel.com> wrote:

> kswapd kernel thread starts either with a CPU affinity set to the full
> cpu mask of its target node or without any affinity at all if the node
> is CPUless. There is a cpu hotplug callback (kswapd_cpu_online) that
> implements an elaborate way to update this mask when a cpu is onlined.
> 
> It is not really clear whether there is any actual benefit from this
> scheme. Completely CPU-less NUMA nodes rarely gain a new CPU during
> runtime.

This is the case across all platforms, all architectures, all users for
the next N years?  I'm surprised that we know this with sufficient
confidence.  Can you explain how you came to make this assertion?

> Drop the code for that reason. If there is a real usecase then
> we can resurrect and simplify the code.
