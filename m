Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B78C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 980B420702
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kezLch5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731718AbgGAPDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731710AbgGAPDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:03:06 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3FFC08C5DB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 08:03:06 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id t6so11866710pgq.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 08:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DLRduH9xJNt7ZS9P5WDmrk008CJ1C+7CjcjdXETEcJI=;
        b=kezLch5rrUi60jG33nK70y7LUB9APA6FNV9IRRpYujLnZiD6cgah+HbUs5mxIVB3Iv
         UCsyTT8ewKxA4aQ9WmcpJAEAqnKr+qbPdFyQPM1BZ8cimAYPwHUxO9C6q1YELSe4Mq8Y
         7aeGcm+RhHCl3kkvvdrMo7qf3qV0xpDO1KcOzmkzLVmwIQWZmdaTfsayNwujOipjjnbD
         EyQQWqC7onLnNpw6QJYDBSyn6hKRt/Lsi59zDlXC3VjXhnBKJy/LrRCr8FhIfendn6Uc
         loSWUSrzx0B+45R4DZNJERZhlrS97WEWdTSzmW4IxKxa87GBpg2vsViicTE5LNVGB1RP
         g82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DLRduH9xJNt7ZS9P5WDmrk008CJ1C+7CjcjdXETEcJI=;
        b=lIroT3hSF9Dym14nE8zGmLqrKu29/eIitC8NElvoC1dKIfksyvo3qlXQj71ZGIn2Jp
         RkWXZNY46vcCEiGzjmbWDNNWuGc8BSHdncjfMZZkPTALujLzRR8zyj1gan2SgBs4WBv1
         yP340cAxAUAU/nCl6sg3TBMtli+pMVmdMN+eV6HW3fY2HUQGjZYDxwOVqp/O2tq/1ww+
         uMeCWM8hJoaTK75cUgzYUFiS4UtQBMkDg5gsF2NBA3knMymAjnqU8BbZeGzxfS7Z7FMW
         JZd6bh/y800Qe5VydrCk4bPtBAEWe+YcBVrxLLFJ16Cyngv70kxW8+CFRO4UnbYzgiWW
         Q+4w==
X-Gm-Message-State: AOAM530/Ylj36pjdziGYSqbT621mNPct4MNNyVe2IetRN+ldYyM7LzxZ
        n8vb/5xSODDKNNKjWow0dl1/GohSYxyn8g==
X-Google-Smtp-Source: ABdhPJyEMQjmd4pVZ5/DiX5oXot2zrsoeDUo/MeGVueczQlp+jKJnQA3AfgeveMKyiC+Dq6CQ0urmA==
X-Received: by 2002:a65:46c9:: with SMTP id n9mr19427865pgr.89.1593615785237;
        Wed, 01 Jul 2020 08:03:05 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:b704:bacd:526c:5cf6? ([2605:e000:100e:8c61:b704:bacd:526c:5cf6])
        by smtp.gmail.com with ESMTPSA id e5sm5355655pjv.18.2020.07.01.08.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 08:03:04 -0700 (PDT)
Subject: Re: remove not needed fields from struct block_device
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200626080158.1998621-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2ac39125-7b19-c692-24eb-6810d78c94e8@kernel.dk>
Date:   Wed, 1 Jul 2020 09:03:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200626080158.1998621-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/20 2:01 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series put struct block_device on a bit of a diet by removing
> fields that are unused or rather pointless.

Applied, thanks.

-- 
Jens Axboe

