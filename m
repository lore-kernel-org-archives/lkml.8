Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6610BC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 420A82073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="maGq02Kd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgDUIR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 04:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728437AbgDUIR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:17:26 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1490C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 01:17:25 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id my1so950859pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 01:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fIbpi7O6WJugTXFmCQCTQurXX9axhW0Esg76IWWTzRM=;
        b=maGq02KdAVVk27vQzcEjc+9Aj6eXZN5V2r9JEffWU+jLG6K5d3N6SCP/HPXtkbM6AK
         RhIjAxrGcbKW+dxQcT37HVZbsVXOjfjTQmpLWjKW209TaIKpir/7hJPTkkBmCv3Rfcls
         Md48rNfmNv79Zp4dZ//dMeuzz0fSSFNgW57QglHqXwr3A1P3Xk0/wcC0wb6mJa4hkW37
         c05pY5whmZVrBy3NEhbbYVPdXi5F6QCxP3xEheuk3vt5UkgEocij/Srp/xIeqjVJCj5+
         gS5hzy/yP4GJRnptmpCjpcdIj8LFjzEWpsJv9d+HgnD8+ovaGjhh0AH59EP3jfZtHWP/
         6/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fIbpi7O6WJugTXFmCQCTQurXX9axhW0Esg76IWWTzRM=;
        b=puya2LxIT/2QE0invLnOn+0JODtmmU6ZOVTqlOUvYeHMnNVbRkCYOvs4HcXI2uWgat
         iU8m/POqIrDaHD1Dv1ml+oMvxQ9Oz2eDBJcaVBg8vV1ciZscODD4ctNMstffVCCp+TPR
         NBMTNh4lnzXlvccAyxbiXRpUlT39tNOP5KiYplAwWTv0oFD2nwu9r8AQDhuqHSq7NmQQ
         v0h9dNxG+kNx549p4KqxzwBv9sz8NbqE2BoDej/WXTy7pjigY2dnz+2l4w0LzTe8nY4p
         7KL+S1G7CNCD6O6e6gt3RjcP7iXNfx8ck2YR+BJdM/eUnFwfnsku4N1PChW35fkpRRSE
         Xtow==
X-Gm-Message-State: AGi0Pub/1pYyJVA0U0zNM2Rstbc2NZ4FSzcUy3Mla3spFK4MB0nHIADV
        FkGVejlhZbQ+3N3jRfrtFxIMCQ==
X-Google-Smtp-Source: APiQypLLHyb++yTAlD6wehS7jB/h9oebLCuGheJNM864LJqIFw1n0PbffrUmSWn8iBeylKnoopk9/Q==
X-Received: by 2002:a17:90a:498a:: with SMTP id d10mr4369781pjh.194.1587457045415;
        Tue, 21 Apr 2020 01:17:25 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id v9sm1610067pju.3.2020.04.21.01.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 01:17:24 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 0/4] Extract DEBUG_WX to shared use.
Date:   Tue, 21 Apr 2020 16:17:11 +0800
Message-Id: <cover.1587455584.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some architectures support DEBUG_WX function, it's verbatim from each
others, so extract to mm/Kconfig.debug for shared use.

PPC and ARM ports don't support generic page dumper yet, so we only
refine x86 and arm64 port in this patch series.

For RISC-V port, the DEBUG_WX support depends on other patches which
be merged already:
  - RISC-V page table dumper
  - Support strict kernel memory permissions for security

Zong Li (4):
  mm: add DEBUG_WX support
  riscv: support DEBUG_WX
  x86: mm: use ARCH_HAS_DEBUG_WX instead of arch defined
  arm64: mm: use ARCH_HAS_DEBUG_WX instead of arch defined

 arch/arm64/Kconfig              |  1 +
 arch/arm64/Kconfig.debug        | 29 -----------------------------
 arch/riscv/Kconfig              |  1 +
 arch/riscv/include/asm/ptdump.h |  6 ++++++
 arch/riscv/mm/init.c            |  3 +++
 arch/x86/Kconfig                |  1 +
 arch/x86/Kconfig.debug          | 27 ---------------------------
 mm/Kconfig.debug                | 33 +++++++++++++++++++++++++++++++++
 8 files changed, 45 insertions(+), 56 deletions(-)

-- 
2.26.1

