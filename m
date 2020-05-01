Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB72C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46BB220857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Nu25g7pI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbgEARtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 13:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729776AbgEARtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 13:49:11 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40296C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 10:49:11 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id b18so5155821ilf.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 10:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FAkF2yaKZTirBIt4k8vbrMCWa7L6IDgN4q10kaek3iU=;
        b=Nu25g7pInQqg92NCuHrYmayuvi3zj47l19mKYK+v6nZ4geQuwZmiJFA0Ii0QRLaf2k
         xhcszlyfj33HWh3Xi5E56xHj2YdoWvAna+nzO5duPolVZHd5AwqU1VwJvEYWiKV5tNrZ
         VVgz6Z8ZDZ1dlDXalq4Xzu5DlrcSogG11QqcmPgyBYcPsqY6QlxwCN7+yTLiZ4xKCo7Z
         5wN4N3ChX/WfdltfWQ01AVZeB/vbq6zulX6fFL5caZZSbqoWdenu5DmZNr0JSsR6zNnz
         7S4JvLkRqEBK1s7dysopowoExTk3x8svJXpsW2HZgqPm4pLLRFkJUqVbqHncgDwv96sp
         7gbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FAkF2yaKZTirBIt4k8vbrMCWa7L6IDgN4q10kaek3iU=;
        b=Q7fC6263ouwNFgHdb7C3B2iiSCOmPRhiwcfbsrZfyYLQhz9NcVbwMhV9VcoxdgCwsh
         1darm8Yl7zaJzQ5TsTU2njTGx/IPAwx/wJmRyD1I0QN1oUGJObWh/BV+ISkJyACfvUC2
         NJAnpiEX1TWfcgEoT2rc/os4VLz5yhG61CszfGZD5Y2ixMMSyHK3kaLHVyEG5sVTRAhp
         hQymu0spBTIbz+eCNsvC1q4zW1nFV5uJukW7sZDJ3t7aMbQXJxPXfm5teH03D0kS2p7E
         oh2uXD9jWpV5AiICaVxwrYc+79ZvZmSIlz2Y7fr65BbZ4ExNS0hiEJJqrux6N054TSBD
         bZKw==
X-Gm-Message-State: AGi0PuZjI+/bWqlxXi1AFzEkU3hmfNqaaOsh/Gsf435SOJWLA7l3NvBm
        LUAxYMpdxazS3v4f7V9uDa7SdcJ6iZfqjw==
X-Google-Smtp-Source: APiQypIjzlOj0z/RyQ2dh1il3B4WXx3fOLCltjGmV8lOFrB8LH4cwP0bYXdcjZVDSR+f+bbE+SWviQ==
X-Received: by 2002:a92:4952:: with SMTP id w79mr4374379ila.15.1588355349738;
        Fri, 01 May 2020 10:49:09 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d23sm1130687ioc.48.2020.05.01.10.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 10:49:08 -0700 (PDT)
Subject: Re: [PATCH v2] eventfd: convert to f_op->read_iter()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <c71b2091-a86e-cc81-056d-de2f1e839f50@kernel.dk>
 <20200501174306.GM23230@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2fa3e8dc-172e-2ac6-bc5e-a8fea5491e22@kernel.dk>
Date:   Fri, 1 May 2020 11:49:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501174306.GM23230@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/20 11:43 AM, Al Viro wrote:
> On Fri, May 01, 2020 at 11:18:05AM -0600, Jens Axboe wrote:
> 
>> -	if (res > 0 && put_user(ucnt, (__u64 __user *)buf))
>> +	if (res > 0 && copy_to_iter(&ucnt, res, iov) < res)
> 
> *whoa*
> 
> It is correct, but only because here res > 0 <=> res == 8.
> And that's not trivial at the first glance.
> 
> Please, turn that into something like

Looks good to me, just one minor edit:

> 	if (iov_iter_count(to) < sizeof(ucnt))
> 		return -EINVAL;
> 	spin_lock_irq(&ctx->wqh.lock);
> 	if (!ctx->count) {
> 		if (unlikely(file->f_flags & O_NONBLOCK) {
> 			spin_unlock_irq(&ctx->wqh.lock)
> 			return -EAGAIN;
> 		}
> 		__add_wait_queue(&ctx->wqh, &wait);
> 		for (;;) {
> 			set_current_state(TASK_INTERRUPTIBLE);
> 			if (ctx->count)
> 				break;
> 			if (signal_pending(current)) {
> 				spin_unlock_irq(&ctx->wqh.lock)
> 				return -ERESTARTSYS;
> 			}

We need to remove waitq and re-set task state here. I'll run a sanity
check on that and send out a v3.

-- 
Jens Axboe

