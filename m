Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF12BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AD1920838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pDEb3yPu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgG3QvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 12:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG3QvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 12:51:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF5CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 09:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jjMQpe0L8t4QpEiDPYSL8pv3IRGlX1u4V9z2z6xKhaQ=; b=pDEb3yPu/WnixlZpy/xq/5ABR9
        GhnCQiqVptbSvNSY+e2MK8gmmxvGsGdxH/tjjAs95I/KGHZ0JjlTWjihv5GZ+nD83zmeXWCF+WgDg
        OX4Ax68N1g4ilczFZvCof04kQEp48pznwgKmVVgGrcYqZikTGha28lmL6eiqr2bLG/iIuu7ydCIPU
        HVre6mPduQtds7xIjZkc0fUhRJftmwjrP7ffzrpZC6KdoVTSxCcKF60qSp7G/G2Cc0OTwBUoKDCj6
        0clvCnJHeJCgoD+ZpytpMU+0r2tfUEU+6e414rw88oTPLoABlNRYWvVXkkjqgelKg3I3j49QGKtgp
        K8CUzfRw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1Blk-0003pn-Ig; Thu, 30 Jul 2020 16:51:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0743230066E;
        Thu, 30 Jul 2020 18:50:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D51CA203DB3A6; Thu, 30 Jul 2020 18:50:57 +0200 (CEST)
Date:   Thu, 30 Jul 2020 18:50:57 +0200
From:   peterz@infradead.org
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH] perf/x86: Reset the counter to prevent the leak for a
 RDPMC task
Message-ID: <20200730165057.GC2678@hirez.programming.kicks-ass.net>
References: <20200730123815.18518-1-kan.liang@linux.intel.com>
 <20200730125817.GL2655@hirez.programming.kicks-ass.net>
 <cd65635b-d226-3089-cb4a-8f60ae408db5@linux.intel.com>
 <20200730164425.GO2655@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730164425.GO2655@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 06:44:26PM +0200, peterz@infradead.org wrote:
> Arguably we should have perf_mmap_open() check if 'event->hw.target ==
> current', because without that RDPMC is still pointless.

event->hw.target->mm == current->mm, I suppose, otherwise accounting
goes wobbly real fast.
