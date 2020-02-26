Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB5DC4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3AE20656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d5Ivp/Me"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgBZTO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 14:14:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46056 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbgBZTOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 14:14:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tKhMa5Sd27YXJPXDMYEL6vfvj6URvuGiqyYEnIj8ZSQ=; b=d5Ivp/MeR6FmmmzcmnsEZlJtvo
        Of99Za5ppM/mNfTTUgq+2JPcmxo9ZRLCoXJ9CMrotPzqhJZbK3RPEK1Fpzthc6HMweW0clIZKgok7
        3GE+FztDwZqH0WZPK4FBDu4KEyqont3D87Esr/LKefZox06SIyHat3uJ4CSC4KRgcSUIMLwH5t8nd
        NQRKX1YHryjnldNC9+WahQzkMN6+aJT/6HOyk0BzQDjfKhk+xohB9L2xXIhYZxlsJWBpTTl/MSeui
        9DHWLfDRsfWXdvTo0PmfDt6tX6AoDHm3fJ2axHoe/lqUoruwCfesCCyWEBIjhIZosAko+QL+CdJ0U
        +fy+VHpA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j728F-0007qG-FI; Wed, 26 Feb 2020 19:14:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6C9E0306056;
        Wed, 26 Feb 2020 20:12:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C17412B740B97; Wed, 26 Feb 2020 20:14:04 +0100 (CET)
Date:   Wed, 26 Feb 2020 20:14:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Luigi Rizzo <lrizzo@google.com>
Cc:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        naveen.n.rao@linux.ibm.com, ardb@kernel.org,
        Luigi Rizzo <rizzo@iet.unipi.it>,
        Paolo Abeni <pabeni@redhat.com>, giuseppe.lettieri@unipi.it,
        Jesper Dangaard Brouer <hawk@kernel.org>, mingo@redhat.com,
        acme@kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 0/2] kstats: kernel metric collector
Message-ID: <20200226191404.GD18400@hirez.programming.kicks-ass.net>
References: <20200226135027.34538-1-lrizzo@google.com>
 <87ftexz93y.fsf@toke.dk>
 <CAMOZA0Lzf2r7rFvgBEWpf-B=wXvyED2CxfzuO7qUA_qVsNtL7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMOZA0Lzf2r7rFvgBEWpf-B=wXvyED2CxfzuO7qUA_qVsNtL7g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 09:26:22AM -0800, Luigi Rizzo wrote:
> [this reply also addresses comments from Alexei and Peter]

I don't see where you address my comment; all you talk about is bpf.

I've never used bpf. Still I also don't see any actual value in you few
lines of code.
