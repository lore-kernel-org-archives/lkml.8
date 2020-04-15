Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40AAC2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C99B820732
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KqdhYQ0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441802AbgDOTa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2436598AbgDOT3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 15:29:19 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB40C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 12:29:18 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d17so429293pgo.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 12:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bm4kU2ZKp3QMbAy5SoYEcpKZV6RD0npZxWuwzSCGnUs=;
        b=KqdhYQ0zbtL9yXg2Bxk2e3AR19MJWNUGM564TCk0GdOiHPJqNwDW5BEC1kr3BJWybs
         gUogR76cvvkgK3pwZp/3ANsg9SJxFBFtpZbE9NvrthZf+5TWO38Nht+VaBh+ZuaGBp2I
         aXk6UIz0PzTSyTO6hk9isRYNGiW1X2Mh2ih6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bm4kU2ZKp3QMbAy5SoYEcpKZV6RD0npZxWuwzSCGnUs=;
        b=gcoPOq79tBizpJPbVeOoCHm0BzkibBKZdq2WtkXlogYlKJN92gl9SWbfM/IJ4Emge4
         j0jYSI6dHQ4A98Q4gWD+AxYDAs0omOh6+hZ175q8J9J0SlVV3NNT1DKmAGno0Hn4X9s+
         lD+URtCZSlGtdKEey7r+mFWgCKCTOPe/MWnux7GPNRvwync2RI7CD3V+FuFVrZcCA8ta
         P6OmeDUgRGoJ5iOqLuym9CdCYneSVrjt4cnnpojwRW0SPG2y2TBJUQMvEwwIluHxJrNl
         ue2v1NhqaykR1QRd1RJoBn3P9bLgXdrpmQ+lTkMr8I/ehSmWVOAfzHst9X/qS3Optwda
         6Fxg==
X-Gm-Message-State: AGi0PuYz7FA0tG6JyeNWzb2v7A7W5pqfMXFTbUWGgjQM3LFhZdYvXF9X
        tkjR5vuXrjho7zobXUnpDzKHWw==
X-Google-Smtp-Source: APiQypJGqAGAcvgr0pgn18GcTFOquOdj4pDUmUBSR2qUPyjJwzMmoxHbt7rZBewVPibsTGM+ZmMj4w==
X-Received: by 2002:a63:1118:: with SMTP id g24mr28220456pgl.259.1586978958145;
        Wed, 15 Apr 2020 12:29:18 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x4sm14566641pfa.191.2020.04.15.12.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 12:29:17 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH] soc: qcom: cmd-db: Use 5 digits for printing address
Date:   Wed, 15 Apr 2020 12:29:16 -0700
Message-Id: <20200415192916.78339-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The top few bits aren't relevant to pad out because they're always zero.
Let's just print 5 digits instead of 8 so that it's a little shorter and
more readable.

Suggested-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/qcom/cmd-db.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index 57382b64f1da..4f8b739c6485 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -278,7 +278,7 @@ static int cmd_db_debugfs_dump(struct seq_file *seq, void *p)
 
 		ent = rsc_to_entry_header(rsc);
 		for (j = 0; j < le16_to_cpu(rsc->cnt); j++, ent++) {
-			seq_printf(seq, "0x%08x: %*pEp", le32_to_cpu(ent->addr),
+			seq_printf(seq, "0x%05x: %*pEp", le32_to_cpu(ent->addr),
 				   (int)sizeof(ent->id), ent->id);
 
 			len = le16_to_cpu(ent->len);

base-commit: d6815c5c43d4f9d18e557d27fd27ae8d9cfd450c
prerequisite-patch-id: fc235b174200bb1b24876628a89a841d1c2e4aad
-- 
Sent by a computer, using git, on the internet

