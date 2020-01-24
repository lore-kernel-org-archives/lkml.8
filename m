Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225D9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0377218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579875686;
	bh=KCRqnPrC1zoA3FxXCtQkGkNTNDI8yiqkX4GiR5ndBRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rKuYAaGSBgwo3Vxz+qzMAwb+Ew7t6TB9XUAB+Pl71ygQL6z0CUxxGu4RicYJ5hABl
	 9lh6c+JUJ3ljgi9OZWeW5wqMWgViqLX+ri/hAu9yTDB33a1L2sbxl9BIF59kPMFucM
	 BKTnKPizcENkyGwKkRQKlyoLGLg+0YxN0NKm+M6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392196AbgAXOVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:21:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:42932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405270AbgAXOVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:21:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EB1F2077C;
        Fri, 24 Jan 2020 14:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579875677;
        bh=KCRqnPrC1zoA3FxXCtQkGkNTNDI8yiqkX4GiR5ndBRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lc1QAqh6C8QomWQdq62u6UcKpVE+M9+WEMhJ55vfvx1lZAmRonGY3ADuBTQi9gORb
         8GJJuaHUIXws2p0E51zm3g58HNttI23mqS5HXz1MXSWj3uFvMRCLp2D/YUkwpYS9Mg
         2CilCDsaqUkgIwg6J5TTzvJNzaJi+gVsXrJuz9Q8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ilie Halip <ilie.halip@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 56/56] riscv: delete temporary files
Date:   Fri, 24 Jan 2020 09:20:12 -0500
Message-Id: <20200124142012.29752-56-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124142012.29752-1-sashal@kernel.org>
References: <20200124142012.29752-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilie Halip <ilie.halip@gmail.com>

[ Upstream commit 95f4d9cced96afa9c69b3da8e79e96102c84fc60 ]

Temporary files used in the VDSO build process linger on even after make
mrproper: vdso-dummy.o.tmp, vdso.so.dbg.tmp.

Delete them once they're no longer needed.

Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/vdso/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index eed1c137f6183..87f71a6cd3ef8 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -55,7 +55,8 @@ quiet_cmd_vdsold = VDSOLD  $@
       cmd_vdsold = $(CC) $(KBUILD_CFLAGS) $(call cc-option, -no-pie) -nostdlib -nostartfiles $(SYSCFLAGS_$(@F)) \
                            -Wl,-T,$(filter-out FORCE,$^) -o $@.tmp && \
                    $(CROSS_COMPILE)objcopy \
-                           $(patsubst %, -G __vdso_%, $(vdso-syms)) $@.tmp $@
+                           $(patsubst %, -G __vdso_%, $(vdso-syms)) $@.tmp $@ && \
+                   rm $@.tmp
 
 # install commands for the unstripped file
 quiet_cmd_vdso_install = INSTALL $@
-- 
2.20.1

