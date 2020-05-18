Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1E5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE25F2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T+jd73SG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgERJZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 05:25:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33106 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgERJZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 05:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AsG25wGsLo5dva63MFW7ZBhcsdfBRHY+JLf9PmDQZPU=; b=T+jd73SGAnN/iUVYvQhlFjUREr
        gU7clEBE7FwvQwYJv+ptRhy1MxwWC+6dGethKvAPM9K+e7aSyzxN6f5QuFhRKhp8kBacyfB8cZ0as
        nut9xtAA3UoV+DhX/7q+x+k1ETWwbtYtEw3C2fN/Iu1EjIyCOKQ15WQI2Zz5XnBYpQt70P0ELh7A0
        p300PEQOHHQJWBINYAN26qJ0kSn1kiXWVxRdamC3E7asrKXlTzKWGgJz8qLYcC+xSMCWvqbHJKYto
        tNS0dJfjpHvswvwkDqhg+nJKTpeOTGYad2j3ljfINB5vz9Izt8G5QD1TNymqNbcquq5sNr2GcM9iq
        0mzhGCrA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jabzU-0005B2-28; Mon, 18 May 2020 09:23:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D409D3011E8;
        Mon, 18 May 2020 11:23:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 730872B3CFEE6; Mon, 18 May 2020 11:23:18 +0200 (CEST)
Date:   Mon, 18 May 2020 11:23:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, mingo@elte.hu, irogers@google.com,
        kim.phillips@amd.com, jolsa@redhat.com
Subject: Re: [PATCH 2/3] perf/x86/rapl: refactor code for Intel/AMD sharing
Message-ID: <20200518092318.GA277222@hirez.programming.kicks-ass.net>
References: <20200515215733.20647-1-eranian@google.com>
 <20200515215733.20647-3-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515215733.20647-3-eranian@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 02:57:32PM -0700, Stephane Eranian wrote:
> This patch modifies the rapl_model struct to include architecture specific
> knowledge to Intel specific structure, and in particular the MSR for
> POWER_UNIT and the rapl_msrs array.
> 
> No functional changes.
> 
> Signed-off-by: Stephane Eranian <eranian@google.com>
> ---
>  arch/x86/events/rapl.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index ece043fb7b494..e98f627a13fa8 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -131,7 +131,9 @@ struct rapl_pmus {
>  };
>  
>  struct rapl_model {
> +	struct perf_msr *rapl_msrs;
>  	unsigned long	events;
> +	int		msr_power_unit;

MSR addresses go negative these days?
