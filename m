Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D29EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 186C62067D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oz4WmDl9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgHCQV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgHCQV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 12:21:58 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EB6C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 09:21:58 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id t23so25505540qto.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 09:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JGx/+3R80pqTONt1Ak8Jv0FtZ9RnXmGr5UYQh/nJfgc=;
        b=oz4WmDl9Oz190893VnZkDCS4wOQS4shbES/m+6CcrPuw3fjI5AZstk82q//PF40BNs
         4k/NwG7css1MZBhTXvQLh28/2o4aIBgNGfTwdKMMODCiZpc7IpbfzYjsIWIDuyh3BnrX
         5O2V+Rki7eiEbpxTeoaC2Z4o3CZ2dwh14f07LxmDxYRFHazxX1nh6pJ9Ju4S697eKnBO
         HpXs3evqkVI1kVv7mfTOrYpMyuxY/jwcftllH0I7E9L3ICCAztypg4i69Mnuejqu8Bta
         lbFrqBrnWGuY86UlHOb3KsWJ0Ai8TVnVOSVk+jf15UsoCQWwfqJvEtREw/5Z5xS5fZz8
         QPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JGx/+3R80pqTONt1Ak8Jv0FtZ9RnXmGr5UYQh/nJfgc=;
        b=j5ZI9pfhieEn9CFZpc4L9TtIXpCfGEaoG6nhQaD3qyEk0WJBdiF9ZagCx4MLr7aIdh
         myHdzd/N6oAAKtPuVjgdyi+5lM/Xl3Rcy008oyqCvu2NMnJ6XjZTLWWG0+s7L08wB2Qb
         gGCPgWAACJKfYJRrUTakcNpLDCgBFI5PPWDsk1Mv+b6C2P9N741uoJ7gKl0SIgQRMh1p
         Z2Zo+ic//ea5ejmWCniC9R6V6kBUm7dbWfD0BRbBo1m2oxAq/vKmrPVEbIVj5ipnfVFT
         Gj3jNl8ntLGy5Pebft+/+d2BverwYDcZlZCvPhLviwfovho/SaPUzUWK2zgICGbLldpd
         qScA==
X-Gm-Message-State: AOAM53068pdD8g2HpmcZXOSJ8/akHaskjpmzMyvexssVgMHsTwcww27v
        N+uHlIK7e/HPSdwlK2KadfTN2hHyORHh1c7UxWfsdg==
X-Google-Smtp-Source: ABdhPJwmhUXl8lp81qKMfCYBpUmSHgHegrIkkADullzlCmhwtwfwVeVPUVFj8fVYKHdh3v0sBSechMm68DGuSlE+2D4=
X-Received: by 2002:ac8:110e:: with SMTP id c14mr17167408qtj.71.1596471717331;
 Mon, 03 Aug 2020 09:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200803131948.41736-1-yuehaibing@huawei.com>
In-Reply-To: <20200803131948.41736-1-yuehaibing@huawei.com>
From:   Brian Vazquez <brianvv@google.com>
Date:   Mon, 3 Aug 2020 09:21:45 -0700
Message-ID: <CAMzD94TUnEwAtEHk9+87K964vE8sVxGZUVoZS-LjyZJKS+-O4Q@mail.gmail.com>
Subject: Re: [PATCH net-next] fib: Fix undef compile warning
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     "David S . Miller" <davem@davemloft.net>, kuba@kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux NetDev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-By: Brian Vazquez <brianvv@google.com>

On Mon, Aug 3, 2020 at 6:20 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> net/core/fib_rules.c:26:7: warning: "CONFIG_IP_MULTIPLE_TABLES" is not defined, evaluates to 0 [-Wundef]
>  #elif CONFIG_IP_MULTIPLE_TABLES
>        ^~~~~~~~~~~~~~~~~~~~~~~~~
>
> Fixes: 8b66a6fd34f5 ("fib: fix another fib_rules_ops indirect call wrapper problem")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  net/core/fib_rules.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
> index a7a3f500a857..51678a528f85 100644
> --- a/net/core/fib_rules.c
> +++ b/net/core/fib_rules.c
> @@ -23,7 +23,7 @@
>  #else
>  #define INDIRECT_CALL_MT(f, f2, f1, ...) INDIRECT_CALL_1(f, f2, __VA_ARGS__)
>  #endif
> -#elif CONFIG_IP_MULTIPLE_TABLES
> +#elif defined(CONFIG_IP_MULTIPLE_TABLES)
>  #define INDIRECT_CALL_MT(f, f2, f1, ...) INDIRECT_CALL_1(f, f1, __VA_ARGS__)
>  #else
>  #define INDIRECT_CALL_MT(f, f2, f1, ...) f(__VA_ARGS__)
> --
> 2.17.1
>
>
