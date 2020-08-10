Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDF6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AD772070B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RJeXxtPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgHJOh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 10:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgHJOh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 10:37:58 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009A3C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 07:37:57 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bh1so4959108plb.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 07:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+RL9x5CZR2lB1YoakKVpI5m0mAByd17ewB2LnQj/+W4=;
        b=RJeXxtPEvgxCKhLrn95wWFyBogkrqRdDdqYriDkEhObCC/1xePyKYbOFh0CMqlTc/W
         5+4ImGhBRAvpBMpB5K+HgmpXiEtfG3lf57vW9e4JzgBZVUY6BjWpWELT0sOYetNSec5X
         lVT2fwha1hU3Jerr8fz5jvyTgGxXhLaqIu4tgsSDMEemKHwGt/k6kVFMIcnX+hoD2ojq
         ytifb9rdzJSxIdfkSVs0NyMN673oROLzEm1sjTzgaoMa3ozoTYyvYqo2Ld3fZtr7Rcc4
         uNPIHgJiE9ETPD2BW+dqGk2Lsl2GSqON1yRlOym9aAEtrd94bMrOX+fTlew5yBYtHx1K
         zI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+RL9x5CZR2lB1YoakKVpI5m0mAByd17ewB2LnQj/+W4=;
        b=NprIiEBMfi0+8TbSMyr3fVvo+KHIvKUWpGDXT/BV52lm79hw19vp+sKI6uR1KOpW3G
         gVjzNOcTnAlPW+r/xDrijb6ym/tQXnIB87voww1Ar2sCqF6iMWkZxiBrnhQG9Vvygdr+
         42VZv0YH/fBjIU4zlgQd6DkQUi6ejeJpeyiHFYj424uTlUbdhtyUwpaXdbqRvCBAMdJi
         XdzpKfSt0DYAuzy4IAdayE6bERepIZUW1URiYbIJQjlebw6Ws87GWmrpCIZFLIs7f6Zy
         w0PdsGiGqgCYM8FapUFWk+MMBwUNvCuu8z5pfe/I1hWx9hJy4uuBgtcQ+Vn1p3YWKT9d
         0Uyg==
X-Gm-Message-State: AOAM533jjqj8ONJlXZaxFwFr3be3rS5vBcC+6kYYJ3VqxjVzLh1ne1MU
        QNzoDqhCJQ5w34F2fu1Sg9ZEXEBwfrs=
X-Google-Smtp-Source: ABdhPJyzy5+5ztrzei0Mo5lCPh9sKcz+HnLn2T1nmy6cbDmjEtpPRbSc6LpqZkSvtvc/8rmCgleb1g==
X-Received: by 2002:a17:90a:d70c:: with SMTP id y12mr1518391pju.31.1597070277385;
        Mon, 10 Aug 2020 07:37:57 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id f6sm23601379pfa.23.2020.08.10.07.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 07:37:56 -0700 (PDT)
Subject: Re: [PATCH] kernel: update callers of task_work_add() to use
 TWA_RESUME
To:     peterz@infradead.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
References: <10debfb3-25f2-20ed-d4f3-1d95ba4c2129@kernel.dk>
 <20200810114407.GT2674@hirez.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <21d27dfe-91f8-ebc3-6390-a0345603ac28@kernel.dk>
Date:   Mon, 10 Aug 2020 08:37:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200810114407.GT2674@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/20 5:44 AM, peterz@infradead.org wrote:
> On Sat, Aug 08, 2020 at 03:43:50PM -0600, Jens Axboe wrote:
>> Any pre-existing caller of this function uses 'true' to signal to use
>> notifications or not, but we now also have signaled notifications.
>> Update existing callers that specify 'true' for notify to use the
>> updated TWA_RESUME instead.
>>
>> This was noted in the original commit as well:
>>
>> e91b48162332 ("task_work: teach task_work_add() to do signal_wake_up()")
>>
>> Cc: Oleg Nesterov <oleg@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> How do you want to route this?

I don't really care, as I have no dependencies on it. Feel free to queue
it up! It's just sitting at the top of my io_uring branch right now,
but that's because I had to stuff it somewhere. Easy to pop off the top.

-- 
Jens Axboe

