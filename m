Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B0BC35642
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12E42467B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272949;
	bh=wCma4w9oD9qUbgcIbmPKaHeJ+eYPd/7Xhrqw7fD7N8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2NirbqN29p4KXYyLvwVjIUud8yT5OA28wGDr9+scaqS6ycp1Cnrf3RXTcR0dM8Coz
	 zdHPbK338c8qdNOSWP7z7nlX5Ir7AH14zH9n02sF3JBFQjsIm61vH0nGH5nWJDRMLt
	 byf7mhUKYDX0BEP8xjYGJjNdH3Go4IYyhrvJA6Q8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387431AbgBUIPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:15:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:52604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733089AbgBUIPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:15:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C12D24686;
        Fri, 21 Feb 2020 08:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272943;
        bh=wCma4w9oD9qUbgcIbmPKaHeJ+eYPd/7Xhrqw7fD7N8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=smiqcPyFscuHcAoxQggoxDi3py/pC9jYH48YnQtzOUJhmFWurprvp+LAEgkqzukEb
         ieIxCwmWUagfij8MJoXPJ5aZSwVbr6eVDWsFA/nZw9pzcaRw4oe7wnqx0bY2ccoDWP
         ncJ3sVph6vKuMw+yLG+BLc5k8a1iTUFGEEMylxnM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 297/344] ARM: 8951/1: Fix Kexec compilation issue.
Date:   Fri, 21 Feb 2020 08:41:36 +0100
Message-Id: <20200221072416.870369113@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

[ Upstream commit 76950f7162cad51d2200ebd22c620c14af38f718 ]

To perform the reserve_crashkernel() operation kexec uses SECTION_SIZE to
find a memblock in a range.
SECTION_SIZE is not defined for nommu systems. Trying to compile kexec in
these conditions results in a build error:

  linux/arch/arm/kernel/setup.c: In function ‘reserve_crashkernel’:
  linux/arch/arm/kernel/setup.c:1016:25: error: ‘SECTION_SIZE’ undeclared
     (first use in this function); did you mean ‘SECTIONS_WIDTH’?
             crash_size, SECTION_SIZE);
                         ^~~~~~~~~~~~
                         SECTIONS_WIDTH
  linux/arch/arm/kernel/setup.c:1016:25: note: each undeclared identifier
     is reported only once for each function it appears in
  linux/scripts/Makefile.build:265: recipe for target 'arch/arm/kernel/setup.o'
     failed

Make KEXEC depend on MMU to fix the compilation issue.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9fadf322a2b76..05c9bbfe444df 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1907,7 +1907,7 @@ config XIP_DEFLATED_DATA
 config KEXEC
 	bool "Kexec system call (EXPERIMENTAL)"
 	depends on (!SMP || PM_SLEEP_SMP)
-	depends on !CPU_V7M
+	depends on MMU
 	select KEXEC_CORE
 	help
 	  kexec is a system call that implements the ability to shutdown your
-- 
2.20.1



