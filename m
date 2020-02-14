Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D39BC3B1B9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64372168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581704599;
	bh=riP2gCnJQ9qVck/TvSGiTv6mMO+xMxqF/8NwkLVdcj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W4Bl0sMuuyJotH0zWsyyVlmQ6w05DOElKf0QsRN8rWC12Bx4s/oKMzWDNvGo4AzuA
	 IloLsV5HJLsZj6HO6QCvLOruHRq7QgWY0fh8B0FXMSstaldLgBbAp4HZuo1fkUgVov
	 3TcmHJuHA//sj5fMyv1uCuaNEg9tFmTPbtSD2TkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390423AbgBNSXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:23:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:52330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729557AbgBNPtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:49:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21FD12467C;
        Fri, 14 Feb 2020 15:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695364;
        bh=riP2gCnJQ9qVck/TvSGiTv6mMO+xMxqF/8NwkLVdcj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EugivuBG698vSvQkbsKbqzKI3WdzpLx8KKsWxXibXF4O9Ek1f2nQPs08V6al2R425
         0l00wHYsKM7QK2PZtg4tXD8I0ietY+jg68gor8OEW39p3JeDyHKHiMTocq3I8rVKGX
         T+sZnQPcsgJswecAx5mTpBQlDXr1uFPCIjZFwa78=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhengyuan Liu <liuzhengyuan@kylinos.cn>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org
Subject: [PATCH AUTOSEL 5.5 023/542] tools/power/acpi: fix compilation error
Date:   Fri, 14 Feb 2020 10:40:15 -0500
Message-Id: <20200214154854.6746-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengyuan Liu <liuzhengyuan@kylinos.cn>

[ Upstream commit 1985f8c7f9a42a651a9750d6fcadc74336d182df ]

If we compile tools/acpi target in the top source directory, we'd get a
compilation error showing as bellow:

	# make tools/acpi
	  DESCEND  power/acpi
	  DESCEND  tools/acpidbg
	  CC       tools/acpidbg/acpidbg.o
	Assembler messages:
	Fatal error: can't create /home/lzy/kernel-upstream/power/acpi/\
			tools/acpidbg/acpidbg.o: No such file or directory
	../../Makefile.rules:26: recipe for target '/home/lzy/kernel-upstream/\
			power/acpi/tools/acpidbg/acpidbg.o' failed
	make[3]: *** [/home/lzy/kernel-upstream//power/acpi/tools/acpidbg/\
			acpidbg.o] Error 1
	Makefile:19: recipe for target 'acpidbg' failed
	make[2]: *** [acpidbg] Error 2
	Makefile:54: recipe for target 'acpi' failed
	make[1]: *** [acpi] Error 2
	Makefile:1607: recipe for target 'tools/acpi' failed
	make: *** [tools/acpi] Error 2

Fixes: d5a4b1a540b8 ("tools/power/acpi: Remove direct kernel source include reference")
Signed-off-by: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/acpi/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/acpi/Makefile.config b/tools/power/acpi/Makefile.config
index 0111d246d1ca2..54a2857c2510a 100644
--- a/tools/power/acpi/Makefile.config
+++ b/tools/power/acpi/Makefile.config
@@ -15,7 +15,7 @@ include $(srctree)/../../scripts/Makefile.include
 
 OUTPUT=$(srctree)/
 ifeq ("$(origin O)", "command line")
-	OUTPUT := $(O)/power/acpi/
+	OUTPUT := $(O)/tools/power/acpi/
 endif
 #$(info Determined 'OUTPUT' to be $(OUTPUT))
 
-- 
2.20.1

