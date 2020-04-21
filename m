Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5015BC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E40C2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgDUGsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 02:48:08 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53460 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgDUGsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 02:48:07 -0400
Received: by mail-wm1-f67.google.com with SMTP id t63so2253310wmt.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 23:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=b1/564aNkDj0Z24zO+RfKAbraVOpfbezUF1bC4vZSy/FJTth/ko85XVa+0ZveWS4AY
         RoqsMurFbMVK3OA0QrHGGOkGVzx8erFzSSjXYFvDJJF66jixbh4keNf5a5DZIr7O0Sba
         J0XQ0TOC/5gT0BIH4aZRQ+gToENJsgbUWBPhKbU2CKc+gEzh41jN1e0SEre0cUzoXv25
         59mihvMq9vbFK0Qa84o8zMRhDr0jNjsFcExT3gMLG5WOe4JlM+NGOgFEkvHRC5xpuO7m
         pHd5OSqiDjahtywUhbuMFBI8rptJ1bjFRbYk/jfxHzoKosQ9Jj+1k5YCUjawlR+JkjWr
         DFSw==
X-Gm-Message-State: AGi0PuYhxB4Q2/Fju6pkuHOSHFsIoxUDrLdGsUb827q14V3mfEfP9sTj
        7NPZxbRkEEC5ZLKcvF1DuS0=
X-Google-Smtp-Source: APiQypIGSNJv8r7Y3Pzy43DudQ/5nAvkOn3xIpJfBHpfk64L7Mff5dWrql9U2kJycOd775B74gR2Gw==
X-Received: by 2002:a1c:9d84:: with SMTP id g126mr3016814wme.184.1587451686268;
        Mon, 20 Apr 2020 23:48:06 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d4f0:54a7:68bc:1947? ([2601:647:4802:9070:d4f0:54a7:68bc:1947])
        by smtp.gmail.com with ESMTPSA id t67sm2342839wmg.40.2020.04.20.23.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 23:48:05 -0700 (PDT)
Subject: Re: [PATCH v12 4/9] nvmet-passthru: Introduce NVMet passthru Kconfig
 option
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
References: <20200420164700.21620-1-logang@deltatee.com>
 <20200420164700.21620-5-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8517ecb8-0ec4-07e6-380d-91db65660a8b@grimberg.me>
Date:   Mon, 20 Apr 2020 23:48:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200420164700.21620-5-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
