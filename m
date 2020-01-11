Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC96C33CA4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 02:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2AB2077C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 02:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgAKCVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 21:21:54 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:45951 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgAKCVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 21:21:53 -0500
X-Originating-IP: 50.39.173.182
Received: from localhost (50-39-173-182.bvtn.or.frontiernet.net [50.39.173.182])
        (Authenticated sender: josh@joshtriplett.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 19A1B240005;
        Sat, 11 Jan 2020 02:21:47 +0000 (UTC)
Date:   Fri, 10 Jan 2020 18:21:45 -0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Arjan van de Ven <arjan@linux.intel.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH] acpi: button: Provide option for power button to directly
 signal init
Message-ID: <20200111022145.GA166025@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Virtual machines and containers often use an ACPI power button event to
tell the machine to shut down gracefully.

Provide an optional, extremely lightweight way to handle this event by
signaling init directly, rather than running a separate daemon (such as
acpid or systemd-logind) that adds to startup time and VM image
complexity.

By default, the power button will continue to notify userspace through
the input layer. With the button.power_signal parameter set, the
power button will instead send the configured signal to init. (For
instance, sending SIGINT will make the power button simulate
ctrl-alt-del.)

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
 drivers/acpi/button.c                           | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ade4e6ec23e0..bbb598e148f4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -450,6 +450,12 @@
 			firmware feature for flushing multiple hpte entries
 			at a time.
 
+	button.power_signal=
+			[ACPI] When the power button is pressed, send this
+			signal number to the init process. If set to 0
+			(default), do not send a signal.
+			Format: integer
+
 	c101=		[NET] Moxa C101 synchronous serial card
 
 	cachesize=	[BUGS=X86-32] Override level 2 CPU cache size detection.
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index b758b45737f5..923259f132d6 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/proc_fs.h>
+#include <linux/sched/signal.h>
 #include <linux/seq_file.h>
 #include <linux/input.h>
 #include <linux/slab.h>
@@ -167,6 +168,10 @@ static unsigned long lid_report_interval __read_mostly = 500;
 module_param(lid_report_interval, ulong, 0644);
 MODULE_PARM_DESC(lid_report_interval, "Interval (ms) between lid key events");
 
+static int power_signal __read_mostly = 0;
+module_param(power_signal, int, 0644);
+MODULE_PARM_DESC(power_signal, "Power button sends this signal to init");
+
 /* --------------------------------------------------------------------------
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
@@ -426,6 +431,12 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
 			if (button->suspended)
 				break;
 
+			if (power_signal
+			    && button->type == ACPI_BUTTON_TYPE_POWER) {
+				kill_cad_pid(power_signal, 1);
+				break;
+			}
+
 			keycode = test_bit(KEY_SLEEP, input->keybit) ?
 						KEY_SLEEP : KEY_POWER;
 			input_report_key(input, keycode, 1);
-- 
2.25.0.rc2

