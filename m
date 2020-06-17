Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C2AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A88C8206E2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgFQIax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 04:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgFQIaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 04:30:52 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53801C061573;
        Wed, 17 Jun 2020 01:30:52 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlTSy-0004br-Jm; Wed, 17 Jun 2020 10:30:40 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1C1971C0089;
        Wed, 17 Jun 2020 10:30:40 +0200 (CEST)
Date:   Wed, 17 Jun 2020 08:30:39 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] compiler_attributes.h: Support no_sanitize_undefined
 check with GCC 4
Cc:     kernel test robot <lkp@intel.com>, Marco Elver <elver@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200615231529.GA119644@google.com>
References: <20200615231529.GA119644@google.com>
MIME-Version: 1.0
Message-ID: <159238263982.16989.12249907300190284430.tip-bot2@tip-bot2>
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

Commit-ID:     33aea07f30c261eff7ba229f19fd1b161e0fb851
Gitweb:        https://git.kernel.org/tip/33aea07f30c261eff7ba229f19fd1b161e0fb851
Author:        Marco Elver <elver@google.com>
AuthorDate:    Tue, 16 Jun 2020 01:15:29 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 16 Jun 2020 15:35:02 +02:00

compiler_attributes.h: Support no_sanitize_undefined check with GCC 4

UBSAN is supported since GCC 4.9, which unfortunately did not yet have
__has_attribute(). To work around, the __GCC4_has_attribute workaround
requires defining which compiler version supports the given attribute.

In the case of no_sanitize_undefined, it is the first version that
supports UBSAN, which is GCC 4.9.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Link: https://lkml.kernel.org/r/20200615231529.GA119644@google.com
---
 include/linux/compiler_attributes.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index cdf0165..c8f03d2 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -40,6 +40,7 @@
 # define __GCC4_has_attribute___noclone__             1
 # define __GCC4_has_attribute___nonstring__           0
 # define __GCC4_has_attribute___no_sanitize_address__ (__GNUC_MINOR__ >= 8)
+# define __GCC4_has_attribute___no_sanitize_undefined__ (__GNUC_MINOR__ >= 9)
 # define __GCC4_has_attribute___fallthrough__         0
 #endif
 
