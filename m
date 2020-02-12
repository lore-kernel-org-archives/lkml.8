Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B44C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C03B2465D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q5RYRX42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgBLVcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 16:32:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47356 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbgBLVcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 16:32:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=62yXb7kO6TJItSD02Iyixn2SKX2PdulFGZN/QvehXUg=; b=q5RYRX42TPN9Oi7y9IkQKuSF2E
        tbIRdTFpijBPubabgk+LuJXJ9H5ZsDP33NNlcytmEkzwDsVcQYylkc/knhRDRjk3OeDy2rYfL5kAC
        xxLJJGqB4RIIq1a76bGWkDNl5jWqy1+m9mB2W4oLzqSn2EnTJtIz80KRAkL29vC28i9sm/EwIbGAH
        1RLVwsLBvqjN1NmUZF61mcxs81ZgvaqgmSkaWBIexyL8JHIiik38QZZHYDwBeksPu9X1OR8qoAka4
        jfb1V4ZPWz8NkD67huGn/uuvnj2A1atOBkMmywi9kjW0h2F2NQmgxATQ7g3bG8teJ2A8YJ1Wb8Bk8
        rpRJbgPw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1zcp-0008Gk-Ci; Wed, 12 Feb 2020 21:32:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1E12D300679;
        Wed, 12 Feb 2020 22:30:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6C41920206D70; Wed, 12 Feb 2020 22:32:48 +0100 (CET)
Date:   Wed, 12 Feb 2020 22:32:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Prateek Sood <prsood@codeaurora.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuset: Make cpuset hotplug synchronous
Message-ID: <20200212213248.GE14897@hirez.programming.kicks-ass.net>
References: <1579878449-10164-1-git-send-email-prsood@codeaurora.org>
 <ee889f30-cb81-e0a8-6068-715ca3399fdd@codeaurora.org>
 <20200212211832.GC80993@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212211832.GC80993@mtj.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 04:18:32PM -0500, Tejun Heo wrote:
> On Sat, Feb 01, 2020 at 08:33:34AM +0530, Prateek Sood wrote:
> > Hi Tejun & Peter,
> > 
> > Could you please share your feedback on this patch for making
> > 
> > cpuset_hotplug_workfn synchronous.
> 
> Hey, IIRC, we went back forth with this several times. Unless there's
> a pressing reason to change, I'd rather leave it alone.

I think I have a similar patch in one of the many in-progress series I
keep around; IIRC it is the one where I add per-cpu support to
SCHED_DEADLINE. The hotplug accounting becomes easier if we do this.

Sadly this series is fairly low on the todo list atm though :/ I have no
problems keeping it around until such a time though.
