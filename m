Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76022C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 540EF2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nKgQQLul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgEHPsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 11:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgEHPsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 11:48:20 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82211C05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 08:48:20 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k18so2260992ion.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 08:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3Yj/VWnxuwVscg+Ow0r6vDZvPUhARSnW2zWYKwQkrpg=;
        b=nKgQQLullofD+pnK7JXZAiS3ATo+bky/bI583PXN4MSy5nR/lcFS/WE9d4TqceYGSQ
         vwbmFJK1RFdd+ZyTeBd6sDd8iRLQIMqly96rE/eg/e0dpib+xK5gonq1nzfqsGGTi3cj
         tkpSJL2Z2PLhFzmZFFpNEgCVbrhFAnGTyzU51KrzqgTiPDnLY7+kQfakiJmiXrUfDgTS
         +5Xs4mbMOrqTnCVycdLFSHSw4zJYElSY/m9hFi5B6bNn5zguLK55+PmXSC5cAvGgyv4A
         vzNQjvyo6QKDzwEOLYd0PoaDqP64eIZScGIGoC7O1djDtAgyqpfCAPzcQyCfQeY/7Cgp
         Ap7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3Yj/VWnxuwVscg+Ow0r6vDZvPUhARSnW2zWYKwQkrpg=;
        b=irzS4dupvdOrYbySnZxVno6DcNaInvKWqc+6684hnieiNrmSot3poJXrR5YqaWMMxZ
         72FthsT+qYHmvBhXMFHqUvsD/xlNA5td2BJwVU6sOXIONwy+oYwdaHHKtNznUDqYycDN
         Esc19XqFpiXFUXJi0D30rcKr7qDHE4HwvBGBsfzH0CgF+Jgi6kCm1dqz6xWNqJ9SyFNj
         wQSa7tckDSNehc5INCbQgfDsJSW0wk4nMwkzz8ysnmYrTg2qQCMS2dmNvKgjsN7qcWFL
         XN82nG06zM21JXeRyidMXLKWRJYKPgolsKa41vLIEpZ8JrvnSvuYBlKKnyGMyAuIQ5b1
         RcXw==
X-Gm-Message-State: AGi0PuY/egYFXJlZhxyqp2R1ErhLmJjynbG2/JyDNcWPdipH8YQkFOjg
        Y4HsKxpauNZscfleuGMn3KoxApdD6d4=
X-Google-Smtp-Source: APiQypIwoCayfrJ+5VgfQJCl3htbKpqdhZ706qrKsseh3LXYReBHJ75Lu/8AozesVU13tEq/sC961A==
X-Received: by 2002:a05:6602:2e0b:: with SMTP id o11mr3143321iow.94.1588952899835;
        Fri, 08 May 2020 08:48:19 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y15sm942871ilg.21.2020.05.08.08.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 08:48:19 -0700 (PDT)
Subject: Re: linux-next: build failure after merge of the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yufen Yu <yuyufen@huawei.com>
References: <20200508152833.7e840076@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c2c822b9-c5d9-d145-9a05-25ed02f14ad0@kernel.dk>
Date:   Fri, 8 May 2020 09:48:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508152833.7e840076@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/20 11:28 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> In file included from include/linux/kernel.h:15,
>                  from include/linux/list.h:9,
>                  from include/linux/module.h:12,
>                  from block/bfq-iosched.c:116:
> block/bfq-iosched.c: In function 'bfq_set_next_ioprio_data':
> block/bfq-iosched.c:4980:5: error: implicit declaration of function 'bdi_dev_name'; did you mean 'blkg_dev_name'? [-Werror=implicit-function-declaration]
>  4980 |     bdi_dev_name(bfqq->bfqd->queue->backing_dev_info),
>       |     ^~~~~~~~~~~~
> 
> Caused by commit
> 
>   0f6438fca125 ("bdi: use bdi_dev_name() to get device name")
> 
> I have applied the following patch for today.

Thanks Stephen, I have added it.

-- 
Jens Axboe

