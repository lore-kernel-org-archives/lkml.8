Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69BAC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 01:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA6EC20747
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 01:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="RAyZt079"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgFNBsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 21:48:43 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:59886 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgFNBsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 21:48:42 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 49ky6c6sjXz9vZ8p
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 01:48:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SSCnQa6OMwan for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 20:48:40 -0500 (CDT)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 49ky6c57PXz9vZ8X
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 20:48:40 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 49ky6c57PXz9vZ8X
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 49ky6c57PXz9vZ8X
Received: by mail-il1-f199.google.com with SMTP id q14so9380409ils.18
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 18:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vwS4iBH2TfaLSm/U9G8+/YZNlczPHmpLDZOOCLUssn4=;
        b=RAyZt079t6nAq4cI1GjMxaPYT9VqopIavYteGGrGjDji87vThIRg/BA0tMYwaPtsu+
         tYxd0WIABoM2N1EnOJoz9izoR1COivh5fagyr2hqq/4//15ubkqcuDEV8JHMEMvzNr1e
         WmwI0+9W/XP2V1LCMXiiwYciZVYKUhKGVvMAR7p0WXg9A3SclX5t11hlSWgOGjlONrt6
         q06KQtiSE6yYuT3xfPzvWWzWP56aIpRgfpWgBlL4DGlRkZOjSiTBp2Jdkw9gvr9ce9Ui
         QQkgtZC3UkO3J2zyUO2yK6ydDDQelAtrpY7YL48bv8PpRYSbhDkHJ+3DHrwnYMy0Jf+N
         DP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vwS4iBH2TfaLSm/U9G8+/YZNlczPHmpLDZOOCLUssn4=;
        b=gOI2HMWB5RBfE+QwRSipRPRh579XcgRb+McoxIH4WCmEtMuT2zK3Pcjf5chZvOMdFF
         w7mbleRVZzp1W+4VXKHhUuH7chG3PFtN1bxVv5TaTPZcEpbnpeFPz65vopqh+ZKvUjdO
         GqDCjH1uno2IrURQcIMv9TYVSp9+BMHdqiWO4d7XfeFdEakNcAOeQh62zQZE87ynScW3
         XHmD5udtXcXcsPcipjhnYpC5wsW8ifKRkS4gtWv/P62z+cuvtL7Zau04nGBwcCynhzAz
         UlYYitRvasS706shpPQSGMkvmFmvb9cOUtJdVi35KXCP8h3I63bZgCAhesRQKW2zNpea
         Ij8A==
X-Gm-Message-State: AOAM533mSABLy7C1rX2gm6pX6jkgj2kolHLpnXAoaYJCzbpgmH+l+/Jj
        CYa3RyHeJGPwMCMiY+SwYr1oojzSadapduGaarC3mQV52MhRrwIveYWczjGUb1CX7tGmab3LFsQ
        orTG7QX2Hj9P2iemIvK5yuaUvH7HY
X-Received: by 2002:a02:8529:: with SMTP id g38mr15074442jai.143.1592099320332;
        Sat, 13 Jun 2020 18:48:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQlNEPoOQIOiFAjrDKzToAN2cpikujTxQg4Kn8KjyoM4aKnt/Ueavi58mg3qK8fmxA97Jk3Q==
X-Received: by 2002:a02:8529:: with SMTP id g38mr15074434jai.143.1592099320183;
        Sat, 13 Jun 2020 18:48:40 -0700 (PDT)
Received: from syssec1.cs.umn.edu ([2607:ea00:101:3c74:49fa:9c47:e40b:9c40])
        by smtp.gmail.com with ESMTPSA id n21sm5598507ioj.43.2020.06.13.18.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 18:48:39 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, wu000273@umn.edu, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/noveau: fix reference count leak in nouveau_debugfs_strap_peek
Date:   Sat, 13 Jun 2020 20:48:37 -0500
Message-Id: <20200614014838.123171-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nouveau_debugfs_strap_peek() calls pm_runtime_get_sync() that
increments the reference count. In case of failure, decrement the
ref count before returning the error.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/gpu/drm/nouveau/nouveau_debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
index 63b5c8cf9ae4..8f63cda3db17 100644
--- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
@@ -54,8 +54,10 @@ nouveau_debugfs_strap_peek(struct seq_file *m, void *data)
 	int ret;
 
 	ret = pm_runtime_get_sync(drm->dev->dev);
-	if (ret < 0 && ret != -EACCES)
+	if (ret < 0 && ret != -EACCES) {
+		pm_runtime_put_autosuspend(drm->dev->dev);
 		return ret;
+	}
 
 	seq_printf(m, "0x%08x\n",
 		   nvif_rd32(&drm->client.device.object, 0x101000));
-- 
2.25.1

