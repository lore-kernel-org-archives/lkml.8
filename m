Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95BFC33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63952072A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="jTrvQEzM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgAJKGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 05:06:52 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43355 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgAJKGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 05:06:49 -0500
Received: by mail-pf1-f193.google.com with SMTP id x6so892486pfo.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 02:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fshKwfwt9Dp2Wq1APH+4/EX0Jo99Mva81d26eLwAGKU=;
        b=jTrvQEzMTwHn/rWFhNwVM3gC79UFrZ/uuP6zVfefiRKyeh6bVS+DfyZq4ZpMFxAuSe
         1sCkq2WvZGSqXTrGJBG4fDnmxo0m2PVk393Z/TFpNMJfTTiRL9GhM+0SHSxyfubHEOk+
         DyWl6eTdDLnRzPxmZp4oRpXVUzoAnox6e4WERP30vR/ESaDHWvxdNos1OqI/y6eaVUnK
         qwOEgTgZ+jLO/O3SnN/HPWCVZw3gq5uDXZeFHcR5nhr5mLU56KGPZza7wr6AL6pKowR5
         U8uTcXnGClHKTqT3UMes3pza4JtmMH32jHzLMNJ2oNlnfUW9BUHun5Q3OLtVbPDGlceM
         XGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fshKwfwt9Dp2Wq1APH+4/EX0Jo99Mva81d26eLwAGKU=;
        b=CPW69n+oo9sX1sdH4+TnpMvcvDyfBehCw2cptv+f1ihXL4q6TnOJZXT16iyFEAdjW0
         vB5AxVFqt+yB/MM8xTuzP7eRZibUitm/YTcSBQD/FdL3tqvc93jMJQ+c8HahD+svIKEr
         ss2bxvv8y4kSUP7kYUjgzAm4U6KnmU572/MNLbKh1gg+a7/2mmukwIkV2/PzX/Z+2mVM
         +PeDigzLnQyp/pD3yQnwZ5a0wP/ShnZDXWpMA5BaeQNqvd8oV4xMnv+OUvZT8ts42cC3
         ZQB4zwXvkJo1kfIlApnQ82PiMdj0cCwY2PgrLg1UkAxloFD1AgtN4oAIIRLVvR0+l+u/
         yxZQ==
X-Gm-Message-State: APjAAAXERAzjXg/IMXxeBA+YDwV34rvxWbaxgfg8Szc1590nHasEQ8pZ
        Qlx8kjQwE6J0L2GHnmBWYE0M4w==
X-Google-Smtp-Source: APXvYqwLM80h5i/WiPXHqIG/DdJ1TUWK+d+JqiEcoNNkviF23F6YROu6y6DgPL2cKbxCTsnfqsFYxg==
X-Received: by 2002:a63:201d:: with SMTP id g29mr3428289pgg.427.1578650808856;
        Fri, 10 Jan 2020 02:06:48 -0800 (PST)
Received: from libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id q21sm2179039pff.105.2020.01.10.02.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jan 2020 02:06:48 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     pbonzini@redhat.com
Cc:     qemu-devel@nongnu.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, libvir-list@redhat.com,
        mprivozn@redhat.com, yelu@bytedance.com,
        zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 2/2] pvpanic: implement crashloaded event handling
Date:   Fri, 10 Jan 2020 18:06:34 +0800
Message-Id: <20200110100634.491936-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200110100634.491936-1-pizhenwei@bytedance.com>
References: <20200110100634.491936-1-pizhenwei@bytedance.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle bit 1 write, then post event to monitor.

Suggested by Paolo, declear a new event, using GUEST_PANICKED could
cause upper layers to react by shutting down or rebooting the guest.

In advance for extention, add GuestPanicInformation in event message.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 hw/misc/pvpanic.c         | 11 +++++++++--
 include/sysemu/runstate.h |  1 +
 qapi/run-state.json       | 22 +++++++++++++++++++++-
 vl.c                      | 12 ++++++++++++
 4 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index d65ac86478..4ebda7872a 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -21,11 +21,13 @@
 #include "hw/qdev-properties.h"
 #include "hw/misc/pvpanic.h"
 
-/* The bit of supported pv event */
+/* The bit of supported pv event, TODO: include uapi header and remove this */
 #define PVPANIC_F_PANICKED      0
+#define PVPANIC_F_CRASHLOADED   1
 
 /* The pv event value */
 #define PVPANIC_PANICKED        (1 << PVPANIC_F_PANICKED)
+#define PVPANIC_CRASHLOADED     (1 << PVPANIC_F_CRASHLOADED)
 
 #define ISA_PVPANIC_DEVICE(obj)    \
     OBJECT_CHECK(PVPanicState, (obj), TYPE_PVPANIC)
@@ -34,7 +36,7 @@ static void handle_event(int event)
 {
     static bool logged;
 
-    if (event & ~PVPANIC_PANICKED && !logged) {
+    if (event & ~(PVPANIC_PANICKED | PVPANIC_CRASHLOADED) && !logged) {
         qemu_log_mask(LOG_GUEST_ERROR, "pvpanic: unknown event %#x.\n", event);
         logged = true;
     }
@@ -43,6 +45,11 @@ static void handle_event(int event)
         qemu_system_guest_panicked(NULL);
         return;
     }
+
+    if (event & PVPANIC_CRASHLOADED) {
+        qemu_system_guest_crashloaded(NULL);
+        return;
+    }
 }
 
 #include "hw/isa/isa.h"
diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index 0b41555609..f760094858 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -63,6 +63,7 @@ ShutdownCause qemu_reset_requested_get(void);
 void qemu_system_killed(int signal, pid_t pid);
 void qemu_system_reset(ShutdownCause reason);
 void qemu_system_guest_panicked(GuestPanicInformation *info);
+void qemu_system_guest_crashloaded(GuestPanicInformation *info);
 
 #endif
 
diff --git a/qapi/run-state.json b/qapi/run-state.json
index d7477cd715..b7a91f3125 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -357,6 +357,26 @@
   'data': { 'action': 'GuestPanicAction', '*info': 'GuestPanicInformation' } }
 
 ##
+# @GUEST_CRASHLOADED:
+#
+# Emitted when guest OS crash loaded is detected
+#
+# @action: action that has been taken, currently always "run"
+#
+# @info: information about a panic (since 2.9)
+#
+# Since: 5.0
+#
+# Example:
+#
+# <- { "event": "GUEST_CRASHLOADED",
+#      "data": { "action": "run" } }
+#
+##
+{ 'event': 'GUEST_CRASHLOADED',
+  'data': { 'action': 'GuestPanicAction', '*info': 'GuestPanicInformation' } }
+
+##
 # @GuestPanicAction:
 #
 # An enumeration of the actions taken when guest OS panic is detected
@@ -366,7 +386,7 @@
 # Since: 2.1 (poweroff since 2.8)
 ##
 { 'enum': 'GuestPanicAction',
-  'data': [ 'pause', 'poweroff' ] }
+  'data': [ 'pause', 'poweroff', 'run' ] }
 
 ##
 # @GuestPanicInformationType:
diff --git a/vl.c b/vl.c
index 86474a55c9..5b1b2ef095 100644
--- a/vl.c
+++ b/vl.c
@@ -1468,6 +1468,18 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
     }
 }
 
+void qemu_system_guest_crashloaded(GuestPanicInformation *info)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "Guest crash loaded");
+
+    qapi_event_send_guest_crashloaded(GUEST_PANIC_ACTION_RUN,
+                                   !!info, info);
+
+    if (info) {
+        qapi_free_GuestPanicInformation(info);
+    }
+}
+
 void qemu_system_reset_request(ShutdownCause reason)
 {
     if (no_reboot && reason != SHUTDOWN_CAUSE_SUBSYSTEM_RESET) {
-- 
2.11.0

