Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2480CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE3E2207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I9jCiD32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731253AbgFSIPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 04:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730651AbgFSIOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 04:14:00 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C4CC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 01:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Zra1TRLfT2HgyHORAMYB+NVY7zN0RlMSIw5efiMlxrg=; b=I9jCiD32gNtOfwPNbkhd9ZPhkN
        xJb4rpXl1BnsGI8IDo8u9mQC+v4NZVisWUUWvlc/bK+t0PsY5zTRSQHxlxzXP61DxDpvB8j6O5umd
        bHAPSWSjTf0oJMu6fgvrlAV/vE9Pqu5rXA5Jq8ihrjHGEHi/YezkbxrygmeXD0FS7fbMrhSE3abPY
        jr5EE7hUmaTT5EYx6DmbdrSIvJ0NxZdFGtyx1C1lSvTreaZX/B/P48/qEUputYF+K3N4peesJnhwr
        +M1OCpa3mxeeobZd439iQm75s6OFFwxATn5ZgY3zmvx1mjEeBHCsXJlE/GnofLvJrcTnGd9cq4pi/
        4Raqq0iw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmC9b-0002Rj-FI; Fri, 19 Jun 2020 08:13:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C5701302753;
        Fri, 19 Jun 2020 10:13:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B1B01203B7CA1; Fri, 19 Jun 2020 10:13:36 +0200 (CEST)
Date:   Fri, 19 Jun 2020 10:13:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Song Liu <songliubraving@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Tejun Heo <tj@kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Francis Ricci <fjricci@fb.com>
Subject: Re: WARNING with LBR + precise_ip=2 + bpf_get_stackid()
Message-ID: <20200619081336.GQ576905@hirez.programming.kicks-ass.net>
References: <ED7B9430-6489-4260-B3C5-9CFA2E3AA87A@fb.com>
 <20200618223555.GB793265@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618223555.GB793265@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 03:35:55PM -0700, Andi Kleen wrote:
> > We noticed that this only happens with precise_ip >= 2. This is caused by 
> > setup_pebs_fixed_sample_data() using pens->real_ip:
> > 
> > 	set_linear_ip(regs, pebs->real_ip);
> 
> With precise_ip == 1 the IP will be one instruction behind.
> That's the only difference to 2 or 3.
> 
> So something about the actual instruction confuses the unwinder.

It's trying to do an unwind with the PEBS IP (or worse the whole PEBS
regset), which doesn't match the interrupt IP or the stack layout at
that time. Of course it doesn't work.
