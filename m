Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40693C433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 18:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22D4C20738
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 18:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596391280;
	bh=eNMVHfQX39Yty+zJexLcHSPVgVrkFYvaSKFTPruKvJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l42BYt5MRzJERCz/E0++G5u2s2GUFQUkqN1XE/wiafuhpk/gIxGQ8LcqIpxDHzk79
	 WWe8xQa2aLRkakBvRNIc/LHJTf4knvaZHdk/Cs4tSDjdnX2drCax2CckR6I2YpEwiI
	 hmELSlEvJzPztDk4si/eqTbKrEKz8AYhmanBejhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgHBSBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 14:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgHBSBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 14:01:16 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598E8C06174A;
        Sun,  2 Aug 2020 11:01:16 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id f24so15844056ejx.6;
        Sun, 02 Aug 2020 11:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cWqP425OZ00Oz4x2XaCg5sL4Bi3BuFHBZ9fhbstEoPo=;
        b=uknpQ4DMxgwRI+7RXzKKaxSHSsHT4JX+qN+G3Zw62I+z7K+v0oM82e+YsM5L2ibFwZ
         ZtPLnfzJt8IFqkH991n5kK4zcZ2/fsZTMmLNrFK7hPe3auCniFr0qepP8+PKlvq/+X4Y
         6FOXivLK6+BH8tYzSACnWRFDv80Xb8yKxgJKQm36t4gslbAugHoQp37YMrGD2IIEXvEW
         lHLgWw9HHo88+yhhI1SsXvM9DHpmveOnmArUrLkNHDmUxgOR5yVJEiJKHqYfS7BI8LbU
         2xANFxjuEWzWjHDwLiCM886yebnNr5jnEbr0RMGk15mMx04KzIUKhAfWZe7dw+zaroY/
         roWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=cWqP425OZ00Oz4x2XaCg5sL4Bi3BuFHBZ9fhbstEoPo=;
        b=qCdOCZpG7/sz7BFat4IaZBpFpBNC4rySzQREiTNaBC3onXjdu7Ayn4Ds8H5qBm0qLN
         Tjudbzz7DesieuzKE758Bu/pGXbrCi50WUxTtsLXgctGf+AKIRyWICrN8VURgKOzSwKm
         yejLw28lTL+gllHMiqr0enMKndpTm7/3nMf5Ps0/kPSte8A3Bjzl5vxIUyAVqBHAYcvi
         wAfiMcXiuu/59k9X99jDPl2f+dwH8AFhk7G840YX6Mcr9J3pLfyXQHaUKn5TcmutMDE1
         kqeNkNtWgNEqC/pABcW+nEExVLlQKpwYL5W5O5VLn8VlvLY8uYTKp9IC235z1/Tis2AH
         qpDg==
X-Gm-Message-State: AOAM532N1e5Iq13l2IZ3ehtocfYpaduM/+U1aKn3bVwDV49bSy4e+uWt
        8PfQP50/xpnfy6geOglkZJU=
X-Google-Smtp-Source: ABdhPJzKJVSrfGoQ7+sK5UMaqi5wNpNE5CXoSPOw/FVAw4VikTzayUXH2AGSuVR6AmkbWWniCTFE/A==
X-Received: by 2002:a17:906:c187:: with SMTP id g7mr13929214ejz.108.1596391275076;
        Sun, 02 Aug 2020 11:01:15 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id t19sm14191760edw.63.2020.08.02.11.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 11:01:13 -0700 (PDT)
Date:   Sun, 2 Aug 2020 20:01:10 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        clang-built-linux@googlegroups.com,
        iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, x86@kernel.org
Subject: Re: [PATCH v2 13/17] x86/setup: simplify initrd relocation and
 reservation
Message-ID: <20200802180110.GA86614@gmail.com>
References: <20200802163601.8189-1-rppt@kernel.org>
 <20200802163601.8189-14-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200802163601.8189-14-rppt@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mike Rapoport <rppt@kernel.org> wrote:

> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Currently, initrd image is reserved very early during setup and then it
> might be relocated and re-reserved after the initial physical memory
> mapping is created. The "late" reservation of memblock verifies that mapped
> memory size exceeds the size of initrd, the checks whether the relocation
> required and, if yes, relocates inirtd to a new memory allocated from
> memblock and frees the old location.
> 
> The check for memory size is excessive as memblock allocation will anyway
> fail if there is not enough memory. Besides, there is no point to allocate
> memory from memblock using memblock_find_in_range() + memblock_reserve()
> when there exists memblock_phys_alloc_range() with required functionality.
> 
> Remove the redundant check and simplify memblock allocation.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Assuming there's no hidden dependency here breaking something:

  Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
