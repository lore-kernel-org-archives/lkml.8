Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB520C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3997207BC
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgFAMzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 08:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgFAMzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 08:55:35 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F7CC061A0E;
        Mon,  1 Jun 2020 05:55:35 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jfjyT-0006oZ-SA; Mon, 01 Jun 2020 14:55:29 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5D4431C0244;
        Mon,  1 Jun 2020 14:55:29 +0200 (CEST)
Date:   Mon, 01 Jun 2020 12:55:29 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] xen: Add missing include to hvm_op.h
Cc:     kbuild test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159101612916.17951.7492360776296750785.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     0cfc1b7f2f935584bdd6ef5d9a08a258a16d0a11
Gitweb:        https://git.kernel.org/tip/0cfc1b7f2f935584bdd6ef5d9a08a258a16d0a11
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 01 Jun 2020 14:50:43 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 01 Jun 2020 14:50:43 +02:00

xen: Add missing include to hvm_op.h

hvm_op.h uses domain_t but does not include the header which contains the
typedef:

  include/xen/interface/hvm/hvm_op.h:29:5: error: unknown type name 'domid_t'

Fixes: 28447ea41542 ("xen: Move xen_setup_callback_vector() definition to include/xen/hvm.h")
Reported-by : kbuild test robot <lkp@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/xen/interface/hvm/hvm_op.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/xen/interface/hvm/hvm_op.h b/include/xen/interface/hvm/hvm_op.h
index 956a046..25d945e 100644
--- a/include/xen/interface/hvm/hvm_op.h
+++ b/include/xen/interface/hvm/hvm_op.h
@@ -21,6 +21,8 @@
 #ifndef __XEN_PUBLIC_HVM_HVM_OP_H__
 #define __XEN_PUBLIC_HVM_HVM_OP_H__
 
+#include <xen/interface/xen.h>
+
 /* Get/set subcommands: the second argument of the hypercall is a
  * pointer to a xen_hvm_param struct. */
 #define HVMOP_set_param           0
