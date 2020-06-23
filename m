Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1235C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 01:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CBF82070E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 01:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQ+k9fFJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731955AbgFWBgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 21:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731765AbgFWBgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 21:36:20 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB45EC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 18:36:20 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id a137so17489615oii.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 18:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6xUzhKnsOu6gQ8wo5pNQ9aUbiM+zR6hakYUaVJ25KuY=;
        b=jQ+k9fFJJ6wao/pAeyhtXubATETSraRIKy+LkYNdX0mwxIbSgAtWYLREjqUMYYasbm
         AUShJj8cYZ3ySM5RLlfT6IebvuG7RlzJSVzbP6ndZJ+/fOqTzcjBiPyX2deW+Ag2k/wQ
         082nggYK5t46GylyCV6wXBvULOw9xjfgM2Gwj1g0MN2ThzwzL1hw3pZanyS83XS4FNTX
         cG5CA6zRBlKLbF0vWgBEVpHuDwj2vA9kGVRYlav7R143QbQE569WHfI9+1oJrfJY/nEC
         yGDVKBb4He6zy2FkYSuwnT6QEvMDPSaIK2JZ8+MZ/HUCmBXh3/XWo9VZbgEqnHBWysbi
         lRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6xUzhKnsOu6gQ8wo5pNQ9aUbiM+zR6hakYUaVJ25KuY=;
        b=h6AkyZgii3ZxSzREfIYXyZ46to/u+1jDpWawpVt3f16Bpgrmp/8lS0zzYwTeDQDZkw
         FU5a3KC86p4qGZneBbI5o3acaIwzvACfMIgxsamkww4MVAK2vcPvxSR9wD9vRgL9jdOa
         c0Fyz0FIznC8Rw1WZ1AWRsletNtzoioJtH3Tq1DRu2rPVIz0XeP5OLyYYAPYyR++n/N+
         dJPDdcr252x9XlgoTzxZ3AbNDFM4KP36swiz+ZiSqd6XYkLJf+gG7HUBXZ23zQWFNUud
         uAnC++n50JFpygI+Oy/041vVu/xrt7GYu4/DGOAC+46xB7NPXAvadBflxXj/cprLATZH
         D+yw==
X-Gm-Message-State: AOAM532/RhAyLjOp75jcmRtC2Ql9MUV31bNBlNH1Vzu/NwUvyTd/lxpm
        kcRE9fiKQUUIs75jKHht0B4=
X-Google-Smtp-Source: ABdhPJxaVLeLGTXxnw01SkIUJf4ClKrnziWYeidk+XMgDIH3PlOiFDay7sjX9ZcaDqPuG1tKRu2qBA==
X-Received: by 2002:aca:4e0d:: with SMTP id c13mr14664131oib.30.1592876180059;
        Mon, 22 Jun 2020 18:36:20 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id j71sm3624030otj.6.2020.06.22.18.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 18:36:19 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] drm/omap: Remove aggregate initialization of new_mode in omap_connector_mode_valid
Date:   Mon, 22 Jun 2020 18:36:10 -0700
Message-Id: <20200623013610.555610-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 42acb06b01b1 ("drm: pahole struct drm_display_mode"), clang
warns:

drivers/gpu/drm/omapdrm/omap_connector.c:92:39: warning: braces around
scalar initializer [-Wbraced-scalar-init]
        struct drm_display_mode new_mode = { { 0 } };
                                             ^~~~~~
1 warning generated.

After the struct was shuffled, the second set of braces is no longer
needed because we are not initializing a structure (struct list_head)
but a regular integer (int clock).

However, looking into it further, this initialization is pointless
because new_mode is used as the destination of drm_mode_copy, where the
members of new_mode will just be completely overwritten with the members
of mode. Just remove the initialization of new_mode so that there is no
more warning and we don't need to worry about updating the
initialization if the structure ever get shuffled again.

Link: https://github.com/ClangBuiltLinux/linux/issues/1059
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/omapdrm/omap_connector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c b/drivers/gpu/drm/omapdrm/omap_connector.c
index 528764566b17..ce4da1511920 100644
--- a/drivers/gpu/drm/omapdrm/omap_connector.c
+++ b/drivers/gpu/drm/omapdrm/omap_connector.c
@@ -89,7 +89,7 @@ static enum drm_mode_status omap_connector_mode_valid(struct drm_connector *conn
 				 struct drm_display_mode *mode)
 {
 	struct omap_connector *omap_connector = to_omap_connector(connector);
-	struct drm_display_mode new_mode = { { 0 } };
+	struct drm_display_mode new_mode;
 	enum drm_mode_status status;
 
 	status = omap_connector_mode_fixup(omap_connector->output, mode,

base-commit: 27f11fea33608cbd321a97cbecfa2ef97dcc1821
-- 
2.27.0

