Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385F5C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C16720738
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgDUGuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 02:50:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38100 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgDUGuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 02:50:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id k11so15143907wrp.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 23:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r/GRNphXS0OX+tPDUFp4R9hzgWz3+xYIsn7uwbptAIg=;
        b=mGDfwjS2ZahrS/KpzkUwPIcav3PbKkX+IQwirLk28j9cyC90JO82D7iV3qd00BXpru
         1NjT2+g1cc4arIt1eP17V6RS2sab1DdcG40PuD59ERggdGZYtbJmz3S4JVEUEPDVsa0t
         fzuSdoizpG7xYQbOfSzqpsgQhitdiD+r8NSPdV063ys1M5URJkZdmYiGciokB3zy75DP
         1uWdYr2sALuwB7Yeuvi5sLxHBQFOIPYkcVT9+TO3mTtaF/CjwvjM6KCLgbvuMombE0JX
         2xYiGoTUK+evlqSGhp7ahd7mTjlmGlBVZA9M74GfPJlr2dryGMYcYjmI26mXcTSDkLob
         pTdQ==
X-Gm-Message-State: AGi0Pubz+Pmt+qKmmn1m0zLE4XLvYONfo1if57rpsdkth9cEyhkejNM+
        9zGxRnQIigOMszEApT3fwNI=
X-Google-Smtp-Source: APiQypIFI5jvJ996opkKsx+IGiqbmSbhza30P4hoiRyXPXlP148WSjJTpoWrLkl88Tb3MoDoFkjIoA==
X-Received: by 2002:a5d:400f:: with SMTP id n15mr22490736wrp.344.1587451852043;
        Mon, 20 Apr 2020 23:50:52 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d4f0:54a7:68bc:1947? ([2601:647:4802:9070:d4f0:54a7:68bc:1947])
        by smtp.gmail.com with ESMTPSA id v131sm2282526wmb.19.2020.04.20.23.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 23:50:51 -0700 (PDT)
Subject: Re: [PATCH v12 7/9] nvmet-passthru: Add passthru code to process
 commands
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20200420164700.21620-1-logang@deltatee.com>
 <20200420164700.21620-8-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e1883123-3b2f-4ade-a824-264ce3ca6d11@grimberg.me>
Date:   Mon, 20 Apr 2020 23:50:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200420164700.21620-8-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This looks good Logan, thanks for doing this.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
