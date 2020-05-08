Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05957C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 20:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9D3821582
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 20:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="BzwRTp8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgEHU7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 16:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgEHU7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 16:59:09 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3326C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 13:59:08 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c64so3201279qkf.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 13:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qinORr0SG7+11njGJ/ss7smA7LMvIKvcYCz/jRR8lPQ=;
        b=BzwRTp8/rzv8F0T2+rEdndgXdruIJ5jfa5qOyBo5ITWnod+C9DkmRjeFJU9yNgG1Ri
         PV2cd2sDwWDHt1oWL19KugIzj0H7DF4DI7a4CMnMPaesS7XTDfSQ8ddaSlwU/u/S3/cM
         zqIjNQ+q4kWOmOQ4oxSj+Gn7dSHh9eC2ZAmxYYQLWo5USDX+TWqKbLAFN/G/0YOh0lBF
         9KRUCD1w7DryfpcJR/AvHbdDpq+rYxRNDg20EIfHb4YiPX2wPSUMV9LLL2H5p2mfnxBF
         Hzr4vJuWcu5B1D/oBBu+ZQ5BBft1aWtC4GF+U2g3M6SuvMm9g0sAq87WHErHRbJ008wU
         SshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qinORr0SG7+11njGJ/ss7smA7LMvIKvcYCz/jRR8lPQ=;
        b=pgdaTVsh1qxoZJuMb5MBCER3NEIATGmdkLQbOQdU/1JX88OX3yHp+t+tcDf0TQz6dc
         IR6yYHt8ZnTB3Sre1AyciJkwm+TYImng6U7WRmOotPo5mw6EL/SiNkC/F5yNnRH38VoJ
         Q2QzyenJ4fYTdrniu9hwe+00G9I36DSf0WXqtCXSEPHndDDFgEvyGe4/n4AkozKQnVR7
         Jguxj4uuurWXlLsOG8OYsWmXOMa7VUvZCX3tBpXMbWcWIyDTOwCioj6HvoTu4JUtd5tE
         dOa2gQlkIQzY2VB+qXIDjk4JpPPcpwRLjupHrCmnwhEPApwbwa0zzMH2Kwfew0Ivbpnj
         mtMQ==
X-Gm-Message-State: AGi0PuZZzPaKTNBHrMFK6Ydf5DDEoNidEEsl3GqtscStycbIFwp7s7VR
        /e6PsQh9Z23UDR/Vu5MSRzK+eQ==
X-Google-Smtp-Source: APiQypIKl3lbcuMPL2YuKLhovD4LMRHKkU6ZYkoYYmNPSSaeLoyJY6sk31pUFQISZVOJjMx/wi3ZMw==
X-Received: by 2002:a05:620a:13a7:: with SMTP id m7mr2699887qki.498.1588971547831;
        Fri, 08 May 2020 13:59:07 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 206sm2058974qki.48.2020.05.08.13.59.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2020 13:59:07 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH -next v2] locking/osq_lock: annotate a data race in
 osq_lock
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <1581429255-12542-1-git-send-email-cai@lca.pw>
Date:   Fri, 8 May 2020 16:59:05 -0400
Cc:     Will Deacon <will@kernel.org>, Elver Marco <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Transfer-Encoding: 7bit
Message-Id: <2C8BF141-5384-475F-B713-6D473557C65C@lca.pw>
References: <1581429255-12542-1-git-send-email-cai@lca.pw>
To:     "Paul E. McKenney" <paulmck@kernel.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 11, 2020, at 8:54 AM, Qian Cai <cai@lca.pw> wrote:
> 
> prev->next could be accessed concurrently as noticed by KCSAN,
> 
> write (marked) to 0xffff9d3370dbbe40 of 8 bytes by task 3294 on cpu 107:
>  osq_lock+0x25f/0x350
>  osq_wait_next at kernel/locking/osq_lock.c:79
>  (inlined by) osq_lock at kernel/locking/osq_lock.c:185
>  rwsem_optimistic_spin
>  <snip>
> 
> read to 0xffff9d3370dbbe40 of 8 bytes by task 3398 on cpu 100:
>  osq_lock+0x196/0x350
>  osq_lock at kernel/locking/osq_lock.c:157
>  rwsem_optimistic_spin
>  <snip>
> 
> Since the write only stores NULL to prev->next and the read tests if
> prev->next equals to this_cpu_ptr(&osq_node). Even if the value is
> shattered, the code is still working correctly. Thus, mark it as an
> intentional data race using the data_race() macro.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Hmm, this patch has been dropped from linux-next from some reasons.

Paul, can you pick this up along with KCSAN fixes?

https://lore.kernel.org/lkml/1581429255-12542-1-git-send-email-cai@lca.pw/

> ---
> 
> v2: insert some code comments.
> 
> kernel/locking/osq_lock.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> index 1f7734949ac8..f733bcd99e8a 100644
> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -154,7 +154,11 @@ bool osq_lock(struct optimistic_spin_queue *lock)
> 	 */
> 
> 	for (;;) {
> -		if (prev->next == node &&
> +		/*
> +		 * cpu_relax() below implies a compiler barrier which would
> +		 * prevent this comparison being optimized away.
> +		 */
> +		if (data_race(prev->next == node) &&
> 		    cmpxchg(&prev->next, node, NULL) == node)
> 			break;
> 
> -- 
> 1.8.3.1
> 

