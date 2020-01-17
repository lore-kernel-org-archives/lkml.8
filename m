Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE722C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 04:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53FF2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 04:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sxc0BE3O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgAQErc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 23:47:32 -0500
Received: from mail-pg1-f177.google.com ([209.85.215.177]:40412 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgAQErc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 23:47:32 -0500
Received: by mail-pg1-f177.google.com with SMTP id k25so11041154pgt.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 20:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=A+4aYu/f+LLI3Jw91RLfV6RdAoA39tW2N/DHyvDL3Ik=;
        b=sxc0BE3OoszJC5FcjG40xTs59ymbvxykkUk8mBvmvm13L2O1sRFFxW7xoQbhpSHgf5
         zBpes8RCdcKhjcpAYj+e1ZpMYfNZb+V3G9DsJxiAOG7j3D06dMgyaXqV6aXcGkpliwi3
         +O7pml11pdBF8JcPPKcJ5hhqz53FCSgApNqw1/SVeIJFPNbpz+SBuBC3cD8mtpZwOewv
         FmCsN7Y72mFfR7chMz/5lm3hczCSBAA81+964CHZyVYUER3aw2clkom8/7Ul9tP2abxW
         c6A37jME6MCwBQ4tjff8WLidrVhe/bqqnDNBYqfQMtgGA8zhJBp6z6SfrQxSpSBPAYpp
         vzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A+4aYu/f+LLI3Jw91RLfV6RdAoA39tW2N/DHyvDL3Ik=;
        b=DtRFGq3OQeQqiLs4uKj8Rhs91vYly+qpW5rM0Hu+ZyqDcnkH2IvdvPZzndCpQpC5YU
         spzjzdhoM9kdayoBHhmh0WByU9Lmx5Vg0W7DmQ8SHbrUYF1B0YmqgOP8+GsMYX0EnxkS
         QvXqdz2mHuW6d+YPanG0aBKYOHDcBqtR4Maceq5Is+DY0ephzjtnxubllNWoYkvXdPdj
         d8Adc1FBlrP8Wd2rkQd28mpPT8PUKGl81q2Q+cEExHC1N9GgxlhlhAe3/szp8nRZqMq9
         8jD4ahGcGbPjqUbSlZkrIvIPeiM/ocRYibxT/j4xaDV/s9paASsNt0oFPH8PY+JxJg2w
         hb2A==
X-Gm-Message-State: APjAAAVphyhksfdQWq+G8jy55mOZVVciIw/x5YepuJg59544nXmyivzo
        RMpebRVUxu+f4yj3J0eGWS9CKUaPVaA=
X-Google-Smtp-Source: APXvYqzvatyId/eBVFoH3KLoXBu5HUCClzB9UM6crG/QSDY1KoMfVERKvTxmUsdwdnzcWDs810WGXw==
X-Received: by 2002:a63:d906:: with SMTP id r6mr43590024pgg.440.1579236451548;
        Thu, 16 Jan 2020 20:47:31 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id z26sm28299448pfa.90.2020.01.16.20.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 20:47:31 -0800 (PST)
Subject: Re: [PATCH] io_uring: hide uring_fd in ctx
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <2aefced4902f33f2b70aaedc32bc8d60a20efd7a.1579225489.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e0d0eaea-3bda-ec22-0da5-8cfbeaf3f42d@kernel.dk>
Date:   Thu, 16 Jan 2020 21:47:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <2aefced4902f33f2b70aaedc32bc8d60a20efd7a.1579225489.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/20 6:45 PM, Pavel Begunkov wrote:
> req->ring_fd and req->ring_file are used only during the prep stage
> during submission, which is is protected by mutex. There is no need
> to store them per-request, place them in ctx.

Thanks, applied.

-- 
Jens Axboe

