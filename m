Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0D6C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 20:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F4892071C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 20:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlaHHv8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgCSUBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 16:01:19 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:34859 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgCSUBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 16:01:19 -0400
Received: by mail-qv1-f66.google.com with SMTP id q73so1754822qvq.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 13:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fM16z92SEo1un958VCQNdAKQJnbQVV8LOPBQhvLRoZk=;
        b=QlaHHv8ppA4DqD6kMC29oEyRqsLMTaCPZWlC+i9gmFsUkYUYuWMVX/5UpLbBooF6pB
         V8sImFyRlvmI97sC5I4LZt/uSgSFEwnwY2I1qgM2OK0FTV0sjFMbo0YWC0cD9YU8IbEB
         I9zmC0rdVaWwX0678SSKY2GfPyrhbS4rxKEfz8V1YFwoKI5GQU1A2+0yJx5eSdoexWLr
         sK05lc/HwVLqFQCXdVJMUOlsCnhSPpmst4WtZOdmrw8O8dqi1V5Gk4G9PtaEdLC0VMMG
         6Sh1Z+q4D813dnjJX5N1bcY2rQKPB2oglQsx516PpUHcCnUmwlDDaeKtb7E6g8DJ2R5T
         0B9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fM16z92SEo1un958VCQNdAKQJnbQVV8LOPBQhvLRoZk=;
        b=i7+SdCnuedgO8tE3G/RNBhbFEsrpXoQeLNojh0ZiSm3LhNE3RRr2gU+u+IdGn0JdLi
         dxHjqA75xhgNhX+GLA+kpQ143zEsgEvPF3Sb9SfVomCc4GaocHKp7Ip4eZz1QCX74a1K
         V/Wt3CwSqeMbbf0Gg/oPNaR7s+Qld26bJn/KAPYJKrct0xchoDvqDU7J+pvWPjXv7mXs
         unGCrMcUCbKiOoFtn0xW+6QMJ2vYuQBqYAwsjxOK/NZfUdNpSItsvqHu52JNDcmFckUl
         xcoLHgRt2eg5LrH7sPkXqNK+9EVN55zWb1y3/CrT+VmJ+pJEcwvY7qQqWk4WQ0ljNr8d
         90dQ==
X-Gm-Message-State: ANhLgQ3YVbSPQao8itAHsAhVUbZkP4Ow4FDG/OuPBNbTOxo5DJFROq/1
        YY5o/rMAADKM+3CMm8GXS5g=
X-Google-Smtp-Source: ADFU+vvGqpBYk3EQhzi5Ry5WVZ9gbnjXOvsi7mGw4BTA2K94j4VfKAfGDB6E6Nws8lRjv832Amc92Q==
X-Received: by 2002:a0c:fc43:: with SMTP id w3mr4897359qvp.32.1584648076983;
        Thu, 19 Mar 2020 13:01:16 -0700 (PDT)
Received: from localhost.localdomain ([179.159.236.147])
        by smtp.googlemail.com with ESMTPSA id m67sm2226944qke.101.2020.03.19.13.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 13:01:15 -0700 (PDT)
From:   Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        sumit.semwal@linaro.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Rodrigo.Siqueira@amd.com, rodrigosiqueiramelo@gmail.com,
        andrealmeid@collabora.com,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
Subject: [PATCH v2] drm: Alligne a comment block
Date:   Thu, 19 Mar 2020 17:00:28 -0300
Message-Id: <20200319200028.2096-1-igormtorrente@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a checkpatch warning caused by a misaligned comment block.

Changes in v2:
- Change subject text

Signed-off-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
---
 drivers/gpu/drm/drm_gem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index a9e4a610445a..564acc1f4030 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -222,10 +222,10 @@ drm_gem_object_handle_put_unlocked(struct drm_gem_object *obj)
 		return;
 
 	/*
-	* Must bump handle count first as this may be the last
-	* ref, in which case the object would disappear before we
-	* checked for a name
-	*/
+	 * Must bump handle count first as this may be the last
+	 * ref, in which case the object would disappear before we
+	 * checked for a name
+	 */
 
 	mutex_lock(&dev->object_name_lock);
 	if (--obj->handle_count == 0) {
-- 
2.20.1

