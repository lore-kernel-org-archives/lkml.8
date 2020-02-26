Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BC6C4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A990222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgBZXK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 18:10:58 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43825 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgBZXK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 18:10:58 -0500
Received: by mail-oi1-f196.google.com with SMTP id p125so1317737oif.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 15:10:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=YRZcWJli+0cmEcksfyp9PEMRGXzRqaxqU0AlJqBzAx8q4payixNtqhHurWMTnNw158
         0rjvdE/kIzmwLsuIIWs5YB6AgZh3nt2fCf8MH4trK/dD2fPtfhMqXHVuy6nY4EPFmN1g
         uqs9u1cvnWo7xb2nKVjzwh07ejECVBMkJ/KZnaXmOuF8/x70BIQPTbzKB/Dt4F+gxgVm
         zQJYDhTCap2Kkv17nzUcZcJN/sBAlE3v+x2vk4HtwyIoopb78UsFHapTGVyEAZq2EuAz
         ud6IQiQvg3xlzgPM8d+SQYrVRa06ruZlhD+px+vPjahZhoFWQcWAYX0BIoe3CvMKL2EQ
         /Obg==
X-Gm-Message-State: APjAAAUMYtwZTDwaRnscI49zybbRtVDF2Ttebp5DDukIo0oD6r+BUojc
        BkGUraet4YFIV2apdtEy1zw=
X-Google-Smtp-Source: APXvYqzFFaZnvuDMnLAnxgWtgqkbNHcFeK+i8qkfD0Kv/zYfIHC7sD29HRx/eDwD6eIQZAV6h3GE/w==
X-Received: by 2002:aca:3f43:: with SMTP id m64mr1069015oia.165.1582758657360;
        Wed, 26 Feb 2020 15:10:57 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id z3sm98874oia.46.2020.02.26.15.10.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 15:10:56 -0800 (PST)
Subject: Re: [PATCH v11 3/9] nvme: Move nvme_passthru_[start|end]() calls to
 common helper
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20200220203652.26734-1-logang@deltatee.com>
 <20200220203652.26734-4-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b39e6dee-1175-64b7-61e2-27a25bb93d97@grimberg.me>
Date:   Wed, 26 Feb 2020 15:10:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200220203652.26734-4-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
