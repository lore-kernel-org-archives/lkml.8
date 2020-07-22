Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56864C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 02:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3468720792
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 02:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="H/23LUgD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731892AbgGVC7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 22:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731641AbgGVC7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 22:59:02 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA642C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 19:59:01 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b92so410107pjc.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 19:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=zqjtHWRY+Z/a6TbVuhQHClnwHjzrKFN6ggxQIupkQnU=;
        b=H/23LUgD/A7MiXAUZsbdZnxzXZBpg0jc4/DCMydcRbAOgHU0MFNVOgSVnG1LouRg05
         UPcE11ZWmmpzoet7wRv6x4OVgqK7O3gcOKYstyufDzMleT8fsM/PPnRJryYgijQqI2s9
         kEC+lKYV49Cufy+esPwh1XS0CwO0egCM5WKGmmXR2bu8gJLNsxhoIdnYX4nk7F4SLsv/
         rTMhVLE+uU40GixvYQlNpcpMGhKHQx9npkpkpjBf/3OrweNyMFvjqzm9Pm8E0hReoxwg
         5/fRWeuY+f2Vc4biwAPxebGv3ALDvj8MmrePOq6/JG5B5zqaobWQa/GqnTxfyk14S3/b
         QtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=zqjtHWRY+Z/a6TbVuhQHClnwHjzrKFN6ggxQIupkQnU=;
        b=nankzqIdn6xM6rRxdZjeUTnmS6tWw+vwVxwOUjYNRTt0crdGVsbagtezsx+5pwQZ5b
         roIj6k626MgNfDbGNNEAxDrGKWWEa7McKoCwrdrk6VB9rtW2CBrB2viiDr4cz4K2tW22
         hrbyEVF/x7/EmDcGnDo3lo+pthft0uzBxMv8ZOYEQo1ccbEahEkFdxpLyxgCxLTPtoAr
         QTXPi70eTU2W8qMnfVqBKtNAyA+F9TWtPVsFyo9cWRpSHtU4jsgxCEKg7adqWNlt89pr
         bMqx+4DwufsQ9lkO1WjUyCsajyIs0gVSQnM3tZWyhURpZzxPm6JbzAoahyVdkoxkfPzw
         eIsg==
X-Gm-Message-State: AOAM533WN7q12MI/Fb7auv+Em/xxGCWxdMzlIzBxixJOTzke/9CVkjXM
        I3Eto/H9qs7jOaDvMKrV/8seOA==
X-Google-Smtp-Source: ABdhPJzW60tSJTO9sdxoBuPAY/s/akhlaAe7a+/s3qIxa8fhbS9vtNMBh6/6hEJ6reEBwznNSR9Kxg==
X-Received: by 2002:a17:902:6901:: with SMTP id j1mr23930134plk.203.1595386741274;
        Tue, 21 Jul 2020 19:59:01 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 22sm21362808pfh.157.2020.07.21.19.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 19:59:00 -0700 (PDT)
Date:   Tue, 21 Jul 2020 19:59:00 -0700 (PDT)
X-Google-Original-Date: Tue, 21 Jul 2020 19:47:25 PDT (-0700)
Subject:     Re: [PATCH 2/2] riscv: Simplify the checking for SR_PP
In-Reply-To: <4bac52941700cd7b714a41606df7b53f4cf24824.1594629047.git.greentime.hu@sifive.com>
CC:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        Paul Walmsley <paul.walmsley@sifive.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     greentime.hu@sifive.com
Message-ID: <mhng-94c29866-a954-4eaf-916a-9ed87b560d19@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 01:32:16 PDT (-0700), greentime.hu@sifive.com wrote:
> This patch simplifies the checking for SR_MPP and SR_SPP. It uses SR_PP in the
> code flow for both m-mode and s-mode then we can remove the ifdef here.
>
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  arch/riscv/kernel/entry.S | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 000984695cd6..597beae0d238 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -210,13 +210,8 @@ ret_from_syscall_rejected:
>  ret_from_exception:
>  	REG_L s0, PT_STATUS(sp)
>  	csrc CSR_STATUS, SR_IE
> -#ifdef CONFIG_RISCV_M_MODE
> -	/* the MPP value is too large to be used as an immediate arg for addi */
> -	li t0, SR_MPP
> +	li t0, SR_PP
>  	and s0, s0, t0
> -#else
> -	andi s0, s0, SR_SPP
> -#endif
>  	bnez s0, resume_kernel
>
>  resume_userspace:

This one is actually on a fairly fast path, so I can buy it's worth saving the
cycle.
