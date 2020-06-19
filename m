Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A842C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3713420885
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1MoH9bQp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbgFSI31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 04:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731341AbgFSI3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 04:29:24 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2078EC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 01:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dGMZctFRJ8WPOzkGW71dhdTqXlz3zNcIlLghIiekP7E=; b=1MoH9bQpxacdvznBKLcBcbWAXR
        z1ba1zRxYFeapTkj26KUvCUA7qo0nYhWH/Nv9FBUHBGohAg4HQc7TSs3IPdj7T3scmKybVcjDxF6e
        nf1cnSAUozZZD8oAt89VAOnb4e+e3gw3hY/J1UdYTLSq4XR4qkdy4wpmPThBDjzy25DzAw1xxMZkN
        beimukOCQkWQNK/z666cpwHQA9Ga4UzGE6ZZtBTyukYNrWGlEzOQxdYnMEQZ7FjGPnskvMMHAr8yl
        oq8bA3RWCfYg1MZ4jrt9vgVYAJOTTAp0iuj1Oe0mbHBIhfdTbZKWftk+xzksGbBDY/dMu1qK29HPU
        pNm1vthg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmCOV-0002lp-LB; Fri, 19 Jun 2020 08:29:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2C36F3028C8;
        Fri, 19 Jun 2020 10:29:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 104C4203B7CA2; Fri, 19 Jun 2020 10:29:02 +0200 (CEST)
Date:   Fri, 19 Jun 2020 10:29:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Michel Lespinasse <walken@google.com>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jonathan Adams <jwadams@google.com>,
        David Rientjes <rientjes@google.com>,
        Ying Han <yinghan@google.com>
Subject: Re: [RFC PATCH v3 1/1] mmap_lock: add tracepoints around mmap_lock
 acquisition
Message-ID: <20200619082902.GR576905@hirez.programming.kicks-ass.net>
References: <20200618222225.102337-1-axelrasmussen@google.com>
 <20200618222225.102337-2-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618222225.102337-2-axelrasmussen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 03:22:25PM -0700, Axel Rasmussen wrote:

> 
>  include/linux/lockdep.h          |  47 ++++++
>  include/linux/mmap_lock.h        |  27 ++-
>  include/linux/rwsem.h            |  12 ++
>  include/trace/events/mmap_lock.h |  76 +++++++++
>  kernel/locking/rwsem.c           |  64 +++++++
>  mm/Kconfig                       |  19 +++
>  mm/Makefile                      |   1 +
>  mm/mmap_lock.c                   | 281 +++++++++++++++++++++++++++++++
>  8 files changed, 526 insertions(+), 1 deletion(-)
>  create mode 100644 include/trace/events/mmap_lock.h
>  create mode 100644 mm/mmap_lock.c

This should have been at least a hand-full of patches. Most definitely
not a single patch.

