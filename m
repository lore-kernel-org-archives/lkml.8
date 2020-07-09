Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F29C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 03:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A14B20772
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 03:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XfXxLQhp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgGIDZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 23:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgGIDZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 23:25:06 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32862C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 20:25:06 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id o22so470024pjw.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 20:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=deFlbzkfMfRMfRuQ/QU9968LuaI6fXYErNVqNwLy8as=;
        b=XfXxLQhprQL4NnAPivi9oxxga+lkbU6keLLx0IU9ns311y+Px8w7PHpAvp64BESVN1
         kApTUyFPpte5GFuHFeS/tqgxuf+JfeKB/NfsCfL4/Q7xLCmt77fIxD8L1nsveweR5Z3U
         stZYA/J8PALWqAOyibX4wC/1mOzF7QgXrVOfRcKrsGPN+zRi5kVsmiu/7GSmraV76z1u
         9ZTiQ1RhmoRrRMw6K/K2zqK3S1fpXNCaMYko6BfG9diP84SEITRpvXXOBEAMHkSzA6Bn
         Z8NbKFFJdzezBHtv/nlht3avdMXFd1UzEOBG0W8I0Mpfku36kQjtIxFh7Q/lo58UxnOj
         k9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=deFlbzkfMfRMfRuQ/QU9968LuaI6fXYErNVqNwLy8as=;
        b=DXtR3KgyRaZpZauX9oPfnfl64kId4kjSv1Q6WgDaUD4ophDVm5nKUNTa4SGaOlngOz
         O728pm/innggiDB/qK/obcVcaBTqe9KZtIHLYwyZpc1thgvw+7/xhdvkFLGW+2c3AsMt
         9mS8CuG8oURlbRFyYuaAV3IV3C1HIoK4hOJ8OmcuhuPy/AsWjSsIhjV6MnLmHCZp7r0L
         MwkDzYUXx6c3zfnf0HTD671ApIbVgjPLjC8t4rMOr3JTScAEE+ZFasglKN7BLbqPq6GP
         zioepd/oeYlwz2iYgfhIYh9r1dMg5fYjRiwhSvGsfZ4KZlnLlZFq8w1T+FYApMtbdc+G
         V50g==
X-Gm-Message-State: AOAM530S3subevGCBCJgNuQYp7nqjJcjBi+PgpSEQ04WobBDS8dcKWLI
        7LERuylei9D4qDaZx3EU0aZXKg==
X-Google-Smtp-Source: ABdhPJz560zuzQ7gzwQLW5ElxrPuuMfP9mKyVDEbkWsInO/9g2BC0r+xIW94+9fByxAUgBsOGZ5Jmw==
X-Received: by 2002:a17:90b:4005:: with SMTP id ie5mr12867035pjb.147.1594265105583;
        Wed, 08 Jul 2020 20:25:05 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id y198sm1043506pfg.116.2020.07.08.20.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 20:25:04 -0700 (PDT)
Subject: Re: [PATCH 2/2] fs: Remove kiocb->ki_complete
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
References: <20200708222637.23046-1-willy@infradead.org>
 <20200708222637.23046-3-willy@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a0d5c015-1985-280e-2253-8e2663b234e9@kernel.dk>
Date:   Wed, 8 Jul 2020 21:25:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708222637.23046-3-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/20 4:26 PM, Matthew Wilcox (Oracle) wrote:
> +void unregister_kiocb_completion(int id)
> +{
> +	ki_cmpls[id - 1] = NULL;
> +}
> +EXPORT_SYMBOL(unregister_kiocb_completion);

This should have a limit check (<= 0 || > max).

>  void complete_kiocb(struct kiocb *iocb, long ret, long ret2)
>  {
> -	iocb->ki_complete(iocb, ret, ret2);
> +	unsigned int id = kiocb_completion_id(iocb);
> +
> +	if (id > 0)
> +		ki_cmpls[id - 1](iocb, ret, ret2);
>  }

I'd make id == 0 be a dummy funciton to avoid this branch.

-- 
Jens Axboe

