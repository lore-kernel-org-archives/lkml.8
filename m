Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E51C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CA220637
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581700982;
	bh=ELlkIfK1/ej71TQAufGUncCZGSmrKBDD0FiRlst3Jtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wSD8zzKbVd8LRO6fUOdvvnGYKlVLUyMHATHtYD25dwV+Dkrv0hBPCrOSzuV2xqBqX
	 X42xv9rp3mMuM8zS/zhGD58OO8vMYAVT831If26rSlek6Hd87lRBbuKcRxZlvOyqOC
	 8oXLgtOLschXRYqOs9QeBwVZJJAjzPXU3PG0dpe8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393131AbgBNRXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:23:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:34570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391340AbgBNQJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:09:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 634B42468A;
        Fri, 14 Feb 2020 16:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696584;
        bh=ELlkIfK1/ej71TQAufGUncCZGSmrKBDD0FiRlst3Jtk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YvOiW7OH21gtfGypri/q33jZDJbH8eQBwW/B2fDF6WmlbEvox5N3dW9T+aQGk8S9J
         2S0IXXIv0TD8RMLlBQ/OTqzda4prArvrC8d+T6IwKFECeOhAMIwQ5UT1WqzE8xSLGI
         qkd97fj7mZGufW68RBfQzqNQLg5JS0v7+JW+WGQE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 5.4 372/459] s390: adjust -mpacked-stack support check for clang 10
Date:   Fri, 14 Feb 2020 11:00:22 -0500
Message-Id: <20200214160149.11681-372-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit 253b3c4b2920e07ce9e2b18800b9b65245e2fafa ]

clang 10 introduces -mpacked-stack compiler option implementation. At the
same time currently it does not support a combination of -mpacked-stack
and -mbackchain. This leads to the following build error:

clang: error: unsupported option '-mpacked-stack with -mbackchain' for
target 's390x-ibm-linux'

If/when clang adds support for a combination of -mpacked-stack and
-mbackchain it would also require -msoft-float (like gcc does). According
to Ulrich Weigand "stack slot assigned to the kernel backchain overlaps
the stack slot assigned to the FPR varargs (both are required to be
placed immediately after the saved r15 slot if present)."

Extend -mpacked-stack compiler option support check to include all 3
options -mpacked-stack -mbackchain -msoft-float which must present to
support -mpacked-stack with -mbackchain.

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 478b645b20ddb..9ce1baeac2b25 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -69,7 +69,7 @@ cflags-y += -Wa,-I$(srctree)/arch/$(ARCH)/include
 #
 cflags-$(CONFIG_FRAME_POINTER) += -fno-optimize-sibling-calls
 
-ifeq ($(call cc-option-yn,-mpacked-stack),y)
+ifeq ($(call cc-option-yn,-mpacked-stack -mbackchain -msoft-float),y)
 cflags-$(CONFIG_PACK_STACK)  += -mpacked-stack -D__PACK_STACK
 aflags-$(CONFIG_PACK_STACK)  += -D__PACK_STACK
 endif
-- 
2.20.1

