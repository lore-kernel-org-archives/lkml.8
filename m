Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22379C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04D14206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="atALUCdR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0UaMBvXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391512AbgF2V6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728939AbgF2V6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:58:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FEDC061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:58:05 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593467881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qCfJAHafYa/AK9R1oGXdsMRC8dDD1+/B6dAzjfz2e8A=;
        b=atALUCdRSCjttKOnEF7ACaejPFRnLCROGTU2TYcrTGB+x4/vvCK2w3z0nOYKLM29guozda
        v7GCs60PvZimi55BI+pF9yKr/oUNB2pfhzkq7fNd86NV8iVTuqfRYKSZwZexUdfeagQSsQ
        r1F6NS0luJXHyEo3nMPC7GqnxrpGXEVvOdhan1/v12ZxlCOJrLWrUEucsY22IFVjXWjuhM
        YrYO6Zgzj0fEHOiEM+CO2MkJKNZZmCoA+gIHSwB53Ee5SDqiG6MXljMOzzertMSSFJkEGB
        dyhtUpSOIV8vYMaows5UqYXNooA2Afc7Lu0+X+b8nSliReFAIoK1N09pDp8WnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593467881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qCfJAHafYa/AK9R1oGXdsMRC8dDD1+/B6dAzjfz2e8A=;
        b=0UaMBvXKer7+fp5NEnvGteOT9ErcAAfKjSd3iwxofOplHufM1dhe3a4AYC6EWgF6qzN1Oq
        lry2ysi0HSt+ASBQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: buffer allocation: was: [PATCH v3 3/3] printk: use the lockless ringbuffer
References: <20200618144919.9806-1-john.ogness@linutronix.de>
        <20200618144919.9806-4-john.ogness@linutronix.de>
        <20200625082838.GF6156@alley> <87sgeh3m5j.fsf@jogness.linutronix.de>
        <20200629140445.GK6156@alley>
Date:   Mon, 29 Jun 2020 23:57:59 +0200
In-Reply-To: <20200629140445.GK6156@alley> (Petr Mladek's message of "Mon, 29
        Jun 2020 16:04:45 +0200")
Message-ID: <87ftad8rh4.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-29, Petr Mladek <pmladek@suse.com> wrote:
>> @@ @@ void __init setup_log_buf(int early)
>> +	prb_init(&printk_rb_dynamic,
>> +		 new_log_buf, order_base_2(new_log_buf_len),
>> +		 new_dict_buf, order_base_2(new_log_buf_len),
>> +		 new_descs, order_base_2(new_descs_count));
>
> order_base_2() is safe. But the result might be tat some allocated
> space is not used.
>
> I would prefer to make sure that new_log_buf_len is rounded, e.g.
> by roundup_pow_of_two(), at the beginning of the function. Then we
> could use ilog2() here.

new_log_buf_len can only be set within log_buf_len_update(), and it
is already doing exactly what you want:

        if (size)
                size = roundup_pow_of_two(size);
        if (size > log_buf_len)
                new_log_buf_len = (unsigned long)size;

I can switch to ilog2() instead of the more conservative order_base_2().

John Ogness
