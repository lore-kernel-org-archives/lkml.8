Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F857C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 20:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09FE02075D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 20:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="e/NsNBEU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgGMULH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 16:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgGMULH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 16:11:07 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323ABC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 13:11:07 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 1so6496378pfn.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 13:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=09LknHY9dkU2M2OX/SgfAySnftMBQc2JUvSKGgKRJCQ=;
        b=e/NsNBEUiK2c9tIx0w5Wa2nFM/f6fn0Dm1wPMhDzZoNngENUVV+uLYf/RdwYXo0OWg
         pqMuzaqoK6PBQ47TV56KgWEUB7BSCB6NWS91anQRwBTg6NN6jVoiCntB7R1NGAa7IMEu
         pOYVUaJ8BPj5TB7BsSxZhZW7ekzkxmN8XVvVg6jTa4Tdknmq6EZXKeF/ZeZjg8x8T80c
         3r3GH5P20vEZf1P6edjZ1pnfbhof/ZafcmoyiXZ34pcNiPunHTpuBMl3lX7B46shBCdI
         xMvJofQ6An2Xe8pGb9uTXECGFHIQ1+hWY6YWIxdVTJZPt3vxpDuWeJ6OmeEdQsHWKXXm
         40gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=09LknHY9dkU2M2OX/SgfAySnftMBQc2JUvSKGgKRJCQ=;
        b=ByhISB6LPmT1ZXZ8kW3dpVxFa8MBxVGuwVEKalun/SCTl7fyEwo3BtQKCVK3vASCo5
         i4/t6wDmdiiEBbCrEYnCSdf+P+0OOSOcELMGX1Kk3hww1HI9pbH0r9Ks05b8WHvjOT8z
         k05N3uAi0E08ViI+209o21qnBvN1j9ONcKJOMFHZyyLTlsYpclL5g4aL9C78ewoCunjG
         v1qfre1RKhvO/4c2bm5Dk5BVLxhUL376ryTE5yC+tONryvXyR0c+P+GCteMAv6pW3dwX
         sBRKiP1N74xbGnDQRRFS20sBNjwwvU8LV99Qbi1ab+zImePH+45MuoIwPg95TkoV/Sw3
         mP2Q==
X-Gm-Message-State: AOAM530MkQZEOuQ6+dM0TsaKIGLENIKTRoWOkByBEvko9LWnPYom2iDE
        HZ2UNX+wxLiHPQjcWWwwmHUwtQ==
X-Google-Smtp-Source: ABdhPJyIavVroDJAFXHGVH3iAha82aBR6fPl20kp6ciqNkYezNXkt68WOlU0Q8ksIhyn8H06/JbttQ==
X-Received: by 2002:a05:6a00:224c:: with SMTP id i12mr1417007pfu.18.1594671066404;
        Mon, 13 Jul 2020 13:11:06 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id d16sm15290442pfo.156.2020.07.13.13.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 13:11:05 -0700 (PDT)
Date:   Mon, 13 Jul 2020 13:11:05 -0700 (PDT)
X-Google-Original-Date: Mon, 13 Jul 2020 13:11:03 PDT (-0700)
Subject:     Re: [PATCH 1/2] riscv: Fix building error in entry.S when CONFIG_RISCV_M_MODE is enabled
In-Reply-To: <742f0a82a9d4ab62d8616784db5a88a95d8b5389.1594629047.git.greentime.hu@sifive.com>
CC:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        Paul Walmsley <paul.walmsley@sifive.com>, lkp@intel.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     greentime.hu@sifive.com
Message-ID: <mhng-f7d831a1-d892-4c55-82e9-4427539f1337@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 01:32:15 PDT (-0700), greentime.hu@sifive.com wrote:
> arch/riscv/kernel/entry.S: Assembler messages:
> arch/riscv/kernel/entry.S:106: Error: illegal operands `andi a0,s1,0x00001800'
>
> This building error is because of the SR_MPP value is too large to be used
> as an immediate value for andi. To fix this issue I use li to set the
> immediate value to t0, then it can use t0 and s1 to do and operation.

Thanks.  I guess I must have something wrong with my build tests, as it's
supposed to be building the NOMMU stuff.  I was just about to fix this up in
the patch, looks like I also lost my own Signed-off-by so I have to ammend it
anyway.

>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  arch/riscv/kernel/entry.S | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 6ed579fc1073..000984695cd6 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -99,7 +99,8 @@ _save_context:
>
>  #ifdef CONFIG_CONTEXT_TRACKING
>  	/* If previous state is in user mode, call context_tracking_user_exit. */
> -	andi a0, s1, SR_SPP
> +	li t0, SR_PP
> +	and a0, s1, t0
>  	bnez a0, skip_context_tracking
>  	call context_tracking_user_exit
