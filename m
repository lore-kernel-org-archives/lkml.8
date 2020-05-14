Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67F1C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B12DD20727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVOaUokL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgENMQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 08:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726050AbgENMQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:16:40 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837AFC061A0C;
        Thu, 14 May 2020 05:16:40 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id f23so1183022pgj.4;
        Thu, 14 May 2020 05:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8psrfxuLJ4TJl2o4vMFKaniWYtduDfiv4RO4VswAsrg=;
        b=bVOaUokLCYXkFYeqHH1OEV25hz4lgjtn3NrokN2C6Rn7s2p2uXiWnKD4bkGL3ZWhX+
         4U/IWnlxdqSjXFSjFSUc3CoUw5hEzO3deTXiBjj3dlQ/xu0EIoJH37StmbJ8CVWrWSWU
         DLFldL8sreksestfVDeWpurmaGyuaRSFySqqebepjGRbUEc3akLu5QR+29idvfUTC29n
         exA+NdktkyWgpbixn3YkjQSR7tMmB2g7SnZnViQ/ZahPVEMi0YNYNi312F2vWpthtWBD
         Fjot1xo8EMN8G7GBToq7yR6FFBeKu4jjcLq4ibMpAY8AmF7bsS3hki9KwYUvtFJi2iAS
         qy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8psrfxuLJ4TJl2o4vMFKaniWYtduDfiv4RO4VswAsrg=;
        b=LCCLSQ0jl+7PB+4vcNg+LmevDLxLj+49G7ox4NSmCa0/Zz0xhYHtHcXmUMYzc9B+ki
         Yno9GZO/I3+tRv4GcEwCx7uE2f3bcSLBZCkkvlqakz+MrW5nODBxJX9YVt0tqAoP5DcK
         Dyxq7WXLu4psNGAMgExonnOLvB5abnVYW7KrJZUI6awAHPngMsvRquWN56XnA/jS+57d
         wNqUM0WkbKXJwruDU9WQwTkSxYXR8Xn4oCt9YYHDwX7LBmPMiadlaS8LQEpHT3olui/k
         dL9+KMlbFd8Mo9lVXKxRoFRy2v2J1eupJ/U8Ebakz3gk9HDvEnFLQlIP/GS/z3NSeSqo
         JLow==
X-Gm-Message-State: AOAM532v2sLuMohAcIHj0v/DBLUNLOe58U5m9MDWErjbhdU87AeIJ591
        iM6ZgkfSkzvL1N8v6jPn754=
X-Google-Smtp-Source: ABdhPJz2p17RSHqQW3n8WMjTtwaHmykfyYXnrgEUQwJ9KTqyeHsLsXjfpqXub/PHt+EivdkDTsGJDA==
X-Received: by 2002:aa7:8bd3:: with SMTP id s19mr4517069pfd.143.1589458600090;
        Thu, 14 May 2020 05:16:40 -0700 (PDT)
Received: from localhost.localdomain ([2001:2d8:eb02:505a:d5fe:3ea6:5791:c8e8])
        by smtp.gmail.com with ESMTPSA id m4sm2216727pfm.26.2020.05.14.05.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 05:16:39 -0700 (PDT)
From:   Steve Lee <steves.lee.maxim@gmail.com>
X-Google-Original-From: Steve Lee <steves.lee@maximintegrated.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ryan.lee.maxim@gmail.com, ryans.lee@maximintegrated.com,
        steves.lee@maximintegrated.com, steves.lee.maxim@gmail.com
Subject: [V4 PATCH 1/2] dt-bindings: Added device tree binding for max98390
Date:   Thu, 14 May 2020 21:16:17 +0900
Message-Id: <20200514121617.8193-1-steves.lee@maximintegrated.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for DT binding of max98390 amplifier driver.

Signed-off-by: Steve Lee <steves.lee@maximintegrated.com>
---

Changed since V3:
	* No changes.
Changed since V2:
	* No changes.
Changed since V1:
	* Modified sample text in example

 .../devicetree/bindings/sound/max98390.txt    | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/max98390.txt

diff --git a/Documentation/devicetree/bindings/sound/max98390.txt b/Documentation/devicetree/bindings/sound/max98390.txt
new file mode 100644
index 000000000000..0ddd4c6ae55e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/max98390.txt
@@ -0,0 +1,26 @@
+Maxim Integrated MAX98390 Speaker Amplifier
+
+This device supports I2C.
+
+Required properties:
+
+ - compatible : "maxim,max98390"
+
+ - reg : the I2C address of the device.
+
+Optional properties:
+
+- maxim,temperature_calib
+  u32. The calculated temperature data was measured while doing the calibration. Data : Temp / 100 * 2^12
+
+- maxim,r0_calib
+  u32. This is r0 calibration data which was measured in factory mode.
+
+Example:
+
+codec: max98390@38 {
+	compatible = "maxim,max98390";
+	reg = <0x38>;
+	maxim,temperature_calib = <1024>;
+	maxim,r0_calib = <100232>;
+};
-- 
2.17.1

