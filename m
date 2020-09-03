Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82396C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46A352083B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyHCLuYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgICSL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgICSLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 14:11:55 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B87C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 11:11:54 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l191so2767142pgd.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 11:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z/WGWzSYGz8J3iaX8Rk7LKkLmt5c/J5bTwTGuVKf+bM=;
        b=iyHCLuYVcjzbildmxRbuti2v+t/KLHeF+cq4vxTapvDBRO6caTSYLekF8dEhsrYq32
         eyxyrahJPBx/80xG8LLDSygjrJRweJHQIIaKCcjn6eFpOHncoo8BVT9DNcWID0daONRP
         GYa608/CENIdt9X4ZFi3zZIu/WhkHroJU+x1c/RGjUUd13XRR9tGY7p4jrAiKgRB5wv+
         WhwE2vG1PkjuJCcqvCyAONxWNSxJ4yCwc17p/52Ot/FP/lr3TR1tpM2vaMUkcVhRp9YG
         mSA1LDXpOyvBVPjaIJckcG83MCOQhrNljVJqyLbRPv/LSUOlMgHEWfH52H8+3uzyGPOG
         jk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=z/WGWzSYGz8J3iaX8Rk7LKkLmt5c/J5bTwTGuVKf+bM=;
        b=Hhfu0ObDKE5mHJxzJoGOFivu/snYwYiVK3rtsKgh4FV7MgN34pCSumRX128FdpVwz+
         HvqfoxTJmJ2mMXNcN0pnbCrOJ998+3hew1pj3zq6YQ4OWiR7qfXkMqv9AOITnt0vYTL5
         AADlKZfgcADqzViKgUMv3DBqiPXzLxi5Ephby9xMA8PZd+YWIp7LW4iOEObF1flGO16i
         9rbfrVzWxv/JIhmbQxYqIgSSCMYQkpkSbIZHTmc6hiwWjJOwjNI4Bqji7yaS9AK2z8O+
         BWcileZC/kBVLuelEuZnVxDq9Yy3yoi1BoCe6gWYzrT6N1Oq89CNwUndgB65QUsJeZ4X
         OSJQ==
X-Gm-Message-State: AOAM533VGZbpZHHJv0kenRCEaP5ZLvG+9jGZcytkMeUhSz/RX6XIBtdB
        j8QYRRXmEZVvIT3falKZYrs=
X-Google-Smtp-Source: ABdhPJyfPlBYjlzETG+eacnYCXqwV7+lBsEJJ9vy7zzrxnQuPusakbXlC9WO+YtfYdKs3BJ6/FMW0g==
X-Received: by 2002:a63:4559:: with SMTP id u25mr3901003pgk.162.1599156714183;
        Thu, 03 Sep 2020 11:11:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f4sm3508606pgi.49.2020.09.03.11.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 11:11:53 -0700 (PDT)
Subject: Re: [PATCH v2 11/11] lockdep,trace: Expose tracepoints
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org,
        npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org
References: <20200821084738.508092956@infradead.org>
 <20200821085348.782688941@infradead.org>
 <20200902035146.GA45826@roeck-us.net>
 <20200902085636.GV1362448@hirez.programming.kicks-ass.net>
 <e4999b75-604f-29a3-e78c-508ee6bede88@roeck-us.net>
 <20200903140047.GD1362448@hirez.programming.kicks-ass.net>
 <9ea73cb4-262d-d9ba-beac-e9e013f89d6e@roeck-us.net>
 <20200903153649.GF1362448@hirez.programming.kicks-ass.net>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <a886338f-ea9e-a6dc-7814-6a6bea87ac28@roeck-us.net>
Date:   Thu, 3 Sep 2020 11:11:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903153649.GF1362448@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/20 8:36 AM, peterz@infradead.org wrote:
> On Thu, Sep 03, 2020 at 08:19:38AM -0700, Guenter Roeck wrote:
>> This doesn't compile for me - there is no "name" parameter in __DO_TRACE().
>>
>> Error log:
>> In file included from ./include/linux/rculist.h:11,
>>                  from ./include/linux/pid.h:5,
>>                  from ./include/linux/sched.h:14,
>>                  from ./include/linux/sched/numa_balancing.h:10,
>>                  from ./include/trace/events/sched.h:8,
>>                  from kernel/sched/core.c:10:
>> ./include/trace/events/sched.h: In function 'trace_sched_kthread_stop':
>> ./include/linux/tracepoint.h:175:26: error: '__tracepoint_name' undeclared
>>
>> I applied your patch on top of v5.9-rc3-75-gfc3abb53250a. Are you using
>> a different branch ?
> 
> Argh, I was on tip/master... easy fix though.

That version silences the tracebacks on arm. I can't test on real hardware,
so I don't know if it also fixes the problem reported at [1] (which seems
related).

Guenter

---
[1] https://lore.kernel.org/lkml/CA+G9fYuiJwN1ad955Xw4ShamX2=373r+56KsbpeverEs+i_NAg@mail.gmail.com/t/#u
