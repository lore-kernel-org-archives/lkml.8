Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F13C2D0F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 01:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C4220774
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 01:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cOd197Tc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgC0BdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 21:33:01 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:33823 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgC0Bc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 21:32:59 -0400
Received: by mail-pl1-f202.google.com with SMTP id j8so5884354plk.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 18:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KfX4YhNI554hDVYR+6ARHJ1c92FuwzQbetwUIUbSZaQ=;
        b=cOd197Tc0jF8mPH8KVYwd9hJtOaPM0teR5d/aaVBilfpv2fnQq4VdJ8W2OLD9Wvn7g
         OeBDI3TNzKDHKT3W8qc0eDAr2I3PHdckKRs8YTe7xheYA62F6dUCRHYv+/hzH9B5iTcR
         SnY7GQpHxOxHfQo+NejJhn+Gg4cXCF+UOAucPeeLnSRNWVoTYm9hQSaG5JsS990B2pDd
         9XIYxKRa37roipCiSN1F+//suiCaCII2Hu7nCtoWQBWMuTMhslCozyfRLdp4uSPHD7Du
         12h94o8Z90VphWhaQYP5S01wZwMbZow82nU+GLcU9g9jLqFRD8qhpPtcg4+03NBI+BPu
         wZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KfX4YhNI554hDVYR+6ARHJ1c92FuwzQbetwUIUbSZaQ=;
        b=R6sKK/3f7NTH0lJXmk+xOaUONMSERXlSOyn1eWoouq+wydD4H7sH5bCIJTzV0EshvP
         eKoTI8HQ0HZiECQxc5veigKMW/MO0PAZsXIk1c0Ixz4aMtGlfzrcJB1EodmAakOeEAfp
         Q09ysvcGHUNLXLADgrCr+R6QY5aD8ScTGmOg39S/n6rTk7MegEbRQw5bz/dH3qpVevOZ
         VtMrjxioNWyE+w/zUZevj4L45fs9vwWbVxpSIW+06ZeXuUW/WmVVfE5TKQKtLeyNc24r
         h4oW4AyrK/4DSNAx64sUfTnUuP63jaMuHoY0A05/tCUFvEDGFCEa2/Klkc/ygBMqPpL8
         CS3g==
X-Gm-Message-State: ANhLgQ2kpIyhtEfMOJcbIeOYXVoNhzOXFqDx1ZBHgyAB/tVVTNPQ9E/z
        8003RM8QYwvJPEDUdCCewCl+srkd2h+Z
X-Google-Smtp-Source: ADFU+vvZVBcF8elF8fTvulona4bRznVutDnKtKKl/DFIzMuaGqA1lxuTP7n4DU222Wk5nXojz7mHQMYTa4xt
X-Received: by 2002:a17:90a:e382:: with SMTP id b2mr2952451pjz.83.1585272778333;
 Thu, 26 Mar 2020 18:32:58 -0700 (PDT)
Date:   Thu, 26 Mar 2020 18:32:39 -0700
In-Reply-To: <20200327013239.238182-1-rajatja@google.com>
Message-Id: <20200327013239.238182-5-rajatja@google.com>
Mime-Version: 1.0
References: <20200327013239.238182-1-rajatja@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v3 5/5] dt-bindings: input/atkbd.txt: Add binding info for
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
v3: same as v2
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

