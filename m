Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9EFC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 02:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE9320732
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 02:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PGno+Sbo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgBDCns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 21:43:48 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45631 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgBDCns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 21:43:48 -0500
Received: by mail-pl1-f196.google.com with SMTP id b22so6621157pls.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 18:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bLnbFVejd+3O1F2qSJJv9BCdZUK0W2Xr7EIvWhOc4yI=;
        b=PGno+SbowrIU8CKbP76n7XJnkCyx2RPzHD8cjSZKYNNQ+5PDRUyfuygaDKnX0jdF4H
         fN3Ru1Vy6qSCGSAF8pTm4AiRKc/s/9cwJjWAQjBbM2DM62cg6VhLmF1o9nB74Ik+pYKI
         tkA82JcbrFs/daJ29fMcfAKpJF0+O2O3+WGZbRNE9aJQXLmeBW8mvLEbHWGvdgxAdS4P
         D7ShfiG3j4/aFD+DFBZUHDE1BlCU6sXN4e/u1PsjOuSqyPEFqwNz/anE3iSQPvu+ib08
         3kMVBaOQHm2hoa3raW+IVBY/PWtCtNikvghn+PhIBgyz+hYPmDN+yOnMYMqta6pa+HjB
         Mk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bLnbFVejd+3O1F2qSJJv9BCdZUK0W2Xr7EIvWhOc4yI=;
        b=RO/J/BP6gxmdTVQoVUlmuSooSz5rVBfz2+3AhEjBDvURtElNAziPg0p/9Uk9BXWI9z
         30lHvcz5pJR1l53WgrWTm0Tea/RY6flAC+mNG2JJJaTM1999EH1l5JD8wmyJHOvbibTE
         noRKEVqFFmwMfSl/w2KR8+ZyS3rea19kqBfV4oVN6OBQ6964d0BKH/7N1CdpTkY/o+2N
         2n/kqdjGcC5HXA/ycfb4xts7LEj8TGA+HuLyR7iNcrxXXKrZF8WUfpYzQEPq28e8iEiR
         wmmfOxeWrUdsY1gRu5Z2m5HbCrLcgEAw+hhf5d/ByYJZu8AsmDu7yn0e376HNBI3cOJH
         LHQA==
X-Gm-Message-State: APjAAAWiQQB4VDcy1qJtTo2XR/dzkdzDMXkY/FS0c4723Jkpj60R8pB4
        vROX6o0uwbYQDSdUxx+Pri/fKgKlwCWeIQ==
X-Google-Smtp-Source: APXvYqzc6ciA9jRBi+H4LmQjqeOjXZrmG//h1JNiFsJW8mgEPZYLd9jRNeOJEU9ROi1FuxWxvdVw1Q==
X-Received: by 2002:a17:902:82c5:: with SMTP id u5mr26272336plz.219.1580784225969;
        Mon, 03 Feb 2020 18:43:45 -0800 (PST)
Received: from [172.20.10.2] ([107.72.98.248])
        by smtp.gmail.com with ESMTPSA id r66sm22716079pfc.74.2020.02.03.18.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 18:43:45 -0800 (PST)
Subject: Re: [v2] nbd: add a flush_workqueue in nbd_start_device
To:     "sunke (E)" <sunke32@huawei.com>, josef@toxicpanda.com,
        mchristi@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
References: <20200122031857.5859-1-sunke32@huawei.com>
 <aaa74a5a-3213-7b97-7cc4-89686d985ff2@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <03c783e2-dbb1-5807-90a4-1d51e965a0b2@kernel.dk>
Date:   Mon, 3 Feb 2020 19:41:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <aaa74a5a-3213-7b97-7cc4-89686d985ff2@huawei.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/20 7:28 PM, sunke (E) wrote:
> ping

Maybe I forgot to reply, but I queued it up last week:

https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.6&id=5c0dd228b5fc30a3b732c7ae2657e0161ec7ed80

-- 
Jens Axboe

