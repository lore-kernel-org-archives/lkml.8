Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4FBC3F35C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875EB2469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811349;
	bh=gH2BIg6EpDo663xGfq3hBDFg5Bu3WvFw9PnUKPXMqgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WuQG3BF00NPGD+2FqpfVUGC0e6BjKoQomtQFA60t3xpfsdNhCZPiBqRsQrRmTqyiN
	 Eo6EVKbaomeChG9OvGKOi6B2BU5o711Z37EVn31nd8xK0Px5NVcvmJwHvhUtFjX7dG
	 6WjOr0WfXwiVEH9NRNX9J7SzRU8ZkpvJgucLqvmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbgB0NtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:49:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:46214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730518AbgB0NtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:49:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD923246B4;
        Thu, 27 Feb 2020 13:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811344;
        bh=gH2BIg6EpDo663xGfq3hBDFg5Bu3WvFw9PnUKPXMqgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lKz79luQd0aACfzUDdFqn+4UwFj2WkJ1azCnX6VxB79UKeWjA4qCQJXEa/tFx+NjV
         R4zJj61Qltud5JDUw8SI6zn71PPF5nX6VcSAGZfFCaoH4sqmgmvSOLh0oGbIPKMFPf
         E0DddcKjSDA9judWBuoOJsaHbdJxQcED40ZU9TRY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 097/165] ARM: 8951/1: Fix Kexec compilation issue.
Date:   Thu, 27 Feb 2020 14:36:11 +0100
Message-Id: <20200227132245.426272030@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132230.840899170@linuxfoundation.org>
References: <20200227132230.840899170@linuxfoundation.org>
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
index 74a70f91b01a4..56bd9beb6a35c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2020,7 +2020,7 @@ config XIP_PHYS_ADDR
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



