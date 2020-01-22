Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159CBC33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 20:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB08624673
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 20:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="z7zNVoDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgAVU60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 15:58:26 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:33124 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbgAVU6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 15:58:25 -0500
Received: by mail-io1-f66.google.com with SMTP id z8so756400ioh.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 12:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=4MircL4o+/KcGaydQPkSmj2rWDThvm1wQe092xveFAg=;
        b=z7zNVoDLPM4MKPRvTM8UcJmi0wu+n3yp7v7+XP9SWb4hRXrNU7h3WCwDGc1P4vU/pr
         1RDsoi29ohD4qtUcHvQ8YVj3VQwls6+TFceX3zfd6HPZyLZ5d2nUYL1gwbItGly6YDQ/
         S2NtkRpr/cc2n/3SgaFMbvs0eS168OjavvQHzbbqmK4j9iFfDgQTEmS2mHsV2YW0RcMW
         zcBAMt6NxOf8u0r10Zm4RBnrYnA+JWTjw0JMqfRjiaz0aHpWK24OVvrAWbwynBgiDRUy
         W+ArAyPuMeakUhlPKLAWTElfVmnwEmTSFh/F8/UOvrdl3yM/7qU6GShXUf03Hoy7DLmn
         ORLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4MircL4o+/KcGaydQPkSmj2rWDThvm1wQe092xveFAg=;
        b=QoOjfi5d+O4pdAV0+OOVH3e09khzPsPZHVVwyJrH07Q3umTmhqXglh0WjAtUXkssAT
         lOyE7lHGPcI2Wo33S1vT/sWQGn7zc1qw5EvOZopk4HKQQKn6eEOBtIz+Tjo4/fvBfKE6
         JhGurddhJE7L85tZ/hEykr35ZJoyrxs4xsg6MZLgS1+otj9zZlL6fblllA9S09BbLkig
         2aZyHAfRuBkmdOOGvE0q/+oi8/LEpgX9V4Ft6eCflyXHMqjY7ovnFRn3k5h//8p41TNT
         H2qtcI4/+9ZCOXk8FPff+S9e5REatPqsc5PADlxA1aPv12vcCiui9IT1GmKbw6JnUrDu
         a9/w==
X-Gm-Message-State: APjAAAX2H63t66Gn4dse9HgfuM8fQBYUoz7ky0JkwDXnbX9N4Us5I3rU
        r6kshL9MvlvXjJ9hvu0LMpv1flPQshA=
X-Google-Smtp-Source: APXvYqw1ulk/Wtf9YIzcaCdr/v609qPcVtLz2wSTPEoZNUkQaI5ybUqWCdtoDCzopR4fh1M5bypPMw==
X-Received: by 2002:a5d:93d1:: with SMTP id j17mr8768497ioo.300.1579726704741;
        Wed, 22 Jan 2020 12:58:24 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g4sm15020839iln.81.2020.01.22.12.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 12:58:24 -0800 (PST)
Subject: Re: [PATCH 0/2] IOSQE_ASYNC patches
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1579723710.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5722c4c7-ac5d-9a28-62e8-c327c6affc3c@kernel.dk>
Date:   Wed, 22 Jan 2020 13:58:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cover.1579723710.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/20 1:09 PM, Pavel Begunkov wrote:
> There are 2 problems addressed:
> 1. it never calls *_prep() when going through IOSQE_ASYNC path.
> 2. non-head linked reqs ignore IOSQE_ASYNC.
> 
> Also, there could be yet another problem, when we bypass io_issue_req()
> and going straight to async.

Thanks, applied.

-- 
Jens Axboe

