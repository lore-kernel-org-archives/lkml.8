Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42E0C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7D5206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AJBXoxuZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390710AbgDCNbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:31:01 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:46818 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727882AbgDCNbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:31:00 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 416C0C00F7;
        Fri,  3 Apr 2020 13:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1585920659; bh=I+coQQYX8vUxLf/p9XNt7bvLAB6yAwx3gaBMedvAiWI=;
        h=From:To:Cc:Subject:Date:From;
        b=AJBXoxuZrsgXWc01+8942AONmG/bFGHAPowhKHVm3FZVzKDZf3C0Gp/rx10Tociej
         iFxT7uNJP1Q/8k9/gZueOL3SsaIPd2r+txxOokOJrbSJ6Ox9Ad6On5zWmRL9KQ7GZw
         JsgKYieUUjZSyCYarZIKekvMH+1ZW2itUeNLaeLOTtqMj7SlS2nA06sO03y8Yy/lbk
         o9pcYhVdOhr1cF85rOpqF3WTpqhedBLjkdoSWh47EK6y4ofq3AFwJQq/5CQOepO8aH
         yTSonVEuy9qzR9iMunLJaTID7hF4H688netdOwU6NceXnzWHRYfUxRMyKSEoMSIDr8
         sb3pnzLrcFcxg==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 948C3A005B;
        Fri,  3 Apr 2020 13:30:53 +0000 (UTC)
From:   Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>
To:     yannick.fertre@st.com, philippe.cornu@st.com,
        benjamin.gaignard@st.com, airlied@linux.ie, daniel@ffwll.ch,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        dri-devel@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>
Subject: [PATCH] drm/bridge: dw-mipi-dsi.c: remove unused header file
Date:   Fri,  3 Apr 2020 15:30:36 +0200
Message-Id: <171ff1fb3918664a570dc8f2f34b446612505f76.1585832665.git.angelo.ribeiro@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dw-mipi-dsi does not use any definition from drm_probe_helper.

Coverity output:
Event unnecessary_header:
Including .../include/drm/drm_probe_helper.h does not provide any
needed symbols.

Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Jose Abreu <jose.abreu@synopsys.com>
Signed-off-by: Angelo Ribeiro <angelo.ribeiro@synopsys.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index 024acad..582635d 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -27,7 +27,6 @@
 #include <drm/drm_modes.h>
 #include <drm/drm_of.h>
 #include <drm/drm_print.h>
-#include <drm/drm_probe_helper.h>
 
 #define HWVER_131			0x31333100	/* IP version 1.31 */
 
-- 
2.7.4

