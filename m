Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712EDC4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A162467B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XiDQ6WtS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgBZONj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 09:13:39 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:45005 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgBZONj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 09:13:39 -0500
Received: by mail-il1-f195.google.com with SMTP id x7so365228ilq.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 06:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FGHkOk7etA0w/lU3iCaXWIwB55mt0PB/liPLxSbfLGg=;
        b=XiDQ6WtSuyRFVXn8DgaqZId+oCLQRtfxO4fozeDNu5fjAQjvk8xgmcNZgahcTJelTf
         /ua4eHVBe0sSmjeTJ7nAj1Uqxi2up8pmT+GO7iOCKwWnOWimmBmCuYU6fII6bE8eEt7o
         Y6du4YnRxbe4vRZlwaUfAWNCi5wXXIwRNZoQ4XV5Tno4b4d6c5m80IhgVVMguLMT0uYy
         Y51xuck/PChsUWj6WbSsadsgpgnE27VvqDFsB88czvXeRRIaJ/0Nor5XslswdY+jyLb1
         H2zbyaIDq2PI1N2CNGk1VE2O4c0kaUi0gDx86irK4Uj/TnCJziwqBa3AU1dIdgXMOiWY
         ks1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FGHkOk7etA0w/lU3iCaXWIwB55mt0PB/liPLxSbfLGg=;
        b=kCuPtgZDaIg5xx/oBSdkt6iLbzJbQCTAFq9KK2q7bn294KfhnjPmL15JV7ZSXbaKhV
         Al7UuzjkrQHhytOtpZSse00qGdt1vX/xOd65cQ/Fb626zf3B0HagUs90JU/eBeECmKCc
         dDiJndnZUx5QM9MBFYgmxQdLWlfuTlTWRY1xleg1+J5lQiS2x6PHgwls2xhdqh+9Qi8e
         /NAaOCHFV/dwGmtDBGPgmOjhVVHExiS0P4RyRZQ5Tsh9RUM9s2j9TeDWFAXZiZubAgFJ
         szTTzkl63X6OIST2IKhRAUebS1Spb7kdpQBjmgVOJ92TTDBwNLynvQSWFc1hxFXlvNLe
         MBBw==
X-Gm-Message-State: APjAAAWUw6Jk5c7qfnVLXkptQbiBSR2zrsHBSgHH4LGVnb5BiHR0LuNg
        96SR4awUCFfwQHBkUYNs11kFCw==
X-Google-Smtp-Source: APXvYqw18LfScNex77RW0imSGzI/wZ7CKupXx9MV2F5iuRHxLafIxyS3twyJwCiTKlMv3UHsrMuYFg==
X-Received: by 2002:a92:3c51:: with SMTP id j78mr3583156ila.210.1582726418925;
        Wed, 26 Feb 2020 06:13:38 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i16sm660223ils.41.2020.02.26.06.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 06:13:38 -0800 (PST)
Subject: Re: [PATCH v2] mm: Fix use_mm() vs TLB invalidate
To:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, luto@amacapital.net,
        keescook@chromium.org, torvalds@linux-foundation.org,
        jannh@google.com, will@kernel.org
References: <20200226132133.GM14946@hirez.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4c6dc38d-1ab1-a48a-f987-f616afd8910b@kernel.dk>
Date:   Wed, 26 Feb 2020 07:13:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226132133.GM14946@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/20 6:21 AM, Peter Zijlstra wrote:
> 
> For SMP systems using IPI based TLB invalidation, looking at
> current->active_mm is entirely reasonable. This then presents the
> following race condition:
> 
> 
>   CPU0			CPU1
> 
>   flush_tlb_mm(mm)	use_mm(mm)
>     <send-IPI>
> 			  tsk->active_mm = mm;
> 			  <IPI>
> 			    if (tsk->active_mm == mm)
> 			      // flush TLBs
> 			  </IPI>
> 			  switch_mm(old_mm,mm,tsk);
> 
> 
> Where it is possible the IPI flushed the TLBs for @old_mm, not @mm,
> because the IPI lands before we actually switched.
> 
> Avoid this by disabling IRQs across changing ->active_mm and
> switch_mm().
> 
> [ There are all sorts of reasons this might be harmless for various
> architecture specific reasons, but best not leave the door open at
> all. ]

Not that I'm worried about it breaking anything, but ran it through
the usual testing and might as well report:

Tested-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

