Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9592C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF8520863
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T0UYuvCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgCBNEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:04:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38890 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgCBNEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 08:04:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h7Dlk8HTPTSVAH8l+fXGmBYGiCphbtgSfwxH7p35WlE=; b=T0UYuvCsXe+47/Zj+UHMbQjXgv
        1TqJL1MkEsVpu0U9tI6nQDe8t9UGE2oz0dNEGaTRiszh5QO1hBDKoADwNMyi8LqHDyLKd0+PHAKtq
        9tNFpZVlCLkpgQ9Sv/+rxEEPAq7EbTK5ic8S+PXJ8qiXyb+oN0SYvJ8cKBIybsL94mbTC66Cffxsg
        i8PXW2FAbLHZX3waC79V8zK3hGBUYJW0ns0thoWLuA1DLHOjHWg60IsnLSBKwOuZtWZ3jyIPVXgbp
        biDay5U3p673YDbaXYR4qCluefMeBKiX//ejNPv8t0d0PsMuZQeDqcZNlodwJYYJBxZvUTf/X7sjH
        9balArFw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8kkL-0005pQ-Eb; Mon, 02 Mar 2020 13:04:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8F0733012C3;
        Mon,  2 Mar 2020 14:02:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 40F3D20CB1522; Mon,  2 Mar 2020 14:04:31 +0100 (CET)
Date:   Mon, 2 Mar 2020 14:04:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] perf: Replace zero-length array with
 flexible-array member
Message-ID: <20200302130431.GA2562@hirez.programming.kicks-ass.net>
References: <20200302124832.GA7504@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302124832.GA7504@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 06:48:32AM -0600, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 

> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 397cfd65b3fe..d71023c46058 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -453,7 +453,7 @@ struct perf_event_query_bpf {
>  	/*
>  	 * User provided buffer to store program ids
>  	 */
> -	__u32	ids[0];
> +	__u32	ids[];
>  };
>  
>  /*

Just to be absolutely sure; there is no ABI difference (or any actual
difference in generated code), right?
