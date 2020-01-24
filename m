Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C6FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3704C20718
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859683;
	bh=mTKVBEIHi6cF1lzOJRCj3dTPD4jl2lFvF1kikQa7370=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DMmC3goS4CAQwnybgjSwkBMAhGYB3gM7/jJ4UAUn9ZohL5DQwXv0Zype/nBD9RYp4
	 T3D0sXB4VJ9n014oBb4BCv70exNRiP4z90hNO88GGhfgPCjRmxYZxMtSFeIDig3n1Z
	 k0PUX7kjvLRbVOwxVd2o0OWMX52LWVWvgPtFGmow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388469AbgAXJym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:54:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:57778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388408AbgAXJyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:54:40 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4175E20709;
        Fri, 24 Jan 2020 09:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859680;
        bh=mTKVBEIHi6cF1lzOJRCj3dTPD4jl2lFvF1kikQa7370=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ExNobaxuxd+WHVo0474ggJJKxDjCiVXdWUid74qHulcaJ07NBa/1aGuj6otJsz/hE
         nOGQhPQhEM/ftBpmOmZ4KGPiaYEL1EH+vmnVp81bR47jGIj81CD1jOa1p0zGWZ/zTr
         fkQJ0xHmIZUxsoswqsp0HUMobOWOb+17u+TSZR04=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 172/343] powerpc: vdso: Make vdso32 installation conditional in vdso_install
Date:   Fri, 24 Jan 2020 10:29:50 +0100
Message-Id: <20200124092942.633812456@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 0f04c878113ef..9c78ef2982572 100644
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



