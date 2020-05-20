Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30144C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 22:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0922720884
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 22:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="EIBjZ/F9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgETWuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 18:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728261AbgETWt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 18:49:59 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BBEC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 15:49:58 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x2so2303648pfx.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 15:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=QKwUc2R6uw/eDgmTMc7GXVJUbTy1jO4XiUWek83viy0=;
        b=EIBjZ/F9r+i1Uxd18RwcwxXQVkYbaLrUocOByK8WgOLNbFAPUA4PhtM3VxYNkiky2k
         MtKNPT9Z0wI0pYeXs6wByOFK/84soRVDHeVVT8LR3zjhz8I6nHgVtg2Z3FnsthUWh6kw
         +WRp6S34NU0IqRFAjTikS376odk3+3C7tkXaOLxdbKeBNC7UBMG+itCpT+fMUk4bt663
         UQQp/CYHbyYYDCre+cnmgwD7jZ+qjjQg50mxchLOh/uHaCrJVffftMhqqCwb5QT8PcDb
         qwsHRlYMUHyCKHPyJ74Sid+Jcjtv3LXljsr8WlvCb/HWkIflaMCub9W3S6OEPTX1PRtS
         3mYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=QKwUc2R6uw/eDgmTMc7GXVJUbTy1jO4XiUWek83viy0=;
        b=i3hEiyyINUQsyfX3TCIcAleKO28lnprwv4cGczn1dC0fQM1nEIcZ1VaN77as2+2dfH
         kgk00N3V4bSe9hX317VOo3DfdN4e2omoPuPggXYDxve5/4aSOMrenq2MBtLtJGY1RudZ
         6kTrm78aSCGqYKadQH3P1TyuEvUSXt8EEu7CRe0PrchrXbO487E8FoyoyDGrU1kREln2
         Nn4F97FO58CHFK4f145VcfsIsYczflSeLelhnxcyZeRIaHTWzl+2o6rgAipcFBQcArjp
         HHoH9X4lcAF9Z6TgyowiJTo0AnoZ3CPiVSLyQQ7j9i7/wuBMhGMs8bIbeY5ITxs8qgQu
         8N9Q==
X-Gm-Message-State: AOAM531wCnvaQoipKoRkzZJucCf30rX0MtGaD+KYwnpYp3ox4U7ZrPH/
        a872UsvmccI+RIQ63H/F+5sRhQ==
X-Google-Smtp-Source: ABdhPJyHDWPJOXCR6ItvC+aD357uYMEJiQMYkP/S6dIex9nbbID5CupKL+DroIq9cN3c4VmBEIaiCw==
X-Received: by 2002:aa7:80cf:: with SMTP id a15mr6904139pfn.124.1590014997875;
        Wed, 20 May 2020 15:49:57 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id d35sm2553068pgd.29.2020.05.20.15.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 15:49:57 -0700 (PDT)
Date:   Wed, 20 May 2020 15:49:57 -0700 (PDT)
X-Google-Original-Date: Wed, 20 May 2020 15:46:51 PDT (-0700)
Subject:     Re: [PATCH v2] riscv: Fix print_vm_layout build error if NOMMU
In-Reply-To: <20200514115335.110603-1-wangkefeng.wang@huawei.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        alex@ghiti.fr, wangkefeng.wang@huawei.com, hulkci@huawei.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     wangkefeng.wang@huawei.com
Message-ID: <mhng-533eaf79-af8c-4bf7-9a18-0990f22a2efd@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 May 2020 04:53:35 PDT (-0700), wangkefeng.wang@huawei.com wrote:
> arch/riscv/mm/init.c: In function ‘print_vm_layout’:
> arch/riscv/mm/init.c:68:37: error: ‘FIXADDR_START’ undeclared (first use in this function);
> arch/riscv/mm/init.c:69:20: error: ‘FIXADDR_TOP’ undeclared
> arch/riscv/mm/init.c:70:37: error: ‘PCI_IO_START’ undeclared
> arch/riscv/mm/init.c:71:20: error: ‘PCI_IO_END’ undeclared
> arch/riscv/mm/init.c:72:38: error: ‘VMEMMAP_START’ undeclared
> arch/riscv/mm/init.c:73:20: error: ‘VMEMMAP_END’ undeclared (first use in this function);
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> v2:
> - Should CONFIG_DEBUG_VM instead of DEBUG_VM
> - Based on riscv fixes branch
>
>  arch/riscv/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 27a334106708..736de6c8739f 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -47,7 +47,7 @@ static void setup_zero_page(void)
>  	memset((void *)empty_zero_page, 0, PAGE_SIZE);
>  }
>
> -#ifdef CONFIG_DEBUG_VM
> +#if defined(CONFIG_MMU) && defined(CONFIG_DEBUG_VM)
>  static inline void print_mlk(char *name, unsigned long b, unsigned long t)
>  {
>  	pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld kB)\n", name, b, t,

Thanks, this is on fixes.
