Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A572EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8132B2073E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctl7VHZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgEORYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 13:24:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55478 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726234AbgEORYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 13:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589563460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g7UxpoSaYFlNgGerVC7wIAaJL2fcWcGLepQ9Q16ldlM=;
        b=ctl7VHZTGeaBIGL59LbXe1iPIf3aGMbxEA06A8GJ963GU4i5fm/Y0FEpJzL50SSVtZ29Qo
        b4f6As9fYize29cRiIjqglkPtuc20T35eJoAL/Yyru5yaFAdTiIq2xXJMtP+V1D8qzs7KM
        w9VAY7tJPJIzGpThkwefflgou9NncDI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-BwngXKV9NgCiUqjJj7MYUQ-1; Fri, 15 May 2020 13:24:16 -0400
X-MC-Unique: BwngXKV9NgCiUqjJj7MYUQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9015618FF679;
        Fri, 15 May 2020 17:24:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.140])
        by smtp.corp.redhat.com (Postfix) with SMTP id 19EA078868;
        Fri, 15 May 2020 17:24:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 15 May 2020 19:24:15 +0200 (CEST)
Date:   Fri, 15 May 2020 19:24:03 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Fox <afox@redhat.com>,
        Stephen Johnston <sjohnsto@redhat.com>,
        linux-kernel@vger.kernel.org,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] sched/cputime: make scale_stime() more precise
Message-ID: <20200515172403.GA30626@redhat.com>
References: <20190718131834.GA22211@redhat.com>
 <20200127122817.GA10957@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127122817.GA10957@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping...

Peter, could you comment?

On 01/27, Oleg Nesterov wrote:
>
> People report that utime and stime from /proc/<pid>/stat become very
> wrong when the numbers are big enough, especially if you watch these
> counters incrementally.
> 
> Say, if the monitored process runs 100 days 50/50 in user/kernel mode
> it looks as if it runs 20 minutes entirely in kernel mode, then 20
> minutes in user mode. See the test-case which tries to demonstrate this
> behaviour:
> 
> 	https://lore.kernel.org/lkml/20200124154215.GA14714@redhat.com/
> 
> The new implementation does the additional div64_u64_rem() but according
> to my naive measurements it is faster on x86_64, much faster if rtime/etc
> are big enough. See
> 
> 	https://lore.kernel.org/lkml/20200123130541.GA30620@redhat.com/
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  kernel/sched/cputime.c | 65 +++++++++++++++++++++++++-------------------------
>  1 file changed, 32 insertions(+), 33 deletions(-)
> 
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index d43318a..ae1ea09 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -528,42 +528,41 @@ void account_idle_ticks(unsigned long ticks)
>   */
>  static u64 scale_stime(u64 stime, u64 rtime, u64 total)
>  {
> -	u64 scaled;
> +	u64 res = 0, div, rem;
> +	int shift;
>  
> -	for (;;) {
> -		/* Make sure "rtime" is the bigger of stime/rtime */
> -		if (stime > rtime)
> -			swap(rtime, stime);
> -
> -		/* Make sure 'total' fits in 32 bits */
> -		if (total >> 32)
> -			goto drop_precision;
> -
> -		/* Does rtime (and thus stime) fit in 32 bits? */
> -		if (!(rtime >> 32))
> -			break;
> -
> -		/* Can we just balance rtime/stime rather than dropping bits? */
> -		if (stime >> 31)
> -			goto drop_precision;
> -
> -		/* We can grow stime and shrink rtime and try to make them both fit */
> -		stime <<= 1;
> -		rtime >>= 1;
> -		continue;
> -
> -drop_precision:
> -		/* We drop from rtime, it has more bits than stime */
> -		rtime >>= 1;
> -		total >>= 1;
> +	/* can stime * rtime overflow ? */
> +	if (ilog2(stime) + ilog2(rtime) > 62) {
> +		/*
> +		 * (rtime * stime) / total is equal to
> +		 *
> +		 *	(rtime / total) * stime +
> +		 *	(rtime % total) * stime / total
> +		 *
> +		 * if nothing overflows. Can the 1st multiplication
> +		 * overflow? Yes, but we do not care: this can only
> +		 * happen if the end result can't fit in u64 anyway.
> +		 *
> +		 * So the code below does
> +		 *
> +		 *	res = (rtime / total) * stime;
> +		 *	rtime = rtime % total;
> +		 */
> +		div = div64_u64_rem(rtime, total, &rem);
> +		res = div * stime;
> +		rtime = rem;
> +
> +		shift = ilog2(stime) + ilog2(rtime) - 62;
> +		if (shift > 0) {
> +			/* drop precision */
> +			rtime >>= shift;
> +			total >>= shift;
> +			if (!total)
> +				return res;
> +		}
>  	}
>  
> -	/*
> -	 * Make sure gcc understands that this is a 32x32->64 multiply,
> -	 * followed by a 64/32->64 divide.
> -	 */
> -	scaled = div_u64((u64) (u32) stime * (u64) (u32) rtime, (u32)total);
> -	return scaled;
> +	return res + div64_u64(stime * rtime, total);
>  }
>  
>  /*
> -- 
> 2.5.0
> 

