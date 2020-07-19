Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C20C433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 21:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 926D020B1F
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 21:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="TussMoAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgGSVCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 17:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgGSVCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 17:02:41 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A06C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 14:02:41 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a6so15928793wrm.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 14:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wVukSkm9ZNAOyksCl8y76WJHMfa+qpv4fs73sx3+kgs=;
        b=TussMoAMDsJv+UH/1wFpUMF6LUXdTwmWbxtSXxMUxOE2jDXGkQOmwi27VruCj1jeu2
         M/s7KdBIo6u2cerL885trF0fM/ZAjsmmqVT+g9FiJH9gFYG78PuHtwb1qbUV3UlEEkgK
         kVBQtAygmc3IO4/iwa7bOEgHZq2nEgJz18ukU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wVukSkm9ZNAOyksCl8y76WJHMfa+qpv4fs73sx3+kgs=;
        b=SSoB6pEDG21C5YBrVXv51R5Nwms3BBW79EMBpkmtU5+bxu9CIibm8oGbhUe75FcWXu
         S7xBDTwkX7lQY5hbkDX7A4inUCICeYr9IMjHXfIf8sA202iFtLz1cwHZP+53/vHkcjQk
         bo8OagUkPJiiCbgZC6a5Q1Dw5rbUiGBaHolL4wwfNYAdfCPahrpEkxm2GbD8M4Awtqub
         NdkM1AumRIFaFH/Xf88bpOP9+ii9LW+nLC/GcWItwtOx6EhxPGFyQ0PDmBGfeJ/7pWgc
         VSqUc5S/+DXbY0vkN/u8tUhYMz8Kyi5q28aBP7fTE4Zww9FGP+eIfk4X4Nu6IGVssJ5A
         jzAw==
X-Gm-Message-State: AOAM53335ukWrrJ+r65WWgAAeuU2Hg27QE7K+IchpqH7KUBtcreqEBn3
        lpj2o7W2prCm/X/S4MpibHb7KQ==
X-Google-Smtp-Source: ABdhPJyrxUUVIMi0zt9ssTOxITvumFWrsHFTWkgYEUlquymTA502lFSv0QZIbN1xUpIAdqJCAsuq0g==
X-Received: by 2002:adf:c986:: with SMTP id f6mr19485303wrh.168.1595192559872;
        Sun, 19 Jul 2020 14:02:39 -0700 (PDT)
Received: from localhost.localdomain ([88.144.89.224])
        by smtp.gmail.com with ESMTPSA id l15sm27408453wro.33.2020.07.19.14.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 14:02:39 -0700 (PDT)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        brendanhiggins@google.com, masahiroy@kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Ignat Korchagin <ignat@cloudflare.com>, kernel-team@cloudflare.com
Subject: [PATCH v4 3/3] um: allow static linking for non-glibc implementations
Date:   Sun, 19 Jul 2020 22:02:22 +0100
Message-Id: <20200719210222.2811-4-ignat@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200719210222.2811-1-ignat@cloudflare.com>
References: <20200719210222.2811-1-ignat@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible to produce a statically linked UML binary with UML_NET_VECTOR,
UML_NET_VDE and UML_NET_PCAP options enabled using alternative libc
implementations, which do not rely on NSS, such as musl.

Allow static linking in this case.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/um/Kconfig         | 6 +++---
 arch/um/drivers/Kconfig | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 9318dc6d1a0c..d888b859c167 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -62,12 +62,12 @@ config NR_CPUS
 
 source "arch/$(HEADER_ARCH)/um/Kconfig"
 
-config FORBID_STATIC_LINK
-	bool
+config MAY_HAVE_RUNTIME_DEPS
+        bool
 
 config STATIC_LINK
 	bool "Force a static link"
-	depends on !FORBID_STATIC_LINK
+	depends on CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS || !MAY_HAVE_RUNTIME_DEPS
 	help
 	  This option gives you the ability to force a static link of UML.
 	  Normally, UML is linked as a shared binary.  This is inconvenient for
diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index 9160ead56e33..2e7b8e0e7194 100644
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -234,7 +234,7 @@ config UML_NET_DAEMON
 config UML_NET_VECTOR
 	bool "Vector I/O high performance network devices"
 	depends on UML_NET
-	select FORBID_STATIC_LINK
+	select MAY_HAVE_RUNTIME_DEPS
 	help
 	This User-Mode Linux network driver uses multi-message send
 	and receive functions. The host running the UML guest must have
@@ -246,7 +246,7 @@ config UML_NET_VECTOR
 config UML_NET_VDE
 	bool "VDE transport (obsolete)"
 	depends on UML_NET
-	select FORBID_STATIC_LINK
+	select MAY_HAVE_RUNTIME_DEPS
 	help
 	This User-Mode Linux network transport allows one or more running
 	UMLs on a single host to communicate with each other and also
@@ -294,7 +294,7 @@ config UML_NET_MCAST
 config UML_NET_PCAP
 	bool "pcap transport (obsolete)"
 	depends on UML_NET
-	select FORBID_STATIC_LINK
+	select MAY_HAVE_RUNTIME_DEPS
 	help
 	The pcap transport makes a pcap packet stream on the host look
 	like an ethernet device inside UML.  This is useful for making
-- 
2.20.1

