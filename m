Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63111C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31E5720823
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1tqwKHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbgEUULj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgEUULj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:11:39 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2AFC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:11:38 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i15so7877001wrx.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QFxwWfYfR7AXwkOuQmpP8qD3BKX+mFa8KRpJpToZPAM=;
        b=L1tqwKHOnWwU9uw5Skd0z/JKmfrYTSNhCdCHYLwUBQ/MYyltsKOYC6mWbqkxBz0FgG
         4txAUA/ovqhX9mOo82XEFhPzpWnDekaZkIL4ytXZjhFarl3mgq4BNHMNVz6ujRWTKde8
         PpLiZw2YDayRyJX8Cf166rKSAW/CaLFEsC+t5RmbSNX/5nqCtPwa/Z5HxN6ZRSFL//Va
         R4NjUlZSCMMyUdLl/IBV75EjSE3O8kAb0qypF4yP2930PebF36zfwiV9rtTm1wCCUuHc
         8AzPLpF1qjpoEwby1A9jtb992Yj4akRGmNpGt70wbJxqjfsSqjyeYPhV/z1Hpk6DryWm
         ruLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QFxwWfYfR7AXwkOuQmpP8qD3BKX+mFa8KRpJpToZPAM=;
        b=ItE2KKRd+nIb3GlbBN2+VKBnDUEYzv1OWhv1bJ/0bkVlWT50O0B8o42yR7aQxCW8mP
         c4gJ+OG36K1ej9M29yd3905qhb1aBixOVbcNQPtHgwUfxSd1ExljKXxJrYRl92mGj1Kz
         3+zj3x5ylteh1LvaEtdzHe1ljt1zIq38E7poA8CDJSc1b6Gb186Wq0PPqZrtEvyZdbJ9
         VPbJS1GU69aI1T77LrjrGO6x7PkCYmy8DZ9ozznHDQpzNnSLrlPmLLjU8L0UdH/X3Rxo
         J+zHtyVQLm5FuQbHAWOv86tuhwJRKl12gu9UlLuZc0TRTVAZjsH0wsKMmmCOlnnnsTPI
         hGug==
X-Gm-Message-State: AOAM530Rw0GZcpLb9VnHD/OUe8xVLjfAAPsNXEutQVzG3HZQk8+mvOJM
        l0LjbpG4KoOp3E8zcKeJHHg=
X-Google-Smtp-Source: ABdhPJyhdBJWDM7yFPDZlpCXpJKvIDK5evrWvW1htRelvT9eJ3A+QKRrcmrwYoXUkl9dcO5hPf9pSw==
X-Received: by 2002:adf:ec8c:: with SMTP id z12mr241357wrn.65.1590091897473;
        Thu, 21 May 2020 13:11:37 -0700 (PDT)
Received: from ?IPv6:2a00:23c6:9e09:2900:4423:7d1b:b637:c183? ([2a00:23c6:9e09:2900:4423:7d1b:b637:c183])
        by smtp.gmail.com with ESMTPSA id e29sm1298419wra.7.2020.05.21.13.11.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 13:11:36 -0700 (PDT)
Subject: Re: [PATCH] smp: generic ipi_raise tracepoint
To:     Nadav Amit <namit@vmware.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <02b57f31-fc0c-df35-57bf-e0a297a7e6c4@gmail.com>
 <40AA62E7-3AFB-44DC-B4A6-F89E5C914620@vmware.com>
From:   Wojciech Kudla <wk.kernel@gmail.com>
Message-ID: <767faf00-0dc0-698a-910f-100608d10d81@gmail.com>
Date:   Thu, 21 May 2020 21:11:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <40AA62E7-3AFB-44DC-B4A6-F89E5C914620@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/2020 20:00, Nadav Amit wrote:

>> -	if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu)))
>> +	if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu))) {
>> +		if (trace_ipi_raise_enabled())
> 
> Why do you need this check? trace_ipi_raise() will do the same check before
> actual tracing:
> 
> 	if (static_key_false(&__tracepoint_##name.key)
> 

Yes, my motivation for conditional logic was performance-driven.
Thanks for pointing out the implicit check.

> 
> In general, I think there are too many trace-points. They look benign(i.e.,
> free), but can cause worse code to be generated as they behave as a memory
> clobber. Many times the same result can be achieved with a probe.
> 

Thank you for the review, I agree this may not be optimal. Let's just stop here.
There's a different patch I submitted today that follows Peter's suggestions
about smp function calls being much more sensible target for new tracepoints.

http://lkml.kernel.org/r/e6141d56-1da1-6c00-198f-cbe4385327ff@gmail.com

Thanks,
W.

