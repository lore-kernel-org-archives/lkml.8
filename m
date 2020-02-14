Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B1AC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06611206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581702787;
	bh=RPAB72Coo722ZwprKZsAXV2OiHXky2bshLNuUdhPIE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ASxeaRwpYDZGtkpOpewEuCpNqcGPDRbVHQTrCMZQ14dSHOFDs/T2iWvwXioA63RwA
	 Wg6BhgjF4P3vZ1lTeXKDWT6knPcwCEiDNynzmYwOCk7Ttj2L7kB80rX2+yXmcJ9vxH
	 lhJHBTlPduabCIhRZkJeI+2LMhx12hxXFXXLDqhA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388246AbgBNRxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:53:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:42212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388573AbgBNP6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:58:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A91F324689;
        Fri, 14 Feb 2020 15:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695903;
        bh=RPAB72Coo722ZwprKZsAXV2OiHXky2bshLNuUdhPIE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vL0Fo+cUP8bAj2h6qKRDLW3vhoYGcQkgT+MAZ3HjTgVP7hLi1ZdGLHksSX/SEfMdk
         UMvQYVb7C5Esza1OuKVrzAu+WiB3mekXvF2/nhMGge7HkExxl6ux080vBMjSBp8rbd
         WzJQW8HHetrUOCyrmG5nlqBi44WcIECr6JTVr578=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.5 444/542] powerpc/ptdump: Fix W+X verification call in mark_rodata_ro()
Date:   Fri, 14 Feb 2020 10:47:16 -0500
Message-Id: <20200214154854.6746-444-sashal@kernel.org>
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

From: Christophe Leroy <christophe.leroy@c-s.fr>

[ Upstream commit e26ad936dd89d79f66c2b567f700e0c2a7103070 ]

ptdump_check_wx() also have to be called when pages are mapped
by blocks.

Fixes: 453d87f6a8ae ("powerpc/mm: Warn if W+X pages found on boot")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/37517da8310f4457f28921a4edb88fb21d27b62a.1578989531.git.christophe.leroy@c-s.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/pgtable_32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 73b84166d06a6..5fb90edd865e6 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -218,6 +218,7 @@ void mark_rodata_ro(void)
 
 	if (v_block_mapped((unsigned long)_sinittext)) {
 		mmu_mark_rodata_ro();
+		ptdump_check_wx();
 		return;
 	}
 
-- 
2.20.1

