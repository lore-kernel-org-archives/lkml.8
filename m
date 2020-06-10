Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E56C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 12:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAD572072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 12:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="deoySOev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbgFJMBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 08:01:46 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:50350 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728599AbgFJMBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 08:01:42 -0400
IronPort-SDR: J/gN24/4kJBxEitJluGVskRJnfAnmDih90Y0DwLPqEjxutALrF5SM/q1gaqBGWci1K3Fjkp37t
 OgRl1GZ6RzjkmBdqY1jpJNWKNdSVWOC5O6R4sDtNhzH29DYjqtYzRJHLhV9czrvrpjLjCLRza6
 7q3F3bd4hD3fd7ZLZUBEtriWB6Vw1+DJCu4gC9EfESuRpsKEV9Jkk6palhEj6cUc1x1XevO8DZ
 GSgaAyMriU9buQ+1MtmE7K+SBonGs7bpT8HHxgFY7fmyOnezlv+gFCFsnRW1XgtCTu9batpOh6
 HZo=
X-IronPort-AV: E=Sophos;i="5.73,495,1583190000"; 
   d="scan'208";a="12636788"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 10 Jun 2020 14:01:39 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 10 Jun 2020 14:01:39 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 10 Jun 2020 14:01:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1591790499; x=1623326499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=aj/H469Jt70amsuUxn3Zl8xKL2aJcivGiaakRkzzSjg=;
  b=deoySOevSLvQWgCq5cDHpnvMSK9UBgwrWn3kOLsdQDCTIK92tZuhlC5w
   kClwRl/JoToHfbpTKOeKYv+lojUiRPFWL2Mta+M52XzzEadMg8eZyjvl0
   V6NI+Kz2qFjOHLpC1hAAC7NdVsByV2K3GYtHJvzsLVKtO7fNfZfjxgdfA
   I0aTY1HIZM8aRKNs/pBmxKGJrTejbICsq3N7lSNV3/5YWbvJ1k7xxmfKG
   1hIoHyK/voAY9C4uur+kwWwL32E8GOhvCzNjVdoVTRV1iRxDmwV14I/e1
   im5ymosLNL2ni0h0+P6gZdcwWUs7kYCCp+mywB7gwTFZnYmfoZCju61Ki
   A==;
IronPort-SDR: JZeBKhHvGM6ayU5TktaAXaP9iBQsvnkagSSTfwd4mbsTJz09lJxwjfW6Zv1F86bJDqfZ98crCh
 fGlgL0lELqCf/7wzXHxDW9p5OQrqTi2sJQUXw3Dm3AZEt+eUb1kuqEiHFdLe18MZYTpiTN2JJi
 klbSj2Krmo+xBqdbuN8nBTfcLGig7uDj6W3ko7CcdYLajOaP9V9fjB4BTVgIL5zv4+l+ZbQCoi
 iZ7sFKYUGiVePUhl9HqmyLXFaGcLA0rZlpKNvv64h/Ln4oGZQ9jXer0/4Upx6jzzHXRMD7iRzS
 9QY=
X-IronPort-AV: E=Sophos;i="5.73,495,1583190000"; 
   d="scan'208";a="12636786"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 10 Jun 2020 14:01:39 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 65E12280075;
        Wed, 10 Jun 2020 14:01:39 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 1/4] dt-bindings: display: simple: add CDTech S070PWS19HP-FC21 and S070SWV29HG-DC44
Date:   Wed, 10 Jun 2020 14:01:28 +0200
Message-Id: <20200610120131.3069-2-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200610120131.3069-1-matthias.schiffer@ew.tq-group.com>
References: <20200610120131.3069-1-matthias.schiffer@ew.tq-group.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the CDTech Electronics displays S070PWS19HP-FC21 (7.0" WSVGA) and
S070SWV29HG-DC44 (7.0" WVGA) to the panel-simple compatible list.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml       | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index d6cca1479633..7749fbd14c6f 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -81,6 +81,10 @@ properties:
       - boe,nv140fhmn49
         # CDTech(H.K.) Electronics Limited 4.3" 480x272 color TFT-LCD panel
       - cdtech,s043wq26h-ct7
+        # CDTech(H.K.) Electronics Limited 7" WSVGA (1024x600) TFT LCD Panel
+      - cdtech,s070pws19hp-fc21
+        # CDTech(H.K.) Electronics Limited 7" WVGA (800x480) TFT LCD Panel
+      - cdtech,s070swv29hg-dc44
         # CDTech(H.K.) Electronics Limited 7" 800x480 color TFT-LCD panel
       - cdtech,s070wv95-ct16
         # Chunghwa Picture Tubes Ltd. 7" WXGA TFT LCD panel
-- 
2.17.1

