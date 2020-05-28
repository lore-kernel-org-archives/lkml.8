Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D55C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 503FE214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387658AbgE1KCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 06:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387518AbgE1KCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 06:02:52 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7427FC05BD1E;
        Thu, 28 May 2020 03:02:52 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jeFN9-0003YY-FQ; Thu, 28 May 2020 12:02:47 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A0A5B1C0051;
        Thu, 28 May 2020 12:02:46 +0200 (CEST)
Date:   Thu, 28 May 2020 10:02:46 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] compiler_types.h: Use unoptimized
 __unqual_scalar_typeof for sparse
Cc:     kbuild test robot <lkp@intel.com>, Marco Elver <elver@google.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <202005280727.lXn1VnTw%lkp@intel.com>
References: <202005280727.lXn1VnTw%lkp@intel.com>
MIME-Version: 1.0
Message-ID: <159066016649.17951.6690158443737654165.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/kcsan branch of tip:

Commit-ID:     f05e1242fbb2d149ceaa87310cf67d03fe007a25
Gitweb:        https://git.kernel.org/tip/f05e1242fbb2d149ceaa87310cf67d03fe007a25
Author:        Marco Elver <elver@google.com>
AuthorDate:    Thu, 28 May 2020 09:43:13 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 28 May 2020 11:51:38 +02:00

compiler_types.h: Use unoptimized __unqual_scalar_typeof for sparse

If the file is being checked with sparse, use the unoptimized version of
__unqual_scalar_typeof(), since sparse does not support _Generic.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/202005280727.lXn1VnTw%lkp@intel.com
---
 include/linux/compiler_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index a529fa2..c1ee208 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -246,7 +246,7 @@ struct ftrace_likely_data {
  * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leaving
  *			       non-scalar types unchanged.
  */
-#if defined(CONFIG_CC_IS_GCC) && CONFIG_GCC_VERSION < 40900
+#if (defined(CONFIG_CC_IS_GCC) && CONFIG_GCC_VERSION < 40900) || defined(__CHECKER__)
 /*
  * We build this out of a couple of helper macros in a vain attempt to
  * help you keep your lunch down while reading it.
