Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD02C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EED720748
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdP0v+vu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgHJOKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 10:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgHJOKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 10:10:36 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC09C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 07:10:36 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o13so4942811pgf.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 07:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+J/Oc1375S3Mr5QmPzxTFCZZPHRpST6WJPtH7+jp6BE=;
        b=TdP0v+vul0dd83LHD9L+PL0bukX+v74d9vF+Fkcf3MoL42Hss5SPz/6A3tl/na4ynU
         aT2jkdSABwLxvJh8QgD5eugETWDmII9HDmon9vdjCx68BI7MJXg764THGeLs+CD6i4GB
         kJ1MHubbpXX4PdKMQGBa8x0OJBVYOwK0hldJ3LTVv6NZ3XYnC78xGUVKrGDmBmqLXE+N
         3BGvSFetgywYbOqcnP8pJ7U1+weuIFyqdGHnkrU1/8Gh65ecHCnI30pZbgWFTEjqowx3
         CC1qAzrRsjEn7O3rLoopQJqsmPXV7F+TTBptuyMVhG13GnHxhaFYkHLMu2A5ACcn+FQl
         euYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+J/Oc1375S3Mr5QmPzxTFCZZPHRpST6WJPtH7+jp6BE=;
        b=O6DIcMcgK1Gz1Gg+NtMImmrSykqKR1rkFUC8IL2SSJ/INCVrLJddt/EvOszpLUucHC
         RFvSa3eIqTCsb/iHViIAN+wYHiA2KdvS3TfNUQ4E0ZYS2a3nYpQV7XXD1/Uw2NTQeumn
         QpYs6YP2Z2UnOm9320ayCr/LRF7LKs7Z6YivhSRb5IlUNuXWvWMHsxWJfNhO4XBL19zw
         IHx3py8CNq/kYsT6M4ZrEiFLlqk3NDujLVGdL0ICQKFAyOehl1wxEvKzVpFmFeAHFFRr
         cmXsviNqtsjaZ+d+BGYju1AViIGQf/1UUjzGUzlIXE0V6xsPzc/6rqA7jhGm64uIjhh0
         avHQ==
X-Gm-Message-State: AOAM530EWz7mdC1a6XZ9ddpUzb3UyfOcdmW4mZtH3+HfS2KUVpvc4YT0
        WXu0YFf6amSdtPmgQIjJupw=
X-Google-Smtp-Source: ABdhPJxnB3iXEH2IWXYhKPyWb0tX3gRI4GKOKOM369h3yRACMLGCrdxdYCGVirjtpPesRKiyMR5EVw==
X-Received: by 2002:a65:4507:: with SMTP id n7mr21600039pgq.180.1597068635169;
        Mon, 10 Aug 2020 07:10:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q17sm22310855pfh.32.2020.08.10.07.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 07:10:34 -0700 (PDT)
Subject: Re: [PATCH] Revert "seqlock: lockdep assert non-preemptibility on
 seqcount_t write"
To:     Greg KH <gregkh@linuxfoundation.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de, will@kernel.org
References: <20200810085954.GA1591892@kroah.com>
 <20200810095428.2602276-1-a.darwish@linutronix.de>
 <20200810100502.GA2406768@kroah.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <bcf94ea2-05e6-2212-f732-b9a79a142f7e@roeck-us.net>
Date:   Mon, 10 Aug 2020 07:10:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200810100502.GA2406768@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/20 3:05 AM, Greg KH wrote:
> On Mon, Aug 10, 2020 at 11:54:28AM +0200, Ahmed S. Darwish wrote:
>> This reverts commit 859247d39fb008ea812e8f0c398a58a20c12899e.
>>
>> Current implementation of lockdep_assert_preemption_disabled() uses
>> per-CPU variables, which was done to untangle the existing
>> seqlock.h<=>sched.h 'current->' task_struct circular dependency.
>>
>> Using per-CPU variables did not fully untangle the dependency for
>> various non-x86 architectures though, resulting in multiple broken
>> builds. For the affected architectures, raw_smp_processor_id() led
>> back to 'current->', thus having the original seqlock.h<=>sched.h
>> dependency in full-effect.
>>
>> For now, revert adding lockdep_assert_preemption_disabled() to
>> seqlock.h.
>>
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Link: https://lkml.kernel.org/r/20200808232122.GA176509@roeck-us.net
>> Link: https://lkml.kernel.org/r/20200810085954.GA1591892@kroah.com
>> References: Commit a21ee6055c30 ("lockdep: Change hardirq{s_enabled,_context} to per-cpu variables")
>> Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Even after this, there are still some build errors on arm32, but I don't
> think they are due to this change:
> 
> 	ERROR: modpost: "__aeabi_uldivmod" [drivers/net/ethernet/sfc/sfc.ko] undefined!

This affects every 32 bit architecture.

> 	ERROR: modpost: "__bad_udelay" [drivers/net/ethernet/aquantia/atlantic/atlantic.ko] undefined!
> 

I don't think that is new. If anything, it is surprising that builds don't fail more
widely because of it. AFAICS it was introduced back in 2018 (a hot 50-ms delay loop
really isn't such a good idea).

Guenter
