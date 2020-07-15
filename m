Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B4DC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D79392065D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="y+7xaubN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgGOUM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 16:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbgGOUMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 16:12:22 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACC5C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 13:12:22 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o11so4172488wrv.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 13:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dia+f5f3wvQzmpYjq6ONA8seF0ZSOjUyP7q0pPCU8gE=;
        b=y+7xaubN85hm0VkPLZmHNUEiHABvfBCqkOclf4aSjJZyIKhK0qT3k9d1a1Kjd9xWfI
         yOOJfjZyB1RameJ3L2thtQ+OCfEPdAlYGtzkLIt41jwSNNa79DDtFLl1NyGhT6CPJGye
         b4isXTPp+hp+hErFrWzx22ciFMfB13LdtRyz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dia+f5f3wvQzmpYjq6ONA8seF0ZSOjUyP7q0pPCU8gE=;
        b=og+b/cQwG+ceBO5qEYxDdLmPCV28/2z3NLm5owxMGGX/tpg9pIKeVxi4im2KiAwCip
         68a9vvTVWvGJjrjjnQFKiRNltugaH2T2xNTtkSDwFQfh+voYTicHPl+8UkNmDd6pXfps
         m2VVneT68DajUMmZ5jBNvWLWapwTz7nXv8hzeRrYBDYLiM/cOs8cfnO/fkeYnH+YiYLz
         F6pRoL3NfV3nkvc+9SskYa8E1KfiLsmF8ccSorgaglM1judr2X6iYy63ATvFUZ9Pwzhj
         ORIiT+Kr6EmZAIX6qqG6xsa9dYFWBtlDooh3N7dzfv7Wn0Z/XkM4J6p5M+MmS1hvZ6/u
         GQ8w==
X-Gm-Message-State: AOAM531BjTluESwu+uUm98LWqQ5B2CSFhMQ66CPexk6T2s80fghvUHzs
        rB7By6qU9/d8ibaftKcD4ErQ7w==
X-Google-Smtp-Source: ABdhPJzoruHsfO20jqQFRAaqzq7uXGD3IjSwFRTxrgR+ek9zXRU/o+P3IAkyJdX46KhbPFg1pm/eKw==
X-Received: by 2002:adf:80c7:: with SMTP id 65mr1204312wrl.246.1594843940696;
        Wed, 15 Jul 2020 13:12:20 -0700 (PDT)
Received: from dev.cfops.net (88-144-169-51.host.pobb.as13285.net. [88.144.169.51])
        by smtp.gmail.com with ESMTPSA id p4sm4765528wrx.63.2020.07.15.13.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 13:12:20 -0700 (PDT)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        brendanhiggins@google.com, masahiroy@kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Ignat Korchagin <ignat@cloudflare.com>, kernel-team@cloudflare.com
Subject: [PATCH v3 3/3] um: allow static linking for non-glibc implementations
Date:   Wed, 15 Jul 2020 21:11:59 +0100
Message-Id: <20200715201159.54166-4-ignat@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200715201159.54166-1-ignat@cloudflare.com>
References: <20200715201159.54166-1-ignat@cloudflare.com>
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
 arch/um/Kconfig         | 5 +----
 arch/um/drivers/Kconfig | 3 ---
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 9318dc6d1a0c..beb98b3b9f75 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -62,12 +62,9 @@ config NR_CPUS
 
 source "arch/$(HEADER_ARCH)/um/Kconfig"
 
-config FORBID_STATIC_LINK
-	bool
-
 config STATIC_LINK
 	bool "Force a static link"
-	depends on !FORBID_STATIC_LINK
+	depends on CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS || (!UML_NET_VECTOR && !UML_NET_VDE && !UML_NET_PCAP)
 	help
 	  This option gives you the ability to force a static link of UML.
 	  Normally, UML is linked as a shared binary.  This is inconvenient for
diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index 9160ead56e33..72d417055782 100644
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -234,7 +234,6 @@ config UML_NET_DAEMON
 config UML_NET_VECTOR
 	bool "Vector I/O high performance network devices"
 	depends on UML_NET
-	select FORBID_STATIC_LINK
 	help
 	This User-Mode Linux network driver uses multi-message send
 	and receive functions. The host running the UML guest must have
@@ -246,7 +245,6 @@ config UML_NET_VECTOR
 config UML_NET_VDE
 	bool "VDE transport (obsolete)"
 	depends on UML_NET
-	select FORBID_STATIC_LINK
 	help
 	This User-Mode Linux network transport allows one or more running
 	UMLs on a single host to communicate with each other and also
@@ -294,7 +292,6 @@ config UML_NET_MCAST
 config UML_NET_PCAP
 	bool "pcap transport (obsolete)"
 	depends on UML_NET
-	select FORBID_STATIC_LINK
 	help
 	The pcap transport makes a pcap packet stream on the host look
 	like an ethernet device inside UML.  This is useful for making
-- 
2.20.1

