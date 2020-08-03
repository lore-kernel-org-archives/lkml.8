Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8D7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 460ED2070A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgHCI3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 04:29:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36803 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgHCI3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 04:29:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id 88so33322770wrh.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 01:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=cFwYlc6MgLzOICgqzwcrqr4IKLWgluUWUIdTGJ4AEUk5oW37nrCTeSm42sq0/PlT7w
         eAZy14uIMKbRDHY4/IZwSDh6uNYTRlD21g6KjBuVsGmPu86BbmzqbP8HIDV6TPmcgaVO
         CP4kwnXGNbxZcfu2C/jbUIIt617p59e2b3foLW8bz3Wq7ByvKg36+aNJ8MuLPnaillDK
         RuxRP6jpD0d6FeTt37KG2IkR0eTRKgGgt4F6Ugsi4IkrG/Z1lowTNMnWynbKyJJn4Rq5
         mXgEiwx/r3cIbRvtFZakFKz5ftZXpBI8o28+8v1WEKIlqhMe56XFDJ/bSVZRinUZNiUV
         doaw==
X-Gm-Message-State: AOAM531l2F7QqoZIQyEvHSx/UEZLJg/wH59X+/bsju2/Oq2WFpmiIt8+
        XpnMHeBxwZUj41RlfI53NhETWpG8
X-Google-Smtp-Source: ABdhPJyPx3/rVzkllsJRPSUy4Uln2/0isGBUXD0h1FIFBnnuS6eoK6QJVjYkInrN0SJMUbG3t5N2Yw==
X-Received: by 2002:adf:f151:: with SMTP id y17mr15055163wro.179.1596443347274;
        Mon, 03 Aug 2020 01:29:07 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:6dac:e394:c378:553e? ([2601:647:4802:9070:6dac:e394:c378:553e])
        by smtp.gmail.com with ESMTPSA id m1sm5183485wmc.28.2020.08.03.01.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 01:29:06 -0700 (PDT)
Subject: Re: [PATCH] nvmet-passthru: Reject commands with non-sgl flags set
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
References: <20200729191009.4485-1-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4641649c-b777-b2cf-2c40-16c0c9d23cfb@grimberg.me>
Date:   Mon, 3 Aug 2020 01:29:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729191009.4485-1-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
