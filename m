Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F830C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 23:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A91B21556
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 23:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9nMsiI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgFQXlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 19:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbgFQXlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 19:41:06 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6390C06174E;
        Wed, 17 Jun 2020 16:41:05 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d27so2368482lfq.5;
        Wed, 17 Jun 2020 16:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pAxyB6C7aJlpOxagnpZfk3yhTf/LsEQQa81zSGYW43g=;
        b=B9nMsiI6lfN7t3LM1U/WpG+wTKt7bOM1IpIV2Ix76X0/HY/Yg9Oqqr903PuHP9lFuB
         RTREq0KBfW1XVVxk9rl39YWJtc81FtuhslgD61jto+JyxjrceZVMG+fIAc4Tu1xO3Tx4
         s77pLBWBAOD902doRB8H+zla+jkalMJpQWef2qmIZgwrt/3cQSDnPX1c76cYLzUhQpoX
         IJVVd0dy2t9y0YmOPFQ7NzbrOeidSofir9I//r3ZjzCLl3SGGZlYsgtD8sBOXwBHe0zm
         Wvrx1ON+QOIJYfYXoGWYxgaacVdscXRs1IdH69uaRuJ1a6ORkFtnNGALZ30YzpClomt2
         HMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pAxyB6C7aJlpOxagnpZfk3yhTf/LsEQQa81zSGYW43g=;
        b=lL3BQeZp90tbns/BFURcCSk+9PgXK0/JkjVXM6hsUhA50fWBZI8Z2Xpk0flaDH/hiT
         132h75iixvrFZ/2+JGuQ9mRxiT8bOclwomPmjJ7w45M5qCiAYKsOZImz4Gj6AKFbYARD
         39KTlksi463G+qMVAQc58sHEwGASNiMV5vu4Y2y8luS+v8YhbP6rzhsCU5rDEOv4nwQt
         wATU1JxRCTM17+9eiZ01bADUQGbGzUSdh9KH3IDKo9+N5i3qvlWUldaL6N5i5sXNldkD
         UM/psxxE2EscKBas105ILHNaLwbrXEZsmnvBpEcPcTmd7HNRIV5P/QxuHlor0pIPyI34
         6UyQ==
X-Gm-Message-State: AOAM532xBdVTkCx5xuFPkyjN2F8qHEF9gn5Gk+Q+su6mCX4AUxMBIJKh
        eA4ch7gQbal/Couj/Rn8XcQ=
X-Google-Smtp-Source: ABdhPJz5cDVUwKIFbHJvRRcZm/RgHQl0lqOLx6eYkfTVVUQv765IyixK8lF7EOCan5KXL+JrjhETlQ==
X-Received: by 2002:a05:6512:10c8:: with SMTP id k8mr704401lfg.181.1592437264376;
        Wed, 17 Jun 2020 16:41:04 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id c8sm287871lfc.46.2020.06.17.16.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 16:41:03 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Daniel Stone <daniel@fooishbar.org>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] =?UTF-8?q?drm/tegra:=20plane:=20Support=20180?= =?UTF-8?q?=C2=B0=20rotation?=
Date:   Thu, 18 Jun 2020 02:40:40 +0300
Message-Id: <20200617234040.1094-4-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200617234040.1094-1-digetx@gmail.com>
References: <20200617234040.1094-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Combining horizontal and vertical reflections gives us 180 degrees of
rotation. Both reflection modes are already supported, and thus, we just
need to mark the 180 rotation mode as supported. The 180 rotation mode is
needed for devices like Nexus 7 tablet, which have display panel mounted
upside-down.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index f8149dc3b1b4..1a9a5f8bba34 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -816,6 +816,7 @@ static struct drm_plane *tegra_primary_plane_create(struct drm_device *drm,
 	err = drm_plane_create_rotation_property(&plane->base,
 						 DRM_MODE_ROTATE_0,
 						 DRM_MODE_ROTATE_0 |
+						 DRM_MODE_ROTATE_180 |
 						 DRM_MODE_REFLECT_X |
 						 DRM_MODE_REFLECT_Y);
 	if (err < 0)
@@ -1105,6 +1106,7 @@ static struct drm_plane *tegra_dc_overlay_plane_create(struct drm_device *drm,
 	err = drm_plane_create_rotation_property(&plane->base,
 						 DRM_MODE_ROTATE_0,
 						 DRM_MODE_ROTATE_0 |
+						 DRM_MODE_ROTATE_180 |
 						 DRM_MODE_REFLECT_X |
 						 DRM_MODE_REFLECT_Y);
 	if (err < 0)
-- 
2.26.0

