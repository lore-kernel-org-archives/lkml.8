Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44F3C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA452467E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579194604;
	bh=VEqvj7Y0Mmc3ACabNYSWR3z88ZrthSjokdgjsRhukvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NIbf45INmTk8ZXOqAnjXa1HyYf0XJLEUJU3C95Z+onQevTXLFgOzqOyjg78jmPxHb
	 aVaGGkmq9WM1/5U/EFpdjPCZ+ZGCm8jRJ34r6thierbgk0KN/jOh9Sauqir8XOdpCE
	 Dh7ma7jmphdLIPKVMwsKaJA9uhLG0Sz3u0n6J1mo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389823AbgAPRKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:10:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:46902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389545AbgAPRJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:09:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4E6F2467E;
        Thu, 16 Jan 2020 17:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194595;
        bh=VEqvj7Y0Mmc3ACabNYSWR3z88ZrthSjokdgjsRhukvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gBA6+k/I69ZSXbPEhcA0m6FrYkXBTFlS13YUZWoGP6Wlhzz0xSqyDQ5prV8wG9KhY
         368vlSJbvr63CtALRNqCG9KLAHk63Q9EUh5C9SrGWYWoHxHQu3gkACzxkIPXMOIh0T
         OlxmTP4DJ5z/x2z9GPlq2FZ99pFit+WE5sga/B84=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Thierry Reding <treding@nvidia.com>,
        Sam Ravnborg <sam@ravnborg.org>, Sean Paul <sean@poorly.run>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 465/671] drm/panel: make drm_panel.h self-contained
Date:   Thu, 16 Jan 2020 12:01:43 -0500
Message-Id: <20200116170509.12787-202-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jani Nikula <jani.nikula@intel.com>

[ Upstream commit bf3f5e98559360661a3d2af340d46522512c0b00 ]

Fix build warning if drm_panel.h is built with CONFIG_OF=n or
CONFIG_DRM_PANEL=n and included without the prerequisite err.h:

./include/drm/drm_panel.h: In function ‘of_drm_find_panel’:
./include/drm/drm_panel.h:203:9: error: implicit declaration of function ‘ERR_PTR’ [-Werror=implicit-function-declaration]
  return ERR_PTR(-ENODEV);
         ^~~~~~~
./include/drm/drm_panel.h:203:9: error: returning ‘int’ from a function with return type ‘struct drm_panel *’ makes pointer from integer without a cast [-Werror=int-conversion]
  return ERR_PTR(-ENODEV);
         ^~~~~~~~~~~~~~~~

Fixes: 5fa8e4a22182 ("drm/panel: Make of_drm_find_panel() return an ERR_PTR() instead of NULL")
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Sean Paul <sean@poorly.run>
Cc: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20190718161507.2047-2-sam@ravnborg.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/drm/drm_panel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 777814755fa6..675aa1e876ce 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -24,6 +24,7 @@
 #ifndef __DRM_PANEL_H__
 #define __DRM_PANEL_H__
 
+#include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/list.h>
 
-- 
2.20.1

