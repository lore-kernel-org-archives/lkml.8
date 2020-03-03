Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1991C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E0D215A4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DRNJ/SUH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgCCKZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:25:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39952 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728473AbgCCKZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:25:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q7J+nBhg14BmG/EbY8GbHer+TYE4rVSJt7RYJveKf8w=; b=DRNJ/SUHqfIteD+NaC+70IinnB
        Ok6rOIrWIM10itbXIODi/yp9jIAtz55rO4Stnt9fRTGtFFEHoioAEcyn6aFUuaVkAwWYQ9txYWHa6
        /XXrIJ5hG7r5huN2V50fGaJERFs2YM+tj3kBjXUIZEwowzaFKMZVdseReHvXl5hj2Td/dgbOjbv2O
        Vvu6jsfpQ9tKO3AInmyy060aNZGorVXpv9p2UHqSNt5L6k+qQTYaB89rJOONY75a0y4NtoHhrs7CG
        fqsm4PXKYKWXQxrtYEn0TyzHFU5ESTOrKw9DLiD+1nuRyPyolVkIyUbSoeMGvy++V3Zp2ujNlTZ7n
        VueEJuZw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j94kA-0007qR-UR; Tue, 03 Mar 2020 10:25:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0E885304D2B;
        Tue,  3 Mar 2020 11:23:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1ADF3206E78F5; Tue,  3 Mar 2020 11:25:40 +0100 (CET)
Date:   Tue, 3 Mar 2020 11:25:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] threads: Update PID limit comment according to futex
 UAPI change
Message-ID: <20200303102540.GC2579@hirez.programming.kicks-ass.net>
References: <20200302112939.8068-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302112939.8068-1-jannh@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 12:29:39PM +0100, Jann Horn wrote:
> The futex UAPI changed back in commit 76b81e2b0e22 ("[PATCH] lightweight
> robust futexes updates 2"), which landed in v2.6.17: FUTEX_TID_MASK is now
> 0x3fffffff instead of 0x1fffffff. Update the corresponding comment in
> include/linux/threads.h.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  include/linux/threads.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/threads.h b/include/linux/threads.h
> index 3086dba525e20..18d5a74bcc3dd 100644
> --- a/include/linux/threads.h
> +++ b/include/linux/threads.h
> @@ -29,7 +29,7 @@
>  
>  /*
>   * A maximum of 4 million PIDs should be enough for a while.
> - * [NOTE: PID/TIDs are limited to 2^29 ~= 500+ million, see futex.h.]
> + * [NOTE: PID/TIDs are limited to 2^30 ~= 1 billion, see FUTEX_TID_MASK.]
>   */
>  #define PID_MAX_LIMIT (CONFIG_BASE_SMALL ? PAGE_SIZE * 8 : \
>  	(sizeof(long) > 4 ? 4 * 1024 * 1024 : PID_MAX_DEFAULT))

I just noticed another mention of this in Documentation/robust-futex-ABI.txt
There it states that bit-29 is reserved for future use.

Thomas, do we want to release that bit and update all this?
