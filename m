Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C7AC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6604020721
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="CUidE9OM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgDCPxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:53:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35834 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgDCPxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:53:15 -0400
Received: by mail-pl1-f193.google.com with SMTP id c12so2841298plz.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 08:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=owgGAHZSGNRil4KZ/mw3izwPWS/tP0UsXJUitXCRVu8=;
        b=CUidE9OMULKs/p+pZoJ2W3cCMfdlp1mq2Ce4gohC0F8wlVWB3a2pfxjRPX6bwvyA3Y
         /XTWjfyag+RP6/6ZNEqe1Q8TAQU5L7t/bRb1o7QxtRgeokfWSSziQSYnRZOgbJ+Zyk1p
         Z8s1CZWxzZxkCu1f2pMoVq2po2eaivsyY4OalQMiMGlCBH0E8DOTNIR1vBaN5fCiOJbU
         KDuIttH0EQu31c4YTJL6Rr7VTt0uUF54Ic7fwfO4wULP4dUBB3WUwAYgE37gtHNj+e1g
         MNvLKo3LECSkxcCu+jvfPhiJrbvbwXdwl3yMPovkPnSTG2nzzAcAkS8a7hGW279SogEx
         Defg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=owgGAHZSGNRil4KZ/mw3izwPWS/tP0UsXJUitXCRVu8=;
        b=i2eA+Bvf10QYP0HR6clfwElPBhMqZHtAD20j/IL4l4w/OgZ8c13j6tB3k9iibDwZ8N
         +C6St7acoJzY0DcypnRtRQhUxmnTeiYOfV7uQMCK7txzn1ZCfwcEBQgQnETYwOOx14mw
         05pQwzr96/mFY/cYsRecOah5HPPWXnvJ+w+uVc6gTZlVppnww6y90F05Vdgn7BwL/vUt
         Q5VpF1jmd+FG4HecITLk+KVLN1RNjnPVYIKc4AD2I2WidkvTE09NZy7SgWFeUVVZZyqJ
         OwaVB0QW4sk3KoowN1kr4LBMzYyjW+w28IbmZFM96Oz6e1Reg0l1bTuaDI+gcEgowKn7
         rE/Q==
X-Gm-Message-State: AGi0PuaVKCtlp8SjisVtlv7BpPrxPgJxw6FZDtZYqGEd7012jg03PjFN
        O/Tvhn7yky8ZlanOTmT230Y4/A==
X-Google-Smtp-Source: APiQypK44jSapqDp3oWFKb6JkHAV3VcWl7yt6FWLfum23xqW7y9mP7dvZQhTjJgPOzhHm88fn1mHNQ==
X-Received: by 2002:a17:90b:3610:: with SMTP id ml16mr10796623pjb.106.1585929192570;
        Fri, 03 Apr 2020 08:53:12 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id w9sm6122572pfd.94.2020.04.03.08.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 08:53:11 -0700 (PDT)
Date:   Fri, 03 Apr 2020 08:53:11 -0700 (PDT)
X-Google-Original-Date: Fri, 03 Apr 2020 08:21:21 PDT (-0700)
Subject:     Re: [RFC PATCH 3/7] riscv: Simplify MAXPHYSMEM config
In-Reply-To: <20200322110028.18279-4-alex@ghiti.fr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, zong.li@sifive.com,
        anup@brainfault.org, Christoph Hellwig <hch@lst.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        alex@ghiti.fr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-f28ea5f1-ad10-4216-8612-f92863d20cca@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Mar 2020 04:00:24 PDT (-0700), alex@ghiti.fr wrote:
> Either the user specifies maximum physical memory size of 2GB or the
> user lives with the system constraint which is 128GB in 64BIT for now.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/Kconfig | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 8e4b1cbcf2c2..a475c78e66bc 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -104,7 +104,7 @@ config PAGE_OFFSET
>  	default 0xC0000000 if 32BIT && MAXPHYSMEM_2GB
>  	default 0x80000000 if 64BIT && !MMU
>  	default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
> -	default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
> +	default 0xffffffe000000000 if 64BIT && !MAXPHYSMEM_2GB
>
>  config ARCH_FLATMEM_ENABLE
>  	def_bool y
> @@ -216,19 +216,11 @@ config MODULE_SECTIONS
>  	bool
>  	select HAVE_MOD_ARCH_SPECIFIC
>
> -choice
> -	prompt "Maximum Physical Memory"
> -	default MAXPHYSMEM_2GB if 32BIT
> -	default MAXPHYSMEM_2GB if 64BIT && CMODEL_MEDLOW
> -	default MAXPHYSMEM_128GB if 64BIT && CMODEL_MEDANY
> -
> -	config MAXPHYSMEM_2GB
> -		bool "2GiB"
> -	config MAXPHYSMEM_128GB
> -		depends on 64BIT && CMODEL_MEDANY
> -		bool "128GiB"
> -endchoice
> -
> +config MAXPHYSMEM_2GB
> +	bool "Maximum Physical Memory 2GiB"
> +	default y if 32BIT
> +	default y if 64BIT && CMODEL_MEDLOW
> +	default n
>
>  config SMP
>  	bool "Symmetric Multi-Processing"

I'm not sure this actually helps with anything, but if it's all going away then it's
fine.  Originally the 2G/128G stuff was there to allow for larger VA spaces in
the future.
