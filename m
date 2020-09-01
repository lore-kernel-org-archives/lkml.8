Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C093AC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92A05206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sWmq658B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="17pyMS9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgIAOyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:54:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39396 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgIALs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:48:27 -0400
Date:   Tue, 01 Sep 2020 11:47:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960873;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d9wop9RHUjCjERWVdTd3kUo7Nmuag7HCI+WHPRHgIjw=;
        b=sWmq658BSYQnvnm+nboWl8P7Rw+a9hTv/JuJKDeQCMBtsmvvYv+Rba/fU12viV/wDiXRG+
        asVexdTsPfL8GWGfov+qVqmsWpSdZRkn5T/rbYZFQywkjsIcJOM6zXYC/xtzhhJFCY620f
        JR3mXriqi0gnBjlajubmKSaFDwCvMcpA4Ck5jiKtTqIIucC5UCkY+i3w5V3h8ngtFs+1GL
        hGOLV733e6bFUwEafKqChO2wsWSM4UIjYKRoQG23GgucGSA1AC1VbgUdedP3HkVXwVJOjj
        kVWGJqLhSBQ4RvATcsWjViAaiOsiEaYOsQlBt91w2k6gLCmolO5Rn4XME09B+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960873;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d9wop9RHUjCjERWVdTd3kUo7Nmuag7HCI+WHPRHgIjw=;
        b=17pyMS9UQOjQt2s75pU94NbSeKzxNyrPOsMmJMnumkXHlb5/aQwldjde/ztNZBBIdSzXyn
        5UFtXy/40qBzU3Ag==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/build] x86/boot/compressed: Add missing debugging sections
 to output
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821194310.3089815-29-keescook@chromium.org>
References: <20200821194310.3089815-29-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <159896087226.20229.1708368825874555559.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/build branch of tip:

Commit-ID:     414d2ff5e5f21049b6b242271a6a8579f9dffc1b
Gitweb:        https://git.kernel.org/tip/414d2ff5e5f21049b6b242271a6a8579f9dffc1b
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Fri, 21 Aug 2020 12:43:09 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 10:03:18 +02:00

x86/boot/compressed: Add missing debugging sections to output

Include the missing DWARF and STABS sections in the compressed image,
when they are present.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200821194310.3089815-29-keescook@chromium.org
---
 arch/x86/boot/compressed/vmlinux.lds.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 02f6feb..112b237 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -69,6 +69,8 @@ SECTIONS
 	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
 	_end = .;
 
+	STABS_DEBUG
+	DWARF_DEBUG
 	ELF_DETAILS
 
 	DISCARDS
