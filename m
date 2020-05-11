Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9C7C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA37E20746
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OhYCfZln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbgEKPGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726687AbgEKPGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:06:45 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DC5C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:06:44 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a7so7940086pju.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iT+tdYyqRDgvuVMsZ4OGGMIEPSaNDFZn3C4PrbVyaUU=;
        b=OhYCfZln8xjCNrXA2rqmTU75wVWvESusZ6O14FJhML3HhfyAo7i7ldiGJ31d4HVsNv
         r87WYM0ILVN5YPujOd+ZKcuR1R8IV9MQPiL/pz0J1GRV8Ph3SUHQQpmF8mo9EZWGPmQV
         QbP0EE4Wc4FVU/awlsy5wHBbjHR6UJa+NCBtbvE/6RpjHKdYVp/YvhahaEuOFpkXRXNz
         w8clS7Ftclvee0JAVShDNPtDgelorrDCSng1VrJKlVcveB1ZUWCk7hKpGXkelddoV8Y3
         ERutYhF4O4Ayp1f5xMqVinb43IrePCtwteTV/2VtvHbFha9CuOjk4Va4iFVSQGMJOGzR
         8OUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iT+tdYyqRDgvuVMsZ4OGGMIEPSaNDFZn3C4PrbVyaUU=;
        b=g9pUMJEHWaYveGU6EVRN9votoagSfUN/3aumFy585yH5UrEmOCGGnBp1TO8i7Y0/YC
         mnk/mULd9TEkQMny04L022yFw/T8ANZWqqFOZTFTCU6UKqpPVM1t8GXGREhnAMeu7Rc/
         XCt/w/pphMRkcQCWojQ7UQtsLZ3jVxSlX8ifpIbXT500KahmH5MmUuVZzBrwNd0V+tvk
         ldT7N3nmlBiwbUH2PnWx9PbrQmw2FLOsvbQam94yy/PmUibAtAI1umPBi+Hr61AhZVuO
         9prZNzrKJWQImYsXxev7+pVyuHak24KnQOaQ3O3qAxiZfuSgVlqrq80pXnUMbZQ95q4x
         DDDA==
X-Gm-Message-State: AGi0PuYVp8XoOngjyCnm+cf4/dRWzj7E4C1uw92cBp6t41PvvQl9qf0l
        JLpIoNoKVvQvKxzcAX5NoFpjIw==
X-Google-Smtp-Source: APiQypLprHSOYRv+5f5iwrFg5ANEyN/qPI/31A2kr4NNqRxzEAw55I2AEq2Rnk8oRGwlwY3KhEaD9w==
X-Received: by 2002:a17:90a:f40f:: with SMTP id ch15mr19417129pjb.178.1589209603637;
        Mon, 11 May 2020 08:06:43 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:2dd6:4c58:486d:263e? ([2605:e000:100e:8c61:2dd6:4c58:486d:263e])
        by smtp.gmail.com with ESMTPSA id e10sm9395447pfl.195.2020.05.11.08.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 08:06:42 -0700 (PDT)
Subject: Re: linux-next: build failure after merge of the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>
References: <20200511142756.1b7ef706@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <74a0ddc6-8637-c821-7128-4431261b0c12@kernel.dk>
Date:   Mon, 11 May 2020 09:06:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511142756.1b7ef706@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/20 10:27 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/block/aoe/aoeblk.c: In function 'aoeblk_gdalloc':
> drivers/block/aoe/aoeblk.c:410:21: error: 'struct backing_dev_info' has no member named 'name'
>   410 |  q->backing_dev_info->name = "aoe";
>       |                     ^~
> 
> Caused by commit
> 
>   1cd925d58385 ("bdi: remove the name field in struct backing_dev_info")

Gah, thanks Stephen. This series is looking less and less impressive,
fallout for both 5.7 and 5.8, in terms of build testing (none).

-- 
Jens Axboe

