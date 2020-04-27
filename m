Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8ADC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 05:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 161BC21707
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 05:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bT29SBfO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgD0FEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 01:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726178AbgD0FEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 01:04:49 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA6BC061A0F;
        Sun, 26 Apr 2020 22:04:49 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t40so6941564pjb.3;
        Sun, 26 Apr 2020 22:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RpEFDruZhhlXBhX9QpFVEyfUVGVZWtywwb585yNz+7Y=;
        b=bT29SBfOK96SESehhTW4BCxtsJFVttVeoi/t0urpRpj0AFJ020vN2h1/7jbZohDiWY
         G+7rYY/cyjMWRX2nWM1nQUHRK5DYY0Z3Re/LQsmmL5pheEmdu3Z1rJ7IPvBhUWW1vcYA
         rRAUC3qAszhg7SieSVaXNxX3irqWsJ185lS+6xxGA+5B6PInlCzT3e4IzLqCdgG84LZT
         0O5T2gDAaSxEEY9ruwlPztv5j6dMcOK3Fxvpnkz0f3/jF7y8KJINeGHpr20aF1GemJoJ
         vZnP/QcZkHuVdvvx0xYhq+BbBscy9ve367kNA6XTMOpJq4QXGHxO/ZNnzNN5zxO0WihD
         fgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RpEFDruZhhlXBhX9QpFVEyfUVGVZWtywwb585yNz+7Y=;
        b=VgeOvtMAr5lvxAiR/T/dnr9JqoGAv2N79bmByarfr8ANh0UyDFa19QF/WWP+cQnJwE
         uxOON+HNRqCBLM2cV0XLiCyA72n3jBPtxwbKNBgbZgVua3zSYarP98DQsQCF5dlzKlKB
         2yjtx6nd2TC2UJjTX0noO1kcKM0HzH9wBt8GF7B4ustpiKuiFp7DCDOrdpmYH/9WlmAU
         Gb8rAGyWSuXMW9grSxvQ3P5QasotdrHACRIzLuFBCFZUvK8rQLMd5F/+/AyM3M9DWGLC
         nnLTe+3MIfAzKcucAaEqBbQ0js9FXDYUye+CyT34nVtZFERDdk8m3bC5f3ipt/+Z6VDh
         O8vw==
X-Gm-Message-State: AGi0PuZJxQO2LCBbyP8Wpkm1uoUCs98hja/WBBxhYYOWhLd0b6yBpVbk
        Hz3Oi+sylhfxjeE/bPSYio4=
X-Google-Smtp-Source: APiQypIf/qo/TUxxXd3N0x5q5i+APW/p3XTbnR6PLJskh1YyRzL4PAyXKe0dL0wTZKlCFIs0r3ai3g==
X-Received: by 2002:a17:90a:3f8e:: with SMTP id m14mr20357937pjc.92.1587963888745;
        Sun, 26 Apr 2020 22:04:48 -0700 (PDT)
Received: from [192.168.0.102] ([49.205.220.192])
        by smtp.gmail.com with ESMTPSA id o21sm9822670pgk.16.2020.04.26.22.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2020 22:04:48 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] hugetlbfs: move hugepagesz= parsing to arch
 independent code
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Longpeng <longpeng2@huawei.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mina Almasry <almasrymina@google.com>,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200417185049.275845-1-mike.kravetz@oracle.com>
 <20200417185049.275845-3-mike.kravetz@oracle.com>
From:   Sandipan Das <sandipan.osd@gmail.com>
Message-ID: <7583dfcc-62d8-2a54-6eef-bcb4e01129b3@gmail.com>
Date:   Mon, 27 Apr 2020 10:34:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200417185049.275845-3-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 18/04/20 12:20 am, Mike Kravetz wrote:
> Now that architectures provide arch_hugetlb_valid_size(), parsing
> of "hugepagesz=" can be done in architecture independent code.
> Create a single routine to handle hugepagesz= parsing and remove
> all arch specific routines.  We can also remove the interface
> hugetlb_bad_size() as this is no longer used outside arch independent
> code.
> 
> This also provides consistent behavior of hugetlbfs command line
> options.  The hugepagesz= option should only be specified once for
> a specific size, but some architectures allow multiple instances.
> This appears to be more of an oversight when code was added by some
> architectures to set up ALL huge pages sizes.
> 
> [...]
> 
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index de54d2a37830..2c3fa0a7787b 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -589,21 +589,6 @@ static int __init add_huge_page_size(unsigned long long size)
>  	return 0;
>  }
>  
> -static int __init hugepage_setup_sz(char *str)
> -{
> -	unsigned long long size;
> -
> -	size = memparse(str, &str);
> -
> -	if (add_huge_page_size(size) != 0) {
> -		hugetlb_bad_size();
> -		pr_err("Invalid huge page size specified(%llu)\n", size);
> -	}
> -
> -	return 1;
> -}
> -__setup("hugepagesz=", hugepage_setup_sz);
> -
> [...]

This isn't working as expected on powerpc64.

  [    0.000000] Kernel command line: root=UUID=dc7b49cf-95a2-4996-8e7d-7c64ddc7a6ff hugepagesz=16G hugepages=2 
  [    0.000000] HugeTLB: huge pages not supported, ignoring hugepagesz = 16G
  [    0.000000] HugeTLB: huge pages not supported, ignoring hugepages = 2
  [    0.284177] HugeTLB registered 16.0 MiB page size, pre-allocated 0 pages
  [    0.284182] HugeTLB registered 16.0 GiB page size, pre-allocated 0 pages
  [    2.585062]     hugepagesz=16G
  [    2.585063]     hugepages=2

The "huge pages not supported" messages are under a !hugepages_supported()
condition which checks if HPAGE_SHIFT is non-zero. On powerpc64, HPAGE_SHIFT
comes from the hpage_shift variable. At this point, it is still zero and yet
to be set. Hence the check fails. The reason being hugetlbpage_init_default(),
which sets hpage_shift, it now called after hugepage_setup_sz().


- Sandipan
