Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139B3C3B1A1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FB424680
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="JZRJ4FMP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389049AbgBNQLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:11:36 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.171]:8823 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391042AbgBNQKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:10:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1581696638;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=jlcXe1GGaAraVsZORKSVtw7OXag13VFOYmFZdQixrBw=;
        b=JZRJ4FMP9ZXCuXrDPeTLweGqbpMjbcDGLrGWfZrmP/8UaXOcnSTheRxk6xPiPrEzQ8
        nS54VLuD+QNtqYo32gbUAJCiwQZAdip36T9+60Xj4dRV9+6cZUBeZOKm9CYL/TD7Py4L
        hilDgakghvlnaIGmgJ4UJ5f6yqzfzvcr+4wSKpya5zYQgH8kEJVmq5telkK4S2fJDv8p
        /zUiRdxvdgLEgv7gvwBQylEfIs1TD/xHQliCO1Ozr7tLGwV/37O09HRq4WEyPMpHAAGr
        6tzoF3OZ9IXE65HWqb3KScUWRY55dp6fUf+MpOlnUzfR5GOjTRR5iKrVssPDnOFnM/nV
        AsUg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2M7OMfsfQx3"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 46.1.12 DYNA|AUTH)
        with ESMTPSA id U06217w1EGARFkw
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 14 Feb 2020 17:10:27 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Paul Boddie <paul@boddie.org.uk>,
        Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Andi Kleen <ak@linux.intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Kees Cook <keescook@chromium.org>
Cc:     devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Subject: [PATCH v2 01/12] drm: ingenic-drm: add MODULE_DEVICE_TABLE
Date:   Fri, 14 Feb 2020 17:10:13 +0100
Message-Id: <1b5475c88032b3851c6d33443e688b432af42a9f.1581696624.git.hns@goldelico.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1581696624.git.hns@goldelico.com>
References: <cover.1581696624.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MODULE_DEVICE_TABLE so that the driver can load by
matching the device tree if compiled as module.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gpu/drm/ingenic/ingenic-drm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
index 6d47ef7b148c..d8617096dd8e 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
@@ -844,6 +844,8 @@ static const struct of_device_id ingenic_drm_of_match[] = {
 	{ /* sentinel */ },
 };
 
+MODULE_DEVICE_TABLE(of, ingenic_drm_of_match);
+
 static struct platform_driver ingenic_drm_driver = {
 	.driver = {
 		.name = "ingenic-drm",
-- 
2.23.0

