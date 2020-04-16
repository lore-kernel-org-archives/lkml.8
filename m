Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88FAC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DD7221D91
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="P5GrsZid"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410320AbgDPP3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2410308AbgDPP3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:29:16 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83BBC061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:29:15 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id c17so7267467ilk.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bjYb46KKHQaM2QcIyYITIA3pOY9fTaV8ZXhY/h80qfU=;
        b=P5GrsZidGxsLQhO/f/2DgJ66F2RC71L7NdxP6UcLCeq0jDSp4Ip1n8eUNx4VUSfhdC
         sy72KquYgeRF4eogqD0vft6f2KZcFTxjjR2lQoSunaIyVJC468Vwc3nRc0eJbYhndjpR
         CUUuuF9raIEedRpjrkd+DSDZ3dJehjNDp4bDHMX7sDx+vr0nVQfQ1vLIQTWRhRxCipVi
         z4Ks8i9S2+Vz+vbGY9F7ooa421z8MT3TwQiGlSbyyJtgHtb7KnNUnt+lqZ/lXU3vmU24
         1dlmXjMEteADo7197Nu4zRMwm9SVYXP//56/SACdl1GdEREng8uPLwUT+ZqI+ZApq1kA
         zq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bjYb46KKHQaM2QcIyYITIA3pOY9fTaV8ZXhY/h80qfU=;
        b=krtUCwRfc7ufQA4smMocPcqeucLM8qmPpET4pqgEhjW0FZdIWnJfT8R1AbHOfW0t42
         iAmUqegM0i+sZXksjvjqupqrjSNZvkIF+rUAivYmjugBcfNxnJvfC8gwBG4o1PQs15zE
         9KL7AARiMtcRnBkUC5EoQG+gwwzwoFwjayg2ckkgN5NfHgUTu4MKWMFhlxY0DJQBliuk
         /n8U5cR1KopbGY/xg+n9ZfGQK3gZSrU4d9T5WCjL+p1gl6JH/JcesBhVitNuJsj+GFiJ
         gVI5es1WIEIa60byjNOD0iX8k2HJop/BOd7HdUu1yJh4uKLqCVUKR4k6IZyQJ1+Rkv2y
         xmlg==
X-Gm-Message-State: AGi0PubNuRjnBW+k5xq90euLj2MBKkF7qdgloRdlOm+BET9hIT0+ZfJz
        mpiDwc/T1dpbRPpmtHKlaKMtqPW9HO/URQ==
X-Google-Smtp-Source: APiQypI4s/OJ6gLtvfesllrxcdSq/g1jWsDIawUun1QNTvXxdU1IPJGPEA+hKrhr5aWkUfJA2dWRZw==
X-Received: by 2002:a92:394d:: with SMTP id g74mr11039032ila.250.1587050954961;
        Thu, 16 Apr 2020 08:29:14 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u16sm3414326ilg.55.2020.04.16.08.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 08:29:14 -0700 (PDT)
Subject: Re: bdi: fix use-after-free for dev_name(bdi->dev)
To:     Christoph Hellwig <hch@lst.de>
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200416071519.807660-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <874d57cb-90f1-db09-8f9d-29527451e241@kernel.dk>
Date:   Thu, 16 Apr 2020 09:29:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200416071519.807660-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/20 1:15 AM, Christoph Hellwig wrote:
> Hi all,
> 
> the first three patches are my take on the proposal from Yufen Yu
> to fix the use after free of the device name of the bdi device.
> 
> The rest is vaguely related cleanups.

Applied, thanks.

-- 
Jens Axboe

