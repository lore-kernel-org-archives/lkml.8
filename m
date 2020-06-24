Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EFFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4133C20836
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="pz4Gwz36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390667AbgFXVXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 17:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390601AbgFXVXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 17:23:39 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60F3C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 14:23:37 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a6so3700493wrm.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 14:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OU9hxPukewkXRvLde3vGecBRHA8j0VV+Jg90d1DOcXc=;
        b=pz4Gwz36EmbLLeBqzMzfnP1XnxcMmgpvXGa+t2k6RhXPR65sMMYzJ0SEBfLj4Eg9Zn
         uZ6vFE0dd0jCjFcQpfN/MKVo4tY3c5LvBjdXqKFq/F/YPpDzX1eUUbPhVqzCee7KWzsD
         bwmuccx0BNMY7d+/ZQv2PVOINeBJvALCj8u20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OU9hxPukewkXRvLde3vGecBRHA8j0VV+Jg90d1DOcXc=;
        b=P1aZ+qzYRAv1k966OqxqJuNYadXzAGNvwgUsLypc1t3O8xaGvuHl+BozKc3Vxn4jYY
         dX7wEFZ9Ss3TOiA1bCbRBwWsg+L6n1P2vVJIxZkqFcJjNzwH7aFY56kar25SYDCy479T
         lamkKKuMjHkCBK9uV8mDE6/s4bpj+lVUH7Mq6LtdR7CzLAfp24Hm6m9tY2EKiZcd2JfZ
         /BtN+t4/pLeDxhCqyZwOwLUmIB41EVL7x9R19iycIKVhoPW9yvTOJVg72Ikr0mE3yGYu
         nUu+XnR+14vPMSTJrnKzuPd7D91KT77stDtN5w9Fztka8ARcOxKRYxD2VsEeyGU06CmD
         2f3A==
X-Gm-Message-State: AOAM530FcKcClM1wFhFFOrCnFDk9nY3VP2nR/BI7jef+5LEUgVmHAh7z
        6e5YtLLUTV6uKjuSkSqbBIjLt1u39XNRkQ==
X-Google-Smtp-Source: ABdhPJw3I6T+xYlxY/Igp1uJwhf1Gyy7wkgQyAKBe5mphvScQvntEyyOyex1ib4Gi+CyrDfERVjrjA==
X-Received: by 2002:adf:ef89:: with SMTP id d9mr19574699wro.124.1593033816238;
        Wed, 24 Jun 2020 14:23:36 -0700 (PDT)
Received: from localhost.localdomain (88-144-169-85.host.pobb.as13285.net. [88.144.169.85])
        by smtp.gmail.com with ESMTPSA id f17sm8241261wrq.3.2020.06.24.14.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 14:23:35 -0700 (PDT)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        brendanhiggins@google.com, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Ignat Korchagin <ignat@cloudflare.com>
Subject: [RFC PATCH] Revert "um: Make CONFIG_STATIC_LINK actually static"
Date:   Wed, 24 Jun 2020 22:23:19 +0100
Message-Id: <20200624212319.403689-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 3363179385629c1804ea846f4e72608c2201a81e.

This change is too restrictive. I've been running UML statically linked kernel
 with UML_NET_VECTOR networking in a docker "FROM: scratch" container just fine.
As long as we don't reference network peers by hostname and use only IP
addresses, NSS is not needed, so not used. In other words, it is possible to
have statically linked UML and UML_NET_VECTOR (and other networking types) and
use it, although with some restrictions, so let's not disable it.

Additionally, it should be at least theoretically possible to use another libc
(like musl, bionic etc) for static linking. I was able with some hacks to
compile UML against musl, although the executable segfaults for now. But this
option prevents even the research to be done.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 arch/um/Kconfig         | 8 +-------
 arch/um/drivers/Kconfig | 3 ---
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 96ab7026b037..817a4c838a06 100644
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
+	default n
 	help
 	  This option gives you the ability to force a static link of UML.
 	  Normally, UML is linked as a shared binary.  This is inconvenient for
@@ -76,9 +73,6 @@ config STATIC_LINK
 	  Additionally, this option enables using higher memory spaces (up to
 	  2.75G) for UML.
 
-	  NOTE: This option is incompatible with some networking features which
-	  depend on features that require being dynamically loaded (like NSS).
-
 config LD_SCRIPT_STATIC
 	bool
 	default y
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

