Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A30C10DAA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 04:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDD9A21D40
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 04:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="JLdEHyMN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgIIE7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 00:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgIIE73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 00:59:29 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69441C0613ED
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 21:59:28 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s65so120747pgb.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 21:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=rdk6qUroklOezfjw+3dsA2Gu4Mz4XSO7jbxK/CWDMqk=;
        b=JLdEHyMNpt93ohv4NKJl4ziWIkVTXyKDXL23hqJYtMGUwYVaCFrN0D+e4FEGsUwX6w
         Q6ieMcouBJy1YjgP3onPlT8k7nXF4bBWteYTZIy1rNDVeU9n5w63TXKmbdT+vaH5xEfe
         8h/7gF0OUTKShx6D8uy6czh+MWyjk/uq2bkYoJZToXb8+w64AYVEsmx9+Cx4HBP4+FqI
         G/qsuKVYv6ma70aopXEJDY9VLsGF8ErWVyshKumui1bHfHsHjDVKNSSUevajiUUv12K9
         G16hBntoZRqrzfUSck1ceDayhfa6dUs3bilNqzPIQ5iyTNwbfmz1Prd0wFf0Da+BjAbt
         ub9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=rdk6qUroklOezfjw+3dsA2Gu4Mz4XSO7jbxK/CWDMqk=;
        b=UtA5FSMvkigxnlplQSzBtIlHAFtsXM8IE6AeiEkTr44cl273nN8iPZ+mFTztUv8+23
         v7mgUxFXo28sqM2oobhCzaL3EP/XLaIh6KUfvh0X9Zhmg7wvjqejt9oonKeFarlRM0aL
         GHgkhJujF850aSAlLAtHJrnj3gthLN2PHYoenT0qoAID8ZbB62HXyy69Yk8cBGqEc9d6
         kZ3GqePZJR+YU6otOEJta7S46gpreLZZXTj53Q0TXGtQ2rcLyUakm9A4/PQChULdHtfV
         gZ3si1N2wPA818AqUOJ2RIxvBjBLyVx+YlCHxASJDICAZX8gMrh9vxH+TxfgjPcc9E/z
         dA1g==
X-Gm-Message-State: AOAM532XFBn34u6L2Wdp5r38277M6/ElmYBiGxPV6YNOh8eOPFMrlO3X
        uDWQ6K79TSKOKyyjahqFUhQSlfe1i5qh9w==
X-Google-Smtp-Source: ABdhPJy+mcRn9gBxX26OAJWUpRkuRfLoO0RKY/cwXfFGpspac8HvpMtXj5XV/6ZXVEST2GvI7VaEVA==
X-Received: by 2002:a63:cd49:: with SMTP id a9mr1595915pgj.277.1599627567758;
        Tue, 08 Sep 2020 21:59:27 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id gb19sm705987pjb.38.2020.09.08.21.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 21:59:27 -0700 (PDT)
Date:   Tue, 08 Sep 2020 21:59:27 -0700 (PDT)
X-Google-Original-Date: Tue, 08 Sep 2020 21:44:39 PDT (-0700)
Subject:     Re: [PATCH 7/8] riscv: implement __get_kernel_nofault and __put_user_nofault
In-Reply-To: <20200907055825.1917151-8-hch@lst.de>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, viro@zeniv.linux.org.uk,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-c08d96cd-2db3-413b-8e5c-cc159e12b507@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 06 Sep 2020 22:58:24 PDT (-0700), Christoph Hellwig wrote:
> Implement the non-faulting kernel access helpers directly instead of
> abusing the uaccess routines under set_fs(KERNEL_DS).
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/include/asm/uaccess.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> index b67d1c616ec348..264e52fb62b143 100644
> --- a/arch/riscv/include/asm/uaccess.h
> +++ b/arch/riscv/include/asm/uaccess.h
> @@ -486,6 +486,26 @@ unsigned long __must_check clear_user(void __user *to, unsigned long n)
>  	__ret;							\
>  })
>
> +#define HAVE_GET_KERNEL_NOFAULT
> +
> +#define __get_kernel_nofault(dst, src, type, err_label)			\
> +do {									\
> +	long __kr_err;							\
> +									\
> +	__get_user_nocheck(*((type *)(dst)), (type *)(src), __kr_err);	\
> +	if (unlikely(__kr_err))						\
> +		goto err_label;						\
> +} while (0)
> +
> +#define __put_kernel_nofault(dst, src, type, err_label)			\
> +do {									\
> +	long __kr_err;							\
> +									\
> +	__put_user_nocheck(*((type *)(dst)), (type *)(src), __kr_err);	\
> +	if (unlikely(__kr_err))						\
> +		goto err_label;						\
> +} while (0)
> +
>  #else /* CONFIG_MMU */
>  #include <asm-generic/uaccess.h>
>  #endif /* CONFIG_MMU */

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
