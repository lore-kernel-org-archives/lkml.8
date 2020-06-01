Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA964C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9401620820
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="hYqOAeMV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgFAPl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgFAPl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:41:28 -0400
Received: from forwardcorp1j.mail.yandex.net (forwardcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A64DC05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 08:41:28 -0700 (PDT)
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 73C5C2E14D5;
        Mon,  1 Jun 2020 18:41:23 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
        by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id nYL5csLrlA-fKfCnuMc;
        Mon, 01 Jun 2020 18:41:23 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1591026083; bh=ZUw5OoQM9e8yDhZExLKpq/mDIO0VeQhAmNKAr534Nu4=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=hYqOAeMVoe3uYRXKUcY97ZTaEcsQNG3HW5IN5Dq9NfMWy7+1XGPruZSeXMMMhSl+p
         WGsmAQZcsop8UjDPwH5Qfj8WKfAIz2DSMoTByULhVodc6b9uTGLS2V98D+w5BdSGBn
         ropWkWT/CMNlGjI/A+YJu8O1cst09SokwFxWemZw=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:6420::1:8])
        by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id d4fjh5CCd5-fKW8PPmL;
        Mon, 01 Jun 2020 18:41:20 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [RFC PATCH] mm: swap: remove lru drain waiters
To:     Hillf Danton <hdanton@sina.com>, linux-mm <linux-mm@kvack.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20200601143734.9572-1-hdanton@sina.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <5634bb7f-8ef0-515a-d2af-97e6226d5926@yandex-team.ru>
Date:   Mon, 1 Jun 2020 18:41:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200601143734.9572-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2020 17.37, Hillf Danton wrote:
> 
> After updating the lru drain sequence, new comers avoid waiting for
> the current drainer, because he is flushing works on each online CPU,
> by trying to lock the mutex; the drainer OTOH tries to do works for
> those who fail to acquire the lock by checking the lru drain sequence
> after releasing lock.
> 
> See eef1a429f234 ("mm/swap.c: piggyback lru_add_drain_all() calls")
> for reasons why we can skip waiting for the lock.

That patch tells nothing about such change in behaviour.

Callers like invalidate_bdev() really need synchronous drain to be sure
that pages have no extra reference from per-cpu vectors.

> 
> The memory barriers around the sequence and the lock come together
> to remove waiters without their drain works bandoned.
> 
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Signed-off-by: Hillf Danton <hdanton@sina.com>
> ---
> This is inspired by one of the works from Sebastian.
> 
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -714,10 +714,11 @@ static void lru_add_drain_per_cpu(struct
>    */
>   void lru_add_drain_all(void)
>   {
> -	static seqcount_t seqcount = SEQCNT_ZERO(seqcount);
> +	static unsigned int lru_drain_seq;
>   	static DEFINE_MUTEX(lock);
>   	static struct cpumask has_work;
> -	int cpu, seq;
> +	int cpu;
> +	unsigned int seq;
>   
>   	/*
>   	 * Make sure nobody triggers this path before mm_percpu_wq is fully
> @@ -726,18 +727,16 @@ void lru_add_drain_all(void)
>   	if (WARN_ON(!mm_percpu_wq))
>   		return;
>   
> -	seq = raw_read_seqcount_latch(&seqcount);
> +	lru_drain_seq++;
> +	smp_mb();
>   
> -	mutex_lock(&lock);
> +more_work:
>   
> -	/*
> -	 * Piggyback on drain started and finished while we waited for lock:
> -	 * all pages pended at the time of our enter were drained from vectors.
> -	 */
> -	if (__read_seqcount_retry(&seqcount, seq))
> -		goto done;
> +	if (!mutex_trylock(&lock))
> +		return;
>   
> -	raw_write_seqcount_latch(&seqcount);
> +	smp_mb();
> +	seq = lru_drain_seq;
>   
>   	cpumask_clear(&has_work);
>   
> @@ -759,8 +758,11 @@ void lru_add_drain_all(void)
>   	for_each_cpu(cpu, &has_work)
>   		flush_work(&per_cpu(lru_add_drain_work, cpu));
>   
> -done:
>   	mutex_unlock(&lock);
> +
> +	smp_mb();
> +	if (seq != lru_drain_seq)
> +		goto more_work;
>   }
>   #else
>   void lru_add_drain_all(void)
> --
> 
