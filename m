Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FC5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EF0F20656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Ic7CLE8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgHUKtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 06:49:20 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38051 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbgHUKtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 06:49:17 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BXyty4jRtz9sTF; Fri, 21 Aug 2020 20:49:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1598006954;
        bh=JjpyRpHNHrdiIzB9HKYK2tJlfybxA7SBXGzOln4SAMw=;
        h=From:To:Cc:Subject:Date:From;
        b=Ic7CLE8CPil48dGMD59EwPqX1s8aafqB7yJvTRAPHkKoPZ7HLlxoyS0nMl7zdulkj
         ExYnaonEXl3hzV0BTmnOb2Ry5nlfoPtDrmfSFE9RbKjyJBIYcVColR+aOk0UNk9sKG
         b084LseD3EL+ywDMxlZrwJagpafnb3wEguhoBrUcQO4BfdiZXlrQIXCgHlTcV/FSE7
         MjbzyYJgdHhUMwTGK0fuTIKxThwXnKxzPURLTeDp+f0Qdvb7UBF8y+Y8jzlCBc/SNP
         wm4Bsqs7ksBNF7fXmUV3a2bBq6RUUFIbB+s39oMVvjMa2Uu90436E5VCa6JNwOtecE
         BheYKTYIX0DhQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linuxppc-dev@ozlabs.org
Cc:     b.zolnierkie@samsung.com, sam@ravnborg.org, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] video: fbdev: controlfb: Fix build for COMPILE_TEST=y && PPC_PMAC=n
Date:   Fri, 21 Aug 2020 20:49:10 +1000
Message-Id: <20200821104910.3363818-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The build is currently broken, if COMPILE_TEST=y and PPC_PMAC=n:

  linux/drivers/video/fbdev/controlfb.c: In function ‘control_set_hardware’:
  linux/drivers/video/fbdev/controlfb.c:276:2: error: implicit declaration of function ‘btext_update_display’
    276 |  btext_update_display(p->frame_buffer_phys + CTRLFB_OFF,
        |  ^~~~~~~~~~~~~~~~~~~~

Fix it by including btext.h whenever CONFIG_BOOTX_TEXT is enabled.

Fixes: a07a63b0e24d ("video: fbdev: controlfb: add COMPILE_TEST support")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/video/fbdev/controlfb.c | 2 ++
 1 file changed, 2 insertions(+)

Does anyone mind if I apply this via the powerpc tree for v5.9?

It would be nice to get the build clean.

cheers

diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/controlfb.c
index 9c4f1be856ec..547abeb39f87 100644
--- a/drivers/video/fbdev/controlfb.c
+++ b/drivers/video/fbdev/controlfb.c
@@ -49,6 +49,8 @@
 #include <linux/cuda.h>
 #ifdef CONFIG_PPC_PMAC
 #include <asm/prom.h>
+#endif
+#ifdef CONFIG_BOOTX_TEXT
 #include <asm/btext.h>
 #endif
 
-- 
2.25.1

