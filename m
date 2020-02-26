Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF53C4BA2D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5EF222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgBZXJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 18:09:26 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36210 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgBZXJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 18:09:25 -0500
Received: by mail-ot1-f67.google.com with SMTP id j20so1152877otq.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 15:09:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=XpDtuYkg8foBb52w+vNwnQJwZ8as3M19jTZC8olCJ4/6cpuWxVHPR3LS+3V0XEf5HO
         gwSM9/iIyhdTAQFlWUxu7vq8/iKgmeLgyPUoBg1njxVa/XYeT5qP8jWkIBqdNILzqRRo
         LV5q5XOkLF1/SxOb8ysaDcxcXlBYHqYhdQ1Wk2cVscWNc/Pmi89/gqXBZCDznWBQyB62
         zRwkt6KSVn5U4uxOsvWjpfvMYEwY6cuuG27hFaiAoo1mQ1QADVqxCpV+B9ClZmdfM8nv
         H1YsI1ugj8FKrzaNyV8dk9Jda6JAigKmyCHjRs7hjms0GUTaXCGpDdrsxu1YdjHebY0N
         CM2Q==
X-Gm-Message-State: APjAAAUzPbxHK7cwlsfP3/bLKycz4BuaAGa1WN+VyxZL2jvU6LZfICIU
        8YMiH3/tfrq5dJ/0ssBR70s=
X-Google-Smtp-Source: APXvYqwkP3uHJLircWTm7OAuwQwMi8hDhyyvFg7yCRw+uqfpZA7le4HeJdPqgRGNQPLFDmH8BAlEcg==
X-Received: by 2002:a05:6830:1d6e:: with SMTP id l14mr996105oti.32.1582758565294;
        Wed, 26 Feb 2020 15:09:25 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id j13sm1289899oij.56.2020.02.26.15.09.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 15:09:24 -0800 (PST)
Subject: Re: [PATCH v11 2/9] nvme: Create helper function to obtain command
 effects
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
References: <20200220203652.26734-1-logang@deltatee.com>
 <20200220203652.26734-3-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <60377f09-c961-10a1-9d5e-69326ff1f046@grimberg.me>
Date:   Wed, 26 Feb 2020 15:09:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200220203652.26734-3-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
