Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A0FC35673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 23:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D21208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 23:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRYBDkeQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgBWXSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 18:18:39 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35710 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbgBWXSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 18:18:36 -0500
Received: by mail-wr1-f67.google.com with SMTP id w12so8248404wrt.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 15:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d52I2cg4cQGyAeOzWmCnImcQNbb68kdLDPhQMpl0hX0=;
        b=iRYBDkeQ4db5W3MUDu0oR5U/Kb/B0rCA+HzQGJSDMO1cEzbzEJK2wWaP5MDxjSKr1h
         j1rOgh/9eTwk+Xu5o7uVeYMmTjEZZNCLqkcL1nfYmCgwYopCzLPlI/g22fJGCLbnJqeo
         AEYr421i8eeHOjanFCkblFnv2Is0kxbP+es1kQLIRF4zI2T0Y5Wp9mikAunnv3U02FvH
         5Nydert3ZrjQSiGEyy6E28QTzou9vF3s9+68a08XhtCKA7eKcObub1NhHvBihg32j8+1
         KwqRUvHVR6Sy4+Rzdy7snQEJsahkHApsArExqEovxJWjqx3WxIom+5bZ1a2UBsm+Ymb8
         Zl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d52I2cg4cQGyAeOzWmCnImcQNbb68kdLDPhQMpl0hX0=;
        b=LB+LnjkZ52X3SK51sPdNjjgAL4ln8nQlvI3R4ocOaD3akcO8kVGWrC/aiB2jtat1hF
         /mXnNgf/kXrz1Di2UIMKch5U+in7ZLZvOsmjoit36e0YiedzM6TIvhlIFry/npFrOQOM
         dFUJS6ie7C/EdJObGg/Pa4KXmwUThto9wYkVB77EJUdVL9W24dScXXgSXh6LXDqyCsJZ
         Kc1XES+RRv9grxlSpbroJRFXRTwTWq6Qv26B2pnZFutmvonNmsSKaqFqiMSgb3+1zjcE
         k7OAcNZiT9W4tlsyZvJIMCk2+QWFB3Gd7bhLZU+1SHSoAsra66CquUK+wCnPEeSaxeh4
         6cKQ==
X-Gm-Message-State: APjAAAVrIliOINl7u5B24HuHNTlJ62LO1sS0zTwzZ6xgUhjTzPLCqeZ1
        hNImPLIvB+eaWPor7Qq2dQ==
X-Google-Smtp-Source: APXvYqzpMefoVwUp3yuLfioLy/yTmYHOYMZwjTho0L2njh6fr9gV3sTHqGTH4o32XE/47kp46mrc/w==
X-Received: by 2002:a5d:5267:: with SMTP id l7mr61272635wrc.84.1582499914687;
        Sun, 23 Feb 2020 15:18:34 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id q6sm8968203wrf.67.2020.02.23.15.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 15:18:34 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     jbi.octave@gmail.com, linux-kernel@vger.kernel.org,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tomer Tayar <ttayar@habana.ai>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Dalit Ben Zoor <dbenzoor@habana.ai>
Subject: [PATCH 28/30] habanalabs: Add missing annotation for goya_hw_queues_unlock()
Date:   Sun, 23 Feb 2020 23:17:09 +0000
Message-Id: <20200223231711.157699-29-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200223231711.157699-1-jbi.octave@gmail.com>
References: <0/30>
 <20200223231711.157699-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at goya_hw_queues_unlock()
warning: context imbalance in goya_hw_queues_unlock() - unexpected unlock
The root cause is a missing annotation at goya_hw_queues_unlock()
Add the missing __releases(&goya->hw_queues_lock) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 8ca7ee57cbc1..6138b461d0f8 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5081,6 +5081,7 @@ static void goya_hw_queues_lock(struct hl_device *hdev)
 }
 
 static void goya_hw_queues_unlock(struct hl_device *hdev)
+	__releases(&goya->hw_queues_lock)
 {
 	struct goya_device *goya = hdev->asic_specific;
 
-- 
2.24.1

