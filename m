Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF17C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D7322067D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nMnqkLp9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgHDMrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 08:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbgHDMoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 08:44:22 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16174C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 05:44:22 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d190so2537606wmd.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 05:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kh3fLdhtAK8iltYl6aGsCpfSwDzQcJQDII6+Lr3Ir4w=;
        b=nMnqkLp9MyaD7mVBWPOdpipOJAA/A+eqGB2+7v2AnGvajHcTmtJGzfEa8AObnk3OGO
         X6yzj+zqibdmVd52uW6BsVLE1twlWOD8iHOgBNZ4VGgtFVF3pWYXGAqPfb8l+53YHRNG
         fkEUw2haM1Xyld8Y5Y4NGy7cZi9KRdEu+s1yEngpns9vBqo+5u5vyUfrDXyt3ivwb/rB
         clg/7E3xKGUCx24uRr1RBdN9jkogBMFaY3KQRg6bWxxmOvo5fYHBnXt+k0Nf+/PDBu2f
         s6HexrWOx4jElhs7Dd34qf7UdiQd6LCDGnCq2XOnNawU9uylFjuZkOHE2fgbsJFmSbff
         SnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kh3fLdhtAK8iltYl6aGsCpfSwDzQcJQDII6+Lr3Ir4w=;
        b=oabJUsKn5bJ2yODlvSjnFk3AXQq0Db2WFFcHmyOb6/4qP7EmXEv6M4Yn3qx/F9UwBI
         D8Eay7LxmU6U3HXa3WcOLACUIND9ya+JMasCVTlasEuF2X8CYKVaDFRiH1hjPxrACL2B
         YrB7Giy4sEhYqdKjnh9wNVeOqY6NVKX+XFPuS3HY7sgGPLcfYu+Tt6as1g1nukhmgL6R
         s6eV0YYMpFuu5xXvSI4nhY8AxqJmqavqL7/QDRuPXPQne3BnF53kPZL3xMZKmfrVz7Us
         LIe+Rf3jk0S//u/8ED4s1aK/o2P5DMkXBzhDWrb/aEB5STQDGlADXnhAMhDU61b9XVLT
         hw5Q==
X-Gm-Message-State: AOAM53253db4DT6Zgzj8Bw1LsCONeP8A2mEI7mmvy9aDd7uvWoGbjc+P
        TC+RMDsQDo1pc2E5qKJEULmrDw==
X-Google-Smtp-Source: ABdhPJxlETqHM58ekeF7YRtlEWgL6bu7W0dZE0N/3gry/XAbgEfMhCjsPaytXate5VOSsOPSdbiQrg==
X-Received: by 2002:a1c:7702:: with SMTP id t2mr3859731wmi.169.1596545060810;
        Tue, 04 Aug 2020 05:44:20 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id r206sm4554096wma.6.2020.08.04.05.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 05:44:18 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 9218B1FF8C;
        Tue,  4 Aug 2020 13:44:17 +0100 (BST)
From:   =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        christoffer.dall@arm.com, maz@kernel.org,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH  v1 2/3] arm64: gate the whole of pci-xgene on CONFIG_PCI_XGENE
Date:   Tue,  4 Aug 2020 13:44:16 +0100
Message-Id: <20200804124417.27102-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200804124417.27102-1-alex.bennee@linaro.org>
References: <20200804124417.27102-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a little weirder as bits of the file are already conditioned
on the exiting symbol. Either way they are not actually needed for
non-xgene machines saving another 12k:

-rwxr-xr-x 1 alex alex  86033880 Aug  3 16:39 vmlinux.orig*
-rwxr-xr-x 1 alex alex  85652472 Aug  3 16:54 vmlinux.rm-thunder*
-rwxr-xr-x 1 alex alex  85639808 Aug  3 17:12 vmlinux*

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 drivers/pci/controller/Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index 8fad4781a5d3..3b9b72f5773a 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -47,6 +47,4 @@ obj-y				+= mobiveil/
 
 obj-$(CONFIG_PCI_THUNDER) += pci-thunder-ecam.o
 obj-$(CONFIG_PCI_THUNDER) += pci-thunder-pem.o
-ifdef CONFIG_PCI
-obj-$(CONFIG_ARM64) += pci-xgene.o
-endif
+obj-$(CONFIG_PCI_XGENE) += pci-xgene.o
-- 
2.20.1

