Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD5DC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40951206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vdi1FjyD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgGOFYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 01:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgGOFX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 01:23:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48597C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 22:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=W6d2rIfmPgB2Me+j3lzL51vigZ26PwE/oISWnxasd3k=; b=vdi1FjyDet0vrzo7qKoohaC600
        ocUWo/IQxBXughg1N7FllP39wcgVlO3Rty+2FIsrzFBMtFlTN86tEwWJmheg9+ODJTgJvk9iqAB4e
        rAo9k78EhN5tQYh8HREM1OSPouvuGBzctAJTCVzycbYdwZSx3yQeIzdasjQlbu6cAm63J9bu+3G83
        VN+Tg809XxJnCkkQO3ha5M1I0sQb9fdh59JOaj+v6J2dyaWoVsmbyhe5D+/LyEnsLD8GsG9I2/GQG
        EKDMOqt36P1qB1YcmeX8613s+bIrfsNHP4Dur/7zJFoTq7vysbk8v5HRGBkif4e9fJerqHN5hR9nr
        NP1Ot6IA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvZtd-0006Vd-Bq; Wed, 15 Jul 2020 05:23:57 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 4/7] drm: drm_mode_config.h: delete duplicated words in comments
Date:   Tue, 14 Jul 2020 22:23:46 -0700
Message-Id: <20200715052349.23319-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200715052349.23319-1-rdunlap@infradead.org>
References: <20200715052349.23319-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop doubled word "is" in several comments.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
---
 include/drm/drm_mode_config.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-next-20200714.orig/include/drm/drm_mode_config.h
+++ linux-next-20200714/include/drm/drm_mode_config.h
@@ -603,22 +603,22 @@ struct drm_mode_config {
 	struct drm_property *prop_src_h;
 	/**
 	 * @prop_crtc_x: Default atomic plane property for the plane destination
-	 * position in the &drm_crtc is is being shown on.
+	 * position in the &drm_crtc is being shown on.
 	 */
 	struct drm_property *prop_crtc_x;
 	/**
 	 * @prop_crtc_y: Default atomic plane property for the plane destination
-	 * position in the &drm_crtc is is being shown on.
+	 * position in the &drm_crtc is being shown on.
 	 */
 	struct drm_property *prop_crtc_y;
 	/**
 	 * @prop_crtc_w: Default atomic plane property for the plane destination
-	 * position in the &drm_crtc is is being shown on.
+	 * position in the &drm_crtc is being shown on.
 	 */
 	struct drm_property *prop_crtc_w;
 	/**
 	 * @prop_crtc_h: Default atomic plane property for the plane destination
-	 * position in the &drm_crtc is is being shown on.
+	 * position in the &drm_crtc is being shown on.
 	 */
 	struct drm_property *prop_crtc_h;
 	/**
