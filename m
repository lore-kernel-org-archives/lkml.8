Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA49BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 15:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8146820897
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 15:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qb1iiiUl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgHRPxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 11:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgHRPxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 11:53:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3041C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 08:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Dn2I3qAdTWh3ORoWLS/wdmt8G2wMu07ZNwWGXI9oNjs=; b=qb1iiiUlJs54zsXMKWlg2x1a9/
        FvxcTm+TKFQO/jivct0sZPJLWXsFQEC4GeYvrUkPjB90b2oJTM5OyZYCH3Pj+3eyzCkSVsjp7cPVV
        W+2N1eosu/ockjKe+6h8sDHgrdGHx4OIGuL6vuWK5nX+wwgvAV+6sEQMfe3QWU1Fvy5KtuYZEBOiZ
        5kkUImjabpoHnkPlMPdyF8v6D7i8eqs/XP7ytz8yhUlrJUKB46PCBxhUAbL8N9E9CuCaeGYAEgDsW
        UHrJWr/ansON5yG70YsnhszZfv/oBemyU4kgr9IawBj3GCAKSiKk+lm5w6zxqImZI0Yw8xlCDO1aO
        9AqOiUYg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k83uk-0005Ki-FG; Tue, 18 Aug 2020 15:52:43 +0000
Subject: Re: [RFC][PATCH v2 10/10] irq_work: Add a few comments
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, paulmck@kernel.org,
        hch@lst.de, axboe@kernel.dk, chris@chris-wilson.co.uk,
        davem@davemloft.net, kuba@kernel.org, fweisbec@gmail.com,
        oleg@redhat.com, vincent.guittot@linaro.org
References: <20200818105102.926463950@infradead.org>
 <20200818112418.591210082@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <56be3f06-4d4a-4128-a8b4-dbe12d37ce78@infradead.org>
Date:   Tue, 18 Aug 2020 08:52:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818112418.591210082@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

a few typos below...

On 8/18/20 3:51 AM, Peter Zijlstra wrote:
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/irq_work.h |   80 +++++++++++++++++++++++++++++++++++++++++------
>  kernel/irq_work.c        |   10 +++++
>  2 files changed, 80 insertions(+), 10 deletions(-)
> 
> --- a/include/linux/irq_work.h
> +++ b/include/linux/irq_work.h


> @@ -48,12 +47,45 @@ static inline bool irq_work_is_busy(stru
>  
>  #ifdef CONFIG_IRQ_WORK
>  
> +/*
> + * irq_work_queue(): run @work in IRQ context on this CPU
> + * @work: work to run
> + *
> + * Self-IPI, NMI-safe
> + *
> + * When the function returns false; @work is already queued and
> + * any eventual execution of it's func() is guaranteed to see

                                its

> + * any state before the failing enqueue.
> + */
>  bool irq_work_queue(struct irq_work *work);
> +
> +/*
> + * irq_work_queue_on(): run @work in IRQ context on @cpu
> + * @work: work to run
> + * @cpu: cpu to run @work on
> + *
> + * *NOT* NMI-safe
> + *
> + * When the function returns false; @work is already queued and

                                false,

> + * any eventual execution of it's func() is guaranteed to see

                                its

> + * any state before the failing enqueue.
> + */

> @@ -67,8 +99,36 @@ static inline bool irq_work_needs_cpu(vo

> +/*
> + * irq_work_queue_remote_state(): like irq_work_queue_remote() except dangerous
> + * @cpu:
> + * @work:
> + *
> + * DO NOT USE, this function is horrible/dangerous.
> + *
> + * The test-and-set-PENDING is not atomic, it also doesn't set
> + * the BUSY bit and with that breaks irq_work_sync().
> + *
> + * This means that the caller needs external serialization; life-time,
> + * where relevant, also needs to be externally orchestated.

                                                  orchestrated.

> + *
> + * There is no validation/debugging to help you if you get it wrong.
> + */
>  extern int irq_work_queue_remote_static(int cpu, struct irq_work *work);
> +
>  extern void irq_work_single(void *arg);
>  #endif
>  


-- 
~Randy

