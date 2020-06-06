Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CFBC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 14:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E84D7207C4
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 14:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="J41o5AQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgFFO11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 10:27:27 -0400
Received: from mout01.posteo.de ([185.67.36.65]:53748 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbgFFO11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 10:27:27 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 929E516005C
        for <linux-kernel@vger.kernel.org>; Sat,  6 Jun 2020 16:27:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1591453645; bh=4nxpxQrUWni6STaypYRZCfXgD235Nbb9ZEifOwmXI6I=;
        h=From:To:Cc:Subject:Date:From;
        b=J41o5AQfeYKrF+eCdIXC1X4Q7fFBGDuVRijSshR/5HJKUZMIAmgqfKpJXqStPPK8G
         tGRdStu7e44eyfa4ECw32IFVHvSyvzBG9h8V7udejiOcpPd1r9CHmAYT/WXEpcu8HE
         SPsGx53E+Ot0tDdwYTVd1FjoJXz4dadlytpWffwREDT3DXsn7bubk51GL2n3EBUCU+
         TOqZkRLUD8KU7iq223hWQPadmgz0otbcw3B+YXqXJSyPVmrFFCYOD7CZCh5kwQWdcV
         bX4826Rp3uyS3L6K6y2LJJLyd2/YcJuUbkF+E1YZs2N6uxuLybtrZUxH38ZSxvw3Qv
         RIzw92R7x8qVg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 49fMKm4sdDz6tmH;
        Sat,  6 Jun 2020 16:27:24 +0200 (CEST)
From:   Benjamin Thiel <b.thiel@posteo.de>
To:     Borislav Petkov <bp@alien8.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     x86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Benjamin Thiel <b.thiel@posteo.de>
Subject: [PATCH] x86/xen: Fix a -Wmissing prototypes warning for xen_start_kernel()
Date:   Sat,  6 Jun 2020 16:27:21 +0200
Message-Id: <20200606142721.19486-1-b.thiel@posteo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix:

  arch/x86/xen/enlighten_pv.c:1212:34:
  warning: no previous prototype for ‘xen_start_kernel’ [-Wmissing-prototypes]
  asmlinkage __visible void __init xen_start_kernel(void)

Add a prototype for xen_start_kernel() in a separate xen-specific header.

Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>
---
 arch/x86/include/asm/xen/setup.h | 7 +++++++
 arch/x86/xen/enlighten_pv.c      | 1 +
 2 files changed, 8 insertions(+)
 create mode 100644 arch/x86/include/asm/xen/setup.h

diff --git a/arch/x86/include/asm/xen/setup.h b/arch/x86/include/asm/xen/setup.h
new file mode 100644
index 000000000000..b7bd97f4b837
--- /dev/null
+++ b/arch/x86/include/asm/xen/setup.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_XEN_SETUP_H
+#define _ASM_X86_XEN_SETUP_H
+
+asmlinkage __visible void __init xen_start_kernel(void);
+
+#endif /*_ASM_X86_XEN_SETUP_H */
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 35321f4d49f1..dc0850f09c70 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -55,6 +55,7 @@
 #include <asm/xen/hypercall.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/cpuid.h>
+#include <asm/xen/setup.h>
 #include <asm/fixmap.h>
 #include <asm/processor.h>
 #include <asm/proto.h>
-- 
2.20.1

