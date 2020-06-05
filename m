Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C90C433E3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 00:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B30192075B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 00:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="AVAJbEw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgFEABu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 20:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgFEABp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 20:01:45 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000A7C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 17:01:44 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r10so4240517pgv.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 17:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=xZdOd+qlY2QRwmTe112l24bUhmXHbEl+plH6oHERkT0=;
        b=AVAJbEw+8SzEbBgb/DyV6PUyCKJwp2jB1suoSwTl8VD0MF5V0fKeKsgQdobihdyB5/
         J7+hzTEwKInrZZryqmy1JqDYidL2j1u+M85iMPHLr9RRvVYRupQqi1XObSqhG+FS0xZr
         DgkJbp/jR0w4JIDt7t4lU26qNOlNx6LwScZ9twfmleVNBJuBJnelRdJK+bNKlDjlDiZo
         yBQB7PH/lBsvsBAOkqx21GpIJKk8Y0loE6wjP21Bv7s6Lj29jozvypxNaROTexbNAtBP
         DnvL3nmAfsAvpmnZep5/g7ZdOpM0cuo2IYebVVZ0S8yFNSXBs6GDHERid3BxlwBZjasr
         ukVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=xZdOd+qlY2QRwmTe112l24bUhmXHbEl+plH6oHERkT0=;
        b=fUEV9WOzJFS5Kf+FjroxCavB8yEf0POV8Mr6RskxfHXq8pnsxsjyyJl9c5qQhbICq7
         j2BtEirPh1WVzwFYURQ2BtCUEfIih7fDWfHuPcSBmp5VovCAqUTbuPBad585oucUB0L9
         PA568pQEi/uPtBVyusjTGy/2anfRthE4GaUa5wThoRugkmJ+4oC6/MqtlpIVRO3UK0Zm
         ofzstpzlfA56vcO11kEgO/Ehdcp1+uStNViCdtUruYG1SoFMCcq4NzO7JxPrfYeJSzv4
         WNANYHyvPYWMoXY/KBI9hjCiIC0CEY28MHxz0SoWsGQXnQmmJe74bs39vpWj2Pv9iOvq
         5WNw==
X-Gm-Message-State: AOAM5326hLiBPuma/0Paf+bQi0/Wo8o9H1cpmM/GIetdW4mYttj9nUDa
        pi6JT0LUMc468T4cydgKwNBnZg==
X-Google-Smtp-Source: ABdhPJwVDFsiRaHk0haBtydd8WFCLmIbWYllGL1INqp/6mVvVIso4x8fKUkKcTESPbIZva5kvdO07g==
X-Received: by 2002:a62:3545:: with SMTP id c66mr6891561pfa.223.1591315304390;
        Thu, 04 Jun 2020 17:01:44 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 128sm5380040pfd.114.2020.06.04.17.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 17:01:43 -0700 (PDT)
Date:   Thu, 04 Jun 2020 17:01:43 -0700 (PDT)
X-Google-Original-Date: Thu, 04 Jun 2020 15:48:03 PDT (-0700)
Subject:     Re: [PATCH 1/1] riscv: Select ARCH_SUPPORTS_ATOMIC_RMW by default
In-Reply-To: <20200602005428.18087-1-maochenxi@eswin.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        maochenxi@eswin.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     maochenxi@eswin.com
Message-ID: <mhng-d1b1b80d-95b9-445e-ab35-db1bf388e9ef@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Jun 2020 17:54:28 PDT (-0700), maochenxi@eswin.com wrote:
> Enable ARCH_SUPPORTS_ATOMIC_RMW by default to support
> osq_lock in mutex/rwsem locks.
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

You need a Signed-off-by for all patches, even small ones like this.  I'm also
going to consider this a bit too large of a change to take during the merge
window: there's very little code, but it dramatically changes the behavior of
the system -- in other words, it's a 5.9 candidate, not a 5.8 one.

Thanks!
