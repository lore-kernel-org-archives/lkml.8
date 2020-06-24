Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5E1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A48FF20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="P4gDQnvB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389014AbgFXJD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 05:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730725AbgFXJD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 05:03:26 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27303C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 02:03:26 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u8so920499pje.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 02:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CuwWstH+orWzdN5oonIi/uqi9D7RHwuB3qVndAM1Epk=;
        b=P4gDQnvBO2gxkNqub6xwOgqwcXxARtbIzm7b8wZjCIIM50ofSjoZcUL+YDs6Q2yC2o
         T9a7lH1XTR93IqWxiFNrQxuYCwt+OfkvxgYNYyc5eD2Ffnp86DWVYmNZaXEWpC/afU+8
         WvVkNlbNd06nIrWRdRDBisUl0QIHUUQMg0MnLr+CW+WyqnRm7yFEVwAzxUUq5ydrP43H
         1bMT5evN3KEu/UftsI4VIJbrk6iq3GpVBzS3iz/SYLbDFlHiTvLGQWKRM6o1MkzSJeXi
         DxcxXgPSgCLUgRy+6EdLglMcCS57Vf26741bEBEQ6VPWwkdi/Hu0k2bIUSIFqYpTiVb0
         RZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CuwWstH+orWzdN5oonIi/uqi9D7RHwuB3qVndAM1Epk=;
        b=AUpuwGEMLlBSq9EUOQIN510YAhnXFRgult8E6KdXgKLHGebBP++ZkpQBMho/sfKGKf
         pMEGE5ZdU4IhRcz4vBSmV6gvaWlrDHXzOw920L4muCHPHhQNCHCs3fd/TyjdbTY7dZwx
         6B+Hq84ZzqluOlGDO6g8Hhty5bE1yFirUFYohmVtfrZDS1eowAX70xiGB0EnlQ0OGi94
         4wHaE5z09tud2r2YlbwPL637xPRpaR02oMzw/qS/8I0go60vsaqpEffPd5Uy7OMuObve
         gofCPUhVU1l8Br+OLnm+1t7H3ERrbs4bTDDExOmMAb4vsbWhkXXo9DWLbJIGU9CxLRjV
         mDCQ==
X-Gm-Message-State: AOAM532N9a6PFu+89ruVVRGrj0ymbLMPKOmgXM5mpRapr8VDtE93x0X3
        Weim6KFoh+njPF8SAOYByza9iA==
X-Google-Smtp-Source: ABdhPJyYFhg10tCLwL1zdRl/wp1/ko3wN8cohqAyOUivtPimeEG0zDICG05j8PKiDtkss3C/NmHFYA==
X-Received: by 2002:a17:902:e989:: with SMTP id f9mr28719637plb.268.1592989405525;
        Wed, 24 Jun 2020 02:03:25 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id v1sm8062046pfn.210.2020.06.24.02.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 02:03:25 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        guoren@linux.alibaba.com
Subject: [PATCH v2 0/2] riscv: Add context tracker suppor
Date:   Wed, 24 Jun 2020 17:03:14 +0800
Message-Id: <cover.1592989082.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for irq_work via self IPI and context tracking.
It is tested in qemu-system-riscv64 and SiFive HiFive Unleashed board based
on v5.8-rc2.

---
Changes in v2
 - Fix the compiling warning

Greentime Hu (2):
  riscv: Support irq_work via self IPIs
  riscv: Enable context tracking

 arch/riscv/Kconfig                |  1 +
 arch/riscv/include/asm/irq_work.h | 10 ++++++++++
 arch/riscv/kernel/entry.S         | 23 +++++++++++++++++++++++
 arch/riscv/kernel/smp.c           | 15 +++++++++++++++
 4 files changed, 49 insertions(+)
 create mode 100644 arch/riscv/include/asm/irq_work.h

-- 
2.27.0

