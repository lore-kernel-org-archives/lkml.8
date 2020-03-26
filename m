Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AC4C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B74420409
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585265300;
	bh=JZKbPbuU2UHbrb6VuFFKYu3d0IBGpuh9U6WpdN5Q95o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zyzxAz1MwZGZ6AYGjnuQMGQ1nEVjAWYAgdnep4EZOs20Sp1+98LRZm8bQdHJ9exIM
	 pDLurW7eYYbaWVO/RbY3aorkB201Gs5+TFRtNlgsZPE2dXgvoqPGSDLwfDr4ehL1mj
	 BG4SpzknyBskVi24iGU7tbplJRxDa9njk9Snxm0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgCZX2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 19:28:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727885AbgCZXYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 19:24:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89DBD20409;
        Thu, 26 Mar 2020 23:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585265079;
        bh=JZKbPbuU2UHbrb6VuFFKYu3d0IBGpuh9U6WpdN5Q95o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q85PokZ2dhFL2w2cjl+pt4aJsxsGn8rSQqaWZN0Su9jLT7w038vLGmLXxn4iYe8J0
         HqsRRX9+JfHKQp+EGEmIwKmNx7lAYHCxh20AOVFFz5Hxj4VhrBPlZhq4RAJMtRiI5A
         069I/f0J7/hN4SFkIWC+18m8iERA/XG6Zt6NLBis=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, Sam Ravnborg <sam@ravnborg.org>,
        Sasha Levin <sashal@kernel.org>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 06/19] drm/bochs: downgrade pci_request_region failure from error to warning
Date:   Thu, 26 Mar 2020 19:24:18 -0400
Message-Id: <20200326232431.7816-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326232431.7816-1-sashal@kernel.org>
References: <20200326232431.7816-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerd Hoffmann <kraxel@redhat.com>

[ Upstream commit 8c34cd1a7f089dc03933289c5d4a4d1489549828 ]

Shutdown of firmware framebuffer has a bunch of problems.  Because
of this the framebuffer region might still be reserved even after
drm_fb_helper_remove_conflicting_pci_framebuffers() returned.

Don't consider pci_request_region() failure for the framebuffer
region as fatal error to workaround this issue.

Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Link: http://patchwork.freedesktop.org/patch/msgid/20200313084152.2734-1-kraxel@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bochs/bochs_hw.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
index e567bdfa2ab8e..bb1391784caf0 100644
--- a/drivers/gpu/drm/bochs/bochs_hw.c
+++ b/drivers/gpu/drm/bochs/bochs_hw.c
@@ -156,10 +156,8 @@ int bochs_hw_init(struct drm_device *dev)
 		size = min(size, mem);
 	}
 
-	if (pci_request_region(pdev, 0, "bochs-drm") != 0) {
-		DRM_ERROR("Cannot request framebuffer\n");
-		return -EBUSY;
-	}
+	if (pci_request_region(pdev, 0, "bochs-drm") != 0)
+		DRM_WARN("Cannot request framebuffer, boot fb still active?\n");
 
 	bochs->fb_map = ioremap(addr, size);
 	if (bochs->fb_map == NULL) {
-- 
2.20.1

