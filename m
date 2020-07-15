Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450B7C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 183992068F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NHRE3Qmc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgGOFX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 01:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgGOFX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 01:23:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8127EC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 22:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=tciRJW/36yu4csWuTfgh0yv4UeiTA/0HzJq70e8Fsh0=; b=NHRE3QmcqQ+ZYKnqffIXqgbtXK
        VnOAO0rX+Yenapjf8nEnGs0jYrBPs3p1cZ/7/sngs0LuV2CXj+edDFYvG/xZa9c48rzr+LJAdIJZY
        RXcIL/mFZOWyDW5lLXR3K/8+zNWgM8rSo+3NcUZ04SOiLaAxdQWzqkGqI/5241rMhmFggveeWYt6Q
        RceJD3dxbroAVE34y5/yCWI0baqnL5A1/yRBsWbdrtnQyO791d3NbH9Y8DPtfZnZWW0FQeD4BQYoy
        cvFMX96y2xEzjM1j00C61WpK43MSd1PwJoTe/R3nj2mu4BCLY+ZzIGGwq+TbfuoHQlFwB0Rmc7Ok+
        Y+ev10rw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvZtb-0006Vd-Lr; Wed, 15 Jul 2020 05:23:56 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 3/7] drm: drm_gem.h: delete duplicated words in comments
Date:   Tue, 14 Jul 2020 22:23:45 -0700
Message-Id: <20200715052349.23319-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200715052349.23319-1-rdunlap@infradead.org>
References: <20200715052349.23319-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the doubled words "the" and "by" in comments.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
---
 include/drm/drm_gem.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200714.orig/include/drm/drm_gem.h
+++ linux-next-20200714/include/drm/drm_gem.h
@@ -143,7 +143,7 @@ struct drm_gem_object_funcs {
 	/**
 	 * @vunmap:
 	 *
-	 * Releases the the address previously returned by @vmap. Used by the
+	 * Releases the address previously returned by @vmap. Used by the
 	 * drm_gem_dmabuf_vunmap() helper.
 	 *
 	 * This callback is optional.
@@ -157,7 +157,7 @@ struct drm_gem_object_funcs {
 	 *
 	 * This callback is optional.
 	 *
-	 * The callback is used by by both drm_gem_mmap_obj() and
+	 * The callback is used by both drm_gem_mmap_obj() and
 	 * drm_gem_prime_mmap().  When @mmap is present @vm_ops is not
 	 * used, the @mmap callback must set vma->vm_ops instead.
 	 */
