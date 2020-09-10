Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991C7C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49C5C207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AUJ38pNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgIJWL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 18:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgIJWLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 18:11:19 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD8FC061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 15:11:18 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id n10so6197702qtv.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 15:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GR2McBa3c+WLdwdMHBorMHUc/q8N5804j6NsqXnydDM=;
        b=AUJ38pNh0a4cQmfCkYoSwn3bQPVBlwFjRFCC3eqLV97NVXGHYiBtqhCLijvLN5pJxI
         M83viNf12njX2Xn6pt8DTRLrTv+Yi2XRlLLobXY4F/+TXjKcrclhFAukpdgOBtvUoKKm
         ZdTIQ7EeYqDWWsH+dJqOVGuwap0dXDj7iwPesU2Oz2BoLbKastojnW9wmbmn+mbjkErc
         UAHzLwSE0IYeouh1DRajO8KaCPaHMnEMzhWcO3K0AkwuFJxqf+b2xT1vzMKusCE1sXGr
         XG2/iiyv7+8B0IDMPiPTapf/TRd17VN1WEByhVr0AC1whRwkUI37PQCd3/YwB5bWZ3LP
         KYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GR2McBa3c+WLdwdMHBorMHUc/q8N5804j6NsqXnydDM=;
        b=KwvKk9L51/3kMEuY/hdfBmUo+vLcfAf5vQKfdfT15wVwmHHFCNjpxMEId1C6pjVpbG
         IzjadDhHYHqacFA6jhkh0C0qZv11GTP+pJl2eVN4fS974mK01o9wWfDo6T587ihcKWwG
         ck2IkMDBpBth9aVI14CMQ1W8LdyqIQsVaNhE3oNW6V0iEwrPtZmupmlpOrDP/EQq4Q3u
         4m8M5zkf1nFs5HXB7rDxiyFa2MaAz5HFyrbfu3MGOBpljSq6LNSlDSpiJBmpZfRdXFLk
         TRBIFjB2EaUhnSV1ecCQT2s27I/dYofecDXcwwoB/llOY+hkbdIShuFiYCo8RBPgc/iH
         OqwA==
X-Gm-Message-State: AOAM531oIxa1S716zXnN3TGjcsSye5BWXz/VvabQe4JjY3M6pHHm2T2d
        0OIGqE0gHhnbM+HYugIvIyfRnw==
X-Google-Smtp-Source: ABdhPJwpZ+eye27c1rO1L8I5ha6UkMNDUxgxsSlTX4QAPB5V32wMurFKQFX7MoZPKzYmfpKdteHCqQ==
X-Received: by 2002:ac8:66da:: with SMTP id m26mr10507099qtp.111.1599775878060;
        Thu, 10 Sep 2020 15:11:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id w36sm100489qtc.48.2020.09.10.15.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 15:11:17 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kGUmi-004RcY-HM; Thu, 10 Sep 2020 19:11:16 -0300
Date:   Thu, 10 Sep 2020 19:11:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-x86 <x86@kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        linux-power <linuxppc-dev@lists.ozlabs.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200910221116.GQ87483@ziepe.ca>
References: <20200907180058.64880-2-gerald.schaefer@linux.ibm.com>
 <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
 <20200909142904.00b72921@thinkpad>
 <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
 <20200909192534.442f8984@thinkpad>
 <20200909180324.GI87483@ziepe.ca>
 <20200910093925.GB29166@oc3871087118.ibm.com>
 <CAHk-=wh4SuNvThq1nBiqk0N-fW6NsY5w=VawC=rJs7ekmjAhjA@mail.gmail.com>
 <20200910181319.GO87483@ziepe.ca>
 <0c9bcb54-914b-e582-dd6d-3861267b6c94@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c9bcb54-914b-e582-dd6d-3861267b6c94@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 02:22:37PM -0700, John Hubbard wrote:

> Or am I way off here, and it really is possible (aside from the current
> s390 situation) to observe something that "is no longer a page table"?

Yes, that is the issue. Remember there is no locking for GUP
fast. While a page table cannot be freed there is nothing preventing
the page table entry from being concurrently modified.

Without the stack variable it looks like this:

       pud_t pud = READ_ONCE(*pudp);
       if (!pud_present(pud))
            return
       pmd_offset(pudp, address);

And pmd_offset() expands to

    return (pmd_t *)pud_page_vaddr(*pud) + pmd_index(address);

Between the READ_ONCE(*pudp) and (*pud) inside pmd_offset() the value
of *pud can change, eg to !pud_present.

Then pud_page_vaddr(*pud) will crash. It is not use after free, it
is using data that has not been validated.

Jason
