Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FADDC54E4B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25C9520736
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLaaBZYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgELGOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 02:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725536AbgELGOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 02:14:38 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93055C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 23:14:37 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id u15so993129plm.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 23:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QJ6p4r/QfkD17FHpL2YTGpm8IpLSMzMuC3KtCg0s5mo=;
        b=iLaaBZYQY7d0MN6c6SgxYeWnAlazltu/qpMaKh/fOE8AAwiZkp6iY26pPpDShNBIvg
         znku9Ab32XQ70jzBILlnBgUsT8/sXigtsXDTtyCcN5eb7LHgbZG4Cf1TNPL1s86w3m9B
         LqI8PYObYeMlYPCPoIgpaElSZn4eJqKRx7BexEDkfJ3e6L9PmAdf2zCjGJV3Rs8pLiSV
         uJWD7Icjx/oqFLhMIZ+beeq3GN9UKaVa4lu45+7XpVHomBg2AyhrvIE+Mvori9tB8wTi
         XxZ+aBB7T5L3fbTPtfQWPpGTIq/gKvpX4jPGncFGjBviWoiH+OlBosehvLvYNGAEUVYT
         Bsiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QJ6p4r/QfkD17FHpL2YTGpm8IpLSMzMuC3KtCg0s5mo=;
        b=N01HgHIn6/QV/xEwgIKbjfToT4XfxMV7acar899KUCAP4dtQ6ZsUMP54FLv9fAekoU
         5/Q1af3WlqRKkb/4OGtthS8n0R+f21gMWoKBig80eLdQ3Xi56SUSRE3e1KfHYiJ6/jLm
         iPXc9a8ibqG6eC+fqyCQFihbbisupWUwloHjpPl02a/AKFv9l9C6O6S/mWBhIEySBpZ0
         RKSY3ZA0vMFrbYB11nMiPLi7Sux7hZ+FEWpBcHBhD8bKMPlqGjp3R12PFjQ7sIJVOx4W
         DiCcSkD7rhGr682AjnGTbF7/l8J8y2TD1Wm0fXkA6Q/9872OyC0msqCa2PlnX6YxCqhU
         Kt6Q==
X-Gm-Message-State: AGi0PuZMq/DaPgupNIT9IG6pW0v5hTQ5Dy0ySrwV26liQE5ZjhKmxYZW
        WKrlQb7DMVH4WZh2d26vhNs=
X-Google-Smtp-Source: APiQypJgZfNQF7KJCaDpZKd/vf3dSExBDe/nV2TndoJ24BuinyBSyxE1AL2vQDY5hWBUkKiwgCi70w==
X-Received: by 2002:a17:902:7204:: with SMTP id ba4mr11840352plb.161.1589264077071;
        Mon, 11 May 2020 23:14:37 -0700 (PDT)
Received: from localhost.localdomain ([49.205.221.80])
        by smtp.gmail.com with ESMTPSA id 6sm10884990pfj.123.2020.05.11.23.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 23:14:36 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     clemens@ladisch.de
Cc:     linux-kernel@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH] hpet: Fix a small information leak
Date:   Tue, 12 May 2020 11:44:24 +0530
Message-Id: <20200512061424.28381-1-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 hpet_info has a hole in it cause of which
we might end up leaking a few bytes.

 Zero them with memset().
Fixes: 54066a57c584 ("hpet: kill BKL, add compat_ioctl")
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/char/hpet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index ed3b7dab678d..d9592eb24635 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -667,6 +667,7 @@ hpet_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	struct hpet_info info;
 	int err;
 
+	memset(&info, 0, sizeof(info));
 	mutex_lock(&hpet_mutex);
 	err = hpet_ioctl_common(file->private_data, cmd, arg, &info);
 	mutex_unlock(&hpet_mutex);
-- 
2.17.1

