Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735EFC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51C3720771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sYGg/2sr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387629AbgGWDZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 23:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733203AbgGWDZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 23:25:11 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C33C0619E2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 20:25:10 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id x72so2299336pfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 20:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9MVfx3nOR6UuOciR/xo7cXZ/th4WV5eo7kpG1rG3ysA=;
        b=sYGg/2srzRVqnhZoUg5o1/8tbs+uw5e5GRk9Prg191UfP1xoMwvH723Ge9XxV8UQ+Y
         4CEWot9lS0SqzGP8KRgPxAJxpC/eEprKLS3vIBqZ5aANULGw14jQP2A7earpJeHPMRIR
         h03gCHjIS00DOdkrfY88+LkPeWA803BH19mIOcX825pt//wFRoKWgLX/4GQxUeM57uDp
         WyjOxQQ4rtE7lDBcbhS6m9tuIqe5ezBXIEwPrhUrtefYV324MprVw5BfPaQGw3Ip0u/v
         Aa//OtUahu1SxHH+0XFEgauJFf2i+AujXdahv7KDbKSx8tvSGdZciHACQveIiHGHIFa7
         5V6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9MVfx3nOR6UuOciR/xo7cXZ/th4WV5eo7kpG1rG3ysA=;
        b=UiTOFro9zMc5A27h09iVZYpKjUPtYAgYlWWa8xug5Fy0DcWZFAgJloYT3AjjLH+Gvq
         6HsmnsvOOIxoiIKCmJVdgaG6/rpLfx/37ksQHGkI50hSxfdRFS6oLeHDk1HREdqK+CBt
         lfni2NUvZdTxYevgKPlb/5tvz6fbHIQCUUbc9w0RNdR3UfDEVt6d/8XDJW3tlzFzWyv3
         0W4OKK+DgWqpx8oQlvffTIZF37ky8Gds5TXtCrkwcYXFvjIXNSK3Kbr9dO5T3Pucv+cy
         iMsM56epAHrNO24prE0Jv+hhuppNLg5vy8xSkLIigCcw6mWGEMkvpPLSamo71c+x8n7R
         J1VA==
X-Gm-Message-State: AOAM531GdluxMtCw1LkSV0tj4CRtERNx7FXhghKA7ywH+4jffoYZUCQJ
        oyhCfiTAfm2s+SGtCN68xj5glQgdrJ1NoA==
X-Google-Smtp-Source: ABdhPJyG7BgknGC9wMaKL2Q7w46TNfVt44bgRZhyUF0TneCCHjumSEJ/mUDzmmYzIcEUfulF3SLN8A==
X-Received: by 2002:aa7:9685:: with SMTP id f5mr2422134pfk.223.1595474710040;
        Wed, 22 Jul 2020 20:25:10 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b128sm1001418pfg.114.2020.07.22.20.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 20:25:09 -0700 (PDT)
Subject: Re: [PATCH -next] io_uring: Remove redundant NULL check
To:     Li Heng <liheng40@huawei.com>, viro@zeniv.linux.org.uk
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1595474350-10039-1-git-send-email-liheng40@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c05036b0-49c0-411c-6051-27dee4a0f2b4@kernel.dk>
Date:   Wed, 22 Jul 2020 21:25:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595474350-10039-1-git-send-email-liheng40@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/20 9:19 PM, Li Heng wrote:
> Fix below warnings reported by coccicheck:
> ./fs/io_uring.c:1544:2-7: WARNING: NULL check before some freeing functions is not needed.
> ./fs/io_uring.c:3095:2-7: WARNING: NULL check before some freeing functions is not needed.
> ./fs/io_uring.c:3195:2-7: WARNING: NULL check before some freeing functions is not needed.

Not needed, but it's faster that way. See recent discussions on the
io-uring list. Hence they are very much on purpose, and it'd be great if
someone would ensure that kfree() was an inline that checks for non-NULL
before calling __kfree() or whatever the real function would then be.

-- 
Jens Axboe

