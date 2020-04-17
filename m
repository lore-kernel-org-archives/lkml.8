Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A299FC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AFE32137B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbgDQM5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 08:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729034AbgDQM5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:57:16 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E586C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 05:57:16 -0700 (PDT)
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jPQYI-0008LQ-T0; Fri, 17 Apr 2020 14:57:03 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 871A1104096; Fri, 17 Apr 2020 14:57:02 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Balbir Singh <sblbir@amazon.com>, linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, tony.luck@intel.com, keescook@chromium.org,
        benh@kernel.crashing.org, x86@kernel.org, dave.hansen@intel.com,
        Balbir Singh <sblbir@amazon.com>
Subject: Re: [PATCH v3 1/5] arch/x86/kvm: Refactor l1d flush lifecycle management
In-Reply-To: <20200408090229.16467-2-sblbir@amazon.com>
References: <20200408090229.16467-1-sblbir@amazon.com> <20200408090229.16467-2-sblbir@amazon.com>
Date:   Fri, 17 Apr 2020 14:57:02 +0200
Message-ID: <871rommfs1.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh <sblbir@amazon.com> writes:
>  #include <asm-generic/cacheflush.h>
>  #include <asm/special_insns.h>
>  
> +#define L1D_CACHE_ORDER 4

Newline between constants and declarations please

>  void clflush_cache_range(void *addr, unsigned int size);
> +void *alloc_l1d_flush_pages(void);
> +void cleanup_l1d_flush_pages(void *l1d_flush_pages);

Can we please have a consistent name space prefix?

l1d_flush_*()

Thanks,

        tglx
