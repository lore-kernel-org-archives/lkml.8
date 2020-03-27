Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E07C2D0E5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A0320838
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FaQGcAPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgC0Mzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 08:55:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51006 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgC0Mzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 08:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3krJFnyu0Fnst6HKu0gHupG+N5IE1NaAfdLwHong6SU=; b=FaQGcAPKbzBala4A1yGdy07K7t
        VMhTv5436EzLqroY5xvBvt6P46ifRCyGNx6eSrPzbidfhQcb87zVeWoF/X6AJFBoTo4k7gdbqezrz
        UMoppxecIzmqXOEbpBovIZaY4HREQZD01wYWPsEllcMutOMTwdUVS66Efw53BgSGEtQomSq1Ti8kV
        beQCkea8hPhGmHqiVJrL4T2aPCMH3fi7mAQQXFwWCsbHgi9QrlJywiUzKpPAW4vqTOlXUlphGfcxv
        zJ4+DhDLXVLnhoKvR92EwNf+k/1W85nNZM4iEJa4L5Um7Li+rq4mHoyo+yz5cAxENgxCyvW6Nhm3I
        3ZY1rCYQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHoW2-0003WI-Gg; Fri, 27 Mar 2020 12:55:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3FD48300478;
        Fri, 27 Mar 2020 13:55:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 290D4203B8785; Fri, 27 Mar 2020 13:55:10 +0100 (CET)
Date:   Fri, 27 Mar 2020 13:55:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/ftrace: Tidy create_trampoline()
Message-ID: <20200327125510.GN20730@hirez.programming.kicks-ass.net>
References: <20200304092105.11934-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304092105.11934-1-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 11:21:05AM +0200, Adrian Hunter wrote:
> create_trampoline() returns 2 values that the (only) caller simply
> assigns to ops members. Amend create_trampoline() to make the
> assignments instead, which simplifies the code.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
