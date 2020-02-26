Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D94C4BA2D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA46F222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgBZXML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 18:12:11 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35428 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgBZXML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 18:12:11 -0500
Received: by mail-ot1-f68.google.com with SMTP id r16so1162503otd.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 15:12:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xT/4YHu6eXt57o062HOZgaUM2lsiqS+nuNgzgWv1QG8=;
        b=s6/65fGUhRSqIIFVaEm+PbW+SQzWPvOAbufwxEfAQbcCC4f4/koPGpLZAeYs1VuNZW
         6f1gYYu1X0u/TAkLreqBaASFLHyctv7zJQ45Z+figesC4OSlyRx6VnBBsBlLLo/Axnx+
         0F5GDx3gsPsz7ble458VDW4os4a0qf7pn6JD8pB4xA2SLE9nts2L88wEyoCDv5pN7CU8
         Y4xKBUKPYaZt2jCO7b06NxCHjiimup2/vbo3JlC6ibPgU9zAYfEx2Cp4Az139BaVH0yU
         EQSRNya8yXZNraZcXDk5dONlksTisPsmD4wgwIkhB87/ryd2n6zwtPL87LZ53J/BuklR
         aPbg==
X-Gm-Message-State: APjAAAVFEdcn9qv/WXQjtZXN61awAF28rAp4T3NTbTcIAXq7zdSOz1Oj
        gSICrNjfrq0r00oIMdgmxM4=
X-Google-Smtp-Source: APXvYqyjxPkX16QhKV9RUQjlv9snQckBzObEW4Lp2XOmmkq3Rrz8VlOnaA+0LZGkemt8F7aKcz4HMw==
X-Received: by 2002:a9d:6a53:: with SMTP id h19mr1038729otn.120.1582758730729;
        Wed, 26 Feb 2020 15:12:10 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id c10sm1264405otl.77.2020.02.26.15.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 15:12:10 -0800 (PST)
Subject: Re: [PATCH v11 4/9] nvmet-passthru: Introduce NVMet passthru Kconfig
 option
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20200220203652.26734-1-logang@deltatee.com>
 <20200220203652.26734-5-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d1cc35d6-faa3-42bf-ef44-dcf8ac7791f9@grimberg.me>
Date:   Wed, 26 Feb 2020 15:12:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200220203652.26734-5-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +config NVME_TARGET_PASSTHRU
> +	bool "NVMe Target Passthrough support"
> +	depends on NVME_CORE
> +	depends on NVME_TARGET
> +	help
> +	  This enables target side NVMe passthru controller support for the
> +	  NVMe Over Fabrics protocol. It allows for hosts to manage and
> +	  directly access an actual NVMe controller residing on the target
> +	  side, incuding executing Vendor Unique Commands.

If unsure, say N ?
