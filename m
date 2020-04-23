Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D3FC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 21:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5C1221569
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 21:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AYAOBoRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgDWVaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgDWVaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 17:30:04 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D58C09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 14:30:04 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fu13so2446109pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 14:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AB5ZytMJUHXlVP3YSGszONFmfmZDNo7x3Nwusr7BT0s=;
        b=AYAOBoRPdl6L/4Fo8en+/tV7gIy3BGyiJxf1u0Q5zwc99fvgnmRJXkmtVr6jR39d+q
         83VZkgYzjB9OM3N0fxgPOHfRhFq+h6b7m14l4K8JOxA7rFdbwU+2WBO3+SBhascU1Q/7
         GECquPJtqeF20GT/66R6waHmNFAmQb0wN/QGWT5f7jwW0ZWkpbz/Znpc8gaEjr0rZX8z
         8V+iB9bpFKH15nrdSOGKrZMbMCIRCa0IfzmGdVCtD13aatKaloeC5wG7IUskQzQesIoB
         tkmM7hGNu/2oo9juHmsp7Iqv9bTqNp3xeH6OxMXRuAgx8PcasCs/PI3mcbOtfi22koTM
         Hwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AB5ZytMJUHXlVP3YSGszONFmfmZDNo7x3Nwusr7BT0s=;
        b=sFzT88eyYKprAVMU0RpBXbAkoyBsezdW9ELtI7/PQW/xE+qYoH/F7qrZwOzawF9S1I
         yPKApLh+uBNILhcI5jgzpw+Qs5bvTxBB/5W4hh408c2TQJqzTrkMxQ47r9qNEMWYma7I
         +pP8dhCTiPaBbFCsW4tnY7/n+/hqFsbEf8BixWvucwfxxeoTH9VYWSx//ra+cb4T/ijn
         P6IZgo8dITE0aHePGfoubYJTzfBrNNlzK/QBbMrQ9akEFKCA8BdiWzqqFAyMH3xAZndX
         DV0Mq3jsEwR2b6XEGW9yya87KpkcchXjJBvCRygncfZjYUAdsJ3hQ1qiJTjy3eX7jA3p
         8CQg==
X-Gm-Message-State: AGi0PuYIicIfQuOy14RQndvS+r3mknTHGppgWkGrYSdy/dZIiLT2iP/Z
        gTz4nv/I6Cz56fRCNsROkU8AJA==
X-Google-Smtp-Source: APiQypLk93Z6mp1zYN4+eqxN7io/bR8mOsfCahnoGFL41slET+uQx9jM/f/OKAoyswJF8zlisvTMrw==
X-Received: by 2002:a17:90a:3086:: with SMTP id h6mr2859548pjb.49.1587677403695;
        Thu, 23 Apr 2020 14:30:03 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id 202sm2916212pgf.41.2020.04.23.14.30.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 14:30:02 -0700 (PDT)
Subject: Re: [PATCH v2] block: Limit number of items taken from the I/O
 scheduler in one go
To:     Salman Qazi <sqazi@google.com>, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jesse Barnes <jsbarnes@google.com>,
        Gwendal Grignou <gwendal@google.com>,
        Hannes Reinecke <hare@suse.com>, Christoph Hellwig <hch@lst.de>
References: <20200423210523.52833-1-sqazi@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <83078447-831c-2921-db5e-9cab4c4c12df@kernel.dk>
Date:   Thu, 23 Apr 2020 15:30:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423210523.52833-1-sqazi@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/20 3:05 PM, Salman Qazi wrote:
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

Any changes since v1? It's customary to put that in here too, below
the --- lines.

-- 
Jens Axboe

