Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2526C35240
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 23:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E74206D3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 23:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X9ZZUmQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbgAWX7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 18:59:20 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:56743 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbgAWX7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 18:59:20 -0500
Received: by mail-pf1-f201.google.com with SMTP id h16so196329pfn.23
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 15:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=taYXiMSvG/uOaWszHXNY3LIQcqdsQdZuQaVnEsyfgN4=;
        b=X9ZZUmQCdFs3o0xNe3+a2C4Q/lpN3y90i7OPOgw8+bGTRkrAQwpN6gGiTFeZ2JR44C
         vMbVwSw1/C/YVthi+ePmCJjl+nqJFlPnMna01e7d3lSWe/GrOkQX8NFNZZpOPkni8UqW
         aiffVoXahEftvoB+wQpe9YS+2/B+YKdPeHB+ZlSuWMIgmbbDKa100IIaISWeB0OquqJL
         fo0IzJpTh5hSuYaQH9eIAEDn4vOdGkCiM3zASdah+l1bHwAAEyNz6ROyEIiN2FFA05LU
         P4+XGcpqX1Sw0l/BbUCUBZ22LzzckjxeoujgJk6s4Zn1G3ps6YVr/hPcD0dH/0xYIheO
         hnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=taYXiMSvG/uOaWszHXNY3LIQcqdsQdZuQaVnEsyfgN4=;
        b=Kgm7oFeAj4bSfnbs1A73XjRjIwjrhBHWD+ty8gYfV7Uh0NqMdUSeJwe02jINNY+EOv
         h1rpkn4KZSMTs1y4bUJY0BPzBZbjSS6eiuQrn3DVudgvUWUQ2D2G16LrndPwXUef6cUk
         9QsnnJnoYZj5V7gAaLwwoxcv51xwlMwjv6YNoEia/FyFd0/vs4Ykm+XWabSJ613Ed53Y
         sJ5YOVggA9UYqzcoKocXE0q1jM5pGxxRrSBM0kS7pkcjKoCY+dHYJ6KCqS2FOSKVgm5T
         r2+8DGTpvFBtZp3PwKKlH4gBe2TOrwvERLgpEtqxZtykQLhZeSItT8/4zOU02hrEFWcP
         cxvA==
X-Gm-Message-State: APjAAAUgU1xLMyhcWMOu2G52Of4S42YJpoUhIh7GvJuMRTZsLNlaJahh
        6L+55lr1kHqrq4tK8vS3Xt3BAeHX+AbXbot81Kn73Q==
X-Google-Smtp-Source: APXvYqyDIp+eGmrYp3/rfPhDduqurXLOKZW+c8hSrVPuXFgIDBtOVRKHnifIEoajdXNfOrzKOOaJj0Mi9uj6fqXTRVQmeg==
X-Received: by 2002:a63:744f:: with SMTP id e15mr1054047pgn.344.1579823959193;
 Thu, 23 Jan 2020 15:59:19 -0800 (PST)
Date:   Thu, 23 Jan 2020 15:59:14 -0800
Message-Id: <20200123235914.223178-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v2] uml: make CONFIG_STATIC_LINK actually static
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
Changes since last revision:

Incorporated Geert Uytterhoeven's suggestion of using a separate
FORBID_STATIC_LINK config option that each driver incompatible with
static linking selects.
---
 arch/um/Kconfig         | 7 +++++++
 arch/um/drivers/Kconfig | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 0917f8443c285..27a51e7dd59c6 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -62,8 +62,12 @@ config NR_CPUS
 
 source "arch/$(HEADER_ARCH)/um/Kconfig"
 
+config FORBID_STATIC_LINK
+	def_bool n
+
 config STATIC_LINK
 	bool "Force a static link"
+	depends on !FORBID_STATIC_LINK
 	default n
 	help
 	  This option gives you the ability to force a static link of UML.
@@ -73,6 +77,9 @@ config STATIC_LINK
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

