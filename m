Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB44AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A191C20870
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PGKtJEH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbgCXMfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 08:35:43 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:53668 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbgCXMfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 08:35:43 -0400
Received: by mail-pg1-f201.google.com with SMTP id c33so13429815pgl.20
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 05:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9qa8aAp+bZ6gg3RjZoXrpyNia4xdGEkV4pXAFPahzW4=;
        b=PGKtJEH2E9p0fcB03gDuNWbPXiQ/2waoPhihfZtac0gHwtFY6/Srthu+qCNEaA9hWX
         ZMDCQJbkHXBUeJdiKVFWL6GEKHGRuADWPn1x3IWiQiE69GsV53fMxXoFyaCvKeC6l+he
         +x0H2QwnOypxbtb3WWtcSB4G3hvSBZ6fzOseLpEoNaJb+ozK2cL+XtqvsBthu1M2wOzB
         svB7tDExbTn+kH1naAnmbBMWO2SLH3cW47kfDkXUoKA7lzbfzSg6Y+toJevOADg0gG5G
         S9963zRiHbFOWHS0bO5cRcPwjsQx7VI2Uq0i4OcUS1h0bAl1Pjjt19e0Zict/AZR9kQS
         rzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9qa8aAp+bZ6gg3RjZoXrpyNia4xdGEkV4pXAFPahzW4=;
        b=jZ1ghb5E0Bsat/yQMXvCjnGzS9wcQxkqX4/vjSUvVHbtMiO7j9AJdJNtYRfxBHgL+g
         xcqcUoMQDXkb6dKW7YwCHbZQOu1oEaHwp7wsePeQScLjGUHugT1HiczYJE82KzzYlmli
         q/x+TJQwnT7/rU1qWL5rq9xz5qHG/uLnWbGt8Ey/H6thSzBfqCAPNxacqhxMk596zgBV
         kEyC8q3RSgmthEW9QN72pD4hQX6GW7g2X4TiGEtLatU7BGlgNav00i9J6O8zT/2HZPP8
         NPi7uLT/kJDIRWAYxNYWCoUEbHxYkOIBIrAVj6yuSEa1luo/YKUCXl3WYrbTG+SB2T++
         Gudg==
X-Gm-Message-State: ANhLgQ1IucLwoI532oSvGsTkEvjx28fRN3t+gUocPwU8ldJPoJJr24i7
        hmVsurcgOZIAA4BvFpQhOY8+c7uaCfOS
X-Google-Smtp-Source: ADFU+vsjCf2WCgjHPJYj99N2JWIuBp5ZMQN3hRm0xa06BAW6KPosWLcQBDeNjnYsynKKF8M5UcQ85Nk9wBQJ
X-Received: by 2002:a63:cb:: with SMTP id 194mr27725855pga.37.1585053342203;
 Tue, 24 Mar 2020 05:35:42 -0700 (PDT)
Date:   Tue, 24 Mar 2020 05:35:16 -0700
In-Reply-To: <20200324123518.239768-1-rajatja@google.com>
Message-Id: <20200324123518.239768-3-rajatja@google.com>
Mime-Version: 1.0
References: <20200324123518.239768-1-rajatja@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v2 3/5] dt-bindings: input/atkbd.txt: Add binding for "function-row-physmap"
From:   Rajat Jain <rajatja@google.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@google.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajat Jain <rajatja@google.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, furquan@google.com,
        dlaurie@google.com, bleung@google.com, zentaro@google.com,
        dbehr@google.com
Cc:     rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create the documentation for the new introduced property, that
describes the function-row keys physical positions.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v2: Remove the Change-Id from the commit log

 .../devicetree/bindings/input/atkbd.txt       | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/atkbd.txt

diff --git a/Documentation/devicetree/bindings/input/atkbd.txt b/Documentation/devicetree/bindings/input/atkbd.txt
new file mode 100644
index 0000000000000..816653eb8e98d
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/atkbd.txt
@@ -0,0 +1,34 @@
+Device tree bindings for AT / PS2 keyboard device
+
+Optional properties:
+
+	function-row-physmap:
+			An ordered array of the physical codes for the function
+			row keys. Arranged in order from left to right.
+
+Example:
+
+	This is a sample ACPI _DSD node describing the property:
+
+        Name (_DSD, Package () {
+                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+                Package () {
+                        Package () { "function-row-physmap",
+                                Package () {
+                                        0xEA, /* T1 BACK */
+                                        0xE7, /* T2 REFRESH */
+                                        0x91, /* T3 FULLSCREEN */
+                                        0x92, /* T4 SCALE */
+                                        0x93, /* T5 SNIP */
+                                        0x94, /* T6 BRIGHTNESS_DOWN */
+                                        0x95, /* T7 BRIGHTNESS_UP */
+                                        0x96, /* T8 PRIVACY_SCRN_TOGGLE */
+                                        0x97, /* T9 KBD_BKLIGHT_DOWN */
+                                        0x98, /* T10 KBD_BKLIGHT_UP */
+                                        0xA0, /* T11 VOL_MUTE */
+                                        0xAE, /* T12 VOL_DOWN */
+                                        0xB0, /* T13 VOL_UP */
+                                }
+                        }
+                }
+        })
-- 
2.25.1.696.g5e7596f4ac-goog

