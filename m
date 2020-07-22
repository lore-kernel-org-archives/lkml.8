Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC9FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 02:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A589C20792
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 02:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="KScI1b+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731883AbgGVC7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 22:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731641AbgGVC7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 22:59:00 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CBFC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 19:59:00 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id p1so255998pls.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 19:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=jwmIpuIZKpcc0Q+zuIwHWh3kDRMkK5YkPe/3s8OgK8M=;
        b=KScI1b+blKBYy4f3sDkI9g0G1j4jqclpWVB09gXAVq7+FMeao6EDj4GFpK8+ZW/DlN
         iPB28KdBUXJOwAUGX+Y/0cbiCEWwuR5OvrF5+TnFFsGt5BGKhepXulde5ZASR0q6EGKE
         +jSLRSj9R4sUKOfx3DHQOxvYDuJCUgldBQxOevkGiuYuVhXuDowKgey7aiA0mzl30/1I
         TRmtFRYTuvdinZ3RJazsktJJl8UJPcXcnbIOJ8HTVCs+OURHpiaJI8uh/Vq0+kkR3zM0
         GGUCwXGvD4u/NxgqS03C3IjBUVKI2xvcX3WNLG6EZiCBWmmauDkuULEaM2Wyf5CZatic
         1TfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=jwmIpuIZKpcc0Q+zuIwHWh3kDRMkK5YkPe/3s8OgK8M=;
        b=WCdhMPM9Qxh6HDtRZoRDDp5YbGcUb7WySiE4VtmDHQGhj+ciDOZx4JAzhs4j8mnCT0
         D2ivUFP/MzFh/xNi9gShaeTV4D5RPOFCaW26ECUe5EFkANRFxO8fVIQVGKesCGecfWKl
         lg44HKcoQRRrhMiw6RCv/8hYBRo+BNI/ORmUffOnpNwccPn19IF29w8u/GhGjuo5nYTf
         Qe8UOAIaPpxx93uFMMCDJegr4yGWbQXj8ijwnq5fpaS7MeW6plf8ebgUbD22nG/mzEi3
         ChvBk9VW890YjSLfLFw+ZrbEUjyylsiofoA9GyPH0/KndKybxzaElN0lJKMIcVF+bUuO
         pu5Q==
X-Gm-Message-State: AOAM533z1lVnnwQrcp0nBKJ8cBXfVP3K2vY+7i2n6WiH4lRcznpXhMo5
        ToDL8v3zlWbuHKsYspcBQfqVkA==
X-Google-Smtp-Source: ABdhPJyMGFdJRFFM26XdtP/bLX9ofuQ9mihGMzeIGOthRaB7mjiEKCQeljlCDhckItGtse2CXo9VUg==
X-Received: by 2002:a17:90a:ea84:: with SMTP id h4mr7888106pjz.128.1595386739541;
        Tue, 21 Jul 2020 19:58:59 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id x9sm18811539pgr.57.2020.07.21.19.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 19:58:58 -0700 (PDT)
Date:   Tue, 21 Jul 2020 19:58:58 -0700 (PDT)
X-Google-Original-Date: Tue, 21 Jul 2020 19:47:23 PDT (-0700)
Subject:     Re: [PATCH 1/2] riscv: Fix building error in entry.S when CONFIG_RISCV_M_MODE is enabled
In-Reply-To: <742f0a82a9d4ab62d8616784db5a88a95d8b5389.1594629047.git.greentime.hu@sifive.com>
CC:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        Paul Walmsley <paul.walmsley@sifive.com>, lkp@intel.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     greentime.hu@sifive.com
Message-ID: <mhng-ca23efdb-a932-4c2c-9b67-223fe779a284@palmerdabbelt-glaptop1>
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

Looks like this one already got fixed, I guess I saw the build report go by and
fixed it?  I don't remember if I actually pulled this in, but I ended up with a
3-register andi so I guess I didn't do it that well.

I'm not sure why my build test aren't catching the M-mode stuff, as the
defconfigs are in the list.  I'll go take a look...
