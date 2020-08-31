Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE8EC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 20:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B2F72078B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 20:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkZqEI05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgHaUix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 16:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgHaUio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 16:38:44 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF384C061573;
        Mon, 31 Aug 2020 13:38:43 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ds1so500207pjb.1;
        Mon, 31 Aug 2020 13:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IwVRkCMCyZnv4TAjRBRmsSZkvVEHDfWBL3BIyYi4zQo=;
        b=ZkZqEI05NuuUmHp4uq5a9dsrbwy6wdRKCA6iPyNirvHNYsQVEQqt6/lvse4QXcTqv2
         3mJ1pK85ab2S9FLesU7vnJPgRPLpltd14LU7nZlzQx3sQAZgkcVa+sBCkKawqacB1437
         b+9+HKTj8Bhj2BcACUf2G8k8rjyMCHPBsFUayVjGCPKiSuU3VdSX/AK3nzAUmLgYekB+
         0n7keCtBO+JccJGJanwqSwRo70x6sH2B+iEoaUSPCdeeSiSwkKtkyAex8kV0D0W0hY0s
         LZUJCW89ct/rL13iuPmo0Qg+ugXIe6iwZCeXUVA5RHMFZrGt2KQUK7HO1RotW/sE7agp
         6EFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IwVRkCMCyZnv4TAjRBRmsSZkvVEHDfWBL3BIyYi4zQo=;
        b=A2DORATqmT4OyPzIwhRYYVJj7YG0xDLuSBcCUjxGqHE0HEJnpXVtV5+pH+/DcAO3oH
         amfIRM9jhDhqupsP7oPs7j2ih4krRCr6tmhWcKftk/hIp7g6QzFd7lZ57ugDZ/7ESZYj
         sR43K8GOxtvnf6bAZy2MlXZtKZSCtOuPo0HHa0CBn72XSBWUKcvECwMIMdyIvRWyLFxw
         is0cT/z575YtAn9esjVCvKdXZqg5jg9yOHXxaHmIfMYkMQH2K4AWfCM05GxqC65jJCZM
         hlY6Ij6fcC5Ig3Z/j5aqlD1B4UH05hIM2gIRraSIG1DpCTiwPuEWOVl43Tdgt81DB8HH
         lucg==
X-Gm-Message-State: AOAM533mEG6ygSoA8WmQlxE+TaKdKjtqJWk2GRwG7QIqgBiDbXw7A4ew
        nnw1TaTsEMRpoj6gX2B3RUQ=
X-Google-Smtp-Source: ABdhPJxZWUFmKJnOqKQskXfTYVdxoI7lzl+mkXQEUEnR18yGX2dCIBolzAzimegoss/mYS3BHiIAsg==
X-Received: by 2002:a17:902:b18e:: with SMTP id s14mr2351578plr.160.1598906323230;
        Mon, 31 Aug 2020 13:38:43 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id a26sm116850pfn.93.2020.08.31.13.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 13:38:42 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        tony.luck@intel.com, fenghua.yu@intel.com, schnelle@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, James.Bottomley@HansenPartnership.com, deller@gmx.de
Cc:     sfr@canb.auug.org.au, hch@lst.de, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: [RESEND][PATCH 0/7] Avoid overflow at boundary_size
Date:   Mon, 31 Aug 2020 13:38:04 -0700
Message-Id: <20200831203811.8494-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

==== For this resend ====
The original series have not been acked at any patch. So I am
resending them, being suggested by Niklas.

==== Coverletter ====
We are expending the default DMA segmentation boundary to its
possible maximum value (ULONG_MAX) to indicate that a device
doesn't specify a boundary limit. So all dma_get_seg_boundary
callers should take a precaution with the return values since
it would easily get overflowed.

I scanned the entire kernel tree for all the existing callers
and found that most of callers may get overflowed in two ways:
either "+ 1" or passing it to ALIGN() that does "+ mask".

According to kernel defines:
    #define ALIGN_MASK(x, mask) (((x) + (mask)) & ~(mask))
    #define ALIGN(x, a)	ALIGN_MASK(x, (typeof(x))(a) - 1)

We can simplify the logic here:
  ALIGN(boundary + 1, 1 << shift) >> shift
= ALIGN_MASK(b + 1, (1 << s) - 1) >> s
= {[b + 1 + (1 << s) - 1] & ~[(1 << s) - 1]} >> s
= [b + 1 + (1 << s) - 1] >> s
= [b + (1 << s)] >> s
= (b >> s) + 1

So this series of patches fix the potential overflow with this
overflow-free shortcut.

As I don't have these platforms, testings/comments are welcome.

Thanks
Nic

Nicolin Chen (7):
  powerpc/iommu: Avoid overflow at boundary_size
  alpha: Avoid overflow at boundary_size
  ia64/sba_iommu: Avoid overflow at boundary_size
  s390/pci_dma: Avoid overflow at boundary_size
  sparc: Avoid overflow at boundary_size
  x86/amd_gart: Avoid overflow at boundary_size
  parisc: Avoid overflow at boundary_size

 arch/alpha/kernel/pci_iommu.c    | 10 ++++------
 arch/ia64/hp/common/sba_iommu.c  |  4 ++--
 arch/powerpc/kernel/iommu.c      | 11 +++++------
 arch/s390/pci/pci_dma.c          |  4 ++--
 arch/sparc/kernel/iommu-common.c |  9 +++------
 arch/sparc/kernel/iommu.c        |  4 ++--
 arch/sparc/kernel/pci_sun4v.c    |  4 ++--
 arch/x86/kernel/amd_gart_64.c    |  4 ++--
 drivers/parisc/ccio-dma.c        |  4 ++--
 drivers/parisc/sba_iommu.c       |  4 ++--
 10 files changed, 26 insertions(+), 32 deletions(-)

-- 
2.17.1

