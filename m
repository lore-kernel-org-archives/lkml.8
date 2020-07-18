Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064F3C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 02:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD4C82070E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 02:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qUgRCn6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgGRC61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 22:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgGRC61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 22:58:27 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13543C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 19:58:27 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b185so10602162qkg.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 19:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t5vwVcGeID8q+Y3Mc+CoAuwJ6W/lykUXCUCPrO4IGFM=;
        b=qUgRCn6iFhKJVmw56sibGFB/9uX/7DQOHLJh5iMqWy0UqTqQj3vnp2AykeX8HtxVpV
         cnLWIv0vw3Lrs1NYYmJw6ktp1OaTi0MZ8Uirn7uAAEjvW/zOcK9bv9RXIWLIUhJwhY3Y
         6jiEnSyGmXr4erRAPva5Bbo485s5NatDJjPIOK0E/4GqqCYCGtO1KUFGgrhhE/O5sQkI
         cm8okqxlo6FfvKTeCq0/JaHcr6Hoa/0y+noYDWl3fiUitDkdTUt4hXjOSZSfdUVRm46q
         0XJEBcKN4C48naX5fyxrUtyp9yofiKrVTurWtUQ3QnRwdq0kuuL0I5mIfVD+vGfb0ojI
         B/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t5vwVcGeID8q+Y3Mc+CoAuwJ6W/lykUXCUCPrO4IGFM=;
        b=MWyvzi/syC+kJlpJfwwGL6YyU9l0+/ZwWGXdtmbfn8Ow0B5fnHFlAl0nsrwpG05D98
         zmgDNEWzpni3OVIOnVyJwGlA9rZ0Dh2xoe3HFcCq19D3WgA+nW7/8Hmis39WpR41GQSj
         oxVXoKl6sM9TxnGxTc4hVGoXh0LGPFqacLHEsuzsX2R2mIkdKzHi00f/bmShD43oOudR
         tRJYpqpZy1M0xuLVFcopWFQRQML5/KSE896gyirLwVtOzwLMsgNuaxquBzji7E6q6BdJ
         oZ1bWZAie3VIOir7kKyowDS0xql4bz4yia1t8wVbcH2HyZZF9USmA62+QPrF/I5DedQA
         RO1g==
X-Gm-Message-State: AOAM533DT7Ihkmtv98sT+7o/KkGdsY7yhu1g2/fGwjPyzLKjkv6qkX1q
        DVzH+1BNdAxzLKr+wVBvzwSuRfDl
X-Google-Smtp-Source: ABdhPJwj0fWFSuinqIE4OCioyHr1lUZ0E/fRxcvxTqdyOCmbwWCbVyX5ke4nLqTwxlqlnYSbFNawmQ==
X-Received: by 2002:a05:620a:79a:: with SMTP id 26mr12135966qka.169.1595041106132;
        Fri, 17 Jul 2020 19:58:26 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id w4sm13693815qtc.5.2020.07.17.19.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 19:58:25 -0700 (PDT)
Date:   Fri, 17 Jul 2020 19:58:23 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] clang: linux/compiler-clang.h: drop duplicated word in a
 comment
Message-ID: <20200718025823.GA1188976@ubuntu-n2-xlarge-x86>
References: <6a18c301-3505-742f-4dd7-0f38d0e537b9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a18c301-3505-742f-4dd7-0f38d0e537b9@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 07:55:02PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Drop the doubled word "the" in a comment.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: clang-built-linux@googlegroups.com

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  include/linux/compiler-clang.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20200714.orig/include/linux/compiler-clang.h
> +++ linux-next-20200714/include/linux/compiler-clang.h
> @@ -40,7 +40,7 @@
>  #endif
>  
>  /*
> - * Not all versions of clang implement the the type-generic versions
> + * Not all versions of clang implement the type-generic versions
>   * of the builtin overflow checkers. Fortunately, clang implements
>   * __has_builtin allowing us to avoid awkward version
>   * checks. Unfortunately, we don't know which version of gcc clang
> 
