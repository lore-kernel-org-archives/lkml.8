Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97348C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 22:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BC8B20708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 22:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ulCHpy+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgGHWQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 18:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgGHWQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 18:16:40 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC4FC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 15:16:40 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id b92so171794pjc.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 15:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JhOBEbjBfRbeDeJV1Ae/XGOkUoos5+zHxKAbjFqaYpA=;
        b=ulCHpy+TnHYWYVXKTgyJQl1OXkcYrOcQhVu9XLZhjL/LXD+syYDYUjno527Ieomzcc
         nqniK0fVv3LLdUf5v9TsH4SrIFJuL7m4RcyfFNRnYuz8Vy8wZZy4K5el8DW0BOovFGeo
         wi4fWKI7/GAKFumoViVDCFgaxzUbnFDtJHR1PEINv0j+eQvQf+edHVkL5moJ2NCzC9kx
         0snNg3+JdBfWmFogrw6zaBt9rqgPLaTw+Oh/3kcN5fQkIQZdrDCvZpDjFRy5+rscpZUX
         rJc9/+wzM/CD8gQn7cDvg1sWFH+oA5MXCuBijsMGhfIBlV5N+oRZzKlkFrZMfAbHxGoD
         MLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JhOBEbjBfRbeDeJV1Ae/XGOkUoos5+zHxKAbjFqaYpA=;
        b=Yy+j+gjTXvq5Uf0sgZWf5Ln1/qzhUckCcKgGRjDN0HP1LiDU2YNzfN3t1yAVyXyyF8
         YYTvmLzwhI9MWFfG1Doywn2a5mfSlSqnpm4s0TtRWvo4YeiV3FNSrl8IxnV+emSorege
         v2AYifUKByhuzw8UdlEC6K7qvr/wm9sPAbkC2A/+G8GT5RxXAw/st23GpNP7rfxigrlJ
         XO54fxMYeLcEClD5EK/ueLBhiqeb6REEZGSEyH1NJvQEVuThAZdz7IyhIbWLTxMJy9FD
         0iBPvFDyyY4FzvKDiAuodbwyNpVPeAtTy1J0hQUDEIZiB4xN6Dd54XxFX/rMNozOI9C2
         /rBQ==
X-Gm-Message-State: AOAM532yaNiF6APSGAYeaEGpdkIBcp9vxwfu9I3cG/I1GiuY05gwsMx/
        zxuXXEwqG9vMqIyC78tSn8sO0A==
X-Google-Smtp-Source: ABdhPJy6QzPWDM7VK5pA10VAMDB+nKO1F3qyfHqN+Mv/wSnII0pJgJazfZEt04Mti77UfafcvkOvFg==
X-Received: by 2002:a17:90a:d30e:: with SMTP id p14mr12285819pju.72.1594246599733;
        Wed, 08 Jul 2020 15:16:39 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id y6sm465489pji.2.2020.07.08.15.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 15:16:38 -0700 (PDT)
Subject: Re: remove leftovers of the old ->media_changed method
To:     Christoph Hellwig <hch@lst.de>
Cc:     Song Liu <song@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200708122546.214579-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a10d2729-a6f9-2b55-afd9-541b1cfb7586@kernel.dk>
Date:   Wed, 8 Jul 2020 16:16:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708122546.214579-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/20 6:25 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series converts md as the last user of the ->media_changed method
> over to the modern replacement, and then cleans up a few lose ends in
> the area.

Applied, thanks.

-- 
Jens Axboe

