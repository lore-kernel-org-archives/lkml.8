Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B9DC33CA9
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 00:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCCE20880
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 00:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UH7MWGgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731794AbgALAQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 19:16:47 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33492 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731715AbgALAQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 19:16:47 -0500
Received: by mail-wm1-f65.google.com with SMTP id d139so7049281wmd.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jan 2020 16:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TO4ro9G4vD3zIHyJt/0agdTa39l4m1TB7ZW3wf7lrf0=;
        b=UH7MWGgmwpk+vFbDOSAfRRM5C2mVjwsDV1I/lidLxqldDbgNh2mQf1YvA9C/MsU15K
         eSNVEdudBaJL3+6RGJN2DaZN3xbK4vXy5fdslb47DmZYmpER4EKUUIMYxqpmcOntHN1l
         h0OGL18OHKnXe/pn/dS+JeYnlNQ36lO5c+iEAPAm95AnQBFva2HCmFAgf9whFsoL3rPk
         vAP5147OME9RQ3F9CGQP5epoyqVAK/twGXgZIFxRjJM97l6b+4qqcaRMLldmjvfZtp/g
         hTifIsQG74JrK5hFgARq04sLxGb7P2nGygPB1DnFV1tFlija8XeEg34NvACoT25k77PD
         2ThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TO4ro9G4vD3zIHyJt/0agdTa39l4m1TB7ZW3wf7lrf0=;
        b=kc+EvvvZoLarGNad6djq9z1tq4Ex/Ib/d3cVm7Qfgh6yrwWzwr1pluhEz9LZFlQU1o
         rUIb6I334ILzZtvxY6zKgl3tkaDOEBrUxoQUQfXZWMmZHP2irV2uTZ7bog1XaxuSwKMT
         FJD5z6GZ4ti+cupERi3DR9zNBUN9XB5VpGudi9fMJ2TkHCwowreXTJLxlLkpL8r8Kks4
         nOk9DXYoqpc7kp8Orh6SrNc8NFoYhhAfOlMdqcB+KI9gVs4n1H2XT8yev47j55xL5r0b
         TnsozkCT9fwb7uTRHMTxf0j9XaAMWn2iq1XLH0z7JC5mOXV1tdt4Phowt6adDDVkEVAY
         eunw==
X-Gm-Message-State: APjAAAXyLO0mgb8hBQAsE4nkIJqcDHN2d++QBxnQHl/ebLAAT8J1qGsr
        Qhw4uaukTjQWAEOhzoQ57/I=
X-Google-Smtp-Source: APXvYqxwsOHaGPq94M95EVR5OBQt7fgZiB2P/O5Jg9DgUSfO9JLb4kiGFlvW8Na/knMYtda6GHHQNg==
X-Received: by 2002:a05:600c:230d:: with SMTP id 13mr11799060wmo.12.1578788204957;
        Sat, 11 Jan 2020 16:16:44 -0800 (PST)
Received: from localhost.localdomain (p200300F1373A1900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:373a:1900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id h66sm8575535wme.41.2020.01.11.16.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2020 16:16:44 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     dri-devel@lists.freedesktop.org, alyssa@rosenzweig.io,
        steven.price@arm.com, tomeu.vizoso@collabora.com, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        robin.murphy@arm.com, linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org, sudeep.holla@arm.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFT v2 1/3] drm/panfrost: enable devfreq based the "operating-points-v2" property
Date:   Sun, 12 Jan 2020 01:16:21 +0100
Message-Id: <20200112001623.2121227-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200112001623.2121227-1-martin.blumenstingl@googlemail.com>
References: <20200112001623.2121227-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decouple the check to see whether we want to enable devfreq for the GPU
from dev_pm_opp_set_regulators(). This is preparation work for adding
back support for regulator control (which means we need to call
dev_pm_opp_set_regulators() before dev_pm_opp_of_add_table(), which
means having a check for "is devfreq enabled" that is not tied to
dev_pm_opp_of_add_table() makes things easier).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 413987038fbf..1471588763ce 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -5,6 +5,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/clk.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 
 #include "panfrost_device.h"
@@ -79,10 +80,12 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	struct devfreq *devfreq;
 	struct thermal_cooling_device *cooling;
 
-	ret = dev_pm_opp_of_add_table(dev);
-	if (ret == -ENODEV) /* Optional, continue without devfreq */
+	if (!device_property_present(dev, "operating-points-v2"))
+		/* Optional, continue without devfreq */
 		return 0;
-	else if (ret)
+
+	ret = dev_pm_opp_of_add_table(dev);
+	if (ret)
 		return ret;
 
 	panfrost_devfreq_reset(pfdev);
-- 
2.24.1

