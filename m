Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF0AC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9871322314
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7Q3sJJg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389143AbgBNUtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:49:07 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55948 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388596AbgBNUs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:48:56 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so11330731wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 12:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U8NBJe69fGI1riovNIettjUorcdU8nc30mS07YUFc+Q=;
        b=L7Q3sJJgTi67bsfEROf03AhhrNUs8bKrCtifQ97H2IMCMaBhlIo45AtMXXm9P8xUiB
         Yus7lWPx+SprZUUuQoUOGgAsfnaOQvF+KJ/Wtp75d/2jXYN9KdnXyJ+e2J4OYKunHPGy
         czwn4jEKR369e4HdeMxBHM+OJlEH9Li7MPSC1YGvOSBumFT9omybY+xpF5I32Ou9V2nJ
         4lQ3qSDQ4nhMI9FsVp14jI62FaNnKh6WbwXHHz7+slPQhbm3RUjjEmCdk//Ms2xLPsrk
         w4VjtAbthr1GoTWyCP32qatj929l9wgVTYfmbuinZXf+llXzOPeIJTd3FSpQDivyne9c
         cWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U8NBJe69fGI1riovNIettjUorcdU8nc30mS07YUFc+Q=;
        b=I2zBpWOmwVYdg8/1P3N+HeooVKLs7X6aJ0fJdUGBeMQpPprknOIdKaHbc3LgzkKV62
         38v8Qrd60+pswo0B6LsWODSNpERP4ViFSZDAvWOHiQxYeOoMmprf3GyTp05LZnTIHuWi
         i3hAb4epOSVept8bJ5iBNcEkgI1RyH7Rac5OlAvuk9D5MPMr4NSuKbaUx57swlJghLJq
         6ljQoVGuwbvysQ2yzvvPWMyf5KS4E2z+fG+8O+PCecKepkZRQLMNgvwLWCPE/VZieCI1
         yGK39p60U+o2/B+dGo+KbiBosBT2CJzj9cyVLcQVnTPvTziiUXYB95VBtLODJiATs7Oc
         E6zg==
X-Gm-Message-State: APjAAAX/XsBzkWzT1raRlSSLU3UPrUwm5VM6s8Mqp4oL8to5++p6AdkV
        bm9EtlFoX1zVhrg7GsAYMq2o7U3Dvrxe
X-Google-Smtp-Source: APXvYqyNQCIWcW+YKuUv1Jqg7zsAZrA5qsYk/Q0dPZFfec7OuCC1amJ598hrOFPcFg1GFZIYir5puQ==
X-Received: by 2002:a1c:9ed7:: with SMTP id h206mr6357549wme.67.1581713334947;
        Fri, 14 Feb 2020 12:48:54 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id y12sm8660782wmj.6.2020.02.14.12.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 12:48:54 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Jules Irenge <jbi.octave@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 19/30] driver core: Add missing annotation for device_links_read_lock()
Date:   Fri, 14 Feb 2020 20:47:30 +0000
Message-Id: <20200214204741.94112-20-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214204741.94112-1-jbi.octave@gmail.com>
References: <0/30>
 <20200214204741.94112-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at device_links_read_unlock()

warning:  warning: context imbalance in device_links_read_unlock()
	 - unexpected unlock

The root cause is the missing annotation at device_links_read_unlock()
Add the missing __releases(&device_links_srcu) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index fc7f1b8746da..3a7e72840740 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -69,7 +69,7 @@ int device_links_read_lock(void) __acquires(&device_links_srcu)
 	return srcu_read_lock(&device_links_srcu);
 }
 
-void device_links_read_unlock(int idx)
+void device_links_read_unlock(int idx) __releases(&device_links_srcu)
 {
 	srcu_read_unlock(&device_links_srcu, idx);
 }
-- 
2.24.1

