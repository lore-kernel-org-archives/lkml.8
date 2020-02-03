Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9417CC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605B12086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580748158;
	bh=KCRqnPrC1zoA3FxXCtQkGkNTNDI8yiqkX4GiR5ndBRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HvLsFPFBAVRcMKaw3vUTGn06ZBjK6F1Cwz4j7ke2FYDT9qxUAqawt6LxYwMWgBlHj
	 cdDvjwWGt2wa73UhrALaodjDtw4ogPOZ1ZCe84wsaAs5zjX3+1CYnGSs/F+hgR74EA
	 zFlls2cKL7x1QyXn9OALAx1e+x5lk1XQZ+Ra4zSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbgBCQeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:34:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:48134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730394AbgBCQd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:33:59 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E682221744;
        Mon,  3 Feb 2020 16:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747639;
        bh=KCRqnPrC1zoA3FxXCtQkGkNTNDI8yiqkX4GiR5ndBRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YgPzNomLEL9faHqAyhPoX1llSEwIw3LBAI0ZpgGoIp51fzD7eQ4QD4igsQQWc59P1
         brRSvrHzjhGUEFINOm8SPNKeAnfphbeqFtNLTQYvL7qwiZq83D1/aamb2yO4DYwrxh
         F85JTyfas73J03BDXVGxy+S5H7EqhTG2dJoQkVJ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilie Halip <ilie.halip@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 49/70] riscv: delete temporary files
Date:   Mon,  3 Feb 2020 16:20:01 +0000
Message-Id: <20200203161919.439647477@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161912.158976871@linuxfoundation.org>
References: <20200203161912.158976871@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



