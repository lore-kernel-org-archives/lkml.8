Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE32C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC1F206CC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581699510;
	bh=61KVnLfdNCBRTqllf7fHtuq32lvkJ3ubBKpfsel+Xms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TpUREBt0N0JRN9kNr/ljDJzyIPMceMVEAyXQqQ/vrOV90tekYRkLGju/C9BY/wnI/
	 NmaE3loucxhaANizP4ixabTppoas46JWtb2kymPvetBjxj9UtwBBjfFKpdY3Mfk/Hh
	 5RV0K/Y0a8iMV60+71dCQHGwOwhiwbWJ4LRw0Xyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404425AbgBNQRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:17:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:47134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392571AbgBNQQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:16:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 431BE24682;
        Fri, 14 Feb 2020 16:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696982;
        bh=61KVnLfdNCBRTqllf7fHtuq32lvkJ3ubBKpfsel+Xms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kHsMdSLpzgkkMrK0l1p4nvuD9JVEctE9vbWhmTGdFdr76bVSICClQ+RJiVw7lB28Q
         bpczFl6N2M6yhA4kikTChXMXQrp4HhqMtmR33OgfarxHS0oKACVNtfA04XEV4l15Uy
         BtOq4xNJOK9VjTV+828ODIU3ED5lc0tOKugdNRWs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 218/252] ARM: 8951/1: Fix Kexec compilation issue.
Date:   Fri, 14 Feb 2020 11:11:13 -0500
Message-Id: <20200214161147.15842-218-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
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
index 9f03befdfbf06..e2f7c50dbace5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2008,7 +2008,7 @@ config XIP_DEFLATED_DATA
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

