Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF7AC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E3A206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qqcbG/Sd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbgAOKMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 05:12:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35716 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729606AbgAOKMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 05:12:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id g17so15127957wro.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 02:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sWr8uUgy0kJm8TRLNh5rzw5SEs7vJsYQ4hnJ+xxpROg=;
        b=qqcbG/Sd6WJ3LNZG2kmclwGUoxBoOEF0z/MomYT4pQReb57EpB4Dbl30Ab7okqMubO
         AiwiUpEnyhTGdfshU5lcI+DL200srdqVPOahHrP4Y0+2I8Sfn8V60scW7K+n6KPSJmwH
         8wI2/HjmOrwsUEg8Z0sJkcBwR9uemDnL7OzM1wQmWEk2WMYzhkrro4t9EVQqFG/akrzK
         TQHSMtCYghj4hnCTusSUcmz8HXaoHB0Snn525QjAflPqa3hwkL6hUlxKyPQtf19PBQvb
         WocJTyRpxqSxL5fp2pZNjEBBnfwk7M2McTMtokj1CtNxVIV4WElHHpbuUvE+m1q1kyhD
         OCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sWr8uUgy0kJm8TRLNh5rzw5SEs7vJsYQ4hnJ+xxpROg=;
        b=Y3XktwluEGXORNfZCQsmKU8pIUGrwBb1J1TVoRMTuMlKgCuObc3k8G0CR+w5yvCN47
         vumdlG90vOp1ejj09ydjwbmu5m1PeqkrvuIwcdNrPOE5Aj+h9uY4WMRxFqWQR+l0KFBy
         IeE0OQ3PK0F6NqPB5hCh08JXxRveyayMbuhSYSX268BWXcnQT7TLnb+G5Ym32lsmQ2Y/
         +XsT4o+t7pTgyyfoabpqtDFGgs79il6FW4KmYT3edOTOSA5cUIcJ4q9uCoRKRi7dhxQs
         dWoOVEfZSX1oP92d/fnEVS9snBW9KyZjJttngWLFhct1DOZaDAxanDa9AFS8tmowlrLp
         pxag==
X-Gm-Message-State: APjAAAVVGRCyfEOe504zL61rjRtSZiq3Yxidy0tqA+rFNN46NBBLo7YO
        Q6zAKaoOfSjs1ci+Z6owgp6wCg==
X-Google-Smtp-Source: APXvYqwk3es76GbViI9iwqiA7Mv42Dn1BSufK8TEk6AOSW8YcdbS4i2kI/hho+ZO1d26iMUx3ckMBg==
X-Received: by 2002:adf:f7c4:: with SMTP id a4mr29610894wrq.332.1579083166487;
        Wed, 15 Jan 2020 02:12:46 -0800 (PST)
Received: from glaroque-ThinkPad-T480.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g7sm23828223wrq.21.2020.01.15.02.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 02:12:45 -0800 (PST)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc:     johan@kernel.org, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, khilman@baylibre.com
Subject: [PATCH v7 1/2] dt-bindings: net: bluetooth: add interrupts properties
Date:   Wed, 15 Jan 2020 11:12:42 +0100
Message-Id: <20200115101243.17094-2-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200115101243.17094-1-glaroque@baylibre.com>
References: <20200115101243.17094-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add interrupts and interrupt-names as optional properties
to support host-wakeup by interrupt properties instead of
host-wakeup-gpios.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 .../devicetree/bindings/net/broadcom-bluetooth.txt         | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
index c44a30dbe43d..dd258674633c 100644
--- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
@@ -23,7 +23,9 @@ Optional properties:
  - max-speed: see Documentation/devicetree/bindings/serial/slave-device.txt
  - shutdown-gpios: GPIO specifier, used to enable the BT module
  - device-wakeup-gpios: GPIO specifier, used to wakeup the controller
- - host-wakeup-gpios: GPIO specifier, used to wakeup the host processor
+ - host-wakeup-gpios: GPIO specifier, used to wakeup the host processor.
+                      deprecated, replaced by interrupts and
+                      "host-wakeup" interrupt-names
  - clocks: 1 or 2 clocks as defined in clock-names below, in that order
  - clock-names: names for clock inputs, matching the clocks given
    - "extclk": deprecated, replaced by "txco"
@@ -37,7 +39,8 @@ Optional properties:
     - pcm-frame-type: short, long
     - pcm-sync-mode: slave, master
     - pcm-clock-mode: slave, master
-
+ - interrupts: must be one, used to wakeup the host processor
+ - interrupt-names: must be "host-wakeup"
 
 Example:
 
-- 
2.17.1

