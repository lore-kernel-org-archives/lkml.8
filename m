Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E487FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A83C120781
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="cP7JTsXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgGBCyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 22:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgGBCyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 22:54:38 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF464C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 19:54:37 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id f16so1478123pjt.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 19:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hmqaZJTWyrZ0FbjDXm8RaPiEdszyKtA9q/J035BPFVA=;
        b=cP7JTsXrRAwaUk/s3r6046kZthbuvo+pnMiLbeJ92TN5Df4IlY5imhcjw6DhnGkCbp
         kvsnwkrOkzH3a3JGOqOwZGog/7b3prPfeaBhvzie1IFd3qYoC3heY995lUjewiSw6d1H
         4AB3xQJu+LyZ+/b9OESxctzddqplBAiW2jQkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hmqaZJTWyrZ0FbjDXm8RaPiEdszyKtA9q/J035BPFVA=;
        b=jxCxur4OWi//jHSphw/LoMjnye6N26+PYZ6rCZsVDcobru9Nj9b9VEFrBBuoogL7M6
         W1AjqYDl1PzwKaKkMuraW9mUMAPNMHGCKp2klH0Ve8peNzHvlrFvy1d0gVEKBT3iGxAN
         Ts4HlbE01WiZiO2vIAylDA/tlt2jjlm9pEYK3zVLGatQM0IxELCP3it5mQmWd9nypdZH
         d806pLPxvqzQ6FMbA4W5FvqB2SlAONcGVmPnPNEqyojtSh4/p9lBlVctORAqcxdLh/Bn
         hW7gsnlQ68Buuo/mZAQnHkebpamDfmOwamnuN7n8sfeAjV7StKpS4U+TwIEuXaUeJnlf
         X1bw==
X-Gm-Message-State: AOAM530grfNit0kfPukVfl2W56BaxnRh/OxQ+zwy/WQ6eQtF6zOag7yv
        Ghz9UPFMnN9JeMqPparltINJhgTGVBI=
X-Google-Smtp-Source: ABdhPJyo4y4l83li9ExCVZOeOn/mYCprRDsvcN4pWndY1hK1p+y5El3vuSv4CxjdcbgqE8OWQCYmKA==
X-Received: by 2002:a17:902:6bc1:: with SMTP id m1mr25456864plt.158.1593658477129;
        Wed, 01 Jul 2020 19:54:37 -0700 (PDT)
Received: from localhost (2001-44b8-1113-6700-3c80-6152-10ca-83bc.static.ipv6.internode.on.net. [2001:44b8:1113:6700:3c80:6152:10ca:83bc])
        by smtp.gmail.com with ESMTPSA id u26sm7243117pgo.71.2020.07.01.19.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 19:54:36 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v8 0/4] KASAN for powerpc64 radix
Date:   Thu,  2 Jul 2020 12:54:28 +1000
Message-Id: <20200702025432.16912-1-dja@axtens.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building on the work of Christophe, Aneesh and Balbir, I've ported
KASAN to 64-bit Book3S kernels running on the Radix MMU.

This provides full inline instrumentation on radix, but does require
that you be able to specify the amount of physically contiguous memory
on the system at compile time. More details in patch 4.

v8 is just a rebase of v7 on a more recent powerpc/merge and a fixup
of a whitespace error.

Module globals still don't work, but that's due to some 'clever'
renaming of a section that the powerpc module loading code does to
avoid more complicated relocations/tramplines rather than anything to
do with KASAN.

Daniel Axtens (4):
  kasan: define and use MAX_PTRS_PER_* for early shadow tables
  kasan: Document support on 32-bit powerpc
  powerpc/mm/kasan: rename kasan_init_32.c to init_32.c
  powerpc: Book3S 64-bit "heavyweight" KASAN support

 Documentation/dev-tools/kasan.rst             |   8 +-
 Documentation/powerpc/kasan.txt               | 122 ++++++++++++++++++
 arch/powerpc/Kconfig                          |   3 +-
 arch/powerpc/Kconfig.debug                    |  23 +++-
 arch/powerpc/Makefile                         |  11 ++
 arch/powerpc/include/asm/book3s/64/hash.h     |   4 +
 arch/powerpc/include/asm/book3s/64/pgtable.h  |   7 +
 arch/powerpc/include/asm/book3s/64/radix.h    |   5 +
 arch/powerpc/include/asm/kasan.h              |  11 +-
 arch/powerpc/kernel/Makefile                  |   2 +
 arch/powerpc/kernel/process.c                 |  16 ++-
 arch/powerpc/kernel/prom.c                    |  76 ++++++++++-
 arch/powerpc/mm/kasan/Makefile                |   3 +-
 .../mm/kasan/{kasan_init_32.c => init_32.c}   |   0
 arch/powerpc/mm/kasan/init_book3s_64.c        |  73 +++++++++++
 arch/powerpc/mm/ptdump/ptdump.c               |  10 +-
 arch/powerpc/platforms/Kconfig.cputype        |   1 +
 include/linux/kasan.h                         |  18 ++-
 mm/kasan/init.c                               |   6 +-
 19 files changed, 377 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/powerpc/kasan.txt
 rename arch/powerpc/mm/kasan/{kasan_init_32.c => init_32.c} (100%)
 create mode 100644 arch/powerpc/mm/kasan/init_book3s_64.c

-- 
2.25.1

