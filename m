Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A53C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8279620734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388594AbgFISKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:10:38 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41344 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388157AbgFISF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 14:05:58 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1jiidG-0001pL-JT; Tue, 09 Jun 2020 19:05:54 +0100
Received: from ben by deadeye with local (Exim 4.94)
        (envelope-from <ben@decadent.org.uk>)
        id 1jiidG-006Vxz-Dc; Tue, 09 Jun 2020 19:05:54 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>
Date:   Tue, 09 Jun 2020 19:04:50 +0100
Message-ID: <lsq.1591725832.909071365@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 59/61] x86/speculation: Add Ivy Bridge to affected list
In-Reply-To: <lsq.1591725831.850867383@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.85-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit 3798cc4d106e91382bfe016caa2edada27c2bb3f upstream.

Make the docs match the code.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 .../hw-vuln/special-register-buffer-data-sampling.rst      | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/Documentation/hw-vuln/special-register-buffer-data-sampling.rst
+++ b/Documentation/hw-vuln/special-register-buffer-data-sampling.rst
@@ -27,6 +27,8 @@ by software using TSX_CTRL_MSR otherwise
   =============  ============  ========
   common name    Family_Model  Stepping
   =============  ============  ========
+  IvyBridge      06_3AH        All
+
   Haswell        06_3CH        All
   Haswell_L      06_45H        All
   Haswell_G      06_46H        All
@@ -37,9 +39,8 @@ by software using TSX_CTRL_MSR otherwise
   Skylake_L      06_4EH        All
   Skylake        06_5EH        All
 
-  Kabylake_L     06_8EH        <=0xC
-
-  Kabylake       06_9EH        <=0xD
+  Kabylake_L     06_8EH        <= 0xC
+  Kabylake       06_9EH        <= 0xD
   =============  ============  ========
 
 Related CVEs

