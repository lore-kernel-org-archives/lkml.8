Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759E1C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4708B21739
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWTcWZAI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgCBKcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 05:32:42 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41161 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgCBKcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 05:32:33 -0500
Received: by mail-lj1-f193.google.com with SMTP id u26so10969945ljd.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 02:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a42O4KV4bEmBFQrB6svb5MCsREuatuBAEWKoVrmbJO0=;
        b=cWTcWZAIYzjyX4csJQI8qpY9zS6H5etvZc0N+Mrjfy88j2LDsNnKBZ2r9ZOt7c0ee1
         Z3l7UAHxFeonp5mJo00Zi1tUpr3Q/MWTk56CuJWDaegT83D6Bi0DGPOjReSz7hCi6jBE
         D1//q/27Sh7NMHJX5zt+R9JW3R799Sc4ccu9n1NERTb5xBYG8OxenY6BJ6X/M4AGPh8W
         9DWOReMKA3aRztFwCRoDvEgY7PBSzMnehaXPgokPEiuCHiVc22zv0RugHl5TZ9VdZx/I
         PGFVb8zFCYwHgI8Jlgq+dw1zf0KLMSd/EOqh3KN/r12jgXFGrbk7J3MxjBTxjPXTxY2F
         pPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a42O4KV4bEmBFQrB6svb5MCsREuatuBAEWKoVrmbJO0=;
        b=NYt4llZ6JOR3xdhKqybACbb2Jna0ClshSjtoRYQw17fkFDcCfYMMheQD/h6TwGq8D4
         6ras96vpwALnuTtHzQNWiKzNbuXa37HXrcWkC52AgqwPZMRp5gyKL2/wvt/niFMq+hP6
         hWFskqhdqQjwYJ7wVkxn19yUpQexjKKo1agmlKvxjoVgRydLeKtCwAvzDESwphg+/v/u
         6IkPpNyxe+GBEtdqQHoTysRPtXBcqo3R08yMm2NhZ7R+HoSVYNCTF5ZQy/wkdOtVYcFl
         uiSIn6LHAlVrmlUa7I1dMDXXgHDpWB2k+RjiXAJdUOvZEcYRYeUjojrSmS8kfebW29k7
         JDLQ==
X-Gm-Message-State: ANhLgQ2Uf3kNQWh5Mq+F8eJg/ca6f0x7IAYTQwWHTKgCW7l/z/5uyD94
        fGS8Y7AWoirdY4FR6YImmZk=
X-Google-Smtp-Source: ADFU+vvy4hEeA0Fk8eWL+molTfrJlcJGZig6kMdWtN2clniYcBX6YHZQdFlQSI1P0cwNHUtitZvmcQ==
X-Received: by 2002:a05:651c:cf:: with SMTP id 15mr11454597ljr.288.1583145151835;
        Mon, 02 Mar 2020 02:32:31 -0800 (PST)
Received: from localhost.localdomain ([149.255.131.2])
        by smtp.gmail.com with ESMTPSA id n21sm3895328lfh.2.2020.03.02.02.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 02:32:31 -0800 (PST)
From:   Roman Stratiienko <r.stratiienko@gmail.com>
To:     jernej.skrabec@siol.net, mripard@kernel.org, wens@csie.org
Cc:     airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Roman Stratiienko <r.stratiienko@gmail.com>
Subject: [PATCH v4 4/4] RFC: drm/sun4i: Process alpha channel of most bottom layer
Date:   Mon,  2 Mar 2020 12:31:38 +0200
Message-Id: <20200302103138.17916-5-r.stratiienko@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302103138.17916-1-r.stratiienko@gmail.com>
References: <.>
 <20200302103138.17916-1-r.stratiienko@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner display engine blender consists of 3 pipelined blending units.

PIPE0->\
        BLD0-\
PIPE1->/      BLD1-\
PIPE2->------/      BLD2->OUT
PIPE3->------------/

This pipeline produces incorrect composition if PIPE0 buffer has alpha.
Correct solution is to add one more blending step and mix PIPE0 with
background, but it is not supported by the hardware.

Use premultiplied alpha buffer of PIPE0 overlay channel as is.
In this case we got same effect as mixing PIPE0 with black background.

Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>

---

v4:
- Initial version, depends on other unmerged patches in the patchset.
---
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 2 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index dd6145f80c36..d94f4d8b9128 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -106,7 +106,7 @@ static void sun8i_ui_layer_update_alpha(struct sun8i_mixer *mixer, int channel,
 	regmap_update_bits(mixer->engine.regs,
 			   SUN8I_MIXER_BLEND_PREMULTIPLY(bld_base),
 			   SUN8I_MIXER_BLEND_PREMULTIPLY_EN(zpos),
-			   SUN8I_MIXER_BLEND_PREMULTIPLY_EN(zpos));
+			   zpos ? SUN8I_MIXER_BLEND_PREMULTIPLY_EN(zpos) : 0);
 }
 
 static int sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int channel,
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index e6d8a539614f..68a6843db4ab 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -108,7 +108,7 @@ static void sun8i_vi_layer_update_alpha(struct sun8i_mixer *mixer, int channel,
 	regmap_update_bits(mixer->engine.regs,
 			   SUN8I_MIXER_BLEND_PREMULTIPLY(bld_base),
 			   SUN8I_MIXER_BLEND_PREMULTIPLY_EN(zpos),
-			   (mixer->cfg->is_de3) ?
+			   (zpos != 0 && mixer->cfg->is_de3) ?
 				SUN8I_MIXER_BLEND_PREMULTIPLY_EN(zpos) : 0);
 
 }
-- 
2.17.1

