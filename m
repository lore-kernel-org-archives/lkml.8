Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B00CC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57BD20675
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7oz6rft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgCJNbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:31:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40250 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbgCJNbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:31:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id p2so15086667wrw.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RoPg/pYX4FGcX/lLbU+K+rHDxbRsiBx9Tndw7mbnSB4=;
        b=V7oz6rft430UpiTzqhHw7x6W4QMiLAcf51mGV0vsYZV9NufJLFcjqLY3cAPBliptgs
         aPcSOukGCB3tFxqqk/MNwSEVWaAJR5mR0DWnxWlqKORPWS167uhJ9tzsIezZTUUm3az1
         Om8dnr4PJBK1UVpCDImGfsMmSG8ii3sfwMLDXwK+M16SgUn30eGpEwztxS+5emgBga9i
         BERy2LdddL6mwJBC18D3Ykc6klY/gGr2vBH+bZtJn1kxqoQZrTRA8A0HGUXilEGw+0Rm
         9OgzMFd24TIw0w4ymDcbv4cv7gpeEujsT8Ul78gsFxlB8i/I3Gw1JNjqKtfNUkvqkd28
         1g8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RoPg/pYX4FGcX/lLbU+K+rHDxbRsiBx9Tndw7mbnSB4=;
        b=AhS93OX3TdfrrA1kV0A0yDEyiLpsuVuVYU0daoCxb8/XavhnB+UApWVXZKFVVRmCds
         3xCykgsHxoSiB9cahkq1zrdnzE5FxAIcQ7HGtnGjwpIHo0KAY/jRZgrI5pIyIprlKE5D
         JdDSaJVxrdOJJktcZlR9P1Icq/1yNUe56omX1y7lKIv84g7wNA9RSmbZB3Vma8DC3IcW
         uRWewU2Z0ZpynuNcIG7A/suanaDkTuqIlbU6cTzIE82P8OFJ/nOhrNlMsUI/v4GXUHd2
         KEOyFoVOXm8gadB00Zct4weFQ4QvMGtbbN+KcFb0VDum75VaqC6r0yasKMGQLRT3SBNz
         h7CA==
X-Gm-Message-State: ANhLgQ0bhGfTc0DlnCm5WGbPfpGMzc01hzbWz46q8rRC+d+CPrIKowAh
        C23D2ToNmh5OFowQIukhWMJBr+TunyQ=
X-Google-Smtp-Source: ADFU+vv6uotQoNEyj1oOp3mfCzDz945g1BQc199VHpzdxA/Ou52xZ4QZVH6ENoJw+Q35b8Djvq5OhQ==
X-Received: by 2002:a05:6000:1186:: with SMTP id g6mr27257446wrx.331.1583847095288;
        Tue, 10 Mar 2020 06:31:35 -0700 (PDT)
Received: from localhost.localdomain ([197.248.222.210])
        by smtp.googlemail.com with ESMTPSA id o7sm14047141wrx.60.2020.03.10.06.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:31:34 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, eric@anholt.net
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 03/17] drm/v3d: make v3d_debugfs_init() return 0
Date:   Tue, 10 Mar 2020 16:31:07 +0300
Message-Id: <20200310133121.27913-4-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310133121.27913-1-wambui.karugax@gmail.com>
References: <20200310133121.27913-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 987d65d01356 (drm: debugfs: make
drm_debugfs_create_files() never fail), drm_debugfs_create_files() never
fails and should return void. Therefore, remove its use as the
return value of v3d_debugfs_init() and have the function return 0
directly instead.

v2: remove conversion of v3d_debugfs_init() to void to avoid build
breakage and enable individual compilation.

References: https://lists.freedesktop.org/archives/dri-devel/2020-February/257183.html
Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/v3d/v3d_debugfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_debugfs.c b/drivers/gpu/drm/v3d/v3d_debugfs.c
index 9e953ce64ef7..57dded6a3957 100644
--- a/drivers/gpu/drm/v3d/v3d_debugfs.c
+++ b/drivers/gpu/drm/v3d/v3d_debugfs.c
@@ -261,7 +261,8 @@ static const struct drm_info_list v3d_debugfs_list[] = {
 int
 v3d_debugfs_init(struct drm_minor *minor)
 {
-	return drm_debugfs_create_files(v3d_debugfs_list,
-					ARRAY_SIZE(v3d_debugfs_list),
-					minor->debugfs_root, minor);
+	drm_debugfs_create_files(v3d_debugfs_list,
+				 ARRAY_SIZE(v3d_debugfs_list),
+				 minor->debugfs_root, minor);
+	return 0;
 }
-- 
2.25.1

