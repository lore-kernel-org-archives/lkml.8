Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8ACC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8086B24695
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581696626;
	bh=ZNUKpT2QmFCsGmu27p7x5piDzLV1yR86miM35jdeFyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UorsjcY764OK49LU7/BsuNX2lf3F23NQVy9cIdqwlUc+yycQcadZggiRdzt7h0OWM
	 E/919mjvlI+OltV7bsd/+Xbtvhe6rQmTTw7QxNMVojz/qXTlqDZKpmNH5cf2yqPP2M
	 K8kFWPKSEOcTI5dxn/hWjXwy8KNE9aKEAjo8yv74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391477AbgBNQKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:10:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388872AbgBNQJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:09:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C64A2468D;
        Fri, 14 Feb 2020 16:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696595;
        bh=ZNUKpT2QmFCsGmu27p7x5piDzLV1yR86miM35jdeFyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yMcpLFn808bU9pxDFrfNbsWNvCKB2lIFFmG2QASQ14T+/5PZ8pC8nU6F9XbEztzwa
         u1c1zeP05qPs2G2Dl2Xc00q9BQ1YyvBUAzg6O2wkDKmV+bkz7GuB9HauHUz6DIPYFK
         Ec31KJpx+ANkaMx2QuEayyA+tAXPjp4XCMJcUkLE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.4 381/459] powerpc/ptdump: Fix W+X verification call in mark_rodata_ro()
Date:   Fri, 14 Feb 2020 11:00:31 -0500
Message-Id: <20200214160149.11681-381-sashal@kernel.org>
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
index 8ec5dfb65b2eb..784cae9f56975 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -221,6 +221,7 @@ void mark_rodata_ro(void)
 
 	if (v_block_mapped((unsigned long)_sinittext)) {
 		mmu_mark_rodata_ro();
+		ptdump_check_wx();
 		return;
 	}
 
-- 
2.20.1

