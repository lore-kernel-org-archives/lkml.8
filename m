Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30913C35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92E42071E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OvKOKJfD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgA2Njy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 08:39:54 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36063 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgA2Njx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 08:39:53 -0500
Received: by mail-pg1-f193.google.com with SMTP id k3so8855717pgc.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 05:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ah4QQ6K1QfptejU5H4/uQ+LpdR24t+eMpQnEA0OsMVc=;
        b=OvKOKJfD9FMElCBRo0DyjnznMUFKfW/uGVfNasmNIX6FPKGms0PK685vFMzIqxxH/U
         /+yM03X/HYthyDI8DvX/W80ggNAJPR1RyjzSYkrPrjeB9DBBzGMTH2HnXiYqyOUOJbJJ
         iWgFVH2wcrOxpq5jFfnw++WvWBVgj7m+yqJ+vc4owJe8fRY4d7/qJI+ucBBmTxoEM4Kw
         C6reNVX0eHX4nh9mb+z9HxIKI4w9XQN38LD4Af/4/8OGx5bgc8NWNVuOXo7m/ewvwYYJ
         lTgmAGbQi+AWzGghj6iAbzYZ6Kt0Fr16qckmpDtw5wqcwftOdijj2I2Nj2queDIuuJbh
         77BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ah4QQ6K1QfptejU5H4/uQ+LpdR24t+eMpQnEA0OsMVc=;
        b=VYjLOXmjF7umsxN6DHEo559wXCSv1at+CGytPUaAUROplYDaZZLKAA8yy5BOL/1Lso
         2u9d2atrshfJmaD6vfUuSm2tGaZFfpwRzrgL9tm4wjAcmXno1hvwGiAySqrVtOrepB3A
         27Mwit2SM51ou0NZxYRn1fLgkoXNM5NMiJLhI7c2qIknC3S373pPZZWEVWNEJmFsn1j3
         YU9oX9/WtYwyF0D2rLUj9jBUpEnE8GcHlweSYmnAfwhzvNVt8d7zy9KB2ZkKHO+1+Skx
         Svon6bGz4vci5F2fWZq2rXaRtZx3pdGHFeQ0roN8h+U0a+ZSoSSsVWhyvgeB50RBiRfU
         2pmA==
X-Gm-Message-State: APjAAAWlSTLlzqNISKXUX9ikyTyEQ/PvxdcG4gBca1D5ayNmbp9ctPUN
        Dg66nUeUrqDVTok8+/Mjja9e67KVcE4=
X-Google-Smtp-Source: APXvYqyTXQ8n2bMp+ka9gBWrzTDS5UvGh7HozYikOd0DAM7NwUNGRbjsd8Jpw3ZYdpnkrDBfziplwQ==
X-Received: by 2002:a63:e80d:: with SMTP id s13mr31323854pgh.134.1580305193016;
        Wed, 29 Jan 2020 05:39:53 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id q8sm2857780pgg.92.2020.01.29.05.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 05:39:52 -0800 (PST)
Subject: Re: [PATCH liburing v2] .gitignore: add missing tests to ignore
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200129091723.16746-1-sgarzare@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9942eb1e-5652-3520-9657-f9cef8ea6bba@kernel.dk>
Date:   Wed, 29 Jan 2020 06:39:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200129091723.16746-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/20 2:17 AM, Stefano Garzarella wrote:
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v1 -> v2:
>     - rebased on master
>     - forced 8-bit content transfer encoding (I hope it works)

It does work - applied, thanks!

-- 
Jens Axboe

