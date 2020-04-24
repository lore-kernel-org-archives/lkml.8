Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AF5C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7831520767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="N1vxKugI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgDXPR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727050AbgDXPR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:17:26 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A075C09B046
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 08:17:26 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id p10so10704718ioh.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 08:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B8MEjSMXDLeeRwMf22Wcm9+JoUVLltdfJd+edXpssbM=;
        b=N1vxKugI0BoYmTSNtupkXRj3vkFAILbKRvbBT2WozGOdp1MBvvlGws1ZIp3JEHUAJp
         tsBMS8v8aaA9SemO10LYsOJOhyAyC5+jRE0CZYtEyXeOGRNfazTh0qnjQetOpCF8PqO9
         +YteoxkK9GUyD4UFdZpGwuwkCNROS8BRD9CqY4+LR4FmoARPe668SqSNkSpR7Dda7Jmo
         YOU8+T7v5yc44dy+dc+siXh9LkAsZ/zdMc3aLotnxGidJClv4EigMN9vxn3OmiC+7SiK
         MpuAj9+WXTvIB2TyrRRJZLioYEg6L8PGg+x8a8/ArJsNTT0ca1XOja8rAWwWxe7QKn+8
         S5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B8MEjSMXDLeeRwMf22Wcm9+JoUVLltdfJd+edXpssbM=;
        b=Gy/B8TRUamtWsLHZPW1579bV6edUfylg0oll7rub+fD5OesGALSvct6vdutPLvtiwW
         09Lxdn+aYNUlyk08PnWoaH4I3duDuaZLu4hBFEzi9B6MqUK4nSgq1E9EDa7VKNOxKYqR
         MbERv12/oxDLQLRzInxdzKuAF8amtJ54l4lw901RAKwych0LjGvy4/WAROpad/pLaCYi
         r89KIuUrIEC06ri67ExKzpdIvc8zJMjf6PWhlTxHXRx1nJUSawRbuXfYZtmgU1pNnIYc
         eZcxGo0wQ1drgm5bQT/ObxQ1FkHeygud9Y9990jhjZ55ExTdeNgi4JbkG9Xm12D3P2mb
         rMAg==
X-Gm-Message-State: AGi0PuZ8QqCBiiGyCmLALa7+Yj6nyJ0QiadUc13y/p/E6KLnqT1PAgI5
        k3Ncn7HZP2rcWw/knWRIOzMQKA==
X-Google-Smtp-Source: APiQypLp/lwrJUWr2wH+WO00hycKJo6TufmGAQ2VrkI7YolBCkrS7/29IYtq2k1bg/ryg6nQtPCWfQ==
X-Received: by 2002:a02:603:: with SMTP id 3mr8822903jav.132.1587741445360;
        Fri, 24 Apr 2020 08:17:25 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k11sm1937455iom.43.2020.04.24.08.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 08:17:24 -0700 (PDT)
Subject: Re: [PATCH v3] block: Limit number of items taken from the I/O
 scheduler in one go
To:     Salman Qazi <sqazi@google.com>, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jesse Barnes <jsbarnes@google.com>,
        Gwendal Grignou <gwendal@google.com>,
        Hannes Reinecke <hare@suse.com>, Christoph Hellwig <hch@lst.de>
References: <20200424150321.38617-1-sqazi@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8998250d-4945-9efd-6936-07e55d505e25@kernel.dk>
Date:   Fri, 24 Apr 2020 09:17:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424150321.38617-1-sqazi@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/20 9:03 AM, Salman Qazi wrote:
> Flushes bypass the I/O scheduler and get added to hctx->dispatch
> in blk_mq_sched_bypass_insert.  This can happen while a kworker is running
> hctx->run_work work item and is past the point in
> blk_mq_sched_dispatch_requests where hctx->dispatch is checked.
> 
> The blk_mq_do_dispatch_sched call is not guaranteed to end in bounded time,
> because the I/O scheduler can feed an arbitrary number of commands.
> 
> Since we have only one hctx->run_work, the commands waiting in
> hctx->dispatch will wait an arbitrary length of time for run_work to be
> rerun.
> 
> A similar phenomenon exists with dispatches from the software queue.
> 
> The solution is to poll hctx->dispatch in blk_mq_do_dispatch_sched and
> blk_mq_do_dispatch_ctx and return from the run_work handler and let it
> rerun.

Applied for 5.8, thanks.

-- 
Jens Axboe

