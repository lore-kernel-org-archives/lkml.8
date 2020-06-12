Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73A2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A20B520801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="X0U0qJ4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgFLHWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 03:22:48 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:36117 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbgFLHWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 03:22:44 -0400
IronPort-SDR: glF5ORSZtnkMy9tnP3ZvWoc5L5CnhqEI7+h0pFfcF5lFVSFI9QmbE0WR0PmEM6o5XGTQpXV/5I
 Iug0NF6D/DywQJrYOdJbPAe5+SOXYa+wnbOUAut021vVRcMTrUzep+ftj/eATR/LGOy+0/eQQc
 HVTWX8V2Fhwkm69X5qg3mKWjQRwYfKrnbHP6iN6uhLaIGcVsOpgihxmXuqXhauX+3HL41iSw8s
 cH2323RK7q0asIgNVaHGP6lJIbNNlOIqtYbuhdtRlunr8GGJP5BNQA+7WlA6SHEgDdnfj7ULN7
 Joc=
X-IronPort-AV: E=Sophos;i="5.73,502,1583190000"; 
   d="scan'208";a="12657244"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 12 Jun 2020 09:22:40 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 12 Jun 2020 09:22:40 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 12 Jun 2020 09:22:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1591946560; x=1623482560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=+2RXMPGnWi9PFwcXzBsGtjQvnkutWbl2BGcACrG6Fe0=;
  b=X0U0qJ4eahre4wH/dsB8o5I+FaNrS6/PFKM/FgKXy6DwiGh1sX+eLD60
   D3fUOaWzI42Sh/R9xjUiW8CimocEUg9R2U1V+UlbDxBp+1Nc43Zj1mAvX
   geG9qF1U/RbhRf9NniXQlo6XvVc7UqCeU/6Bi0vLlqHVsZRFc9LqGGqgZ
   nGUj/S8t6Ht1PGa3h3fmJMEi/hKjiI5PFc/tXz8WIbinqCLWnOMu73VcU
   0060Ugxr47I7NC8Dj3rZK7ntktwDJjpPKQ+/mFpVKzsOD6Wh9e7LDiA+1
   miXH4SqRXAoEr3hvEB6NMN06+3Xtyu11Wq+zCe0Y/u3XZ/2ARBuWRzsab
   Q==;
IronPort-SDR: pAHMaG0K0O+7aGg/nIt1H2ShKR0QZhgS3oA62nB0Y8dqj0U3Jg/plsv7gFEEX1BAHCUWRDyE/r
 av70quZRD69VqxWhu86r3DZGQ9AUalOHqR4+RqNUj7TclABtaUd00m0yTjhHS9bUkqryOeNIgk
 mfqAaWksrHCDuxOycHn/ckkc0si573rq13w4b6U5E1NcvuOQptIjlOZOxPVTLWAwZTSpyWJSKk
 CHd+bHOCTqk38uLBuVmgMNkw57DhJA70eKzFoaXR1Jgjuxr2xJV1l4tYBK1MRVNSXw7pIauEG1
 34U=
X-IronPort-AV: E=Sophos;i="5.73,502,1583190000"; 
   d="scan'208";a="12657243"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 12 Jun 2020 09:22:40 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id A6E47280065;
        Fri, 12 Jun 2020 09:22:40 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH RESEND v2 2/4] dt-bindings: display: simple: add Tianma TM070JVHG33
Date:   Fri, 12 Jun 2020 09:22:17 +0200
Message-Id: <20200612072219.13669-3-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200612072219.13669-1-matthias.schiffer@ew.tq-group.com>
References: <20200612072219.13669-1-matthias.schiffer@ew.tq-group.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Tianma Micro-electronics TM070JVHG33 7.0" WXGA display to the
panel-simple compatible list.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: no changes

 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 2ddb520edc6d..6deeeed59e59 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -251,6 +251,8 @@ properties:
       - starry,kr122ea0sra
         # Tianma Micro-electronics TM070JDHG30 7.0" WXGA TFT LCD panel
       - tianma,tm070jdhg30
+        # Tianma Micro-electronics TM070JVHG33 7.0" WXGA TFT LCD panel
+      - tianma,tm070jvhg33
         # Tianma Micro-electronics TM070RVHG71 7.0" WXGA TFT LCD panel
       - tianma,tm070rvhg71
         # Toshiba 8.9" WXGA (1280x768) TFT LCD panel
-- 
2.17.1

