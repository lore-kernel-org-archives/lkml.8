Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DADDC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 219C921582
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193991;
	bh=hZZmyq3Wa/MfViE7LfEFeQVmtZnWTDwEPeNqkljtXQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ufkULIvU4VL9SpJ+ccNIUxagAwh7gVWSUUwAPXfv0Gi/dZjx4KFWKORgilWee7/Sn
	 t8MZmFNVoy6AVdbTJX/Tum9z4ktAn6GxKibX0rDOs5jC1qm8NFiPOHqVhsPz7niUPi
	 xjz9RtHbx1FlOGbjsoA2QurYrNK8xalgwfSx2FiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387590AbgAPQ7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:59:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:48880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387562AbgAPQ7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:59:48 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6B7E2192A;
        Thu, 16 Jan 2020 16:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193987;
        bh=hZZmyq3Wa/MfViE7LfEFeQVmtZnWTDwEPeNqkljtXQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DmIjlCF7t6OE/pPzXKUdUfObyaXsql3nWRyzrz2RX8RbfNmW/6KlybltswWZfGkbn
         DJUvCJewE5j/L3Ea3o83PIx2mbSCecvEkIoDtlSPWBfsAVsjVbZtA+kXrNnTMeHHiB
         ZuMQMSs+ubKs4QWgFayG4C1lt5W/2v4zQye/rcAE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Samuel Holland <samuel@sholland.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 119/671] kbuild: mark prepare0 as PHONY to fix external module build
Date:   Thu, 16 Jan 2020 11:50:28 -0500
Message-Id: <20200116165940.10720-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165940.10720-1-sashal@kernel.org>
References: <20200116165940.10720-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit e00d8880481497474792d28c14479a9fb6752046 ]

Commit c3ff2a5193fa ("powerpc/32: add stack protector support")
caused kernel panic on PowerPC when an external module is used with
CONFIG_STACKPROTECTOR because the 'prepare' target was not executed
for the external module build.

Commit e07db28eea38 ("kbuild: fix single target build for external
module") turned it into a build error because the 'prepare' target is
now executed but the 'prepare0' target is missing for the external
module build.

External module on arm/arm64 with CONFIG_STACKPROTECTOR_PER_TASK is
also broken in the same way.

Move 'PHONY += prepare0' to the common place. GNU Make is fine with
missing rule for phony targets. I also removed the comment which is
wrong irrespective of this commit.

I minimize the change so it can be easily backported to 4.20.x

To fix v4.20, please backport e07db28eea38 ("kbuild: fix single target
build for external module"), and then this commit.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=201891
Fixes: e07db28eea38 ("kbuild: fix single target build for external module")
Fixes: c3ff2a5193fa ("powerpc/32: add stack protector support")
Fixes: 189af4657186 ("ARM: smp: add support for per-task stack canaries")
Fixes: 0a1213fa7432 ("arm64: enable per-task stack canaries")
Cc: linux-stable <stable@vger.kernel.org> # v4.20
Reported-by: Samuel Holland <samuel@sholland.org>
Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 3b836cc8b22d..bf77bc0b92d9 100644
--- a/Makefile
+++ b/Makefile
@@ -964,6 +964,7 @@ ifdef CONFIG_STACK_VALIDATION
   endif
 endif
 
+PHONY += prepare0
 
 ifeq ($(KBUILD_EXTMOD),)
 core-y		+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
@@ -1072,8 +1073,7 @@ scripts: scripts_basic asm-generic gcc-plugins $(autoksyms_h)
 # archprepare is used in arch Makefiles and when processed asm symlink,
 # version.h and scripts_basic is processed / created.
 
-# Listed in dependency order
-PHONY += prepare archprepare prepare0 prepare1 prepare2 prepare3
+PHONY += prepare archprepare prepare1 prepare2 prepare3
 
 # prepare3 is used to check if we are building in a separate output directory,
 # and if so do:
-- 
2.20.1

