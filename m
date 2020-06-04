Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3A9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9471620663
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rh72YHVB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbgFDOSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 10:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbgFDOSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 10:18:40 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CFEC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 07:18:40 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ga6so1190358pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 07:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ri5FBTpEA9YkaHeCTU7jHRHoP9LrYKT9s+Qg6K61SSU=;
        b=rh72YHVBIfH9tw+L1kUlcM7Gq/mLJMS3+FLS011d4U4EHYjFhYed5pAMZOrrS35TDy
         ziqKm6a1hFMWKMKBv/TW1yJnTuWOg95Sphq/viB24eiJH22UNKtUOtuKIVErog1M5bJ/
         FzlAefLQwQsbyvajmM5QKNVZg/6Ju6bnVmJsJsgMJK0CjofaseMTQFZT1OTFCNYetQ2i
         WVzxbXQPDE91syM+ApsKN7hpEUvTcUCotpraQ8pwzCCsLrSl+rfAZ+4hMSFBn+SkBOwf
         OcZCkFkTJWjzzjLjppuVPL34sHWWK2nOoZDBWJyB+GdWUi5u8inTSN0vOC5ORhLzmZKj
         Tp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ri5FBTpEA9YkaHeCTU7jHRHoP9LrYKT9s+Qg6K61SSU=;
        b=j30/upJWiEKuX+OgX+v4m4ZUx85JXJcnijaUjWTGHt2oreTT/bDMe+03fPyhDf1bhI
         hLCj3TJsHTLMBgQal5I6XqAKoZnGa7Nomc0rG0PXwnkzIXt0S/Ezsi9+6mmJQ1LEQHEV
         dQJ+0hosTfdv7XpKt2SvRorS5gruyE8nhAjkYAz5qUGFabXe1dwII4vhDNZNjvuQ/Cur
         22yzg+RQEqqjXXc6LubQztxB/N/O8gPowOw/+arpPfuNFcNhv0rt1NukDGmCqL+4a29y
         148vNKudblZc1VWWLKWALC5qXMo0T6YtNXxwHIC9pFoHYic9cvKZhRlt48+7gyM3R/Kk
         Qj+w==
X-Gm-Message-State: AOAM5326oQNH7imhue1UJlznmdGmxu+ShR4qZ7T0I1XQLfJDIX9GVt/0
        F5nT9Gk0XesQQnFJCCVX0Ig=
X-Google-Smtp-Source: ABdhPJzferPw9hH2XobZ3S3MSlDPZ0jO/zKP9sOAwBUu6Fyd6er521sSuzRUualnimvicjNHVJY9Nw==
X-Received: by 2002:a17:902:a711:: with SMTP id w17mr5026271plq.173.1591280319828;
        Thu, 04 Jun 2020 07:18:39 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v22sm5165951pfu.172.2020.06.04.07.18.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jun 2020 07:18:38 -0700 (PDT)
Date:   Thu, 4 Jun 2020 07:18:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, frederic@kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, cai@lca.pw,
        mgorman@techsingularity.net
Subject: Re: [RFC][PATCH 7/7] sched: Replace rq::wake_list
Message-ID: <20200604141837.GA179816@roeck-us.net>
References: <20200526161057.531933155@infradead.org>
 <20200526161908.129371594@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526161908.129371594@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 06:11:04PM +0200, Peter Zijlstra wrote:
> The recent commit: 90b5363acd47 ("sched: Clean up scheduler_ipi()")
> got smp_call_function_single_async() subtly wrong. Even though it will
> return -EBUSY when trying to re-use a csd, that condition is not
> atomic and still requires external serialization.
> 
> The change in ttwu_queue_remote() got this wrong.
> 
> While on first reading ttwu_queue_remote() has an atomic test-and-set
> that appears to serialize the use, the matching 'release' is not in
> the right place to actually guarantee this serialization.
> 
> The actual race is vs the sched_ttwu_pending() call in the idle loop;
> that can run the wakeup-list without consuming the CSD.
> 
> Instead of trying to chain the lists, merge them.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
...
> +	/*
> +	 * Assert the CSD_TYPE_TTWU layout is similar enough
> +	 * for task_struct to be on the @call_single_queue.
> +	 */
> +	BUILD_BUG_ON(offsetof(struct task_struct, wake_entry_type) - offsetof(struct task_struct, wake_entry) !=
> +		     offsetof(struct __call_single_data, flags) - offsetof(struct __call_single_data, llist));
> +

There is no guarantee in C that

	type1 a;
	type2 b;

in two different data structures means that offsetof(b) - offsetof(a)
is the same in both data structures unless attributes such as
__attribute__((__packed__)) are used.

As result, this does and will cause a variety of build errors depending
on the compiler version and compile flags.

Guenter
