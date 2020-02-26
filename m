Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876C5C4BA15
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D1F20838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="PEkBC2gG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgBZPwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 10:52:04 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36141 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbgBZPwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:52:03 -0500
Received: by mail-qk1-f194.google.com with SMTP id f3so3078372qkh.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 07:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4GYwlf0Xa2QHt1cHVU8f4uTPVQEe66S6tW8iKIjB1EY=;
        b=PEkBC2gGo9Wp0CTNFzcX/uGLGqh45la2h+234pEbgb0JKCTWiVwR5CK2qWd8o7GV9+
         vZ0V3mJmWDxwpkokIiWuE2AK5D0JvSuKri12uT1Y5ZmnM2+2x1lk6TfjQrITZNEH8kqT
         OpLenMqGsrmR+s2Jh+PZTctbpw7UkSpOJj3m46DAs7sTe9V+A8PrxIZxTU0Jx2ozkU+h
         l2FfR5Vf/ZZGO7KqofRi3aS6TzSV2SHQoTpS42nUl+B16nz+oN/qYJaqXNzKW0WQZswg
         b+O0gHwTc4Y9Ju+CjJy1uD3JRDYV9kySWYvBERLoM4RJvQwJnkBJANxBmrBhZlFtAjqz
         NmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4GYwlf0Xa2QHt1cHVU8f4uTPVQEe66S6tW8iKIjB1EY=;
        b=JjDCgHMZGDsrBNBPg2ebdm09DYMrl8QeMqQ9PQJ0T3sFCd5+DLPP9LJQ4R68XVOlq+
         snKAzfOb7yhaoqfvkAztezZfxEPV8ZOij2DprT+tUo8lsgK4RgH2jaE+k4IJnJ1gMkKU
         FlwTcyHjUQ4m4FNHnJ5Bv74zQIwsgI0wneGENcmRJnjEsiYpKzN6TLGHvHPmQYyl/o08
         lBhzwbmmF9SIACH7jpKSaHzLfwnfQRw3nOHCRxywjMo/E4JU9uyE2eQeRNMs/nQ1gzEm
         zvswrk3kuoltJcaVJXbIlJ54v8eOTO6YgOUZNy4JgG+ta/jBFNrIvOPhvJFXefI+PqwR
         1gZA==
X-Gm-Message-State: APjAAAX+7NQ7+UiCCLVftFGp8sDQMfORFWsUVdY6mh0UoIZpIpkjivvN
        TQ36ZxZ9ySv24KWw+XSKuhtJFQ==
X-Google-Smtp-Source: APXvYqxycYwltSMF6mRZHm7TjXsCzQqI/GC2y1t3waZQf56agLdqkPAjaYu5yvSrjxUQYf0tQtgA0w==
X-Received: by 2002:a37:64cb:: with SMTP id y194mr5808427qkb.364.1582732321799;
        Wed, 26 Feb 2020 07:52:01 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 3sm1332599qte.59.2020.02.26.07.51.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 07:52:01 -0800 (PST)
Message-ID: <1582732318.7365.129.camel@lca.pw>
Subject: Re: [PATCH V14] mm/debug: Add tests validating architecture page
 table helpers
From:   Qian Cai <cai@lca.pw>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 26 Feb 2020 10:51:58 -0500
In-Reply-To: <7c707b7f-ce3d-993b-8042-44fdc1ed28bf@c-s.fr>
References: <1581909460-19148-1-git-send-email-anshuman.khandual@arm.com>
         <1582726182.7365.123.camel@lca.pw>
         <7c707b7f-ce3d-993b-8042-44fdc1ed28bf@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-02-26 at 15:45 +0100, Christophe Leroy wrote:
> 
> Le 26/02/2020 à 15:09, Qian Cai a écrit :
> > On Mon, 2020-02-17 at 08:47 +0530, Anshuman Khandual wrote:
> > > This adds tests which will validate architecture page table helpers and
> > > other accessors in their compliance with expected generic MM semantics.
> > > This will help various architectures in validating changes to existing
> > > page table helpers or addition of new ones.
> > > 
> > > This test covers basic page table entry transformations including but not
> > > limited to old, young, dirty, clean, write, write protect etc at various
> > > level along with populating intermediate entries with next page table page
> > > and validating them.
> > > 
> > > Test page table pages are allocated from system memory with required size
> > > and alignments. The mapped pfns at page table levels are derived from a
> > > real pfn representing a valid kernel text symbol. This test gets called
> > > inside kernel_init() right after async_synchronize_full().
> > > 
> > > This test gets built and run when CONFIG_DEBUG_VM_PGTABLE is selected. Any
> > > architecture, which is willing to subscribe this test will need to select
> > > ARCH_HAS_DEBUG_VM_PGTABLE. For now this is limited to arc, arm64, x86, s390
> > > and ppc32 platforms where the test is known to build and run successfully.
> > > Going forward, other architectures too can subscribe the test after fixing
> > > any build or runtime problems with their page table helpers. Meanwhile for
> > > better platform coverage, the test can also be enabled with CONFIG_EXPERT
> > > even without ARCH_HAS_DEBUG_VM_PGTABLE.
> > > 
> > > Folks interested in making sure that a given platform's page table helpers
> > > conform to expected generic MM semantics should enable the above config
> > > which will just trigger this test during boot. Any non conformity here will
> > > be reported as an warning which would need to be fixed. This test will help
> > > catch any changes to the agreed upon semantics expected from generic MM and
> > > enable platforms to accommodate it thereafter.
> > 
> > How useful is this that straightly crash the powerpc?
> > 
> > [   23.263425][    T1] debug_vm_pgtable: debug_vm_pgtable: Validating
> > architecture page table helpers
> > [   23.263625][    T1] ------------[ cut here ]------------
> > [   23.263649][    T1] kernel BUG at arch/powerpc/mm/pgtable.c:274!
> 
> The problem on PPC64 is known and has to be investigated and fixed.

It might be interesting to hear what powerpc64 maintainers would say about it
and if it is actually worth "fixing" in the arch code, but that BUG_ON() was
there since 2009 and had not been exposed until this patch comes alone?
