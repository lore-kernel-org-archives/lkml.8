Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB893C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E05E208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FbYjimOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgCXMfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 08:35:53 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:49345 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbgCXMfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 08:35:53 -0400
Received: by mail-pg1-f201.google.com with SMTP id d124so3626299pgc.16
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 05:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hVHQV/dj3HvNuxis1PdKXEZxW+M5qBzMZyzK/EGMeCk=;
        b=FbYjimOK12I3PtYwelwNdAM2oLqQiMBiW6ebqxTWZSWqK1WLC+1+frlwjsMx9DI0CB
         /yfXTd2ISAw1B9RmhQ2JWRGMh+q5h0RvT2rl8xxYQxy6QKE9UUX7jAGn2q7Hrc3vstib
         Vxo9M9Xjb52PXkfCA0EDImFlAzYoWgv/DOD7q3CbUAIRhTShV3HgYgO3AJ9x1P86gTSw
         eaGh29VpqQpDD8VO/Ty4W3ecqFe73U60Gveu6iqzJigkW8z4DYo6PMi09w2M9zsC+UrZ
         0jwTerdfdH62UUszaOpPEALroapa4mktu665iMT193wZhGKHqm1NY0CSalVcWI6DDnDJ
         r7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hVHQV/dj3HvNuxis1PdKXEZxW+M5qBzMZyzK/EGMeCk=;
        b=gDxFvw2WkfDlXZG+Ma3SZsjtPERxi2ZKJ4LqqnxS5QjckOKvGRobUo8uA+7JasDK7c
         ViICplnVV4Mc0fXDDhI/2fSkabsU6jQ6O0avRlSMWslPHES5EtF0mdFcJ9/Sdw9FaB3u
         Eiqz3XsWW64Z9V0sYoKPk55aPZ1aUMpTlVmq5hDtdVL62lKHOVZmCZWwptQrlVS/crpO
         DWXAxYT3e6FLNO8R/2bOqxW2hQ2B4GPOhPmrSKjITKLE4bgI5+XzjWQ13Su25PWxLq1D
         E4zTMu6V6RAs7mVfui7HLZnp4P10y1P1i41QIKESyohKox6q1iF0hxJk1E2BMWZM4aP8
         AUEw==
X-Gm-Message-State: ANhLgQ0wWmuHrEMClCP09XC8g/P4sP/740zBDWd19x30KJ3KTCy3KnB3
        sCHp3/yNkwNfGM0Trs5xcuumOYwDd8AO
X-Google-Smtp-Source: ADFU+vsjCoKpoZ06ftk7XttqwAP+E9Yftk1Lj/gHqvVXELUNqecE5DCpQGtBz3ovvibLOkGOpmVDNkzSdZyn
X-Received: by 2002:a17:90a:bb92:: with SMTP id v18mr5069386pjr.171.1585053351277;
 Tue, 24 Mar 2020 05:35:51 -0700 (PDT)
Date:   Tue, 24 Mar 2020 05:35:18 -0700
In-Reply-To: <20200324123518.239768-1-rajatja@google.com>
Message-Id: <20200324123518.239768-5-rajatja@google.com>
Mime-Version: 1.0
References: <20200324123518.239768-1-rajatja@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v2 5/5] dt-bindings: input/atkbd.txt: Add binding info for
 "keymap" property
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

Add the info for keymap property that allows firmware to specify the
mapping from physical code to linux keycode, that the kernel should use.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v2: Remove the Change-Id from the commit log

 .../devicetree/bindings/input/atkbd.txt       | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/atkbd.txt b/Documentation/devicetree/bindings/input/atkbd.txt
index 816653eb8e98d..0a0037d70adc8 100644
--- a/Documentation/devicetree/bindings/input/atkbd.txt
+++ b/Documentation/devicetree/bindings/input/atkbd.txt
@@ -6,9 +6,15 @@ Optional properties:
 			An ordered array of the physical codes for the function
 			row keys. Arranged in order from left to right.
 
+	keymap:
+			An array of the u32 entries to specify mapping from the
+			keyboard physcial codes to linux keycodes. The top 16
+			bits of each entry are the physical code, and bottom
+			16 bits are the	linux keycode.
+
 Example:
 
-	This is a sample ACPI _DSD node describing the property:
+	This is a sample ACPI _DSD node describing the properties:
 
         Name (_DSD, Package () {
                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
@@ -29,6 +35,25 @@ Example:
                                         0xAE, /* T12 VOL_DOWN */
                                         0xB0, /* T13 VOL_UP */
                                 }
+                        },
+                        Package () { "keymap",
+                                Package () {
+                                        0xEA009E, /* EA -> KEY_BACK */
+                                        0xE700AD, /* E7 -> KEY_REFRESH */
+                                        0x910174, /* 91 -> KEY_FULL_SCREEN */
+                                        0x920078, /* 92 -> KEY_SCALE */
+                                        0x930280, /* 93 -> 0x280 */
+                                        0x9400E0, /* 94 -> KEY_BRIGHTNESS_DOWN*/
+                                        0x9500E1, /* 95 -> KEY_BRIGHTNESS_UP */
+                                        0x960279, /* 96 -> KEY_PRIVACY_SCRN_TOGGLE*/
+                                        0x9700E5, /* 97 -> KEY_KBDILLUMDOWN */
+                                        0x9800E6, /* 98 -> KEY_KBDILLUMUP */
+                                        0xA00071, /* A0 -> KEY_MUTE */
+                                        0xAE0072, /* AE -> KEY_VOLUMEDOWN */
+                                        0xB00073, /* B0 -> KEY_VOLUMEUP */
+					...
+					<snip other entries>
+                                }
                         }
                 }
         })
-- 
2.25.1.696.g5e7596f4ac-goog

