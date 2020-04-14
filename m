Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E892C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 210372054F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586883447;
	bh=vmk8BTnD6d9Q3knpuyxvc0zR9tED8Zq5ox7CAm6Yye4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PVjkR6VF2zIbFbe1kl0zo/7ZSvHJ6Lm/alpjzKxvpRLdgNlfOWCugG8GApaXgNxmt
	 b5o/QRfOXFxwfMgCDKHoxozBFrYb3ch14KZ4GwZCs3bA7uOw7cVIGP6VnBoWmTTjBm
	 cweLij5Mf8z9a1IuSX0fMQEVYtA5vXLuVDxJHgjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404360AbgDNQ5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:57:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407496AbgDNQtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:07 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 786952087E;
        Tue, 14 Apr 2020 16:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882942;
        bh=vmk8BTnD6d9Q3knpuyxvc0zR9tED8Zq5ox7CAm6Yye4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AH7xfgF556ACrULlpvbiIkSjmGKQBfGfKG8gbNK5h3pJYuzUjp0UinnIKVSo+WrqP
         oxI6iROkHLnVQXplgEaMScSM3ilFWhfoQnETy71pB1OYgIzKYMyho0qTFeCtHBYikL
         Rd/VEWf2fLBeWhFzFrp1/yBNaNXi6baoG2VksgQ0=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOOk8-0068lM-Lm; Tue, 14 Apr 2020 18:49:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v2 06/33] MAINTAINERS: dt: update display/allwinner file entry
Date:   Tue, 14 Apr 2020 18:48:32 +0200
Message-Id: <1be758765272ba4c2acbc3904bdf71c863a90186.1586881715.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586881715.git.mchehab+huawei@kernel.org>
References: <cover.1586881715.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset f5a98bfe7b37 ("dt-bindings: display: Convert Allwinner display pipeline to schemas")
split Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
into several files. Yet, it kept the old place at MAINTAINERS.

Update it to point to the new place.

Fixes: f5a98bfe7b37 ("dt-bindings: display: Convert Allwinner display pipeline to schemas")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db31497..86f98c3e6cfc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5552,7 +5552,7 @@ M:	Chen-Yu Tsai <wens@csie.org>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git git://anongit.freedesktop.org/drm/drm-misc
-F:	Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+F:	Documentation/devicetree/bindings/display/allwinner*
 F:	drivers/gpu/drm/sun4i/
 
 DRM DRIVERS FOR AMLOGIC SOCS
-- 
2.25.2

