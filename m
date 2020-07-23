Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A3BC433F2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F17620825
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qsgMou3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgGWMke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgGWMkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:40:33 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0F9C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:40:33 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a24so2943660pfc.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kVohVnfwjLH/vNxjUDzb9bo50R8uLX+J3tnsuaYfcQ8=;
        b=qsgMou3EmMIJ0oQmXJ95lIaUDa34csjQryODt5bBLaLJQfNVEtlVjuMZWwARy9Ui3M
         8mr9FjWYG3WCwfVuo2/sQklNkNASj4jT2C1u2chbcOOvUnKwgl7ZzxME2qu6ptrVCOOl
         DuqiVLNWAAuU2hDJwW9t1ispK9vcI1jPXhlUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kVohVnfwjLH/vNxjUDzb9bo50R8uLX+J3tnsuaYfcQ8=;
        b=r/NmtJBntclUk8DQrlcHq5s4U8Tpux59dTzkK9DoWAh0xuKIhuWIBGvIcImjo+HuVa
         2YT8GIVOY6Ex53s8WE4evVhxC9gTt7DDK5QOW+VS456erTfBMhU09md6Fb6FUJCsAbPZ
         onpSeHLiixXeAExxRelvoon5QXV97Tx6oRY2p6Oc0VeOfuvDjU/69WbFOrtvr+GgMbOC
         GFhKNf3r48cXmYI09b1ED8inb8CqjgZrIqyM4yQEQyXD/SS9IQ8QbtxaZWO+mTpVdSrD
         cHFWD0kiO96dqmjLn/ECHs9XeQeRtsSkqhcXqBlXiW5NkJHg+HTh7tzLpq6VyowG4RRz
         klEg==
X-Gm-Message-State: AOAM533YmB4t4CO+3npdn/h7/7Tj81rj4zz1V8y1xOCHo798/aiVI1IO
        1zxTEIjwBsGc7qPsvjWt5wVeGA==
X-Google-Smtp-Source: ABdhPJwInVHDWAkEuLz1WrQZFyYPuLS+jKB6G8tJGaxV3fmKVEpD75RSE7YXF1VkD7+YXTaK4k462w==
X-Received: by 2002:a63:7cd:: with SMTP id 196mr3921174pgh.230.1595508033163;
        Thu, 23 Jul 2020 05:40:33 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:cbf:ea0:8a30:a3af])
        by smtp.gmail.com with ESMTPSA id m26sm3051270pff.84.2020.07.23.05.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:40:32 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 5/7] dt-bindings: arm: rockchip: Add Engicam PX30.Core C.TOUCH 2.0 10.1" OF
Date:   Thu, 23 Jul 2020 18:09:49 +0530
Message-Id: <20200723123951.149497-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723123951.149497-1-jagan@amarulasolutions.com>
References: <20200723123951.149497-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PX30.Core is an EDIMM SOM based on Rockchip PX30 from Engicam.

C.TOUCH 2.0 10.1" Open Frame is a Carrier board with Capacitive
touch 10.1" open frame from Engicam.

PX30.Core needs to mount on top of this Carrier board for creating
complete PX30.Core C.TOUCH 2.0 10.1" Open Frame.

Add bindings for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 392bdb7042de..910b28dcbe53 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -70,6 +70,12 @@ properties:
           - const: elgin,rv1108-r1
           - const: rockchip,rv1108
 
+      - description: Engicam PX30.Core C.TOUCH 2.0 10.1" Open Frame
+        items:
+          - const: engicam,px30-core-ctouch2-of10
+          - const: engicam,px30-px30-core
+          - const: rockchip,px30
+
       - description: Engicam PX30.Core EDIMM2.2 Starter Kit
         items:
           - const: engicam,px30-core-edimm2.2
-- 
2.25.1

