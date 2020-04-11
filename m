Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C189C2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2626F21744
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607313;
	bh=TOlzQZqFBlXXk6vVW3nEQ7OnPHurudRh2uEU+6f1lvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=snMbm6O3Ekw+B7pZEQRsvBZa6Iu60ht7QYsjpEQa6Bz8ke3ZsyT36erhZ5Ct1RRnE
	 VFD0q8XdTj2pBjqYZtXpX9Jy8KAYjvUJMA00EZ/Nq0UDK0Q/Ii1EzuhAP48ln8MLJ7
	 tKN9/lka2f/lobt0z5qftIXDbdAoIFmRx/8bx7R8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgDKMPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:15:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbgDKMPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:15:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABF7320692;
        Sat, 11 Apr 2020 12:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607308;
        bh=TOlzQZqFBlXXk6vVW3nEQ7OnPHurudRh2uEU+6f1lvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ner4ZNgcEJDLL6uhIILRhJ7TZZgJSPneX9prSs388UCdtaQMdodPSXrw/3R9GTYVK
         uj2k7vvK3v8ZEnALX4jER1phSDA1k83FWVnrJ6uXgx+5AeEg21E2mtNcYQanF38ExQ
         C4I4r2nV+iwBbzCKydg+irUF7Z7OU2ZBN3sRN2bg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 07/54] drm/bochs: downgrade pci_request_region failure from error to warning
Date:   Sat, 11 Apr 2020 14:08:49 +0200
Message-Id: <20200411115509.052519082@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115508.284500414@linuxfoundation.org>
References: <20200411115508.284500414@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index a39b0343c197d..401c218567af9 100644
--- a/drivers/gpu/drm/bochs/bochs_hw.c
+++ b/drivers/gpu/drm/bochs/bochs_hw.c
@@ -97,10 +97,8 @@ int bochs_hw_init(struct drm_device *dev, uint32_t flags)
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



