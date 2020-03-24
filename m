Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84731C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA3220789
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="L7oVu0H7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgCXRTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 13:19:21 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:51400 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727577AbgCXRTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:19:20 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 30661C0F2C;
        Tue, 24 Mar 2020 17:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1585070359; bh=mbYZLHfjTBL/c2ycO3hpQiOnBX1h8x51+xhnJlS8Qrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=L7oVu0H7u1pjUfWkxZsh30YX86ko/gXo8zNkxFHlvbYAl7e6QdkcfW9zn15nG+l00
         3TA/kgZsOrMX1GTa2F5EOCso+M5lEHDc0R7gK0oTD6OQiISN2kOmHH9oapbWJLp2nW
         KnAdVl074BrjhCJEQSD19JNC7xx94lcjrYI868M56EeqU2fZSCalemFFrM771eK+gG
         zjP1oafvRuT5agT5TksM1koEfEjZwdEfdAINSwnQk8hCPcwKejO+gGDN6/Xl//tLrg
         MrPGdWohH8xEcP3KiNFidYrhCVwaQSYnYkwKWyhnWkkS/o/Cr3z3mHtGl6R6oUSCQ+
         Nk2udRR0tr+Jw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id CE2C0A0068;
        Tue, 24 Mar 2020 17:19:16 +0000 (UTC)
From:   Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH 4/4] MAINTAINERS: Add IPK MIPI DSI Host driver entry
Date:   Tue, 24 Mar 2020 18:18:22 +0100
Message-Id: <36986cefc2abfe36ae36cae38438b7c7cb03598d.1585067507.git.angelo.ribeiro@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1585067507.git.angelo.ribeiro@synopsys.com>
References: <cover.1585067507.git.angelo.ribeiro@synopsys.com>
In-Reply-To: <cover.1585067507.git.angelo.ribeiro@synopsys.com>
References: <cover.1585067507.git.angelo.ribeiro@synopsys.com>
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
index 19eea09..3de4365 100644
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

