Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB13C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455802051A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDrvcQtt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgCQVGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 17:06:05 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36397 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgCQVGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:06:03 -0400
Received: by mail-qk1-f196.google.com with SMTP id u25so35176674qkk.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 14:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vdiK/K3dvfcLjdBU9Aq5+NpRaZi8TfMUsERWtzgU2PQ=;
        b=rDrvcQttb28q0tTTlvqT69dEpcKnrP7/n43mH+rN34dBE4N4qT0eI0FVg+3A8n8L4D
         5nB+dUQMnllx+AJb0sukZ4ybEFYmr+yostsv8qfCOuyeE3a/+JX+qDtEmMhjzfH7dqsM
         mhrwy6kQw51dU41GgWWIDaj1IlIu4JgKT/pFTFdtUKUzAQwsjiOiTffAR2UTSPgdiTeF
         SGRSWCfq5sZUd2QYY+8fZ+CknAsiGkJ+urq5zZnf/LY3uplcbaBjJ/JeMh9AEEN0BV+s
         LqnesuLCrUt6/VHkNobWJqzeUlergomSx+hICPFDCatLACtXeyONlb5HrY8VwCKRGlIB
         1xcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vdiK/K3dvfcLjdBU9Aq5+NpRaZi8TfMUsERWtzgU2PQ=;
        b=F4S5ksqW7+piSYqtsfV1C7rTGOHiwGlVrJA62YOakZl2D8at8Fzwv7Sf6jJKev7FAU
         FUDP4MaVyHo4n7Jw+uFtMrQxwpS8amdwQyxHgUdaOLSC8z/XsP6ZtRS37W9FaWjxQogE
         YZt8PWMXmAOVhHRgknJpN0SnglCAt5XXxD9+bivew5GeMRHGngaM69dI78ujivl2NXCD
         BjhGzO0S64XFhAqPcJyF9XNbkc3HzV+yKkZW5CnxMomfH2ZNZWl336bTdcpQSYec2I6r
         kjZH4Ia7IjIgZJVKIiLhRl0MGLLQocTJjEFYwDsMRH3VIJQ0coDzrW3QWCx+V1nBXMdH
         YYmQ==
X-Gm-Message-State: ANhLgQ2a9fvOIDsXLffPs9zJvxsia8Lu2zi0WcolM4QSe+MhSLfQl9Eo
        8d0evxSlJZn0ubf2V8jWk9E=
X-Google-Smtp-Source: ADFU+vu/MfSxDYIvdrPpn7R600MIh8U0c6YMpF/wV+Xeg2HAChVwbBbQ9wbloHp5NOw/pGzR8JUxmw==
X-Received: by 2002:a05:620a:124d:: with SMTP id a13mr867875qkl.278.1584479162648;
        Tue, 17 Mar 2020 14:06:02 -0700 (PDT)
Received: from localhost.localdomain ([179.159.236.147])
        by smtp.googlemail.com with ESMTPSA id s195sm2696891qke.25.2020.03.17.14.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 14:06:01 -0700 (PDT)
From:   Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        sumit.semwal@linaro.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Rodrigo.Siqueira@amd.com, rodrigosiqueiramelo@gmail.com,
        andrealmeid@collabora.com,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
Subject: [PATCH v2] drm: Correct a typo in a function comment
Date:   Tue, 17 Mar 2020 18:03:39 -0300
Message-Id: <20200317210339.2669-1-igormtorrente@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace "pionter" with "pointer" in the drm_gem_handle_create description.

Changes in v2:
- Change subject text

Signed-off-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
---
 drivers/gpu/drm/drm_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 6e960d57371e..c356379f5e97 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -432,7 +432,7 @@ drm_gem_handle_create_tail(struct drm_file *file_priv,
  * drm_gem_handle_create - create a gem handle for an object
  * @file_priv: drm file-private structure to register the handle for
  * @obj: object to register
- * @handlep: pionter to return the created handle to the caller
+ * @handlep: pointer to return the created handle to the caller
  *
  * Create a handle for this object. This adds a handle reference to the object,
  * which includes a regular reference count. Callers will likely want to
-- 
2.20.1

