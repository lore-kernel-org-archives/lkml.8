Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D88C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 22:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50B820716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 22:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="L0wTNSd/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgA2WTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 17:19:11 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38665 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgA2WTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 17:19:11 -0500
Received: by mail-pj1-f65.google.com with SMTP id j17so432738pjz.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 14:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gm6baxWqlVJBYjrTuitTNaBr1MkKZDLEKcjPTz92Yuw=;
        b=L0wTNSd/ba+/Jir8Y8zAOCd7bzmaRvQDYfPfI8/l5zQ/mCR76l00gBEDLWTaLHWYed
         oJM+kdxg6sizMD60HCiFYaoJapHuqErPhDUoNTBNc3XtG4v/jLGEqonFFwajIcmS5S8H
         rn1JDRJEIgVmwOZqhTfq8qfszi6iq44EBMiW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gm6baxWqlVJBYjrTuitTNaBr1MkKZDLEKcjPTz92Yuw=;
        b=BKqptmQz1zlhbDEnUZo2Yt6bZLE+m1dBBmUKM01FpFSsCNBByC3SaZI2tnoBAtQaHu
         sI9X9DZmcmrvd/eBsI/JSPuikgE/a4Kjg2aZVPfGYdBXI+S7oj9rO6pYzGqQPRKlz9ri
         kHTPlueLzJ7Ce6xaN2u+/AL6A97iv1q4q9xCGbzwrDJ73RDwH1IN2kIYfBXUFvdnnTfr
         +WaKaKsmYi7IS8QLnditClNCCdonL0381nk+vICOIAeixBCYEJJLiaFOSFy9L3jKVkjH
         UlzFXZm1uJFEqyFfqOksm+fXclbOfrEpuLWbPy6k+7rsLgc4P3E67HMsBRfnqzCzppej
         zXxw==
X-Gm-Message-State: APjAAAUNxQ/YlU/twU0rlam7yGjqT9SJWfU+7kccDf9YB6jd80CLYIQN
        7qeM6dQ6xtmBraAQiaopiWs2jQ==
X-Google-Smtp-Source: APXvYqyVTFJ4QGYL+Go0ew04cMV55S2wewIfTCwD5Ah3U4M1HkXDKHhZSGpRe9nEJkt5UHJBefNCPA==
X-Received: by 2002:a17:90a:3243:: with SMTP id k61mr2157855pjb.43.1580336350700;
        Wed, 29 Jan 2020 14:19:10 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id gx2sm3676730pjb.18.2020.01.29.14.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 14:19:10 -0800 (PST)
Date:   Wed, 29 Jan 2020 17:19:09 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Amol Grover <frextrite@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 2/2] events: callchain: Use RCU API to access RCU pointer
Message-ID: <20200129221909.GA74354@google.com>
References: <20200129160813.14263-1-frextrite@gmail.com>
 <20200129160813.14263-2-frextrite@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129160813.14263-2-frextrite@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 09:38:13PM +0530, Amol Grover wrote:
> callchain_cpus_entries is annotated as an RCU pointer.
> Hence rcu_dereference_protected or similar RCU API is
> required to dereference the pointer.
> 
> This fixes the following sparse warning
> kernel/events/callchain.c:65:17: warning: incorrect type in assignment
> 
> Signed-off-by: Amol Grover <frextrite@gmail.com>
> ---
>  kernel/events/callchain.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> index f91e1f41d25d..a672d02a1b3a 100644
> --- a/kernel/events/callchain.c
> +++ b/kernel/events/callchain.c
> @@ -62,7 +62,8 @@ static void release_callchain_buffers(void)
>  {
>  	struct callchain_cpus_entries *entries;
>  
> -	entries = callchain_cpus_entries;
> +	entries = rcu_dereference_protected(callchain_cpus_entries,
> +					    lockdep_is_held(&callchain_mutex));


Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


>  	RCU_INIT_POINTER(callchain_cpus_entries, NULL);
>  	call_rcu(&entries->rcu_head, release_callchain_buffers_rcu);
>  }
> -- 
> 2.24.1
> 
