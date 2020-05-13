Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D998DC2D100
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B27C3208A9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388271AbgEMNdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388189AbgEMNdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:33:46 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9483BC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:33:46 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jYrVq-0003gD-Ll; Wed, 13 May 2020 15:33:30 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id E1937100605; Wed, 13 May 2020 15:33:29 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Balbir Singh <sblbir@amazon.com>, linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, tony.luck@intel.com, keescook@chromium.org,
        benh@kernel.crashing.org, x86@kernel.org, dave.hansen@intel.com,
        thomas.lendacky@amd.com, Balbir Singh <sblbir@amazon.com>
Subject: Re: [PATCH v6 6/6] Documentation: Add L1D flushing Documentation
In-Reply-To: <20200510014803.12190-7-sblbir@amazon.com>
References: <20200510014803.12190-1-sblbir@amazon.com> <20200510014803.12190-7-sblbir@amazon.com>
Date:   Wed, 13 May 2020 15:33:29 +0200
Message-ID: <87r1vo2c46.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh <sblbir@amazon.com> writes:
> +With an increasing number of vulnerabilities being reported around data
> +leaks from L1D, a new user space mechanism to flush the L1D cache on
> +context switch is added to the kernel. This should help address

is added to the kernel? This is documentation of an existing feature...

> +Mitigation
> +----------
> +When PR_SET_L1D_FLUSH is enabled for a task, on switching tasks (when
> +the address space changes), a flush of the L1D cache is performed for
> +the task when it leaves the CPU. If the underlying CPU supports L1D
> +flushing in hardware, the hardware mechanism is used, otherwise a software
> +fallback, similar to the mechanism used by L1TF is used.

This lacks documentation of the limitations, especially that this does
not help against cross Hyperthread attacks.

I've massaged the whole thing a bit. See below.

Thanks,

        tglx
8<-----------------

--- a/Documentation/admin-guide/hw-vuln/index.rst
+++ b/Documentation/admin-guide/hw-vuln/index.rst
@@ -14,3 +14,4 @@ are configurable at compile, boot or run
    mds
    tsx_async_abort
    multihit.rst
+   l1d_flush
--- /dev/null
+++ b/Documentation/admin-guide/hw-vuln/l1d_flush.rst
@@ -0,0 +1,53 @@
+L1D Flushing for the paranoid
+=============================
+
+With an increasing number of vulnerabilities being reported around data
+leaks from the Level 1 Data cache (L1D) the kernel provides an opt-in
+mechanism to flush the L1D cache on context switch.
+
+This mechanism can be used to address e.g. CVE-2020-0550. For paranoid
+applications the mechanism keeps them safe from any yet to be discovered
+vulnerabilities, related to leaks from the L1D cache.
+
+
+Related CVEs
+------------
+At the present moment, the following CVEs can be addressed by this
+mechanism
+
+    =============       ========================     ==================
+    CVE-2020-0550       Improper Data Forwarding     OS related aspects
+    =============       ========================     ==================
+
+Usage Guidelines
+----------------
+Applications can call ``prctl(2)`` with one of these two arguments
+
+1. PR_SET_L1D_FLUSH - flush the L1D cache on context switch (out)
+2. PR_GET_L1D_FLUSH - get the current state of the L1D cache flush, returns 1
+   if set and 0 if not set.
+
+**NOTE**: The feature is disabled by default, applications need to
+specifically opt into the feature to enable it.
+
+Mitigation
+----------
+
+When PR_SET_L1D_FLUSH is enabled for a task a flush of the L1D cache is
+performed when the task is scheduled out and the incoming task belongs to a
+different process and therefore to a different address space.
+
+If the underlying CPU supports L1D flushing in hardware, the hardware
+mechanism is used, otherwise a software fallback, similar to the L1TF
+mitigation, is invoked.
+
+Limitations
+-----------
+
+The mechanism does not mitigate L1D data leaks between tasks belonging to
+different processes which are concurrently executing on sibling threads of
+a physical CPU core when SMT is enabled on the system.
+
+This can be addressed by controlled placement of processes on physical CPU
+cores or by disabling SMT. See the relevant chapter in the L1TF mitigation
+document: :ref:`Documentation/admin-guide/hw-vuln/l1tf.rst <smt_control>`.
