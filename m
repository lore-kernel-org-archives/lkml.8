Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61251C2BB85
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 19:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B90206F7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 19:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owX5RmHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgDKTDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 15:03:01 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:36532 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgDKTDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 15:03:01 -0400
Received: by mail-il1-f195.google.com with SMTP id t8so186542ilj.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 12:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=geygEetnxFUbF7qcnow6BWFQrHKQpMqo/AimQRIb2J8=;
        b=owX5RmHWoLMAOlS0chOL9zLwquEDbLi5abb4351ycfJCC13LsOIMlJuH0N2iamMmg+
         Thy/jUp9BRuG03nMWO8O/Fcrlz/6AvEQiaE5+yV4vA2hIvHsj8d9gNUNRhgh0UsItOYo
         c6QrLDxK+OuujGZdxaWnLOCCyvbh+Y/k+xOnnWIMcsmIHy5UBBeyZyN4NlmQsgdsmm57
         Gq+xxcbFpeLfpLD5Z0mEXsbXacDKPZxzy4S2OU5GD39LsOL0aRXTZWKxgVlbODwLLRfH
         DjGxgcLtdnjkTETCtyOzfYLS9nFLs4Mqojhwif4A1UMAfQWZj8fwrSUK76CAf5Qnitdg
         23rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=geygEetnxFUbF7qcnow6BWFQrHKQpMqo/AimQRIb2J8=;
        b=Jr4NXQ9qzZ8fIjYo19k5HT0mb6HJvROYok5GoxaQ6J6oo/Z8s/QVImpsJ4NsPj5muN
         NrZVeRm433RmrMZNy4+ABhzkiLzheb6JttpwyJuqwTf/q+DSLGeYo1bznvxO2WHdCJfk
         NPQR2vlsCa7+n5w0TFqOXpCeoJuqgZ8r6dd3Yi6S0GpVZfx5k0xmqOIeyPJu7dAq2m0S
         HLRLU4zKY6bvKzyFSREozVlv3u5uC07Bw4Aw0ebCgK8v3ofr3yHSfTH4+nK5cZfM4eei
         IvExHiKYvkyHNmQyN+4ByL7Y1I/0qyU+sEU6/onvDDbnVNWMmkVjWVzuuahXZehIK3SH
         FoVw==
X-Gm-Message-State: AGi0PuYqOlJNRHma3jLk86/n4t6yyV7M9sp6z+8h25xiwrT4xgOq8YZR
        Lug7lCM0nwzfXoujH7+Qk9o=
X-Google-Smtp-Source: APiQypKhOkOaKU7yvl4bRHK+wGd8oLUZN00ujbv8m7RB6wstiOfYYw3Imh0iaB6PBH4j59Vb2vD77g==
X-Received: by 2002:a92:834b:: with SMTP id f72mr10268736ild.128.1586631779441;
        Sat, 11 Apr 2020 12:02:59 -0700 (PDT)
Received: from james-x399.localdomain (97-118-146-253.hlrn.qwest.net. [97.118.146.253])
        by smtp.gmail.com with ESMTPSA id v17sm2068309ill.5.2020.04.11.12.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2020 12:02:58 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v2] component: Silence bind error on -EPROBE_DEFER
Date:   Sat, 11 Apr 2020 13:02:41 -0600
Message-Id: <20200411190241.89404-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a component fails to bind due to -EPROBE_DEFER we should not log an
error as this is not a real failure.

Fixes:
vc4-drm soc:gpu: failed to bind 3f902000.hdmi (ops vc4_hdmi_ops): -517
vc4-drm soc:gpu: master bind failed: -517

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - remove braces
---
 drivers/base/component.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index e97704104784..dcfbe7251dc4 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -256,7 +256,8 @@ static int try_to_bring_up_master(struct master *master,
 	ret = master->ops->bind(master->dev);
 	if (ret < 0) {
 		devres_release_group(master->dev, NULL);
-		dev_info(master->dev, "master bind failed: %d\n", ret);
+		if (ret != -EPROBE_DEFER)
+			dev_info(master->dev, "master bind failed: %d\n", ret);
 		return ret;
 	}
 
@@ -611,8 +612,9 @@ static int component_bind(struct component *component, struct master *master,
 		devres_release_group(component->dev, NULL);
 		devres_release_group(master->dev, NULL);
 
-		dev_err(master->dev, "failed to bind %s (ops %ps): %d\n",
-			dev_name(component->dev), component->ops, ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(master->dev, "failed to bind %s (ops %ps): %d\n",
+				dev_name(component->dev), component->ops, ret);
 	}
 
 	return ret;
-- 
2.20.1

