Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B662C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 21:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 193AB20773
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 21:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="LTGU1jJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730765AbgFRVxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 17:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbgFRVx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 17:53:29 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6872C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 14:53:29 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h10so3532444pgq.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 14:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=SL62Uu0LgT8DtVpQ/K6bjtvmgLWLSYUdlf5vO/HvI34=;
        b=LTGU1jJTw0oLZ91IEIjG06MPqIFPLWfhDwJ2yEyAiiXtrrAsPByVLHgkbIOo4TAFIw
         RmPLzHMk2Edyw937No8I8BP06DQVmBUQOvSUMR2e+Lkb87i9gLXp1BzFLG+CaPtcN+Pm
         E49eOtEN8yuzfqqCFzlEw0mXbip0RhNsYM2wNaUabSOCyZHPYFu2/rJf3G8WLwvs9BFP
         IgwcEmLH+tID/DGrutOjcdpTf4h69OChRW3UGDPM53KRDMDdy3lxawKLUti+kdzXOqZ+
         IvwFbzs4zJcl5enNIqS8fw8GOvPxEf7/8iE+HHAcaSdsx7HNkArXhXmX8uKB+Nrx/TAY
         ivnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=SL62Uu0LgT8DtVpQ/K6bjtvmgLWLSYUdlf5vO/HvI34=;
        b=OWlD1cpdkENfzQNBXomr3w3bMtPfW1hbNrkMyuzqDnf/Pe7X/jRf8Of82RI6e8VtID
         4ZugFcHF3jzOZtQ/5eJeiCO5S7ez92vyfLcKvlnC6RgDggEvQ62EHxoxga+Yf+ObYqtP
         eQadpfAEisq7617vNYU+kMJCL/wucTgd4JB/npRRE25PeCKN7sZsD4SmKOw52u1sxPT0
         U2rK/8iiQmFXROk4Ul96JNB7l5+snhuWjul/jx0f/N98MdryY6DmvCNaWglxT8QnMrwU
         we8wcGNUii2EFMDRnCS1gTBg8FGtwYldnBHHPU2SSDbhnfz2rAspPXnfGt20vTt/uEvg
         fMXA==
X-Gm-Message-State: AOAM531N7hOWtJyeE0cabc478rR0AHW82TgP42RbynkfjX37BZEjgedP
        MnrSXt85LZDlOHGiSajm7gPgKF6QoXW++Q==
X-Google-Smtp-Source: ABdhPJyClNRLpobqYjvvoK/HvLfe4HfcZSZBRB74Q0SEc6rjFTHhysdlLKXiISI42p5kvPX8bTLHRw==
X-Received: by 2002:a63:235c:: with SMTP id u28mr492586pgm.278.1592517209065;
        Thu, 18 Jun 2020 14:53:29 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id n3sm3141734pgq.30.2020.06.18.14.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 14:53:28 -0700 (PDT)
Date:   Thu, 18 Jun 2020 14:53:28 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jun 2020 14:46:07 PDT (-0700)
Subject:     Re: [PATCH v2 1/1] riscv: Select ARCH_SUPPORTS_ATOMIC_RMW by default
In-Reply-To: <20200605051510.51590-1-maochenxi@eswin.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        maochenxi@eswin.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     maochenxi@eswin.com
Message-ID: <mhng-14ddadff-c517-4156-90a7-86d44a2a289a@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Jun 2020 22:15:10 PDT (-0700), maochenxi@eswin.com wrote:
> Select ARCH_SUPPORTS_ATOMIC_RMW by default to enabel osqlocks.
>
> PS2: Add signed off info.
>
> Signed-off-by: Chenxi Mao <maochenxi@eswin.com>
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index a31e1a41913a..cbdc605d20d9 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -68,6 +68,7 @@ config RISCV
>  	select ARCH_HAS_GCOV_PROFILE_ALL
>  	select HAVE_COPY_THREAD_TLS
>  	select HAVE_ARCH_KASAN if MMU && 64BIT
> +	select ARCH_SUPPORTS_ATOMIC_RMW
>
>  config ARCH_MMAP_RND_BITS_MIN
>  	default 18 if 64BIT

Thanks, this is on for-next.
