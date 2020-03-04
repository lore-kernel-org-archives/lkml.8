Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B91EC3F2DA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E3620838
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4bWqPW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbgCDOlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 09:41:14 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33255 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388023AbgCDOlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 09:41:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id x7so2727484wrr.0;
        Wed, 04 Mar 2020 06:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tCtKJyb0/NtRc1ah/YeyZWRmrmSc960u9t/iq++pctQ=;
        b=R4bWqPW02fm4nkxV0Ak9O8GdBoEajmQ37qYu+0EweklUM9nyjVIUHvh8+6oCSiZqni
         /UI75iYEW/gPNcnB403xDMsMsPyQ0Z0XUbtWyAIuxxEF8Xl4LPj47io6o9wQbCAgtNo6
         3e/5spSmMM50Tam8A794PbBptTnR9RaDVS5b0f56GKR9mJTV3LCr1BoSgYt9X8d0L4Gl
         x8VZqquFLgKio7ch59MeSiqjH2tfw86Q+QCnaos0CxQaRwV+HhGkKYENhyOZEEF3hiLO
         LQUetKEibArZLltveclWLmI2vcYFuWZNUEREFkJRnpz7XAjGeC4nU2HoAaDfY9BuCNuc
         Xj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tCtKJyb0/NtRc1ah/YeyZWRmrmSc960u9t/iq++pctQ=;
        b=UTqEm47uNhSYNhXLKW2QNpSThNbfNciqyVSqns78RtEn+5J3wi1njOOEw+eLfCRLaE
         2S4UacYuzsSkccQ/tk5IIapgprdbqJFsosjyREoACFEsyK+bc65d0rbw+z8SopzeD8Jj
         Mae3gGBd768JOT/6LYRHK78rAHroEFHMMQrXNO0loMipZcN/Zp0vYkFbKXnolfKXNBcN
         E3BxjpzBQx4pBFZodlAzDhMa3fIMC0Dc6IGnMwAvzDP7eHwjzDz2q0kTq661nxihwV25
         Y/8dTQEwA3v0ACJGMHgiEYfVuXiE+W9zo+kaR4Tln82i87niORW3iz3Brgk/hYksRZoO
         s3qw==
X-Gm-Message-State: ANhLgQ2qJHd+yZpYlW+pbNakjtVonULw4ZAsG0nwzW+5R0mm7pCJKdvB
        6wcRDYXyPPHic3GzPLr0Kmk=
X-Google-Smtp-Source: ADFU+vsV2rXo6R7E8LyFSyxoB2/CQNHH4LKEdBCKcqgGzs6DkRDeFKR72TjfYg/ctlXmu8Su0JfJQA==
X-Received: by 2002:adf:cd0a:: with SMTP id w10mr4331698wrm.171.1583332869611;
        Wed, 04 Mar 2020 06:41:09 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d16:4100:3093:39f0:d3ca:23c6])
        by smtp.gmail.com with ESMTPSA id u20sm4195561wmj.14.2020.03.04.06.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 06:41:08 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Christoph Hellwig <hch@lst.de>, Borislav Petkov <bp@suse.de>,
        Yash Shah <yash.shah@sifive.com>, linux-edac@vger.kernel.org,
        Sebastian Duda <sebastian.duda@fau.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: rectify EDAC-SIFIVE entry
Date:   Wed,  4 Mar 2020 15:40:45 +0100
Message-Id: <20200304144045.15060-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9209fb51896f ("riscv: move sifive_l2_cache.c to drivers/soc") moved
arch/riscv/mm/sifive_l2_cache.c to drivers/soc/sifive/sifive_l2_cache.c
and adjusted the MAINTAINERS EDAC-SIFIVE entry but slipped in a mistake.

Since then, ./scripts/get_maintainer.pl --self-test complains:

  warning: no file matches F: drivers/soc/sifive_l2_cache.c

Rectify the EDAC-SIFIVE entry in MAINTAINERS now.

Co-developed-by: Sebastian Duda <sebastian.duda@fau.de>
Signed-off-by: Sebastian Duda <sebastian.duda@fau.de>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Paul, please pick this patch.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6158a143a13e..5c755e03ddee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6110,7 +6110,7 @@ M:	Yash Shah <yash.shah@sifive.com>
 L:	linux-edac@vger.kernel.org
 S:	Supported
 F:	drivers/edac/sifive_edac.c
-F:	drivers/soc/sifive_l2_cache.c
+F:	drivers/soc/sifive/sifive_l2_cache.c
 
 EDAC-SKYLAKE
 M:	Tony Luck <tony.luck@intel.com>
-- 
2.17.1

