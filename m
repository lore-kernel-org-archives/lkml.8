Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F70C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C148920787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZT+wLdJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732226AbgGVSOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgGVSOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:14:33 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE83BC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:14:32 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o18so3233469eje.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9YXzBu5CzF+ORy2slLhhzsC7TGMl1ab46whl8Gc0jIE=;
        b=YZT+wLdJt81DIoI1eEOPyqj1ApstGxBDSFtKpxwA9aFw78rHiaPtz1o5R5aWPA7mJV
         zmNy+2woINSM+h80UBALJOtOA5Upoq2morXnjWFdTQ+Wtq6buPJsqYcpPDzzaESTPck8
         tqZXYqMilV+HuupNqSOpFSxS29xvqMO9EENURQIGqLlabe8vJ8zb3/5WKCe6akTx6gDA
         SUp6DhxR16CeNKMBUPluYu+Z6vVdb83WgEs8iYvA+T5Qj20InAeKKUMLFkdk+OmiOKLc
         LL+k+HbMYlgqkEwBrDHamrOmKY1UgM1OIJAGO7wZjw+h6mM9gTK41HYB0dM36Eqxdsr9
         pJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9YXzBu5CzF+ORy2slLhhzsC7TGMl1ab46whl8Gc0jIE=;
        b=QANuBUMzb1HVzC9fYQtNkCmmkw3E1uoe0UzmUZOnCdOzYM/JuUqYn0Q5s7NKyxp9Z7
         JiOV7eX67osXeYaIzwLcVSscjtqV0MLSkbcgHG/bbxEB/7tH/9pCPL4CkQYXSsPdNueb
         pB1gk5jkswdiuQwKE5KwEvpy4zdBmeRi/TzsDKd5HSoX5z8pBNo1pmh1xUfQSXD1yyl1
         Iz7uWGfYIvpT6kNp2GDGiVSiwfp+s7YHmIl3XCR62y6uxWl67+vB51l6MdVbVLtd9SUj
         Bu9BQN+p14QbVKNlRkIqVzJk3MHMRMbd+oHLl0YnS5OP7mh4KUwdZ5BUJD3XzmrPaJxb
         uN7g==
X-Gm-Message-State: AOAM5307dGBs6ZJNBPqhLR0pcT9Aiddvla9dBNEh7/2/jbNm6bBGn6b2
        H4VnSUvp0itPOoaba0SwZLsfujlnvQ==
X-Google-Smtp-Source: ABdhPJw3iiCki6IlU7m1rxI1/D3e8gIWcFUfyjOXBSfZ5zryqeraDoQ2XJLCt9CzAECYRrmd99AhNA==
X-Received: by 2002:a17:906:6406:: with SMTP id d6mr810152ejm.30.1595441671712;
        Wed, 22 Jul 2020 11:14:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810b:f40:e00:922b:34ff:fe38:6455])
        by smtp.googlemail.com with ESMTPSA id x64sm372954edc.95.2020.07.22.11.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 11:14:31 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner=20?= <heiko@sntech.de>
Cc:     Alex Bee <knaerzche@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] drm: rockchip: set alpha_en to 0 if it is not used
Date:   Wed, 22 Jul 2020 20:13:31 +0200
Message-Id: <20200722181332.26995-5-knaerzche@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722181332.26995-1-knaerzche@gmail.com>
References: <20200722181332.26995-1-knaerzche@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alpha_en should be set to 0 if it is not used, i.e. to disable alpha
blending if it was enabled before and should be disabled now.

Fixes: 2aae8ed1f390 ("drm/rockchip: Add per-pixel alpha support for the PX30 VOP")

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---

Changes in v2:
- capitalize "F" of "Fixes" in the commit message

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index c80f7d9fd13f..0f23144491e4 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1013,6 +1013,7 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 		VOP_WIN_SET(vop, win, alpha_en, 1);
 	} else {
 		VOP_WIN_SET(vop, win, src_alpha_ctl, SRC_ALPHA_EN(0));
+		VOP_WIN_SET(vop, win, alpha_en, 0);
 	}
 
 	VOP_WIN_SET(vop, win, enable, 1);
-- 
2.17.1

