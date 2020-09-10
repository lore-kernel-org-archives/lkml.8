Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83169C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CBC621D90
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="niIsVsui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgIJVDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731137AbgIJOiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:38:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07990C061757
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 07:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=339zgSxlL+lIOBUMV+vGyrR7HJ2OP+EpscMBIaERCsY=; b=niIsVsuiYZMuYDebocCko43GH3
        LC64ZGy+0bUGrsPvvsP3UEJNNEXjW/tbm/G9dCIXBWLdrDvOkvIVLbDltd/BPSRb1cNi/OKMYwmm7
        c/KTpVxtAaAnna5TBi4EngQofZQqeSgoEPKLeEbrkoPo5tTDn96HGk0sxeNNfZhXwX6tre49kryBz
        7M6YInC/k0vrSEdVlX872vrkIaJdWe7lFlwL/W40CGs8jGfUCuQfuGo+rD2odj5sSt+T+Yo5G9m2b
        QcN1o2X9qP0FA+RY1urVRC9JIJMzCNYFSlRUM88u+9ongnLQQfJ06/7mRhG9J9yKFvb5xyqyVJrQv
        zVaH+HsA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGNhq-00067N-5M; Thu, 10 Sep 2020 14:37:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 44FE4305C10;
        Thu, 10 Sep 2020 16:37:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2E03824C0EAEA; Thu, 10 Sep 2020 16:37:45 +0200 (CEST)
Date:   Thu, 10 Sep 2020 16:37:45 +0200
From:   peterz@infradead.org
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, anna-maria@linutronix.de,
        vbabka@suse.cz, mgorman@techsingularity.net, mhocko@suse.com,
        linux-mm@kvack.org
Subject: Re: kcompactd hotplug fail
Message-ID: <20200910143745.GE35926@hirez.programming.kicks-ass.net>
References: <20200910141006.GA1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910141006.GA1362448@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 04:10:06PM +0200, peterz@infradead.org wrote:
> Hi,
> 
> While playing with hotplug, I ran into the below:

Ah, it could be I wrecked my kernel bad... :-(

I'll let you know if I can reproduce this on a pristine kernel.
