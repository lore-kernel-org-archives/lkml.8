Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E45EC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 23:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6AAE2071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 23:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UIlxYZvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgAXX0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 18:26:55 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48494 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729236AbgAXX0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 18:26:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/KWIys5Er9MsfBx37atukpmP50mnDEiIhVNZ2UJB108=; b=UIlxYZvdhkJxP35S73XaGgdjv
        /xzcLDV7acMj5fr8Z728D6rnxOhrU4/zFxlgiDpbTW5DTN5dsBc5OeU9JpbBm+3J25lUKEm2z4WhQ
        WoUKjER6Mw1ahJv2iAeUsvt7a5c3IrlALR0Lp7BcRGdx+XRwQpGX7w9D7RYn5WPUX7BQQdmtUGED9
        9S0zDHCSo1SC4TXDbuhzE1/IXiHJZNAbAM7b7kDIcpLxyQTCRJ1LiWTOA1YrLBLCGGEqpO3a4zLZG
        tkU3a4Edy8TIV9gcU0wp9NvRHFIGnZQMbaQVCQjrnE1sE6K05WILUO8d27nBVpoNziWcsgTuU4g+7
        8DpIKC0Eg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iv8Lc-0006BY-25; Fri, 24 Jan 2020 23:26:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E347E302526;
        Sat, 25 Jan 2020 00:24:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A0BAC20A1561B; Sat, 25 Jan 2020 00:26:40 +0100 (CET)
Date:   Sat, 25 Jan 2020 00:26:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v3] perf/core: fix mlock accounting in perf_mmap()
Message-ID: <20200124232640.GC14914@hirez.programming.kicks-ass.net>
References: <20200123181146.2238074-1-songliubraving@fb.com>
 <87zhed9pek.fsf@ashishki-desk.ger.corp.intel.com>
 <0E502E71-B1A8-493B-BD9F-24F15BEDA1D6@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E502E71-B1A8-493B-BD9F-24F15BEDA1D6@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 09:28:26PM +0000, Song Liu wrote:
> Thanks Alex!
> 
> > On Jan 24, 2020, at 1:25 AM, Alexander Shishkin <alexander.shishkin@linux.intel.com> wrote:
> > 
> > Song Liu <songliubraving@fb.com> writes:
> > 
> >> Eecreasing sysctl_perf_event_mlock between two consecutive perf_mmap()s of
> > 
> > Typo: "Decreasing".
> 
> Peter, could you please fix this typo when you apply the patch? I guess
> it is not necessary to spam the list with a v4 just for this typo. 

Done!
