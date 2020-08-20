Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D7DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1E732076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="yoTD1RCV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgHTUpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 16:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728451AbgHTUpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 16:45:00 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB47FC061386
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 13:44:58 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q93so1649454pjq.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 13:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=iJ1OwKtfZUiEaD/By8wQCQJ5w4e+/SuoDaxAh4xoYIg=;
        b=yoTD1RCV1vQ+E9mi6aZ3W407bzZWfiFsU7FTJ4JPtTnONQn4f9iOFZ8bK7ZnPq/5Bu
         /Pus5dwVh2RwQ6mMY8VSw79RTxgfzkNYEmSmPDfl9MTZb+HSAij+Y7mzpix8E9V1Fcjo
         rXAH27XS+u+JMlv48olZhaWJWoIzqChgv7iEI1SMDYfHpsLWJwtitCloXQYdRaugj9t5
         7K1Bp45M1URaVAn0tKzthyVMtybdaFJH2ajjBMdMKICJBxrmmgnUWp1Q8qowvTjO0mc4
         BipR9JGXVwndjolDCmb03ySdE084egC9UCfKafA+0+PdSHHYK22LpzPdqukEMw0A2aY+
         Pq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=iJ1OwKtfZUiEaD/By8wQCQJ5w4e+/SuoDaxAh4xoYIg=;
        b=aD+lnTXOe67Wo21X35TgRWDh77p+l1XIzh2Uo3HSuOmzGnJNGm+4dZ7QmgF28eSTr+
         IVkR9U8VgVed6rrcO+7BbbPkfBVeWHDiwb1MTB4WUVvwJpVG8FyLQ2HoO8lJPSQvLdao
         Seuu+ldWxrJl8RwdszrLXv4nhB3yjqY6Qb/7arOyIqrDG+7Mvdk6Pl8dUCpwUH6IQ6kY
         8VcuWxnI0z/OTLknEjC1F85Ik6pMsxNDJrYwfnuNtTD7M5CjeMjsdfT1zfSwr9dmfSNH
         lUPRQ4OTkV7IY8+f/7b6d1wrGp4BpJ8pr7vVmThQlAxY/DZ88waE90yZoFKC4FGI+1W8
         ftyw==
X-Gm-Message-State: AOAM532V/fBAynA5ZHp1ATRaYb/ibpYXtNywIU6nttTdrYbHP2J6jUWN
        dQ68BcIzabY7U3gkOLr4QLX1YeoMSc9tAQ==
X-Google-Smtp-Source: ABdhPJy7KEtP70xiQ5oHihQRcs/deZzjjA98uzS2A3WICdeD6f4n9pYW0wwgjgjxgzlGT0SgVH1HJA==
X-Received: by 2002:a17:902:7d94:: with SMTP id a20mr135796plm.174.1597956298185;
        Thu, 20 Aug 2020 13:44:58 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id u15sm3011247pju.42.2020.08.20.13.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 13:44:57 -0700 (PDT)
Date:   Thu, 20 Aug 2020 13:44:57 -0700 (PDT)
X-Google-Original-Date: Thu, 20 Aug 2020 13:35:38 PDT (-0700)
Subject:     Re: [PATCH 2/3] riscv: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
In-Reply-To: <25223adbad5badb3cd0000df078b407bafc129fd.1593766028.git.zong.li@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-81da4508-59e4-4b55-855a-f7d9c31ced50@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Jul 2020 01:57:54 PDT (-0700), zong.li@sifive.com wrote:
> AT_VECTOR_SIZE_ARCH should be defined with the maximum number of
> NEW_AUX_ENT entries that ARCH_DLINFO can contain, but it wasn't defined
> for RISC-V at all even though ARCH_DLINFO will contain one NEW_AUX_ENT
> for the VDSO address.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/include/uapi/asm/auxvec.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/riscv/include/uapi/asm/auxvec.h b/arch/riscv/include/uapi/asm/auxvec.h
> index d86cb17bbabe..22e0ae888406 100644
> --- a/arch/riscv/include/uapi/asm/auxvec.h
> +++ b/arch/riscv/include/uapi/asm/auxvec.h
> @@ -10,4 +10,7 @@
>  /* vDSO location */
>  #define AT_SYSINFO_EHDR 33
>
> +/* entries in ARCH_DLINFO */
> +#define AT_VECTOR_SIZE_ARCH	1
> +
>  #endif /* _UAPI_ASM_RISCV_AUXVEC_H */

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
