Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4566CC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1166A2468D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579195596;
	bh=IQeDTDep0s6HDwdvNtRn12GS86m6ofyc5QpeLNQV6Vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nya7eS4dtoWobLJYNQIep4yJSqNDUaaF+YfdfhTiaKyatlcKcGs/Fr14pkkNpi+8h
	 5i+7JeeC//QjUUzMqUU2pYFBpwu/TM6iIM9aXAHk11qSbSxrGMdpPEOMUZjLUOIFaK
	 +stblIzenb7zzBJE5WixfoHiGG67zWNUTdG5bbe0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403982AbgAPR0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:26:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:35202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403954AbgAPR00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:26:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 703B0246CA;
        Thu, 16 Jan 2020 17:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195586;
        bh=IQeDTDep0s6HDwdvNtRn12GS86m6ofyc5QpeLNQV6Vc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PUmcfrWVOqWPZ6zCJ71z4bF5hYsjtKZGXWPbBoLOpkvpfa5ys+qvjz70F8+2IUqnX
         XYVyFYV6yI6ErhP2ivHvKM5/2efmDVL56tuKueazdnWlpSMiOVzTmPhCEUFf/XUaNs
         jiGJUZcZG+blZhAF4AJE+sjaNlzQImuMDkfpYYVo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.14 166/371] powerpc: vdso: Make vdso32 installation conditional in vdso_install
Date:   Thu, 16 Jan 2020 12:20:38 -0500
Message-Id: <20200116172403.18149-109-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Hutchings <ben@decadent.org.uk>

[ Upstream commit ff6d27823f619892ab96f7461764840e0d786b15 ]

The 32-bit vDSO is not needed and not normally built for 64-bit
little-endian configurations.  However, the vdso_install target still
builds and installs it.  Add the same config condition as is normally
used for the build.

Fixes: e0d005916994 ("powerpc/vdso: Disable building the 32-bit VDSO ...")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 0f04c878113e..9c78ef298257 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -385,7 +385,9 @@ vdso_install:
 ifeq ($(CONFIG_PPC64),y)
 	$(Q)$(MAKE) $(build)=arch/$(ARCH)/kernel/vdso64 $@
 endif
+ifdef CONFIG_VDSO32
 	$(Q)$(MAKE) $(build)=arch/$(ARCH)/kernel/vdso32 $@
+endif
 
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
-- 
2.20.1

