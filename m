Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59903C33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267B62080D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="KtFlac/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgAMQSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 11:18:02 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:50246 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728850AbgAMQSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1578932276; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NPnDiCsvTROonMdJKidxb9+nsp++gvayYV31oxzIDVo=;
        b=KtFlac/iVFiTRUORL2X7EuzZccES3e8NcSBvU3Sjayq3k9xEOfFOt8JlQK00Lmr+e4RDCD
        6uMrOAklBvRjdfrStY/r38J6+Aq5rMqZ7haPUp6VSdpcqs8KkYGH94QN8otjbrKVrtASOv
        /pSE0WqvySQREh7VwdO1OV05tkbbTX8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 2/3] dt-bindings: panel-simple: Add compatible for Frida FRD350H54004 LCD
Date:   Mon, 13 Jan 2020 13:17:40 -0300
Message-Id: <20200113161741.32061-2-paul@crapouillou.net>
In-Reply-To: <20200113161741.32061-1-paul@crapouillou.net>
References: <20200113161741.32061-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings documentation for the Frida 3.5" (320x240 pixels) 24-bit
TFT LCD panel.

v2: Switch documentation from plain text to YAML
v3: Simply add new compatible to panel-simple.yaml file instead of
    adding new file

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 8fe60ee2531c..4a8064e31793 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -37,6 +37,8 @@ properties:
       - auo,b116xa01
         # BOE NV140FHM-N49 14.0" FHD a-Si FT panel
       - boe,nv140fhmn49
+        # Frida FRD350H54004 3.5" QVGA TFT LCD panel
+      - frida,frd350h54004
         # GiantPlus GPM940B0 3.0" QVGA TFT LCD panel
       - giantplus,gpm940b0
         # Satoz SAT050AT40H12R2 5.0" WVGA TFT LCD panel
-- 
2.24.1

