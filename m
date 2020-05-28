Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08117C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C092089D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMe8pdSM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405466AbgE1RWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 13:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405353AbgE1RWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 13:22:15 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6BCC08C5C6;
        Thu, 28 May 2020 10:22:15 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ci21so3568895pjb.3;
        Thu, 28 May 2020 10:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qcSzY/uymA1q+msx4bjKvFPacUb0/rhanm5U4h595gk=;
        b=EMe8pdSMV3jP/8QdUW1bAa269r+DWPydOCiOdYSSbNToAB/LSZqpWZb67ctpSHC1xG
         hi/t8r2btRhb4U/zmYs4grR/IYHEB4rnlgiZ9Hb7wJp4+xotpWznupRzx+GB9IbMo12s
         i844D61IioYB/xMuOvP2pQWIMnb4ji2p9l5Vy5hmF0bcDIhz2ovrsMH+u0Swju2QDe3U
         a9k73K2WSkqjx5qPNY2o/k6Vq4gsxUzo+DHki6ghCnECL+czNbeCrzK2FOatS4SGJTWi
         cw//UvztdLyYI+1xAlD4GYX+ajNWcb0gMYBnimxVjoRfS3JA5BxG4YJ9QWCfZdYWZRVG
         EQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qcSzY/uymA1q+msx4bjKvFPacUb0/rhanm5U4h595gk=;
        b=VreLcaYnu2UDqMfJqrvcrHU0eE1s9FiCiKvxh2sO65eIb6SyDTedDgzYfRZYEY63R+
         dtSyoIJsofDK20cXJWE6IS+GS+05Y2rMaOAWwpohnXTJqWTqW/lAIcZTHlWH+XaJSlno
         NCQMbq6j6ymkURnaeFfbrZmbuOj75echz/WMOgZeegWiww6K6i/vfr752K6Fx/kJxJ+7
         qWY5DqQ6rLTy3n9eMU4ZD8CzMebhzQAWkxTE3q3NDvXJH2OoIrwHYytFwbUeuTq2yQsv
         tPn1J7OhT8fFhSaPM5aOPvoFRy0QSYQW/1S64A9anWRXOyvLb2OjwdEJ44XepdqN9Tgf
         1myw==
X-Gm-Message-State: AOAM533S+4d5z1nqZgUJIpLl6tSss+s33iglzjBCQiMRWHBjdKPtXvmN
        vGxNwaR0nArPF+oVchdZuqU=
X-Google-Smtp-Source: ABdhPJwMKV6VVQS4lZTjyIbSP9Z+d+mVGjfwC6ZCtmJiJ9eUG74r7/zHGDAoDWr9od9cwTAl4zdIGg==
X-Received: by 2002:a17:902:9a43:: with SMTP id x3mr4567199plv.332.1590686535048;
        Thu, 28 May 2020 10:22:15 -0700 (PDT)
Received: from localhost.localdomain ([61.83.141.141])
        by smtp.gmail.com with ESMTPSA id i11sm5270791pfq.2.2020.05.28.10.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 10:22:14 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Sidong Yang <realwakka@gmail.com>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Fix typo error in todo.rst
Date:   Fri, 29 May 2020 02:21:59 +0900
Message-Id: <20200528172159.24641-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change wrong function name drm_modest_lock_all() to drm_modeset_lock_all()

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 Documentation/gpu/todo.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 658b52f7ffc6..436489b53fea 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -305,7 +305,7 @@ acquire context. Replace the boilerplate code surrounding
 drm_modeset_lock_all_ctx() with DRM_MODESET_LOCK_ALL_BEGIN() and
 DRM_MODESET_LOCK_ALL_END() instead.
 
-This should also be done for all places where drm_modest_lock_all() is still
+This should also be done for all places where drm_modeset_lock_all() is still
 used.
 
 As a reference, take a look at the conversions already completed in drm core.
-- 
2.17.1

