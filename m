Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A77C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 262BD20575
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="y8cC9UPV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgEMVOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 17:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgEMVOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 17:14:45 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87265C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 14:14:45 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id w65so279360pfc.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 14:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=4+xSC9bsrPwFy66uuVLgjjuRRD6A290/AIOo8xDaczg=;
        b=y8cC9UPVb/LpnhQcVv3DQFfsyP9xOVUr34YZ+rgvlk99pXbXiAUjEcmTk8rR7JecUn
         M7rvujyKfX417pYnhlyjtXXOldBKCB1N556dFyZCrzVWE+xZryoMCpZJn1E8hIcK7fdD
         Au/+nFpMUwtAcdhITxyFuxMMICq4X61/OfFY/U8vH9KpeCoRXvpbNKYQkjqSKI/FlrLU
         aUmMUM7QiDsqi37mnJpRcRHI0mbPEED0leDzLP+YI3vRpHfa7K2UAG29jR6fuvl7uqLm
         6MppLl25kjw42fDXTZxcaABI24Sx+SBO9/JwehhR8v0438+XHgHtlQ0FNi3xjuCRCoDW
         Jbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=4+xSC9bsrPwFy66uuVLgjjuRRD6A290/AIOo8xDaczg=;
        b=Zz6Lj4FovaCePAKYfsuMlf96ORusgJkCVgDOXMr58q10viCI8LRtProlLR5nFJALPK
         mHMikMqtxddBXb909F0QinySITcAB7yAGmX5qtb/VjD27db3UMyT50gElm2aUgLoASRx
         xBzDIdMnt9ztBl2lWtb3xmoqK9OUh3ZYwSekmJ9RLvEcHiG/AH3P49IvQZ6d1ZlLmEK7
         rjex86P8KSBzK7BTMpDaHQVS9kwO48+OMd+Klfec4MFdRant3koCuJnKs4aId6pSWv55
         1sfcHyg9Zq/JESOc1KZwTyG6MZr0dR9GLeM0tCPCAlogxPf1RBUqA0NjmLT9dffUO/Oa
         wsZQ==
X-Gm-Message-State: AOAM5320V5VJYxqaucdSMOw8HcsgT3DH0hCNBkVslHWmpGxQ6gnXwYDx
        +Njy8TEk2VTB9pZV/vxTFhC9bg==
X-Google-Smtp-Source: ABdhPJyl/k6oTH3iTiwWC8Vrw7cGObT1MXaEUnLbNBG6QRWSf0056vKV/N4CX2dWIylHpqdUNJcyXw==
X-Received: by 2002:a63:e602:: with SMTP id g2mr1138569pgh.380.1589404484887;
        Wed, 13 May 2020 14:14:44 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id w73sm408511pfd.113.2020.05.13.14.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 14:14:44 -0700 (PDT)
Date:   Wed, 13 May 2020 14:14:44 -0700 (PDT)
X-Google-Original-Date: Tue, 12 May 2020 17:21:48 PDT (-0700)
Subject:     Re: [PATCH 05/10] riscv: Disable ARCH_HAS_DEBUG_WX if NOMMU
In-Reply-To: <20200511022001.179767-6-wangkefeng.wang@huawei.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wangkefeng.wang@huawei.com, hulkci@huawei.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     wangkefeng.wang@huawei.com
Message-ID: <mhng-f65a8b91-0836-4927-a39f-8167cd3ec67f@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 May 2020 19:19:56 PDT (-0700), wangkefeng.wang@huawei.com wrote:
> DEBUG_WX is only useful when MMU enabled, diable it if nommu
> and fix the build error.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/riscv/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 78f30f2fdd51..7da0a36a8df0 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -69,7 +69,7 @@ config RISCV
>  	select HAVE_ARCH_KASAN if MMU && 64BIT
>  	select HAVE_ARCH_KGDB
>  	select HAVE_ARCH_KGDB_QXFER_PKT
> -	select ARCH_HAS_DEBUG_WX
> +	select ARCH_HAS_DEBUG_WX if MMU
>
>  config ARCH_MMAP_RND_BITS_MIN
>  	default 18 if 64BIT

Looks like this depends on something that isn't in any of my trees yet.
