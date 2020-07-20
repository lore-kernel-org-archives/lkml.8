Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8889C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6A2520684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W7lnT5Ry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388693AbgGTQUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388514AbgGTQUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:20:33 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD5CC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 09:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uC/tilAEaHjArnaAm1aUzbWB0T6K1yC5bOJBtaxkp14=; b=W7lnT5RyfkfkI3q/mMftN3ZL3l
        gFNEwDpe9DMFL1phWV6FT62H2N0ShCnxXYBb46Hwmv4fUDuywjvoaC2JQ5nEhFf727nMIY+YGxFyY
        UkCQwpwpgpsafutV83CLTkk9HX+p7uyLgtbUDq1PYdxIgwIRn3LiY4ICjtIg/ErnOedfdtug9CpFR
        U3xsuHOXzc7WbxMZ7r/qrOPg9nR+8I7ZYQwncujiEyDxGLwdZt3oxXAWiZkSAgU3p+L+VryhSNS/R
        JMBnr3aTQiVjqBVggs3HOe2Sj1Q98+ieFvw4a20RuZxcDmFIGbeFIYwIf2A8xwUMDGkN060+dACe2
        HZSak66w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxYWg-0002Yz-Md; Mon, 20 Jul 2020 16:20:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E03C7307B8F;
        Mon, 20 Jul 2020 18:20:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C8C5F23426BB1; Mon, 20 Jul 2020 18:20:24 +0200 (CEST)
Date:   Mon, 20 Jul 2020 18:20:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH V6 03/14] perf/x86/intel: Introduce the fourth fixed
 counter
Message-ID: <20200720162024.GT10769@hirez.programming.kicks-ass.net>
References: <20200717140554.22863-1-kan.liang@linux.intel.com>
 <20200717140554.22863-4-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717140554.22863-4-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 07:05:43AM -0700, kan.liang@linux.intel.com wrote:
>  /*
> + * There is no event-code assigned to the fixed-mode PMCs.
> + *
> + * For a fixed-mode PMC, which has an equivalent event on a general-purpose
> + * PMC, the event-code of the equivalent event is used for the fixed-mode PMC,
> + * e.g., Instr_Retired.Any and CPU_CLK_Unhalted.Core.
> + *
> + * For a fixed-mode PMC, which doesn't have an equivalent event, a
> + * pseudo-encoding is used, e.g., CPU_CLK_Unhalted.Ref and TOPDOWN.SLOTS.
> + * The pseudo event-code for a fixed-mode PMC must be 0x00.
> + * The pseudo umask-code is 0x0X. The X indicates the index of the fixed
> + * counter.

Isn't it X+1 ? Such that 0x0000 is an invalid event? After all, the
pseudo event for Fixed2 is 0x0300.

> + *
> + * The counts are available in separate MSRs:
>   */
