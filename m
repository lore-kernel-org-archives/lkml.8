Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9985C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 04:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77DF4208DB
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 04:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWcCGLEN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgEBEpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 00:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726435AbgEBEpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 00:45:32 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1B4C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 21:45:31 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d17so5554871pgo.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 21:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xWUbV1bTknAW0Bm6cae3+Htidg6+0EEEOJS3c1Nz340=;
        b=CWcCGLENPQImkqqGQQ1S3R76NcIM4HXNAblks/uAoiD0EsKHrTPWYcSCIAH1I5maxB
         B3Oa8XQ9oZB/dumamkUN3bEmubcAY6KNQdlCTkaqdJA40SVLP2dEGUTP3etHX2x+3fMB
         OJWaB0nPuu+7WtKcPZy8hbYfu12AZjI5mfHuAcBY5wcC9buFzOv37AF3r3ksa2zpW7Mv
         JrDxRhYwggk6BNq0CdXOcJZBraj6DUbUAi4dewt6CTc7XAckeDK4ziGimZAtFx0EEHLQ
         OtgIqxIovzWuoa+RsGEIEO9g14UjzJPlgmz5VegYRD1WtR0i88wbxRWV0hl4PSkZgxe3
         q2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xWUbV1bTknAW0Bm6cae3+Htidg6+0EEEOJS3c1Nz340=;
        b=EtitJEZSn/GHplJ8ZaNAQrzexQq43WUqDQzGa3JmeucGQQ6YT0CTgfTw4TGnpP5Prx
         tnV6a2mKjkLMFBmirrPwWQaZJsvWpX5ZY4egIPtyBgGu2aPNhevKbCKuPOuJljEgcmcg
         zx5KbhdTRm3P1l4UpDMHy0RzCXuCtB6PmARu4a4Ao7KUhL+KlAHcb6nXYij9CHC1Gqy/
         i++mjvhCRpFxGHIyWbTfQvLloVlqdk6wZGiTm6A9VEZV8qSNXONlV4aVVZgWBzRJb1TQ
         FLZhDKTg4HxWbW+99bDa/qtTC5a6qIB/Y2P9SYHoy3AFHtEccIffJY2dVX7zL7V+ID/J
         AFdw==
X-Gm-Message-State: AGi0PuYqlQ7zs4fFdhyDTFzT8fz0IH8MKZqEzFABLQHmkQYr68+mgnG5
        Urtbn5UshycCezVppPNzs2A=
X-Google-Smtp-Source: APiQypItOayLSQuLFl90m701CNyQEVV584jm0Or9VVtbPtHhNAOkNrr6bvIQ/BKwQeOZGFwlS1UbJQ==
X-Received: by 2002:a63:1e22:: with SMTP id e34mr7546320pge.427.1588394731375;
        Fri, 01 May 2020 21:45:31 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com. [147.11.224.80])
        by smtp.gmail.com with ESMTPSA id z28sm3597373pfr.3.2020.05.01.21.45.30
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 01 May 2020 21:45:30 -0700 (PDT)
From:   Bin Meng <bmeng.cn@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Bin Meng <bin.meng@windriver.com>
Subject: [PATCH v2] powerpc: Drop CONFIG_MTD_M25P80 in 85xx-hw.config
Date:   Fri,  1 May 2020 21:44:54 -0700
Message-Id: <1588394694-517-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bin Meng <bin.meng@windriver.com>

Drop CONFIG_MTD_M25P80 that was removed in
commit b35b9a10362d ("mtd: spi-nor: Move m25p80 code in spi-nor.c")

Signed-off-by: Bin Meng <bin.meng@windriver.com>

---

Changes in v2:
- correct the typo (5xx => 85xx) in the commit title

 arch/powerpc/configs/85xx-hw.config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/configs/85xx-hw.config b/arch/powerpc/configs/85xx-hw.config
index b507df6..524db76 100644
--- a/arch/powerpc/configs/85xx-hw.config
+++ b/arch/powerpc/configs/85xx-hw.config
@@ -67,7 +67,6 @@ CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_M25P80=y
 CONFIG_MTD_NAND_FSL_ELBC=y
 CONFIG_MTD_NAND_FSL_IFC=y
 CONFIG_MTD_RAW_NAND=y
-- 
2.7.4

