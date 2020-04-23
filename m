Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4968BC54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2099F2075A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="jdxNZdqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbgDWPnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 11:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729072AbgDWPnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:43:18 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F12C09B040
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 08:43:17 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x15so3149942pfa.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 08:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Kg7M4xD9jeOCc5gp5xCZax2oVOZa7KcCbIv0zMuiHGw=;
        b=jdxNZdqnkgxjmMccyXVc0yzWYhqTW73wR2FVcl/1mojOY4JsmcywIotiTcLKHeMHPY
         M/h7nfQ6Lt5H96VNs0x9u5d9XRzMG+92RQk8x+Yh9Zeu232zSPh9aCzXnohs+gOBWrtf
         N9QgGJ4qwwY7UT1uKCfUMSFWTIOOR9XOFTGESa2ZRUjoAaByvITQ6Vdgx0AxU4mXmy6u
         aOAGqMEQIcNlLhF7zHYbybWBFdK7MgJ1hDujYGWm64+QhHL8cEUQJTFdbp9RYMIpE02L
         OS2/hOcJs5y0mFcnv/kB1JozMVPx2p2JKvHa228VsX4F+uj+rwayzCgggu/VLt+oBbst
         6LXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Kg7M4xD9jeOCc5gp5xCZax2oVOZa7KcCbIv0zMuiHGw=;
        b=eXiXkDon8c26y93/aCmqlPYgS3JV0rI/CRJySvKXTDYRbZTtZW873HhRFj91uVN78I
         R64fdJmfwL53ZNemgpZGAPL3EQHehRz2RIJraaGqs4LCN0RzitUhJI+/gPIvelQ7E2f2
         ewdhFcwgKfU0Fi2PHxiuQ3oYxE+DLIQsDn7761wXYtFThdd+vzjfjLe0HOu0q7P96vdg
         9XUzBM3EQDNbsttAxKr3vNPfTspj4p40cI2gyuVuzOvQcKGVdMDv95lXMuIQmDVTAq+O
         Kci+3T5I//iyRlKvr37e4p+S3hyrSxqiWzVTmBspzlDNf0VByEOevVrx6E3qfytD6zJ5
         dlDw==
X-Gm-Message-State: AGi0PuYP2+JK1U3LSFt76NniragjaLJzMdlWYROpuPqJRrGvHN4S3dbu
        yL9g/VfuYJrNb1rDPUio0RAiuA==
X-Google-Smtp-Source: APiQypL0rdmDv1u1pIBnXgRbU4zfRGn7m8WubBpK6fMP8z32Ebbh6TMUsEYXss99PdGrrqmfyNIXXw==
X-Received: by 2002:a62:1bd0:: with SMTP id b199mr4264913pfb.283.1587656596222;
        Thu, 23 Apr 2020 08:43:16 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id t11sm2913054pfl.122.2020.04.23.08.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 08:43:14 -0700 (PDT)
Date:   Thu, 23 Apr 2020 08:43:14 -0700 (PDT)
X-Google-Original-Date: Thu, 23 Apr 2020 08:38:24 PDT (-0700)
Subject:     Re: [PATCH 1/3] riscv: sbi: Correct sbi_shutdown() and sbi_clear_ipi() export
In-Reply-To: <20200417121222.156422-1-wangkefeng.wang@huawei.com>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, wangkefeng.wang@huawei.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     wangkefeng.wang@huawei.com
Message-ID: <mhng-25c7c97b-dc82-462d-b6ef-b67a32d57f76@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Apr 2020 05:12:20 PDT (-0700), wangkefeng.wang@huawei.com wrote:
> Fix incorrect EXPORT_SYMBOL().
>
> Fixes: efca13989250 ("RISC-V: Introduce a new config for SBI v0.1")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/riscv/kernel/sbi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 7c24da59bccf..62b10a16c8d7 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -102,7 +102,7 @@ void sbi_shutdown(void)
>  {
>  	sbi_ecall(SBI_EXT_0_1_SHUTDOWN, 0, 0, 0, 0, 0, 0, 0);
>  }
> -EXPORT_SYMBOL(sbi_set_timer);
> +EXPORT_SYMBOL(sbi_shutdown);
>
>  /**
>   * sbi_clear_ipi() - Clear any pending IPIs for the calling hart.
> @@ -113,7 +113,7 @@ void sbi_clear_ipi(void)
>  {
>  	sbi_ecall(SBI_EXT_0_1_CLEAR_IPI, 0, 0, 0, 0, 0, 0, 0);
>  }
> -EXPORT_SYMBOL(sbi_shutdown);
> +EXPORT_SYMBOL(sbi_clear_ipi);
>
>  /**
>   * sbi_set_timer_v01() - Program the timer for next timer event.

Thanks.  I've put all three of these on fixes.
