Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDE2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 967B42067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="NRmx+ioE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbgGHNRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729202AbgGHNRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:17:39 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF04C08E763
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 06:17:39 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id o18so46063635eje.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 06:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=PWRsLjeSIRxFVm4lyVcX8i8BX8wAJXIoc5VxUkUZwHw=;
        b=NRmx+ioEz6/FYs1tzoxGi406btC1lF515cu2m+XhPpoZlDvLC8m4Rx6T02t1upk6NR
         U/YFLRrHV/9kv25tgJgmmU+kkk7cmuh9uB1y5Js51AfgxLzxY5x+eNIbEdT32C4Q/HLL
         l5EjfsqCgr4kUPL0bcbfmiompBtODUlVy++jzvY13da932wqsypwIexKAdETrFHtDeSj
         8ZIPwD12o35KK35d9Tk9KZ59lTx7605Hr2TG81u9wbmlZogkmAEVlkoTBILQa4FbWk4n
         rgn+F9UIc2OpOgNDVudX27htma2p8jjwRp5zXUilqohiabSLqBIGwOoOQh9Jcn0xLoFU
         I0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PWRsLjeSIRxFVm4lyVcX8i8BX8wAJXIoc5VxUkUZwHw=;
        b=qDIfwZfmFw2sNvd/CG8HqDuFlxnhZrSggOQrYNz19WFvMfjXZnEmh+zJ2Li5nIlyd4
         YeIhCK48nKkc9wHzRDqAEIaqBEt9qr6zQjNbbjNl+yKruAO5aM6R8NoOZp9jKZFRvwDL
         AZK5NFHi07YnoGGZNYkwJ1GddcRpXiLkMmzOMfu6zoYQvu/svueVrXgOaB/w/LvBMKRL
         biu+hWZJg5cZH9B3jXFsrE+QrkqTKiaXmGCfekOh9RCZ99/0WVwXuatHjwyk6ZJuZfYy
         0bDIGjWs4rsPNbUbTuW8OHC+P1VoPiwkZNXcFSrcVxnJK+4uqrEkQqNLMsOI+LRxL4hf
         4tmw==
X-Gm-Message-State: AOAM531abWAXiYgHesTFG0KfcR6buNRDxd5NTeFXlyvT3kxdEPWmp96U
        XPMk8e9sqpCZTw23tfZCmTGZmA==
X-Google-Smtp-Source: ABdhPJx7XbEfNLIvzfMD5YcR7uo0UHrzyQNYYq/K3eHOh74wxiayjkW/+RfyzznIvuzgU4MrzouyJQ==
X-Received: by 2002:a17:907:1051:: with SMTP id oy17mr53833820ejb.394.1594214258033;
        Wed, 08 Jul 2020 06:17:38 -0700 (PDT)
Received: from [192.168.178.33] (i5C746C99.versanet.de. [92.116.108.153])
        by smtp.gmail.com with ESMTPSA id v11sm1936527eja.113.2020.07.08.06.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 06:17:37 -0700 (PDT)
Subject: Re: [PATCH 1/6] md: switch to ->check_events for media change
 notifications
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200708122546.214579-1-hch@lst.de>
 <20200708122546.214579-2-hch@lst.de>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <09cd4827-52ae-0e7c-c3d3-e9a6cd27ff2b@cloud.ionos.com>
Date:   Wed, 8 Jul 2020 15:17:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708122546.214579-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/20 2:25 PM, Christoph Hellwig wrote:
> -static int md_media_changed(struct gendisk *disk)
> -{
> -	struct mddev *mddev = disk->private_data;
> -
> -	return mddev->changed;
> -}

Maybe we can remove "changed" from struct mddev since no one reads it
after the change.

Thanks,
Guoqing
