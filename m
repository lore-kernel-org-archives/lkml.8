Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56728C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E60A20671
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kN0PmvDM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgENOHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726087AbgENOG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:06:59 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6B8C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 07:06:59 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id n11so1284633pgl.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 07:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q6a5nhhtlwC3I5RzWhkpkIibe9GsSPKfDndfMfvdcTU=;
        b=kN0PmvDMVtljFEv8ZZiWnVY21ZcFZaTdWSR1rQHlizhryKZoT6g9M4GrlsOwKVeqJq
         ntH4vWDYpi91xUTxHfxrLJIJzhXSE+RLmZiXwTZ9Owk/SsspqFBnyMD8YCSLlgaSkK46
         eF0z/hFDoYIVfwK9h6M5JYCKKus1Bv7kWrO2ZNsAMHINFO3qgY1FwSzhCeiVmBwXTGNg
         cHPze5zERq3uZ3+sW6yXhCusceImIEWPrA6W5Dzj8mfjw3giik3sNdVcQCk0KFgbY77k
         eeStU+Y2el2jtJs633pADino/pFOdlt+CZ8sNVncMD6jYCxLRfcV+UUaD0iyePkQydpt
         hnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q6a5nhhtlwC3I5RzWhkpkIibe9GsSPKfDndfMfvdcTU=;
        b=bGdLopEvowBo1RtMGA81p7u9pNqC8aAUhJ8809ZZHW3XvTxjQAtU/LvfRWrCuP5hib
         PgoHX6LNMhSToMy9caTeXBRz2iUW1m1WvbGzEjxCBKPhzuXJnavusZCMFE8+x2xEboLE
         LCq0N6ifaIdOg1cwhTP2UQvgZdKphRhRLZ56SOB+Osw76HPk175D0/LFf2YKQOiaY2qh
         t2jB4Ly5yn3CBQbJ9GYn6C8SnOLCGKWLz68tOiuoBfYLIPSQE3zWm9NKxSC+SydL9JVK
         RONETwqKMxnpviUJ1eGTBCA8ml1UjI4V6bYTlEYtS+ySuoMaBPdbELPbKSKMUu3PqWNk
         tdvg==
X-Gm-Message-State: AOAM530AYzGABGmc/ylZOrv0R0evJsA06pLcA6AGHAzTRr9NmkeGgQ9O
        PA+3vJVp7NFamwk/2rbqB0JMFg==
X-Google-Smtp-Source: ABdhPJznyMcs2R1vd0kHKH4cBcFVIp8kNX0MWajfDDv2D4gE7p+9fLnw22AzwjVOeCG7+qIXLh5N4w==
X-Received: by 2002:a63:5225:: with SMTP id g37mr4043696pgb.230.1589465219177;
        Thu, 14 May 2020 07:06:59 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:a45a:373e:9b20:39ea? ([2605:e000:100e:8c61:a45a:373e:9b20:39ea])
        by smtp.gmail.com with ESMTPSA id g16sm2450843pfh.217.2020.05.14.07.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 07:06:57 -0700 (PDT)
Subject: Re: linux-next: build failure after merge of the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20200514185737.701b40dd@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b2fafdce-2616-cad4-79c8-c8186e4e0272@kernel.dk>
Date:   Thu, 14 May 2020 08:06:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200514185737.701b40dd@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/20 2:57 AM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (x86_64
> allnoconfig) failed like this:
> 
> In file included from include/linux/blk-cgroup.h:23,
>                  from include/linux/writeback.h:14,
>                  from include/linux/memcontrol.h:22,
>                  from include/linux/swap.h:9,
>                  from include/linux/suspend.h:5,
>                  from arch/x86/kernel/asm-offsets.c:13:
> include/linux/blkdev.h: In function 'blk_io_schedule':
> include/linux/blkdev.h:1857:26: error: 'sysctl_hung_task_timeout_secs' undeclared (first use in this function)
>  1857 |  unsigned long timeout = sysctl_hung_task_timeout_secs * HZ / 2;
>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   e6249cdd46e4 ("block: add blk_io_schedule() for avoiding task hung in sync dio")
> 
> linux/sched/sysctl.h was not included since CONFIG_BLOCK is not defined.
> I have applied the following patch for today.

Sorry about that, it's fixed in the current tree.

-- 
Jens Axboe

