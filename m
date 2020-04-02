Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41E9C2D0E9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 05:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AEA72078E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 05:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YX4kK4/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgDBFga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 01:36:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36711 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgDBFg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 01:36:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id c23so1341746pgj.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 22:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qRIzo5o5vpllI++B3nY//4/moCStw1oArBNgpNNZWE0=;
        b=YX4kK4/l4v2Dc+sIlNifTF+eu7cc0Xwqmrkw6+903BF5W9hYTPcWEQ1O8+LgEOjeXJ
         QXFfirICEm2ToMk+K+f0BAw2q3aM4+7i/mtghVUotn2aFVQr/rkHHVy4LVTDEhrRC3q5
         bG9OMYPBR3q3H/nLiX2GyaPOIqz5tskvc9Oyg/MuabGNsxkYzFRjlQCzUafRlE5XYHAq
         lXfnvpaasLeK+GEb7tU+b2Xxu9ZrwbqDiVUXeweP+wX9flK1mvhJRUyrWxmL/Prxknt4
         lE9I+3V7sQZxFcL0CdBjr6rIg+ML2jv5LdLcdtU2QhmAsVwdSUHcvQAgE6VYtTngmeYK
         qj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qRIzo5o5vpllI++B3nY//4/moCStw1oArBNgpNNZWE0=;
        b=cWpD+xmwcXSKOF2DLJDFhoQtBM+ooFvqd96uyQqB7SsO3cIaqELu8w6YWzv1+cq+/R
         L3U6yzSeeHgw58omcQisZc97PU/pixVou9kRT90uMCdV6zchZHlYiEHAwkw6fJuidWMZ
         Ig0IZEOYvWTmXjVGlCklF7RPHFBxI2fDUmyoG2i1NlC4bF7gkvw/mHnA14q3NAxdeQhF
         VVsJkoRxrsBiq6xfwvvK/29KnUD+7gCKaytQeYxoBoCDlpIRyCYt7MSeSeOaNi1xRsV3
         zznSouhknqO4gQ/MnVPbzeCxsS1AZchBJ+Xnq9YnseHDjuFAO94POKUb5TTpdiP0i33s
         ZzlA==
X-Gm-Message-State: AGi0PuZ1QkxnLb7ojadwHRr+xF+8w5hbw0fuQYJKyAE3/sHuPL/+bJbc
        oQVnwQnJwysjwRHWtv32xpY=
X-Google-Smtp-Source: APiQypIAgreB/HoC94SMNNTLUG92Y3nyUkudT6yq5FXpvuXoHAEl+87D1f6IfaXfXj/J4INNUM45eg==
X-Received: by 2002:a62:7950:: with SMTP id u77mr1573409pfc.34.1585805788026;
        Wed, 01 Apr 2020 22:36:28 -0700 (PDT)
Received: from OptiPlexFedora.fios-router.home ([47.144.161.84])
        by smtp.gmail.com with ESMTPSA id y28sm2863136pfp.128.2020.04.01.22.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 22:36:27 -0700 (PDT)
From:   "John B. Wyatt IV" <jbwyatt4@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     "John B. Wyatt IV" <jbwyatt4@gmail.com>
Subject: [PATCH 2/2] staging: gasket: Fix comment 75 character limit warning
Date:   Wed,  1 Apr 2020 22:36:17 -0700
Message-Id: <20200402053617.826678-3-jbwyatt4@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200402053617.826678-1-jbwyatt4@gmail.com>
References: <20200402053617.826678-1-jbwyatt4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix 75 character limit warning in comment reported by checkpatch.

Reported by checkpatch.

Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
---
 drivers/staging/gasket/apex_driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index f48209ec7d24..5ad15f398893 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -50,8 +50,8 @@
 #define NUM_NODES 1
 
 /*
- * The total number of entries in the page table. Should match the value read
- * from the register APEX_BAR2_REG_KERNEL_HIB_PAGE_TABLE_SIZE.
+ * The total number of entries in the page table. Should match the
+ * value read from the register APEX_BAR2_REG_KERNEL_HIB_PAGE_TABLE_SIZE.
  */
 #define APEX_PAGE_TABLE_TOTAL_ENTRIES 8192
 
-- 
2.25.1

