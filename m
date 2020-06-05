Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B75C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 03:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 626DD207D5
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 03:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oApTUVbv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgFEDW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 23:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgFEDW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 23:22:57 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8251C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 20:22:56 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id m2so2130127pjv.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 20:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QyQw+sLIla93dlac0TERwcz4aWSKJuqSco16Wn/VCK0=;
        b=oApTUVbvRfwUXQkyK9U+0EK+y9ZjZdvqoGei9Z2c+lWyA4V9WeC6RwySmnttTG6h6R
         J5FKeKiU9vufOnBhhFWruh7l2jnbuXC8HWckjX0IWbOhN+hgkr19jyYnvyUKtb9GTheu
         evTg8bf8NZZU26vKyLPUwu2n9wMheLWcgtUV6877z7H0Zr5+wAxY7sqTsokSArUmkoJa
         77CgaSzTGld6I7+o8tUozYfgSTrnAM0/BRZqTO7g6feV+eKBM4odUNA3qXqctA8zH9JB
         ScsFF9jE/IDuxxV3ZgUfLedbHUBWt3W81bm87m3jv5JSAc39E9TYoGsaPR5oEcTt461g
         XBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QyQw+sLIla93dlac0TERwcz4aWSKJuqSco16Wn/VCK0=;
        b=q5gsd4cQQitwBYy6RNrJ7zBr4bbHeDlQMcbMdvhdZpiIRgA9/gqah33+4EKktZMwix
         LugPcqF0okcUfuKSjaW5ahewVFco/mmSCA5i46+Z+DtMiuwnuSdNkhAUA4QzVl2n7dQw
         EzZITIJ/Q8peLTEBnNHYf+JrqEW4oSuE2cB0kgKuy2uBtiv2yPbv4wT/J/vPOaToEKO/
         p5Xc3xPH8bb2G39/jg1nN2JUveq6zqcPP2WNj1ka66nzELcDbFrEQR81ELN+CpXqj51e
         6pjPOLRKUgce6RjT8GGFXP3Oi+84rIgsi/dL7pZ+3gKKC7eA4Q73PBjeJafX2Zq1EEHu
         6S4w==
X-Gm-Message-State: AOAM531isvJ7pf7KxRH7A11befVXHv4QZXNmjNcmvwvk8UKjnYW3wMOi
        i/qunaTvryfQ5ZhPnmuMdljJrg==
X-Google-Smtp-Source: ABdhPJwxXh8FFNGBgBksKWyrxn6L7WMe3Dlu7Qjsdz92aLKnsM1nGvuXZeAExnd99VH2EfqwFr5bhg==
X-Received: by 2002:a17:90a:2222:: with SMTP id c31mr570134pje.200.1591327376490;
        Thu, 04 Jun 2020 20:22:56 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id a14sm5520589pfc.133.2020.06.04.20.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 20:22:55 -0700 (PDT)
Subject: Re: [PATCH v2 5/6] block: nr_sects_write(): Disable preemption on
 seqcount write
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>, linux-block@vger.kernel.org
References: <20200603144949.1122421-1-a.darwish@linutronix.de>
 <20200603144949.1122421-6-a.darwish@linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b8440471-e78d-8112-2ab3-c2a948095fa8@kernel.dk>
Date:   Thu, 4 Jun 2020 21:22:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200603144949.1122421-6-a.darwish@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/20 8:49 AM, Ahmed S. Darwish wrote:
> For optimized block readers not holding a mutex, the "number of sectors"
> 64-bit value is protected from tearing on 32-bit architectures by a
> sequence counter.
> 
> Disable preemption before entering that sequence counter's write side
> critical section. Otherwise, the read side can preempt the write side
> section and spin for the entire scheduler tick. If the reader belongs to
> a real-time scheduling class, it can spin forever and the kernel will
> livelock.

Applied, thanks.

-- 
Jens Axboe

