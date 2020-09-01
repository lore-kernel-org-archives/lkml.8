Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1A7C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4B5F2078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p925V7sn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgIAWR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgIAWRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 18:17:23 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDA3C061244;
        Tue,  1 Sep 2020 15:17:22 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bh1so1250044plb.12;
        Tue, 01 Sep 2020 15:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=M8j6Ldkq7Y6L6HNtPJpdtArkg82hNoz7EQt2ZZQpQiE=;
        b=p925V7snElOQZXlWMLip8xP1dwydX4MO40+mVFj0KyAvGYuTSaLzAdLMfBDDV081Yc
         fEnLq463d09UGAfhsrrBF62cGT/GqQtYjv0nq5ng6OZ5m4jKNTDM86uafLdc6j721eOg
         6f1p/HTw+taNTu4O7whEf+6bZmHYqxDOIiy5obUbw/5UsCVHJ9vf6MEnKgvy+pQvF+5J
         IeXr6w2XCQR8Hs6QTtvSXHW9D7hGl2Fnpi3RZZppFwo5+UafHLipz4crtYIUn/PHLBWc
         C/yluXJaWRsBj31/j7ffRgYozI9+twYp8EsiVCVuCJtaxWo11IwJJw/rhIA2CmV/TP98
         71mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M8j6Ldkq7Y6L6HNtPJpdtArkg82hNoz7EQt2ZZQpQiE=;
        b=ukiO7dtpVcqm5U0EAXKmIP27VKHX+8Bs1ZWdRZa8PwOYzbaOPPIpuyl87MrfGMTJyz
         eYCGkjOJagJRVBgo7Xl76Ztgs2xAWKp/x7ndYaJjFr5ly9aO36nv15e+KE1EpKClSmsa
         BWCTdX/VvUpbEZvSOfZyXhj7Gn92W89u39rSwTDB97OMcs+IER6A8Vb8E6QdvA4511dz
         3L9zGOaDmQqYmBfyjx4DamA9T5TORD9SRBbo3KVqByrECbtBkBONAFWMnhu4bld1ocqt
         5tXDiE2cWmKCgkdtwU/bN98WF6qck23f5pIosoeWjF1YAwDxlaWLBk0hQFfam2UHbp2I
         Lg3A==
X-Gm-Message-State: AOAM531YpBLHTLqDhPC3ziij+PMqoz/A5sqRFukzjNDOWexbPH4W4rCD
        MIswmKABJS4C7N+C+YvIA468EtmGpQPMsg==
X-Google-Smtp-Source: ABdhPJzHMtqQ9oWwXWEViAEvRErMfjdDqEOcrOWlNbyGgorcxLjtTk6m7wzAANlJgigaSW1gJ7x2hQ==
X-Received: by 2002:a17:902:9a8e:: with SMTP id w14mr3206869plp.6.1598998641433;
        Tue, 01 Sep 2020 15:17:21 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id w203sm3201356pfc.97.2020.09.01.15.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 15:17:21 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     hch@lst.de
Cc:     sfr@canb.auug.org.au, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, rth@twiddle.net,
        ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux-alpha@vger.kernel.org, tony.luck@intel.com,
        fenghua.yu@intel.com, linux-ia64@vger.kernel.org,
        schnelle@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        linux-parisc@vger.kernel.org
Subject: [PATCH 0/2] dma-mapping: update default segment_boundary_mask
Date:   Tue,  1 Sep 2020 15:16:44 -0700
Message-Id: <20200901221646.26491-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches are to update default segment_boundary_mask.

PATCH-1 fixes overflow issues in callers of dma_get_seg_boundary.
Previous version was a series: https://lkml.org/lkml/2020/8/31/1026

Then PATCH-2 sets default segment_boundary_mask to ULONG_MAX.

Nicolin Chen (2):
  dma-mapping: introduce dma_get_seg_boundary_nr_pages()
  dma-mapping: set default segment_boundary_mask to ULONG_MAX

 arch/alpha/kernel/pci_iommu.c    |  7 +------
 arch/ia64/hp/common/sba_iommu.c  |  3 +--
 arch/powerpc/kernel/iommu.c      |  9 ++-------
 arch/s390/pci/pci_dma.c          |  6 ++----
 arch/sparc/kernel/iommu-common.c | 10 +++-------
 arch/sparc/kernel/iommu.c        |  3 +--
 arch/sparc/kernel/pci_sun4v.c    |  3 +--
 arch/x86/kernel/amd_gart_64.c    |  3 +--
 drivers/parisc/ccio-dma.c        |  3 +--
 drivers/parisc/sba_iommu.c       |  3 +--
 include/linux/dma-mapping.h      | 21 ++++++++++++++++++++-
 11 files changed, 34 insertions(+), 37 deletions(-)

-- 
2.17.1

