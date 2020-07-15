Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAF2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5C6C206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wRO8II/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgGOFX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 01:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgGOFX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 01:23:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB950C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 22:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9IWnFL149DsEdluoFjPRJBomyc71/NwJFJ211eC5iS0=; b=wRO8II/w3mzO+r5WYhZT7LZzmb
        iv9lqJ9NXhnMFxUMyMMNi95Dc6KAPiCfwGQyO59W1z16OXTnTzEahv4xgdsSWD3GpKaCgy9cb0LZ1
        zllukXgRfRksbF8TNpQZ9BBc41CVGnRJjsPtVg5kM43RfvNJQ7WbKKePGJbi8su2un8z2JCvYGpiq
        QfnRYkZSYe2LXM2ysJ4SpHUTmU1M+pfW1r9KJZhSXokv8o9x50ORTeNw1w9Ut8eRoG2U8l63zfrJ7
        bMWvhwcdJtCKx52ZewNQtX5w69wY0NBHYf8LvbbTgfHxK7CbVoqTejk9kDMSPLR/F3wWQ2e6+8+Pm
        NACCPojQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvZtZ-0006Vd-JX; Wed, 15 Jul 2020 05:23:54 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 2/7] drm: drm_bridge.h: delete duplicated word in comment
Date:   Tue, 14 Jul 2020 22:23:44 -0700
Message-Id: <20200715052349.23319-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200715052349.23319-1-rdunlap@infradead.org>
References: <20200715052349.23319-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop doubled word "should" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
---
 include/drm/drm_bridge.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/drm/drm_bridge.h
+++ linux-next-20200714/include/drm/drm_bridge.h
@@ -475,7 +475,7 @@ struct drm_bridge_funcs {
 	 * one of them should be provided.
 	 *
 	 * If drivers need to tweak &drm_bridge_state.input_bus_cfg.flags or
-	 * &drm_bridge_state.output_bus_cfg.flags it should should happen in
+	 * &drm_bridge_state.output_bus_cfg.flags it should happen in
 	 * this function. By default the &drm_bridge_state.output_bus_cfg.flags
 	 * field is set to the next bridge
 	 * &drm_bridge_state.input_bus_cfg.flags value or
