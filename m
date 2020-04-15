Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F88BC2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 06:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1161A206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 06:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fosowwon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634800AbgDOGUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 02:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728821AbgDOGUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 02:20:35 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1ECC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 23:20:35 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t40so6255155pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 23:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ce6sr+CcTt2E/wBJEF5SOEYHtX50oqszVN9CmkzlX/E=;
        b=Fosowwonbvmo4Z2Zo2FOE3ink0asATjzUtSfb4eYAY3FFQeR3PatiHir4oZRNYuley
         X4KJcgo2CCAPUpr6gHfr8oULwt4J3SQLW5YaGv80QTJXyW/FtL6oTjFSxVAkFiY+R2Q+
         KG1IDplabKU+jTWb0dLfXXJgDWHKtoXUdAghY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ce6sr+CcTt2E/wBJEF5SOEYHtX50oqszVN9CmkzlX/E=;
        b=O705ZIXN0wXMcSKeBxgIGu+x2NJL+ZO9qcFM0GHJwFoNa1S4WyeQb4O7fGrvSwiNq0
         s53IPU8+3/vYN3n3PZqBO2ycZc69bOhXgjsLSLussBmvtgapk1dss0Zkca/+H9xiAM6m
         9Opr7qXyteY9fPE0nZgvHLhQ/MK/nglRORL49EglPLAEX46a5WM8zRDqi4Ice+MOqUEn
         8Rex0jO6LS+dStgb13hH0Ypv6epx7GeDyHxXmnw7CyQ6b6IoIS41KuyNFgPpnmGw3H68
         Oi8BmjQU2n9NU47lHcoTip6QBS2LbBDoDuKC26ifTqse4E96vPxizfgC52W98SWdH/8+
         VDZA==
X-Gm-Message-State: AGi0Pua5pktizs2OvXP3VNlx4/8FJXthIDE0LQQkgMrjiFTIwHECSyIY
        284ebVct8m7dZX3qodb/+o4DfJl55Yw=
X-Google-Smtp-Source: APiQypJJBZRWnzW0QGrGHvXq+dW5VczMHY4xKxhL/5+qEbTKsWyTkgFdUhIZzftweKSaibyeqFCFAQ==
X-Received: by 2002:a17:90a:2645:: with SMTP id l63mr4580241pje.54.1586931634566;
        Tue, 14 Apr 2020 23:20:34 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x27sm13008542pfj.74.2020.04.14.23.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 23:20:34 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] soc: qcom: cmd-db: Cast sizeof() to int to silence field width warning
Date:   Tue, 14 Apr 2020 23:20:33 -0700
Message-Id: <20200415062033.66406-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We pass the result of sizeof() here to tell the printk format specifier
how many bytes to print. That expects an int though and sizeof() isn't
that type. Cast to int to silence this warning:

drivers/soc/qcom/cmd-db.c: In function 'cmd_db_debugfs_dump':
drivers/soc/qcom/cmd-db.c:281:30: warning: field width specifier '*' expects argument of type 'int', but argument 4 has type 'long unsigned int' [-Wformat=]

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/qcom/cmd-db.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index 6c308f92a13c..6b5c440c9dc3 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -280,7 +280,7 @@ static int cmd_db_debugfs_dump(struct seq_file *seq, void *p)
 		ent = rsc_to_entry_header(rsc);
 		for (j = 0; j < le16_to_cpu(rsc->cnt); j++, ent++) {
 			seq_printf(seq, "0x%08x: %*pEp", le32_to_cpu(ent->addr),
-				   sizeof(ent->id), ent->id);
+				   (int)sizeof(ent->id), ent->id);
 
 			len = le16_to_cpu(ent->len);
 			if (len) {
-- 
Sent by a computer, using git, on the internet

