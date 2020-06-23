Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A19DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0967A20774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387636AbgFWRkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:40:01 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:51130 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387564AbgFWRj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:39:58 -0400
Received: by mail-pj1-f47.google.com with SMTP id jz3so1786436pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 10:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=LHpHDH2BJksLP+jVFyWOvoHv2TwTTN8u7YtsUCr6dRFypiwHg//jToVZBYRIlRAfEk
         gJXm2PW+dZxkQPG96/WRQaDlKvgR8paWZHLINAKkfmxv17b2kMeuLS7O1qIKwnVls0+e
         gOglO65g8TqtPSvWp8yAy1RW7ph43XS02UbhiLlm9ZXKDOJYxFkNqGGpdBFPDulS3snQ
         rtGt+VGVnHxLO33gvupMyek6tHFxhFlJphOzhixhZVfUuwGsvWisVWSbvwyC7RD1skz6
         rufgrJtSFrgysd0p11DrdxyOaR72Pfi1KrnhFdvO4mjNRuSQ10xM8ZMg9bSthjfS1NwU
         o1cg==
X-Gm-Message-State: AOAM531aVmEOeB4BNbeW30EJjogZsukd90N/8rL4FANClSsYuABvVNCA
        iyuwV8drf8HkSdpLPiSK2XumCwTq
X-Google-Smtp-Source: ABdhPJy5yNa9YCh5UqfALz8PSpQpHx/uLWc0fOou3IMn1j8a8eVkY6oZe4ui356rmDdzLOrCbq0HBQ==
X-Received: by 2002:a17:90b:1a86:: with SMTP id ng6mr9447871pjb.88.1592933996847;
        Tue, 23 Jun 2020 10:39:56 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:acd7:a900:b9f:8b8b? ([2601:647:4802:9070:acd7:a900:b9f:8b8b])
        by smtp.gmail.com with ESMTPSA id b24sm17087560pfo.112.2020.06.23.10.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 10:39:56 -0700 (PDT)
Subject: Re: [PATCH 3/3] nvme: Use USEC_PER_SEC instead of magic numbers
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, kbusch@kernel.org,
        axboe@fb.com, hch@lst.de
Cc:     baolin.wang7@gmail.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
 <a64d35465b8d91ab11f37d814ac10003da7804b8.1592916850.git.baolin.wang@linux.alibaba.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c2b796ae-a00e-7368-e60d-1fea473cbee9@grimberg.me>
Date:   Tue, 23 Jun 2020 10:39:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <a64d35465b8d91ab11f37d814ac10003da7804b8.1592916850.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
