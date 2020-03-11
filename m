Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BF6C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ECFF20750
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noA+/Z1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbgCKRne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:43:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37678 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730486AbgCKRnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:43:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id a141so3107376wme.2;
        Wed, 11 Mar 2020 10:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2AsgLfDS4BH//bZzgWykwkfl2H5xfBl7A5I1f5MVUhg=;
        b=noA+/Z1EG3yGGgsXsC3y4RHI7uOm1qZ3feLx1mroJlFFWwEH4nPGzOdJY2WeYCDqko
         rfb5yFjjPfD6VFWhKPBS/cGHC6sJ/xh4uKadBsoJE7yhAW8VVNT5OnxXjUxP9NlSZkB6
         V9UFsnuCu25buJPjoWovmUTCGtLIlxBUE9oZTZX9YAyIRWr6g7FDSwNkP3SALevEnjdy
         X08kf2GRkmZ/F6jb9RlouPZAlvA44bxzRj0VROfW3N6OUFCUpzxY6hHBcdKWgk7Bguak
         OoSslOOoA9z0yf3oATpR/5CEB+uk4Z6HQHw0LEJztYZRESj67kK3amEz4RAZ8AiM1EyF
         sdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2AsgLfDS4BH//bZzgWykwkfl2H5xfBl7A5I1f5MVUhg=;
        b=ETFi3PjwCiOxV4ycLcjhViUddAUoPXi20YWzuY3m7EPhSihpVyz0EqrZ9+D+iUeJmt
         rmn3oIc6ICwofhgnz8FEWIARBwO8MAX1bmMkFtm1Yq2jVuKLVoa8NclSZvopEVD/904c
         pDaF7hCtem6Z7tw+hEBRFPADKNyYaAyx8GyMQXrfT6ROwbi7W7zo9G8sakTXdT76P31H
         ywEPwRoponM2NbPq7SFK7VYAlrTDx6bnWl5Ft0ZzVMGvnlLLhuy6Mza0YC9BsZRqs80Q
         bpA16+yGtUXmwqNjaMVYuUk/uc1WE8IpjoMfBOPdDr7lLtCOIpzvz8S6N4LFkj69MNMK
         nVhQ==
X-Gm-Message-State: ANhLgQ1ufDvDm8d6Q4qwFPNJW7ermzzNbhCp5CX84qnyznEwuQRAAsg4
        KIy0zQmGxXMp/lxOApicfk0diHBS
X-Google-Smtp-Source: ADFU+vsGIHuUFLLALx+EZj11W8sJMVfT8mLaq6XyHbUXZwurQL5aYlv5E13r2MsZ4Y6uPYTI1JfqPQ==
X-Received: by 2002:a1c:ab07:: with SMTP id u7mr4521159wme.23.1583948611726;
        Wed, 11 Mar 2020 10:43:31 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id d1sm8933166wrw.52.2020.03.11.10.43.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Mar 2020 10:43:31 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, heiko@sntech.de, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] dt-bindings: sound: rockchip-i2s: add #sound-dai-cells property
Date:   Wed, 11 Mar 2020 18:43:22 +0100
Message-Id: <20200311174322.23813-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200311174322.23813-1-jbx6244@gmail.com>
References: <20200311174322.23813-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'#sound-dai-cells' is required to properly interpret
the list of DAI specified in the 'sound-dai' property,
so add them to 'rockchip-i2s.yaml'

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/sound/rockchip-i2s.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml b/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
index eff06b4b5..7cd0e278e 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
@@ -77,6 +77,9 @@ properties:
       Required property for controllers which support multi channel
       playback/capture.
 
+  "#sound-dai-cells":
+    const: 0
+
 required:
   - compatible
   - reg
@@ -85,6 +88,7 @@ required:
   - clock-names
   - dmas
   - dma-names
+  - "#sound-dai-cells"
 
 additionalProperties: false
 
@@ -103,4 +107,5 @@ examples:
       dma-names = "tx", "rx";
       rockchip,capture-channels = <2>;
       rockchip,playback-channels = <8>;
+      #sound-dai-cells = <0>;
     };
-- 
2.11.0

