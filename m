Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AB2C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EB5E2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgDUGsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 02:48:38 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:54860 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgDUGsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 02:48:38 -0400
Received: by mail-wm1-f44.google.com with SMTP id h2so2245128wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 23:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=ChurfBTPp1FLjDOoo7PmzT2yLrMCrhufu5bq6oxhsBwrnU0/sVFCmyWuea4HEDNaOU
         nMSjOmSnoF6M6Di26K/gTsqZjlvTPpqR70ml4GFPBBABv23szUyV/D2doiSZvd6PvGvB
         y7mLTd+53+mQ+sTuLBe0Hc3eqFq3uuLbpBKNngQwuPY3JUj+8so4jMOXH6VeGkcdDoOt
         s84yzU39QZv1hIbL7DEDWXCGuab2g3yDZ7DL2IYeAA8xyGByUELr7BiaXGJa0p9QxTjT
         rt7Awim22/3BC9R3ONxo0fVoA9MIv+d60edwT5+vCq9jemWKDdw/CH7R2FIzGMompLhL
         fHuA==
X-Gm-Message-State: AGi0PuZSFI/Rdu46Pl5DCZ02hZWVIKMZ8ZH3sZ7bEjBVbCZejSG6ttKc
        V36zmQt4Ld6Oe2CN920YxQ0=
X-Google-Smtp-Source: APiQypKsgr7fjMjZ8sDRXnwjXEEggw3b2Y289+BZrqBKARlrbAutDjCSNHuIXSYlZGGr1lhbDkcS7A==
X-Received: by 2002:a05:600c:21d3:: with SMTP id x19mr3227447wmj.60.1587451716277;
        Mon, 20 Apr 2020 23:48:36 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d4f0:54a7:68bc:1947? ([2601:647:4802:9070:d4f0:54a7:68bc:1947])
        by smtp.gmail.com with ESMTPSA id i6sm2649234wrc.82.2020.04.20.23.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 23:48:35 -0700 (PDT)
Subject: Re: [PATCH v12 8/9] nvmet-passthru: Add enable/disable helpers
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
References: <20200420164700.21620-1-logang@deltatee.com>
 <20200420164700.21620-9-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9f885add-aa53-6d63-e97a-ed033e39e7fd@grimberg.me>
Date:   Mon, 20 Apr 2020 23:48:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200420164700.21620-9-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
