Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F719C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD7520786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d6Lha3Xz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OtFhfHHE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgH0H5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:57:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36564 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbgH0Hy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:26 -0400
Date:   Thu, 27 Aug 2020 07:54:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514864;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9YqiSaCnS2KOqPvA9P2XCB7kGgE8cJkDykwBkGMJQQE=;
        b=d6Lha3XzlJ0W2WF6UyVkFMxhU1J5B2dGZysIfXYRd5dXN5+smxaWZasC4kvdTSEg017f5V
        +6kRpbWxmtAhtu0FI4bGVFdIILj6EiCZb9rLi7yKrM972dopfxyLdI4oUEY7JWkcw6Cl6V
        H7qzB74fZ/Ce8VGdKYasVmnADdBWeqSNkMzkE31Iy2GEpgxFk223pkG+8KPcepMkJyW+2I
        4SiLBPqMFrYCkCFmwz8zC03mwrQDC123Ius6ZFKDK+0LYFROwXCkv2wEhlALzqx8XRBMFw
        gCR3xA+mtHiiCymh7G7Y/uujzBHS0xwFCLwTqLMIMiF96Y6Ac0yQnOTmX7ZG8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514864;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9YqiSaCnS2KOqPvA9P2XCB7kGgE8cJkDykwBkGMJQQE=;
        b=OtFhfHHEBNYBhXTkBfThAKEYlIOgDGoGbODPV+naEdiYYPlpEI5DIA9sigXC38yPoq9Cm2
        oVUKuVjBtzAkpiDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqlock,tags: Add support for SEQCOUNT_LOCKTYPE()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200729161938.GB2678@hirez.programming.kicks-ass.net>
References: <20200729161938.GB2678@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <159851486396.20229.12728013017338610822.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     6eb6d05958f3208b3dd2b5311f1a6e68abdbe5d5
Gitweb:        https://git.kernel.org/tip/6eb6d05958f3208b3dd2b5311f1a6e68abdbe5d5
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 29 Jul 2020 20:12:32 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:42:01 +02:00

seqlock,tags: Add support for SEQCOUNT_LOCKTYPE()

Such that we might easily find seqcount_LOCKTYPE_t and
seqcount_LOCKTYPE_init().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200729161938.GB2678@hirez.programming.kicks-ass.net
---
 scripts/tags.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index 32d3f53..fc5b532 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -201,6 +201,8 @@ regex_c=(
 	'/\<DEVICE_ATTR_\(RW\|RO\|WO\)(\([[:alnum:]_]\+\)/dev_attr_\2/'
 	'/\<DRIVER_ATTR_\(RW\|RO\|WO\)(\([[:alnum:]_]\+\)/driver_attr_\2/'
 	'/\<\(DEFINE\|DECLARE\)_STATIC_KEY_\(TRUE\|FALSE\)\(\|_RO\)(\([[:alnum:]_]\+\)/\4/'
+	'/^SEQCOUNT_LOCKTYPE(\([^,]*\),[[:space:]]*\([^,]*\),[^)]*)/seqcount_\2_t/'
+	'/^SEQCOUNT_LOCKTYPE(\([^,]*\),[[:space:]]*\([^,]*\),[^)]*)/seqcount_\2_init/'
 )
 regex_kconfig=(
 	'/^[[:blank:]]*\(menu\|\)config[[:blank:]]\+\([[:alnum:]_]\+\)/\2/'
