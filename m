Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F49AC0044D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 03:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C093A20578
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 03:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SG5VD3z4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgCODhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 23:37:35 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46390 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgCODhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 23:37:35 -0400
Received: by mail-pl1-f195.google.com with SMTP id w12so6210377pll.13
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 20:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/+9Q8TJ7jtUHpxRJyGUZ1bL86SBe7tVjOmhbbOA4p4w=;
        b=SG5VD3z4MI8OduY4+2c3wYVTGDxZx6rfjOy9JvWLiHNHsY2hQyAoP0lwTCXSev6QbO
         ROubWXIRQkgbTJ2+P2NPwnxQAY5jSgsq9oNiRl6qOQO/u3mz/NKMzUiyFaxap0XDRYb6
         7OU8qGPjTqzxy+OwjkGyUlU9h6kWIB3H7s8mEMK/rPlLR51mo5OWHJs74cop8QLPfT/M
         8G+6wBz5Rvc2qvVTMnuPdBquQbW9CwJksbbU/Kqx3lyrrMq9BBBbh9BTuD7+eOTroTsM
         M/+Hlfot730nD9afcqDOp6rhHNZPe9QxozAI2p3v21Lkcu5LrtghZVuXsyC9Qd5P97o3
         0bNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/+9Q8TJ7jtUHpxRJyGUZ1bL86SBe7tVjOmhbbOA4p4w=;
        b=WKtIOIjSgJJFIWSsFvy1A5k38b8s+ZMZ02mLL/NNfegILc6uztb6CVTsFtBW0Njdac
         TsjYZpqTH5aRgQsxIEDYXyor8VTH3pseV3LR6z35gZAcBODlKfKj3TOqjnHPaJFlYES0
         /gnqwTrzyu1S0roI1mayhPbme+ZRfMp+dl4J9LFcK6kmEEMHd3vF0CbgG1tpReQnUC7h
         zpN+/59et8swk2E6kb9T1/wwDTfY06RIIatpLDZpSfj6TgsLGy8n2x3iosudL0ozorYx
         nOwUM35ZBF8uZVf2epM2GSac1DEMpqtHcqAinYJBhkqtrhx1N1XbRN5XlP6BLa7hc/qX
         SzJQ==
X-Gm-Message-State: ANhLgQ3k2DYSWclMqhp5O8cfW/03Fuv0fmcJlSnr6GtcFJ9qig3awYCU
        +7PhaDsoJTTwjPR+QqLYkGLWlRomkV7+RA==
X-Google-Smtp-Source: ADFU+vtUob9/wk2Xo5IPPKPI0Pio7lMK+3XwsB2YuJ0xrn4KtFRW2bv81Vj2/I2bo284+Z7N4zVwcw==
X-Received: by 2002:aa7:8b03:: with SMTP id f3mr20486548pfd.133.1584201520387;
        Sat, 14 Mar 2020 08:58:40 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id n7sm3779560pgm.28.2020.03.14.08.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2020 08:58:39 -0700 (PDT)
Subject: Re: [PATCH 5.6] io_uring: NULL-deref for IOSQE_{ASYNC,DRAIN}
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <3fff749b19ae1c3c2d59e88462a8a5bfc9e6689f.1584127615.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <62bc8817-5777-7f79-3c27-028a770e2f3b@kernel.dk>
Date:   Sat, 14 Mar 2020 09:58:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <3fff749b19ae1c3c2d59e88462a8a5bfc9e6689f.1584127615.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/20 1:29 PM, Pavel Begunkov wrote:
> Processing links, io_submit_sqe() prepares requests, drops sqes, and
> passes them with sqe=NULL to io_queue_sqe(). There IOSQE_DRAIN and/or
> IOSQE_ASYNC requests will go through the same prep, which doesn't expect
> sqe=NULL and fail with NULL pointer deference.
> 
> Always do full prepare including io_alloc_async_ctx() for linked
> requests, and then it can skip the second preparation.

Thanks, applied.

-- 
Jens Axboe

