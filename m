Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6D5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69CDD2074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q+MNE8p9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgGAIdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbgGAIbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:31:34 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED26C03E97A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:31:33 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s10so22842381wrw.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g4vtMLIQ9URViZPtlxWaBshj1L+t67E3sh2ahjZQq+U=;
        b=q+MNE8p9VMC8baguroJ/Mnwydbo6fLutqepXxZA0e3uFYruuvKjRyS80k8dDrqJSon
         gh9EWOZdOt5O1w/fOxnf/C+JEFFEaoIzkq3lXeB8zEWq9SDPAwW8REnAfOSJ8ajhGaWZ
         KwcHdwIpGdjz66bCPMvjrj1iFxPLAf0MuvpMBbC7j2PECcMnZ22x9fOpzHlncjoXVf7n
         WlB7o/M6fIuLuZrFjql8QL1ymluT+iZ0H79clK9NMXMhsIYX7WFfPgyCfKWNJ3vEMg8B
         FHJ/wxzOt9qO5q5gNeRGdNJgHAAHIpGk+hQyoeOw8FMqGUqHl985zJOtDH36clZb5BoO
         naeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g4vtMLIQ9URViZPtlxWaBshj1L+t67E3sh2ahjZQq+U=;
        b=lNJKR+2SaEbCDTsOQYQx+BDiUTJmjV9BV/bfQ9YlIcSDlg7AqblCgcNkuJr+6gmF6f
         R1ocLOA2Xqok4UA5dPdIX/+qvEFZYTPoGqeKXOJ2kKuU2HHd1vr6aotH+weRbUJpRO9U
         IRFX3tIu70ejOjMd4a07ScgxQuEgpEm/y2/eIe0YKJ1bjNLvjHg43BnSHmrPkjO/7+IO
         ZpvDVk6e3LAmBeU49k964Xu7TLkmlGeou3FTmNoo+OgBT1S6v9LyCAdnbcQyQm7YdLbd
         RU5H6LdX8ESJ1r8gNnlOw30YP1caDpPVcKnCO4/MRr07wHcBCQ7vkzk6wezUsOmcPWCC
         8rIQ==
X-Gm-Message-State: AOAM531LZg2p8jy3gC4c/XuAmiF3jq4nEOgfBBv89age4R5ROVpXQWe8
        m96s1lhZSqPf0we5+8DNaSwMLA==
X-Google-Smtp-Source: ABdhPJybwW1ISMYlCXUphCc8qWH1/R6vvWtAJh/2Kw6uA38mDXSitBGOdn6Sn9eH1ywmhhJLphBf8Q==
X-Received: by 2002:adf:f8cb:: with SMTP id f11mr27048723wrq.358.1593592292632;
        Wed, 01 Jul 2020 01:31:32 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id 59sm6717816wrj.37.2020.07.01.01.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 01:31:31 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        George Zhang <georgezhang@vmware.com>
Subject: [PATCH v2 07/30] misc: vmw_vmci_defs: Mark 'struct vmci_handle VMCI_ANON_SRC_HANDLE' as __maybe_unused
Date:   Wed,  1 Jul 2020 09:30:55 +0100
Message-Id: <20200701083118.45744-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701083118.45744-1-lee.jones@linaro.org>
References: <20200701083118.45744-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmw_vmci_defs.h is included by multiple source files.  Some of which
do not make use of 'struct vmci_handle VMCI_ANON_SRC_HANDLE' rendering
it unused.  Ensure the compiler knows that this is in fact intentional
by marking it as __maybe_unused.  This fixes the following W=1 warnings:

 In file included from drivers/misc/vmw_vmci/vmci_context.c:8:
 include/linux/vmw_vmci_defs.h:162:33: warning: ‘VMCI_ANON_SRC_HANDLE’ defined but not used [-Wunused-const-variable=]
 162 | static const struct vmci_handle VMCI_ANON_SRC_HANDLE = {
 | ^~~~~~~~~~~~~~~~~~~~
 In file included from drivers/misc/vmw_vmci/vmci_datagram.c:8:
 include/linux/vmw_vmci_defs.h:162:33: warning: ‘VMCI_ANON_SRC_HANDLE’ defined but not used [-Wunused-const-variable=]
 162 | static const struct vmci_handle VMCI_ANON_SRC_HANDLE = {
| ^~~~~~~~~~~~~~~~~~~~

Cc: George Zhang <georgezhang@vmware.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-omap2/mmc.h              | 4 ----
 drivers/mmc/host/omap.c                | 1 -
 include/linux/platform_data/mmc-omap.h | 3 +++
 include/linux/vmw_vmci_defs.h          | 2 +-
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/mmc.h b/arch/arm/mach-omap2/mmc.h
index 7f4e053c34344..b5533e93cb632 100644
--- a/arch/arm/mach-omap2/mmc.h
+++ b/arch/arm/mach-omap2/mmc.h
@@ -16,7 +16,3 @@ static inline int omap_msdi_reset(struct omap_hwmod *oh)
 	return 0;
 }
 #endif
-
-/* called from board-specific card detection service routine */
-extern void omap_mmc_notify_cover_event(struct device *dev, int slot,
-					int is_closed);
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 33d7af7c7762a..6e4199556d000 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -28,7 +28,6 @@
 #include <linux/slab.h>
 #include <linux/platform_data/mmc-omap.h>
 
-
 #define	OMAP_MMC_REG_CMD	0x00
 #define	OMAP_MMC_REG_ARGL	0x01
 #define	OMAP_MMC_REG_ARGH	0x02
diff --git a/include/linux/platform_data/mmc-omap.h b/include/linux/platform_data/mmc-omap.h
index 9acf0e87aa9be..f0b8947e6b07d 100644
--- a/include/linux/platform_data/mmc-omap.h
+++ b/include/linux/platform_data/mmc-omap.h
@@ -116,3 +116,6 @@ struct omap_mmc_platform_data {
 
 	} slots[OMAP_MMC_MAX_SLOTS];
 };
+
+extern void omap_mmc_notify_cover_event(struct device *dev, int slot,
+					int is_closed);
diff --git a/include/linux/vmw_vmci_defs.h b/include/linux/vmw_vmci_defs.h
index fefb5292403bc..be0afe6f379ba 100644
--- a/include/linux/vmw_vmci_defs.h
+++ b/include/linux/vmw_vmci_defs.h
@@ -159,7 +159,7 @@ static inline bool vmci_handle_is_invalid(struct vmci_handle h)
  */
 #define VMCI_ANON_SRC_CONTEXT_ID   VMCI_INVALID_ID
 #define VMCI_ANON_SRC_RESOURCE_ID  VMCI_INVALID_ID
-static const struct vmci_handle VMCI_ANON_SRC_HANDLE = {
+static const struct vmci_handle __maybe_unused VMCI_ANON_SRC_HANDLE = {
 	.context = VMCI_ANON_SRC_CONTEXT_ID,
 	.resource = VMCI_ANON_SRC_RESOURCE_ID
 };
-- 
2.25.1

