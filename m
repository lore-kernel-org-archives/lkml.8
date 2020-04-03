Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86980C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49DAF20721
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lceOlfDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404362AbgDCQRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:17:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54674 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbgDCQRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:17:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id c81so7718094wmd.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 09:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=N/dufn/yNOMJ2IHz3OJ8DzV8nJCZDUY6SoIeQkbo4HE=;
        b=lceOlfDEZO6ls8DfUYwEazvNtjyoNL1xnA5Hyjf4y7vnnCPcqQagBjMy4dSag11/Gy
         MJ6Agqo5OFJg8oMCea8PM67NSFhZgb+Zgk0AntQnGD42JS6ROtv65aZPI3H7sF3FAt/j
         SpMIx8Df9bVaMG1QMUljC2IpJUeeQt/XHRi/QdahMV8GFGEdAkiciNQl3FpQ5XYYz/vZ
         a3e2a4+PRD/6DojPFhZnn2ho1cuBL+D7pRNYpfbRcG+td1E22Zc5iuQsGdZh6tyGx31Y
         BMC7uEQn2JptK+sGIMGCvCdh+zMEXfnN34ZPq2ipDYleISBGLADwLXrP2PmW4LBILD9Z
         /bIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=N/dufn/yNOMJ2IHz3OJ8DzV8nJCZDUY6SoIeQkbo4HE=;
        b=GnjOrR3UJNE2a7n45coNE5VsbXL3pJZDBPfZ/D0LFioS4nedEO6sz7aQD+mfRBAKRH
         LkDNDTvbbkNuXlfZZ7pl+iOWUeFADeglkYJBFy/DjHMxv5rFcCur0Ot1hiCl0KtDd2oV
         B0xWi2Uzu+nuB5QrNzq7w3eiKQU1LpMvQWxDvPgfBAPBTCM52E2YcVZhkHMZI6+oTQ+x
         nI5oHCzoEm9hPlYyKd1ORUU346aYDsZCxegBCsxUVQhng8gE5T0x3JHzUIuS2VhXD0aM
         s5qg8djhaMXKC402zPpx3SSs7aAH5P9L00VmLHrL3sRTm18QSveBmP1hk++gHf6g+Emp
         gm6w==
X-Gm-Message-State: AGi0PuY0oRFQOySu8pZZie1adhq69ceu8OQXGzdB3IhXm+cgbIF2nQPk
        ppjXAPdcCYeN0rG/55bwEg==
X-Google-Smtp-Source: APiQypI3FWaGbD3ENSlGqfMpgNcKgs3YQAwSWbkNhPyFv8RpF3rl1MY5lpQmkLuiEx6TMSeDwmUXlw==
X-Received: by 2002:a1c:195:: with SMTP id 143mr9595391wmb.0.1585930624236;
        Fri, 03 Apr 2020 09:17:04 -0700 (PDT)
Received: from earth.lan (host-92-23-85-227.as13285.net. [92.23.85.227])
        by smtp.gmail.com with ESMTPSA id p10sm12433171wrm.6.2020.04.03.09.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 09:17:03 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <djed@earth.lan>
Date:   Fri, 3 Apr 2020 17:17:02 +0100 (BST)
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Jules Irenge <jbi.octave@gmail.com>, linux-kernel@vger.kernel.org,
        julia.lawall@lip6.fr, boqun.feng@gmail.com,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 4/4] locking/rtmutex: Remove Comparison to bool
In-Reply-To: <20200330112157.GI20696@hirez.programming.kicks-ass.net>
Message-ID: <alpine.LFD.2.21.2004031716310.10601@earth.lan>
References: <0/4> <20200330012450.312155-1-jbi.octave@gmail.com> <20200330012450.312155-5-jbi.octave@gmail.com> <20200330112157.GI20696@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 30 Mar 2020, Peter Zijlstra wrote:

> On Mon, Mar 30, 2020 at 02:24:50AM +0100, Jules Irenge wrote:
>> Coccinelle reports a warning inside __sched rt_mutex_slowunlock()
>>
>> WARNING: Comparison to bool
>
> I don't mind the patch; but WTH is that a WARNING ?!? Superfluous, but
> definitely not wrong or even dangerous AFAICT.
>
>> To fix this,
>> a comparison (==) of a bool type function result to value true
>> together with the value are removed.
>>
>> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
>> ---
>>  kernel/locking/rtmutex.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
>> index 851bbb10819d..7289e7b26be4 100644
>> --- a/kernel/locking/rtmutex.c
>> +++ b/kernel/locking/rtmutex.c
>> @@ -1378,7 +1378,7 @@ static bool __sched rt_mutex_slowunlock(struct rt_mutex *lock,
>>  	 */
>>  	while (!rt_mutex_has_waiters(lock)) {
>>  		/* Drops lock->wait_lock ! */
>> -		if (unlock_rt_mutex_safe(lock, flags) == true)
>> +		if (unlock_rt_mutex_safe(lock, flags))
>>  			return false;
>>  		/* Relock the rtmutex and try again */
>>  		raw_spin_lock_irqsave(&lock->wait_lock, flags);
>> --
>> 2.25.1
>>
>
Thanks for the reply, I will take good note.
