Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E40C4345C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8545E23119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="q44JM/Mh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgHFLEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 07:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729279AbgHFKgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 06:36:23 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9E1C0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 03:27:51 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id g6so38507630ljn.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 03:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kMBgMZhsaHkiYpNXe6mnulxBmErGl6mZVT718X/hP1s=;
        b=q44JM/MhPtGS1X8CEtdPT8jY1IsznRmL/EUJCRVKZ0SQjpJuKmiF3MRSg0V201k6/0
         7wdleRwGXgcpS6GBcJQn3aN4+K1pHDGZuvFRDvTF9APAIhXb+a2xl9Jp+eur4UHwQKOG
         a+RLO7aCLHiHjNUkqDHv3KHpAByqNpYKygFYVYfjG2rDRNZ1boVJjHid9G6QxHXMRDHj
         lxu6G5SWy3EMKBtlkZJxRZeLycn9DXYVVNUnw64xSNl8FhKmMBKmB/5GaDUrg6bknGVy
         69EcKcUZE3qqrUPWzoTffaHacemMJWCOZb/G6QEBjYa8rAKMuVSkNGFwC876gdtvvS/j
         Xp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kMBgMZhsaHkiYpNXe6mnulxBmErGl6mZVT718X/hP1s=;
        b=HcKeeIat/rByzKASXGjtRf52YxAJK6HBjzBVRS1pVlBU8UA4zVdCI5kjUJNLyHPewG
         s5BEqk75OJjRtLYi02/2bFm1JEYLgsyk3nFHQ369dh1nK67ky8DhddLZ9U3o1WzMGmIt
         j/BgEHRKUfosjfstYfszFqjEMxTCKqemdeSbQZJBZL/Hk3mMj0cDPx24dAnwuSfP+KFb
         0NjIJyIyR11SEV3wGTrnlhjxEdl9hkKhyuqtz3EiD6DwMCbM/rtZ699goH/jViDtQ9YK
         +w1tjwFzjyI7AwTzH3YuQhgZX4Zag5zxRzjJdq0HemenkyrVZYmJ/W9070KmARsG00sl
         EHVg==
X-Gm-Message-State: AOAM533lYHnV6mCRKeCMDVwrrdoVaQp2k2AnBBgznB1GkyyhL4sT3eKF
        0tpH50ov/kWs4BO8hLiXuVxfCQ==
X-Google-Smtp-Source: ABdhPJwKs0kOBphzk4nhXY72GuBZVVKvwfIRMs8kMWmC7io4Zo82tk1RHZ72Ob2Qcz50sTYcK1DvmA==
X-Received: by 2002:a05:651c:201b:: with SMTP id s27mr3653296ljo.468.1596709669841;
        Thu, 06 Aug 2020 03:27:49 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id h18sm2208204ljk.7.2020.08.06.03.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 03:27:49 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 80A47102E1B; Thu,  6 Aug 2020 13:27:57 +0300 (+03)
Date:   Thu, 6 Aug 2020 13:27:57 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: Re: [PATCH v3 3/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <20200806102757.7vobcaewdukr2xdl@box>
References: <20200804095035.18778-1-rppt@kernel.org>
 <20200804095035.18778-4-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804095035.18778-4-rppt@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 12:50:32PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Introduce "memfd_secret" system call with the ability to create memory
> areas visible only in the context of the owning process and not mapped not
> only to other processes but in the kernel page tables as well.
> 
> The user will create a file descriptor using the memfd_secret() system call
> where flags supplied as a parameter to this system call will define the
> desired protection mode for the memory associated with that file
> descriptor. Currently there are two protection modes:
> 
> * exclusive - the memory area is unmapped from the kernel direct map and it
>               is present only in the page tables of the owning mm.
> * uncached  - the memory area is present only in the page tables of the
>               owning mm and it is mapped there as uncached.

I'm not sure why flag for exclusive mode is needed. It has to be default.
And if you want uncached on top of that set the flag.
What am I missing?

-- 
 Kirill A. Shutemov
