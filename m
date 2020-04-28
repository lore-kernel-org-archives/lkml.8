Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEB0C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB477206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KS7057pW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgD1Kj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 06:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726345AbgD1Kj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:39:26 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EF9C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 03:39:25 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x17so23293282wrt.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 03:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=80sgaI4V0GcoX09oHFdbjGz6NLLhGSyR/ATMNQ5JFUg=;
        b=KS7057pWE5Y3f6NX4Rf0u1UU51Wh7W5BrXh4bhGUOZ3N27k8Mna6+KeaRUL1/cew8A
         Zv65yxTYa5KCTTUXf77KIOfc4+o+qYsA1IaSdrNDJNfQYTM7AgG+byIIzsLahp2diQUp
         yi6kv4AKlOdjnY+i9SIaPtOCf2CWXf0rLQIYHl4yrR0ZVyHVo/G6nS1iFttdoZy79d8+
         7c2ruAgUCtMl+KCB+bCBYWwenNnWF+yOQlTSijHQCstZWYYmu3qq9fYhVJmuvBAn3frs
         unkxkzK4N3wV11/pc05dF5HwH80dG8t6dmllRox6fiF6ZOHt3/IikSRX0/c72nnebqgf
         M7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=80sgaI4V0GcoX09oHFdbjGz6NLLhGSyR/ATMNQ5JFUg=;
        b=e7kQ58I43zocG4lgz8RVsiV8lOsYQjvzbzJWXrbIk7/GigsXdpn4zQ6iUK0bnY2ngW
         B0o2R16rUZFA1GhyCQhfy738wBqz2kNdAHw/8vOfSFIFMtTVqrWKwQ3o+4W6ScxbWiat
         r/YkTrnY01Mt8pJlJx639lUMwTl+UrGH1WYWSNDNniHTrxdb5OhPvLRuACb1iHSuZRtx
         si11AH/QWY300fMlBaueJGDUhK6eRLuvcT4K+HWo+nR/FgLdiNjvlLC7RsPrwkelMmMZ
         lHi62c2zw7MsykgVy6JMLP3DXArNg+DnuzT1PjpRErhKQS1ZZYOWWyMQ9rKATSFHsn0Z
         qTEg==
X-Gm-Message-State: AGi0Pub/XlQeKeuxQ0NhW8KHNxGmnobPMtyrOzSZ6iWXT/KIl/Mmul7p
        Q3aVjs0z2j4GoBJlUdsnH4pnaMC9Dkw=
X-Google-Smtp-Source: APiQypJWtjWbQvJyFN4AqxsjlS5T7yW1mWgp+uBZ0F+u4QDyM78njpCwg+bWGhNV3ynTqCfuP0gYwg==
X-Received: by 2002:adf:ce0a:: with SMTP id p10mr31435246wrn.89.1588070364624;
        Tue, 28 Apr 2020 03:39:24 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id y18sm2914896wmc.45.2020.04.28.03.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 03:39:24 -0700 (PDT)
Date:   Tue, 28 Apr 2020 11:39:22 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mfd: wcd934x: Drop kfree for memory allocated with
 devm_kzalloc
Message-ID: <20200428103922.GS3559@dell>
References: <20200427110805.154447-1-weiyongjun1@huawei.com>
 <20200427122922.56643-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200427122922.56643-1-weiyongjun1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Apr 2020, Wei Yongjun wrote:

> It's not necessary to free memory allocated with devm_kzalloc
> and using kfree leads to a double free.
> 
> Fixes: 6ac7e4d7ad70 ("mfd: wcd934x: Add support to wcd9340/wcd9341 codec")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/mfd/wcd934x.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
