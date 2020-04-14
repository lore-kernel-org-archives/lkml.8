Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE82C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 17:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FC4220678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 17:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586885160;
	bh=obYyiyTbGmR44FhMsbwJlUxtDZYky71vqYd2njr6jms=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=D8xvfb2wfglTJ20hZeS28aspxfMmYQouroGe9Va3zSFIbY+U8N6bcswj3CzBIJNob
	 mW1E3u5rEvyTpeBYZNI7eP3NzHlkS3STe7D5yqnPum5IMBOQF6bdnq20YMHUGUPdsm
	 fl8CXw4gLieYnSj5eSmuFgaMzMmYfbRGMiqBr+54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407692AbgDNRZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 13:25:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407592AbgDNRZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 13:25:53 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D967320678;
        Tue, 14 Apr 2020 17:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586885152;
        bh=obYyiyTbGmR44FhMsbwJlUxtDZYky71vqYd2njr6jms=;
        h=From:To:Cc:Subject:Date:From;
        b=Y5CtSHAXmi8FxInllehx4Q+/hbJorGr7xHnJEh8OrwXaVDRqavymXWjcCkm1uru3O
         1GABxm1dHwFsya56CHvjHERqBhyBAbPb6kTashCxR/FbdjwIwIrK+FOWZFQFIXCr0Z
         oWNdkiHpo0wqWoJxwya4QeXm9f+boK/NKm1jQzHs=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        NeilBrown <neilb@suse.de>, Jessica Yu <jeyu@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] docs: admin-guide: merge sections for the kernel.modprobe sysctl
Date:   Tue, 14 Apr 2020 10:24:30 -0700
Message-Id: <20200414172430.230293-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Documentation for the kernel.modprobe sysctl was added both by
commit 0317c5371e6a ("docs: merge debugging-modules.txt into
sysctl/kernel.rst") and by commit 6e7158250625 ("docs: admin-guide:
document the kernel.modprobe sysctl"), resulting in the same sysctl
being documented in two places.  Merge these into one place.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---

Jon, could you take this through the docs tree as a fix for 5.7?

 Documentation/admin-guide/sysctl/kernel.rst | 47 +++++++++------------
 1 file changed, 19 insertions(+), 28 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 39c95c0e13d30..0d427fd109419 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -390,9 +390,17 @@ When ``kptr_restrict`` is set to 2, kernel pointers printed using
 modprobe
 ========
 
-This gives the full path of the modprobe command which the kernel will
-use to load modules. This can be used to debug module loading
-requests::
+The full path to the usermode helper for autoloading kernel modules,
+by default "/sbin/modprobe".  This binary is executed when the kernel
+requests a module.  For example, if userspace passes an unknown
+filesystem type to mount(), then the kernel will automatically request
+the corresponding filesystem module by executing this usermode helper.
+This usermode helper should insert the needed module into the kernel.
+
+This sysctl only affects module autoloading.  It has no effect on the
+ability to explicitly insert modules.
+
+This sysctl can be used to debug module loading requests::
 
     echo '#! /bin/sh' > /tmp/modprobe
     echo 'echo "$@" >> /tmp/modprobe.log' >> /tmp/modprobe
@@ -400,10 +408,15 @@ requests::
     chmod a+x /tmp/modprobe
     echo /tmp/modprobe > /proc/sys/kernel/modprobe
 
-This only applies when the *kernel* is requesting that the module be
-loaded; it won't have any effect if the module is being loaded
-explicitly using ``modprobe`` from userspace.
+Alternatively, if this sysctl is set to the empty string, then module
+autoloading is completely disabled.  The kernel will not try to
+execute a usermode helper at all, nor will it call the
+kernel_module_request LSM hook.
 
+If CONFIG_STATIC_USERMODEHELPER=y is set in the kernel configuration,
+then the configured static usermode helper overrides this sysctl,
+except that the empty string is still accepted to completely disable
+module autoloading as described above.
 
 modules_disabled
 ================
@@ -446,28 +459,6 @@ Notes:
      successful IPC object allocation. If an IPC object allocation syscall
      fails, it is undefined if the value remains unmodified or is reset to -1.
 
-modprobe:
-=========
-
-The path to the usermode helper for autoloading kernel modules, by
-default "/sbin/modprobe".  This binary is executed when the kernel
-requests a module.  For example, if userspace passes an unknown
-filesystem type to mount(), then the kernel will automatically request
-the corresponding filesystem module by executing this usermode helper.
-This usermode helper should insert the needed module into the kernel.
-
-This sysctl only affects module autoloading.  It has no effect on the
-ability to explicitly insert modules.
-
-If this sysctl is set to the empty string, then module autoloading is
-completely disabled.  The kernel will not try to execute a usermode
-helper at all, nor will it call the kernel_module_request LSM hook.
-
-If CONFIG_STATIC_USERMODEHELPER=y is set in the kernel configuration,
-then the configured static usermode helper overrides this sysctl,
-except that the empty string is still accepted to completely disable
-module autoloading as described above.
-
 nmi_watchdog
 ============
 
-- 
2.26.0.110.g2183baf09c-goog

