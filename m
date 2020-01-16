Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EE1C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2672072B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217607;
	bh=IeJ6EBQprC0bGfzJZS49TcDe89b6mYMbG0kfwUyY/q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WsStp/FsOjczjoIdpOnDtWSefG1XzFI+dQsjdVKqFKpF4VbQwXsnnxtIAvvqk2GLR
	 5GYi3ZZAMS6QFitpMNF79EAuZZ1MAw3q3O4UPxwojiAtnx8l71dVrnlQML7nMv9BcS
	 GPmwjbjj9StRnYwK5X97gwDGw5VWOZRP1b483qkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404348AbgAPXd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:33:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:43684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404336AbgAPXdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:33:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B4712072E;
        Thu, 16 Jan 2020 23:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217603;
        bh=IeJ6EBQprC0bGfzJZS49TcDe89b6mYMbG0kfwUyY/q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dooK7kpQka9QqUOAJk7XGZhfIGDvjU6f6GqTfohJyYR77MLkswCOkJSYEs826UW4o
         ef6/cVyTahhfgtHCbwGEJ91txe9jKGeaLijJqxSf1d1GV6MRHG+KH+jPCJJF4tRXuE
         TouR3ranM3fDz9FW+zPKI4wQNSKvw55FvroFSaKM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jouni Hogander <jouni.hogander@unikie.com>,
        Paul Burton <paulburton@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-mips@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 66/71] MIPS: Prevent link failure with kcov instrumentation
Date:   Fri, 17 Jan 2020 00:19:04 +0100
Message-Id: <20200116231718.535344089@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231709.377772748@linuxfoundation.org>
References: <20200116231709.377772748@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jouni Hogander <jouni.hogander@unikie.com>

[ Upstream commit a4a3893114a41e365274d5fab5d9ff5acc235ff0 ]

__sanitizer_cov_trace_pc() is not linked in and causing link
failure if KCOV_INSTRUMENT is enabled. Fix this by disabling
instrumentation for compressed image.

Signed-off-by: Jouni Hogander <jouni.hogander@unikie.com>
Signed-off-by: Paul Burton <paulburton@kernel.org>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-mips@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/boot/compressed/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 331b9e0a8072..baa34e4deb78 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -29,6 +29,9 @@ KBUILD_AFLAGS := $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
 	-DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) \
 	-DKERNEL_ENTRY=$(VMLINUX_ENTRY_ADDRESS)
 
+# Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
+KCOV_INSTRUMENT		:= n
+
 # decompressor objects (linked with vmlinuz)
 vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/string.o
 
-- 
2.20.1



