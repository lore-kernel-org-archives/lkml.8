Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D871C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 07:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C77720936
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 07:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ImDaDzcW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgHaHeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 03:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgHaHdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 03:33:54 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1100DC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 00:33:54 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y6so2626283plt.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 00:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hZSVVlzCnMPoR4b5u5OMpuptMjmKI3KwnmPpyqImBpQ=;
        b=ImDaDzcWK/4IInTiJ2oAvPHYIu0YQryEKk/fy8tssE3Ltr6/P/ijFD4XLwmfExahz5
         CN5fnhgN0m5B8+MH0JbreZf6BD9Yg+H3nlcevR8kNTQr6KzmYYZ7dQ8lv1ZwRM6lS71q
         mahzsLLg2VX8y6ldWR3y1s4yARiNNr+ShIv0rDlrc7rW5pGN5Yq+v7VXGEgNHfasB5py
         HVDpl7am9OetRZL/psTh9wSMTeQAlNuSPDJ4rxteMNsDPKk6HbmVsaLgWJ/GiwLpo+ze
         aIYmdAikpsFMtYz1EWGjspUybSbavWuO0aiNUtM5e2IOH8D56JhwAYqX7HDJqqTQPD7r
         OQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hZSVVlzCnMPoR4b5u5OMpuptMjmKI3KwnmPpyqImBpQ=;
        b=CIoavj+108zYWnFhV3a7FTa8kVwc79yce6cOwe3wxeHVzWu1GE9idQBJGTfudEIRNr
         RffpKdTKRBEJXKMDVIqExsb/89AvKLLM8erezbTkV1pF/S+1lRTSQWLIkVREHzuCOK7F
         ombkofSbGc+2MEjKTcr2Vj7NiTU9/Dwf+0aydCSFVq6XnnnaiRx+2wUxXP1Suwj2tzFF
         T+jM9BAQbWbveQ6P4S8DOr/NlB5DGOimkiH3wT+/lntOMjOKwqD/TtSNN8n9uRKJD0IK
         x1ZfCNvSp0Xx9o9W937RxVBaOW7irosjaWBjxDjrgU92yXd2UkbZwoYqf23+UIajrSpj
         76ew==
X-Gm-Message-State: AOAM532MRD2mjDQe16po5J9e00fNYAeda9gHcXtCr+28cmEmjjcQoySU
        KMol0HkJ+DhMSc7L82CoBOMUvbRMipYL7w==
X-Google-Smtp-Source: ABdhPJwMVEHHX5MwUgGnmy7sotXz2c38b13YD+1A9xPCFVHxe7VjzTGF2tMmeWi8CszDKrNDK1Y9OA==
X-Received: by 2002:a17:90b:1098:: with SMTP id gj24mr235879pjb.55.1598859233588;
        Mon, 31 Aug 2020 00:33:53 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id m3sm6065979pjn.28.2020.08.31.00.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 00:33:53 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        david.abdurachmanov@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v4 0/3] Get cache information from userland
Date:   Mon, 31 Aug 2020 15:33:47 +0800
Message-Id: <cover.1598859038.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no standard CSR registers to provide cache information, the
way for RISC-V is to get this information from DT. Currently, AT_L1I_X,
AT_L1D_X and AT_L2_X are present in glibc header, and sysconf syscall
could use them to get information of cache through AUX vector. We
exploit 'struct cacheinfo' to obtain the information of cache, then we
don't need additional variable or data structure to record it.

We also need some works in glibc, but we have to support the function in
kernel first by rule of glibc, then post the patch to glibc site.

The result of 'getconf -a' as follows:

LEVEL1_ICACHE_SIZE                 32768
LEVEL1_ICACHE_ASSOC                8
LEVEL1_ICACHE_LINESIZE             64
LEVEL1_DCACHE_SIZE                 32768
LEVEL1_DCACHE_ASSOC                8
LEVEL1_DCACHE_LINESIZE             64
LEVEL2_CACHE_SIZE                  2097152
LEVEL2_CACHE_ASSOC                 32
LEVEL2_CACHE_LINESIZE              64

Changed in v4:
  - Check null pointer before use.
  - Re-write the code for readability.
  - Rebase source to v5.9-rc3.

Changed in v3:
  - Fix sparse warning: Use NULL instead of integer 0.

Changed in v2:
  - Add error checking for parsing cache properties.

Zong Li (3):
  riscv: Set more data to cacheinfo
  riscv: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
  riscv: Add cache information in AUX vector

 arch/riscv/include/asm/cacheinfo.h   |  5 ++
 arch/riscv/include/asm/elf.h         | 13 ++++
 arch/riscv/include/uapi/asm/auxvec.h | 24 +++++++
 arch/riscv/kernel/cacheinfo.c        | 98 +++++++++++++++++++++++-----
 4 files changed, 124 insertions(+), 16 deletions(-)

-- 
2.28.0

