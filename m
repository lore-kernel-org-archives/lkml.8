Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5589FC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222F92070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340596;
	bh=mER//Xvie/6H/Xs1QdZ3VlSUenuLA157YBjo4JLRCJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VM10rROQum9GXxCUrx1AcRLgcezGu26MbDRcD3aZvAFJym3QLLfb2GuPYXgr40/oC
	 mAHal1MIOStWLZPoTRZYyRKJdVDcXWi8A9i9gfTiCnqBXyrNj0jD1ygCkDlMUkVaPH
	 Rf33qHve7l9bbLqVotCx72IVlmVhOPEOrygmjDSs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbgBJNQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:16:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:33026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729030AbgBJMiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:38:09 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96E192168B;
        Mon, 10 Feb 2020 12:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338288;
        bh=mER//Xvie/6H/Xs1QdZ3VlSUenuLA157YBjo4JLRCJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fv2jler9zCpQGh+Bw2ZJWMJXC7za2yrWMAEnbbc/2uVQ1rCy6eOLUPbZJZ56yqGY6
         6MQ/t0lWDhIVi9ZTJZ3AO7ugVcA17bh58/0fLqdpbnWnjdw052oGlfrEJRplsejk0A
         ZrMjo/z8PoKIfdO5v+R0bRwHAE/FFRHhIgwJJO8w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 5.4 189/309] drm/rect: Avoid division by zero
Date:   Mon, 10 Feb 2020 04:32:25 -0800
Message-Id: <20200210122424.712061540@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 433480c1afd44f3e1e664b85063d98cefeefa0ed upstream.

Check for zero width/height destination rectangle in
drm_rect_clip_scaled() to avoid a division by zero.

Cc: stable@vger.kernel.org
Fixes: f96bdf564f3e ("drm/rect: Handle rounding errors in drm_rect_clip_scaled, v3.")
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Benjamin Gaignard <benjamin.gaignard@st.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Testcase: igt/kms_selftest/drm_rect_clip_scaled_div_by_zero
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20191122175623.13565-2-ville.syrjala@linux.intel.com
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_rect.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/drm_rect.c
+++ b/drivers/gpu/drm/drm_rect.c
@@ -54,7 +54,12 @@ EXPORT_SYMBOL(drm_rect_intersect);
 
 static u32 clip_scaled(u32 src, u32 dst, u32 clip)
 {
-	u64 tmp = mul_u32_u32(src, dst - clip);
+	u64 tmp;
+
+	if (dst == 0)
+		return 0;
+
+	tmp = mul_u32_u32(src, dst - clip);
 
 	/*
 	 * Round toward 1.0 when clipping so that we don't accidentally


