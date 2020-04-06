Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F34C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821C220769
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OdUaNn8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgDFNYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:24:32 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:37542 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728262AbgDFNYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:24:31 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 27286404C3;
        Mon,  6 Apr 2020 13:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1586179471; bh=kO6bVcAz100KA27JSJXzLR1/q1Cun0xk/nxnhMvtHEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=OdUaNn8AWpn3+D0gxKe1APO8OBe4MWXyGjHAWJ4pLwCRSd7I3r4ZP8hy0bh4xYUC3
         Qn/5mQDHROxsvVLJu6QrXyKWCekXPbocBlK3oAFGZ7FAdCfUj41E7cG/MgIBJmOWDH
         XRgg0zL+e1jOTGzCj6ZpiffOR0xPh1FIG+wwj76zbCq1gtT5CYfx51BDd5GdHL8UB5
         F1qi1Uj/JqVN4oivAnuStzCY9Wm8SzmoCmfasEgFYf4qR5lpQRtTeOWZKWoW4D5Hnw
         s5sgiTDc+3VoNCUu1nhiUDItU5HMI+2QmS9LMaMGS9I000pKEb0GFoJZRXsdnnkmhZ
         mlP5fAAUFrUGQ==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id DB0FAA006D;
        Mon,  6 Apr 2020 13:24:28 +0000 (UTC)
From:   Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, Gustavo.Pimentel@synopsys.com,
        Joao.Pinto@synopsys.com
Cc:     Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>
Subject: [PATCH v2 4/4] MAINTAINERS: Add IPK MIPI DSI Host driver entry
Date:   Mon,  6 Apr 2020 15:24:14 +0200
Message-Id: <197608bb7875677a0e61238f0434cc31f37737ba.1586174459.git.angelo.ribeiro@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1586174459.git.angelo.ribeiro@synopsys.com>
References: <cover.1586174459.git.angelo.ribeiro@synopsys.com>
In-Reply-To: <cover.1586174459.git.angelo.ribeiro@synopsys.com>
References: <cover.1586174459.git.angelo.ribeiro@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creates entry for Synopsys DesignWare IPK MIPI DSI host driver and
adds myself as maintainer.

Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Signed-off-by: Angelo Ribeiro <angelo.ribeiro@synopsys.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aff76a7..ffc678e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5445,6 +5445,14 @@ S:	Maintained
 F:	drivers/gpu/drm/mcde/
 F:	Documentation/devicetree/bindings/display/ste,mcde.txt
 
+DRM DRIVER FOR SYNOPSYS DESIGNWARE IPK
+M:	Angelo Ribeiro <angelo.ribeiro@synopsys.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+F:	drivers/gpu/drm/ipk/
+F:	Documentation/devicetree/bindings/display/ipk/
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+
 DRM DRIVER FOR TDFX VIDEO CARDS
 S:	Orphan / Obsolete
 F:	drivers/gpu/drm/tdfx/
-- 
2.7.4

