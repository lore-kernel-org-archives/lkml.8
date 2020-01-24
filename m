Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B0BC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 22:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A69A2071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 22:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iRRfETWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgAXWOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 17:14:08 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:44958 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbgAXWOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 17:14:08 -0500
Received: by mail-pg1-f201.google.com with SMTP id o21so2184312pgm.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 14:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=geC9hix2m9kGrQA1AgAiVyPdofDuegQV+sdp/6AkzSY=;
        b=iRRfETWsjhw5goUymtnni7SUDlPk6D3OkS7laA0F9rkl54bMDWiXkDJ7ERP1BIuaBB
         k6kbMx7VK4npLy4YL/S/gNA+fOiStTiTERkqqGsT1tGRgOEiIiILDVwFv/yZLXnlkfkl
         5Y2MURsG+KtkoyhNxpcyV+CfIdagtezZOcSbUhuWpkiowJkTJgG0upIx34t57wnvQZtU
         eiKc9urpSafdnhhHqAumxMZR/YOZdeYnDvCGv9zjIFeu5jP4K5+jeb3M3zrcdTfNHjdo
         QrF0K6Bnh2WwqYbuHZ2OOe9xZzFknDtYnVZZqhaaHdJkC9fFLb7OZw6/cKVFQjd9/8Tt
         42wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=geC9hix2m9kGrQA1AgAiVyPdofDuegQV+sdp/6AkzSY=;
        b=K2zdMm6Z7JHu2goGouWzi6wSdooLEKGOB5u6NbMJFlPhY9kRGW0G/iPa5l9t6EyLEX
         RbSjwdi3JlxLOdiTGIhFa/C2QaAJEaFlalsO3KRbT1PRUZMdmhgdlAvfjlTUeqxhHotd
         zduyis2lSd6raFYpkiSh6tbriXlfbmGGY+9vIYhiDtWUoUoolYF1P1wKxoCxNURIj5kO
         yduAJi7mQ0xXZ62+M624RsJG5SRFUAJYPE9YmaB6f6WWYkj7A5MKQdXlLWD9ZXVgNEnN
         95TNACApaFSkydi/Grwc1HDDmYGHtyDZ88ydaEGJMY1RZWNIdzLIhBGCLY8rcl57VTMX
         b7NQ==
X-Gm-Message-State: APjAAAVAMk5rEJ5Vq5umlzooNgze5vLeDVf4EB8JqWcTCXHNRq9M/ozI
        H2SOefTD56GZmwtp2/fV4cmGFKeYsiy2kSG7Kp+Yzw==
X-Google-Smtp-Source: APXvYqyjUL9L/ftdar4bI9P2UlBlPlPH9Vl4aalxzJKewNpcsHgpqmvaINWiaQE9S4toNIr+Sijydu+SjX69SbztXbHu2w==
X-Received: by 2002:a63:364f:: with SMTP id d76mr6652376pga.215.1579904047529;
 Fri, 24 Jan 2020 14:14:07 -0800 (PST)
Date:   Fri, 24 Jan 2020 14:14:01 -0800
Message-Id: <20200124221401.210449-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v3] uml: make CONFIG_STATIC_LINK actually static
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        geert@linux-m68k.org, james_mcmechan@hotmail.com
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        davidgow@google.com, Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, CONFIG_STATIC_LINK can be enabled with options which cannot
be statically linked, namely UML_NET_VECTOR, UML_NET_VDE, and
UML_NET_PCAP; this is because glibc tries to load NSS which does not
support being statically linked. So make CONFIG_STATIC_LINK depend on
!UML_NET_VECTOR && !UML_NET_VDE && !UML_NET_PCAP.

Link: https://lore.kernel.org/lkml/f658f317-be54-ed75-8296-c373c2dcc697@cambridgegreys.com/#t
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/um/Kconfig         | 8 +++++++-
 arch/um/drivers/Kconfig | 3 +++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 0917f8443c285..28d62151fb2ed 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -62,9 +62,12 @@ config NR_CPUS
 
 source "arch/$(HEADER_ARCH)/um/Kconfig"
 
+config FORBID_STATIC_LINK
+	bool
+
 config STATIC_LINK
 	bool "Force a static link"
-	default n
+	depends on !FORBID_STATIC_LINK
 	help
 	  This option gives you the ability to force a static link of UML.
 	  Normally, UML is linked as a shared binary.  This is inconvenient for
@@ -73,6 +76,9 @@ config STATIC_LINK
 	  Additionally, this option enables using higher memory spaces (up to
 	  2.75G) for UML.
 
+	  NOTE: This option is incompatible with some networking features which
+	  depend on features that require being dynamically loaded (like NSS).
+
 config LD_SCRIPT_STATIC
 	bool
 	default y
diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index 72d4170557820..9160ead56e33c 100644
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -234,6 +234,7 @@ config UML_NET_DAEMON
 config UML_NET_VECTOR
 	bool "Vector I/O high performance network devices"
 	depends on UML_NET
+	select FORBID_STATIC_LINK
 	help
 	This User-Mode Linux network driver uses multi-message send
 	and receive functions. The host running the UML guest must have
@@ -245,6 +246,7 @@ config UML_NET_VECTOR
 config UML_NET_VDE
 	bool "VDE transport (obsolete)"
 	depends on UML_NET
+	select FORBID_STATIC_LINK
 	help
 	This User-Mode Linux network transport allows one or more running
 	UMLs on a single host to communicate with each other and also
@@ -292,6 +294,7 @@ config UML_NET_MCAST
 config UML_NET_PCAP
 	bool "pcap transport (obsolete)"
 	depends on UML_NET
+	select FORBID_STATIC_LINK
 	help
 	The pcap transport makes a pcap packet stream on the host look
 	like an ethernet device inside UML.  This is useful for making
-- 
2.25.0.341.g760bfbb309-goog

