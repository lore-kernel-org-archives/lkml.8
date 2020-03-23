Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BF1C54FD1
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 23:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CED320409
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 23:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FJ96uvPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgCWXpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 19:45:24 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:52090 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbgCWXpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 19:45:22 -0400
Received: by mail-pl1-f201.google.com with SMTP id d4so10706922plr.18
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 16:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=K7VFDU7GlU5U4OxUapn6OgbtnHCUEbg6buPZcCk3EXM=;
        b=FJ96uvPEpHjQNRDWex/xGNOmSvOdt1pxL2MVP9Hn8diPXufsanczI0F9UAwO9HFVTX
         AgDe+k3+hRhAyxWUMmJIrgSJpJ2qMRUI+aGSVuv6dNc+zBRwUg5Ub/YbdtHAw5Un5RXS
         d5IiS9DkmsILyrHWrBDYIIQYUkJgqkBlJtY+XQoXuw1slRWB8/1/uarmnWmyKGSkogFP
         40hGgvrLi0bP4NbCEWZIB5CNNHknbs6EDbY04O1VSXN85uELIroHuGM2ksd0R9YD+KyN
         t832C0CLLfJcotEpZqoGckNiIXDgEuc0Nq6WfXCCNgEqx1JzdFkQyi6xFQV+lzGB0zJA
         fWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=K7VFDU7GlU5U4OxUapn6OgbtnHCUEbg6buPZcCk3EXM=;
        b=En0rdSuvN5vfYIe6pxVT2A9Vyh1PvB7p6v/3wrzPS3rmu9Z74p3i7oEPQiKdMn/lM2
         JjfyaKbaLmEDcRPR/FMRPQi4WCwYWYd9Wjhyfv4CoVd3iaxD1rh1Epxtd7J11gldYP1h
         K9YBnvPOEP5vzC5X36nTbQccHdBER7qB6OD6/ENX9T5+n468rtwXbm2/WFtW8N1VKOWs
         haaGWZ576NM1Vc4ewlk5LDgNppZ0pQ1dQ+C7rkTYgX6noew1NaECdfkQGrNVGq+06moa
         Artwv3EM00JChqsRYXGYZIHvCSvbjuX/cFOIO0lFk/Bmjz8oQ4YRPpmESzcBViyVrYHV
         QUiA==
X-Gm-Message-State: ANhLgQ2JxLBwbHOdCqjeRDBXscv/6hGTyv9PSOllY9AQPK1m9OyD2YyK
        5yQQf9tzd4C8SXUdfuskkJoKjj2rNd/H
X-Google-Smtp-Source: ADFU+vtzNNZ+frS2k2eYn6AUK9rcW4jYx4Hb49mce2tIaK5oiVCnnrj0ZBd2sKY+xjgd7DejcbjvLfReTdBh
X-Received: by 2002:a17:90a:8586:: with SMTP id m6mr1937984pjn.121.1585007121296;
 Mon, 23 Mar 2020 16:45:21 -0700 (PDT)
Date:   Mon, 23 Mar 2020 16:45:05 -0700
In-Reply-To: <20200323234505.226919-1-rajatja@google.com>
Message-Id: <20200323234505.226919-5-rajatja@google.com>
Mime-Version: 1.0
References: <20200323234505.226919-1-rajatja@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH RESEND 5/5] dt-bindings: input/atkbd.txt: Add binding info for
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
Change-Id: I5226fffc048399f003bc30410d5893f5ab24be08
---
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

