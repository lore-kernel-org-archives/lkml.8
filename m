Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059E2C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 18:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23D120714
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 18:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LsfvxAZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbgC1S7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 14:59:32 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:36556 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbgC1S7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 14:59:31 -0400
Received: by mail-pg1-f202.google.com with SMTP id b130so11097697pga.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 11:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RmZqFhOWmJfblEL39xHqmka8Tn/Hx8czxElVow6EI48=;
        b=LsfvxAZTfx0EdEbqJrtv0QvW38sITdabmPyei4aZ2Hy3cyyWY8SsoAvWle9hPf5oDC
         ioejvTsBSCiwQsSjc2tzw9uRHh5zKQM35MiR5Jdej0EAugnnFvynwQezlZKSIaFKf+La
         nIHtqe5HTcqlUdFEb8uGC3sm6xVXOuKjYe9VctUSWq2rT40VMpsnwW1JlzqcHdJ/3ez7
         Iqv4ChmXgPnGbUir4rlt7tTWuh4eaLA4hd2t5DdPvqYnkNloLEfog78LvamAkZV9W4++
         wA5TR4ndSFw18N6W6nDejDarzS/aDW4vxFXuhtAkifBrNPgcvyAUmmDz7Cdr0CFTNk91
         7fOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RmZqFhOWmJfblEL39xHqmka8Tn/Hx8czxElVow6EI48=;
        b=FR9ngBq9i7pXqywqbmuWlQg5FANt+fqatXtstchHaSIGFuwotWKHKbDojmT1AlK8tB
         /q4DJWt6bO6Sh0MzKVJtBTbLRkoYRld7WjE40JcnTwg9iTMMU5hxG/kqhqWwf2T4K4eJ
         obcpTeuBqCb2719Cx9VhgxiUtjYoTYhOJX30J8TY4BQF+nhBcMm7YKvaO4G5hecvg0Hq
         bIku0HVunu9r3ATnKd2oRkCaa9U6oJleyC4zFi2rpqno9AC68AFO2tNUuGJ3kqpCA4Dl
         XtQIhYUvSZRdakeGylWAFGAnuIsoQzex0vyQZ5zp2Z9CGLVUVQfrdBHTYO48FxbOKtx3
         3Ehg==
X-Gm-Message-State: ANhLgQ2E2FVg2BvyzmYrwZHSX2OnW5CfvWTTaLbV3ikXQCrWLorOowMk
        F02PzXnYudlMzuNrqJSP0afpRjknDElD
X-Google-Smtp-Source: ADFU+vuoEMxULA3UhwesqVMltERLeDVP8XgmIuQ9z/hiaou45fh2RQVncRU3HyXUkshQHrnPQy2r2ato9pUj
X-Received: by 2002:a63:4c0b:: with SMTP id z11mr5506572pga.385.1585421969560;
 Sat, 28 Mar 2020 11:59:29 -0700 (PDT)
Date:   Sat, 28 Mar 2020 11:59:14 -0700
In-Reply-To: <20200328185916.98423-1-rajatja@google.com>
Message-Id: <20200328185916.98423-3-rajatja@google.com>
Mime-Version: 1.0
References: <20200328185916.98423-1-rajatja@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v4 3/5] dt-bindings: input/atkbd.txt: Add binding for "function-row-physmap"
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
v4: Same as v3
v3: same as v2
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
2.26.0.rc2.310.g2932bb562d-goog

