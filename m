Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B3CC433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 08:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FD63207CD
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 08:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Pfn0Q9jS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgGDIwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 04:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgGDIwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 04:52:38 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DACBC08C5DE
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 01:52:38 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k6so35181522wrn.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 01:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HnWE2oirgCn5o685xdW8KSCAfE3mrg9wzOfvPNj8xZg=;
        b=Pfn0Q9jSVoOwJyQytzVUeoY7P2OBAlYd1kI+8Ic+E7FkY31u/OBLdx2MwJQAj7U0xS
         LZloTN42l6yrZlVD7MHnq7NtLkSsxeMPiW1IVwvff0kZ7haeMVd1EAbrpEE9p927TtN/
         0epWoIWnrbaM1NXUl5fyZlH0dq7ssGJdiPbxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HnWE2oirgCn5o685xdW8KSCAfE3mrg9wzOfvPNj8xZg=;
        b=e6dYgGrrgooRbE0y8HTB194vgTsgybXVXZLXuMHPbDLi7N+sYjAS8vjOlPRh4mRe69
         iKMKeun+HyW2leLzMnMyMCggzkKHhnu4NCM7Vj4RdeIIR4hTveCKivmfSf7/3yCxOLLC
         YDqFpDa9UeBShvoNv63TptkibTIvNcGTzSHj6unJLk7eUDMj+bQYUlc/voKBUrbnGtEv
         sHeczX43jdfyGZpYWC7dJbcSyjzmOcGN9CTiW5kLwjANbwAkZLrxCVjapKLas1L9h52r
         YVQc/2pIkDzcLVs7bLrVuje90KzltSyCs4PJN5rzAPUX1s9qK/FsUtBbgWvXhiz3ZLUi
         93IA==
X-Gm-Message-State: AOAM531jJtb71mOuyJfJtiwvY7r6LfukFFFTR12hQ1W6r0qJ2QgAgZD4
        q5c/0SI+m7fAsbix4Jy0QA42mQ==
X-Google-Smtp-Source: ABdhPJxzJZHlOo7En8/cR47BCLtZwGkdzG4ZzFalBQ61w+bS7kduaH5pHCbCBTUTALDaJGaV3wYWPw==
X-Received: by 2002:a5d:60c5:: with SMTP id x5mr5494877wrt.67.1593852757099;
        Sat, 04 Jul 2020 01:52:37 -0700 (PDT)
Received: from localhost.localdomain (88-144-169-139.host.pobb.as13285.net. [88.144.169.139])
        by smtp.gmail.com with ESMTPSA id a22sm15195915wmb.4.2020.07.04.01.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 01:52:36 -0700 (PDT)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        brendanhiggins@google.com, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Ignat Korchagin <ignat@cloudflare.com>, kernel-team@cloudflare.com
Subject: [PATCH v2 3/3] um: allow static linking for non-glibc implementations
Date:   Sat,  4 Jul 2020 09:52:13 +0100
Message-Id: <20200704085213.444645-4-ignat@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200704085213.444645-1-ignat@cloudflare.com>
References: <20200704085213.444645-1-ignat@cloudflare.com>
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
---
 arch/um/Kconfig         | 2 +-
 arch/um/drivers/Kconfig | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 9318dc6d1a0c..af7ed63f9c74 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -67,7 +67,7 @@ config FORBID_STATIC_LINK
 
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

