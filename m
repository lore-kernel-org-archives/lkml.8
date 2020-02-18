Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6E3C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447FE2464E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="of1bnSom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgBRR2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:28:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43551 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgBRR2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:28:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id r11so24915426wrq.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 09:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RQKZJvHf1WtLQUnnQ+YYr8z0U0bnUL/X5oP4lbmCs/g=;
        b=of1bnSomwHNCr/K4IwVeC844d2lNrG7EeEsYbcslvaQOYTyn6ONlfHSBA/bDDBcsgw
         Fr292hw7tiOAcRcAg9S8LuNfeHmlaYQ0bP2vEF4rX4oGw01MQ1Pas0LFZrpIVOvetzBe
         e3r1Cj5ZrC32v8GmGAMIrk2dmXsbojIb1aZAGrQzBJsv1KVhaZQM6+xXpKCF1BZlGku3
         hc+nI4Mw1AB4noQRq7YvpeJLzVMMtK1pGm7KpHMlAzyoUl/eWD7pyKX8LvRfyoBPbQIo
         YwM8VZSeZWzArpoMW5cJvhDFavE/qu9/YQUBRLMCTXPiqGPikviiKQ9uCyiv0TGlC6GI
         vlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RQKZJvHf1WtLQUnnQ+YYr8z0U0bnUL/X5oP4lbmCs/g=;
        b=qBq20LABlphdkWbSBHVPjo2AZkNTKdU7UPsrVO1Cl6zzXAOASZkvuoztS2I5OyGhCW
         wofTW/UnkRHu2A29+w17Jxc+McRL6gWQ6tnx4tajTsAGGzRan+1PDm6R80K+YUeyYvur
         9fW6FtbLEK1QdpuRuePaGHCQ/pBoM+vxCqJkf6E5hjJT/ePBDBwadcTL7K/R9YEt+hXp
         kic2vDX0TVFBuUaE2ZQg9Fjo4YvPxDNNC8xnOpF3pi6w/rPQL22t3435ysjDQXoAmrCw
         wp4nDsocVi2YINnGYKdSKcn354lqS2EZNZe9UYLxxWx3vSwF4q1/ec4wJ8e057umOPq7
         xKQw==
X-Gm-Message-State: APjAAAVMW11YIRaQ17Ee8MKx5bx0EOTw+ReDqIWkXxC2WpK5LumjE/9Y
        n9khMkd5TFgMCje5opM+PDE=
X-Google-Smtp-Source: APXvYqwCmwWwQooLJukyapOJfGjMEKhOTHvMcsMfWr+K1Mn4hamrwPeP1liVlfVU3P2zF5Jk8xifdQ==
X-Received: by 2002:adf:e641:: with SMTP id b1mr30114961wrn.34.1582046928676;
        Tue, 18 Feb 2020 09:28:48 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id t13sm6998757wrw.19.2020.02.18.09.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 09:28:48 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH] drm/i915: make i915_debugfs_register return void.
Date:   Tue, 18 Feb 2020 20:28:16 +0300
Message-Id: <20200218172821.18378-5-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200218172821.18378-1-wambui.karugax@gmail.com>
References: <20200218172821.18378-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As drm_debugfs_create_files should return void, remove its use as the
return value of i915_debugfs_register and have i915_debugfs_register
return void.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/i915/i915_debugfs.c | 8 ++++----
 drivers/gpu/drm/i915/i915_debugfs.h | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
index e5eea915bd0d..4a3c58f9fc1e 100644
--- a/drivers/gpu/drm/i915/i915_debugfs.c
+++ b/drivers/gpu/drm/i915/i915_debugfs.c
@@ -2391,7 +2391,7 @@ static const struct i915_debugfs_files {
 	{"i915_guc_log_relay", &i915_guc_log_relay_fops},
 };
 
-int i915_debugfs_register(struct drm_i915_private *dev_priv)
+void i915_debugfs_register(struct drm_i915_private *dev_priv)
 {
 	struct drm_minor *minor = dev_priv->drm.primary;
 	int i;
@@ -2408,7 +2408,7 @@ int i915_debugfs_register(struct drm_i915_private *dev_priv)
 				    i915_debugfs_files[i].fops);
 	}
 
-	return drm_debugfs_create_files(i915_debugfs_list,
-					I915_DEBUGFS_ENTRIES,
-					minor->debugfs_root, minor);
+	drm_debugfs_create_files(i915_debugfs_list,
+				 I915_DEBUGFS_ENTRIES,
+				 minor->debugfs_root, minor);
 }
diff --git a/drivers/gpu/drm/i915/i915_debugfs.h b/drivers/gpu/drm/i915/i915_debugfs.h
index 6da39c76ab5e..1de2736f1248 100644
--- a/drivers/gpu/drm/i915/i915_debugfs.h
+++ b/drivers/gpu/drm/i915/i915_debugfs.h
@@ -12,10 +12,10 @@ struct drm_i915_private;
 struct seq_file;
 
 #ifdef CONFIG_DEBUG_FS
-int i915_debugfs_register(struct drm_i915_private *dev_priv);
+void i915_debugfs_register(struct drm_i915_private *dev_priv);
 void i915_debugfs_describe_obj(struct seq_file *m, struct drm_i915_gem_object *obj);
 #else
-static inline int i915_debugfs_register(struct drm_i915_private *dev_priv) { return 0; }
+static inline void i915_debugfs_register(struct drm_i915_private *dev_priv) {}
 static inline void i915_debugfs_describe_obj(struct seq_file *m, struct drm_i915_gem_object *obj) {}
 #endif
 
-- 
2.25.0

