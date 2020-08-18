Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FA7C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 01:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D111E2078B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 01:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lS0FFQw0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgHRBtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 21:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgHRBtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 21:49:52 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85D5C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 18:49:51 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f5so8451012plr.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 18:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gQ7reijxzkPh6XlB60dWEZ1uS5kV5suZyhlPdHoRKiQ=;
        b=lS0FFQw02e1S6J+y2jas2uRFTthkEM50S98LE7b0QcaoiUSm4hnffDVXADscrD60uD
         V+JLI2rMbLRBJW9QeAAU4LvOdy606dBDkeDVh9RcV3YrDVygmJN55SUMv+KOKCwzlwjd
         M6dp2iQBIex5Ff7DdvFljQUdDQyYy9rC4az4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gQ7reijxzkPh6XlB60dWEZ1uS5kV5suZyhlPdHoRKiQ=;
        b=EFLjQXMYqYhuJC+wZNy67ZczOFaB4q05jyIUIeKbsbWupPdLWe57RU2OdCTyEK4tGl
         ypL7in2pvXkoAa4mKRZThA4EmxGUDtWTpPTAHLJnJYflmW+MimPotM4Fw3iLWOFCGUgR
         KEq7bScjzdVcgXQCgbVv9l4sKXEulWRpZXSeAMPD/2tAX6CYEw9obMWseGBWAEysnV1W
         mXKIHxghijY7CC+4GXm549SJI4UupbiMKIiYx7FGtDsjpCtOZLqUWd+tfjOcsODw1SSs
         n5g0bcwkf68YdzRAcgbBdDfv59YLvAEQJnooOK5O8w8qjq6tetBHsc/HYv1LJHt1d49Z
         pgLw==
X-Gm-Message-State: AOAM533PuoRzNpQ0ZLX7ZouHlFNLcw+IItJsli17erwfLtVuSK6eDKdf
        MEv97UaLizoTpk3desSWbrpix+/Xp16tvA==
X-Google-Smtp-Source: ABdhPJzcUpp0e9Jifz63FSo+J2Cie2nTf8NCAk26apBIrpsNp4wFCfyqOJJsGGaoLNIvZvlQ7OozCA==
X-Received: by 2002:a17:90a:ac04:: with SMTP id o4mr14345979pjq.130.1597715391225;
        Mon, 17 Aug 2020 18:49:51 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id x12sm21086774pff.48.2020.08.17.18.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 18:49:50 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH] ARM64: vdso32: Install vdso32 from vdso_install
Date:   Mon, 17 Aug 2020 18:49:50 -0700
Message-Id: <20200818014950.42492-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the 32-bit vdso Makefile to the vdso_install rule so that 'make
vdso_install' installs the 32-bit compat vdso when it is compiled.

Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Fixes: a7f71a2c8903 ("arm64: compat: Add vDSO")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/Makefile               | 1 +
 arch/arm64/kernel/vdso32/Makefile | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 55bc8546d9c7..b45f0124cc16 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -165,6 +165,7 @@ zinstall install:
 PHONY += vdso_install
 vdso_install:
 	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso $@
+	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso32 $@
 
 # We use MRPROPER_FILES and CLEAN_FILES now
 archclean:
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index 5139a5f19256..d6adb4677c25 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -208,7 +208,7 @@ quiet_cmd_vdsosym = VDSOSYM $@
       cmd_vdsosym = $(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
 
 # Install commands for the unstripped file
-quiet_cmd_vdso_install = INSTALL $@
+quiet_cmd_vdso_install = INSTALL32 $@
       cmd_vdso_install = cp $(obj)/$@.dbg $(MODLIB)/vdso/vdso32.so
 
 vdso.so: $(obj)/vdso.so.dbg

base-commit: 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5
-- 
Sent by a computer, using git, on the internet

