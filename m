Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61E8C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFB302075B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e+FZ645c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LeesnAIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgHXJsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbgHXIkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:40:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E49C061573;
        Mon, 24 Aug 2020 01:40:40 -0700 (PDT)
Date:   Mon, 24 Aug 2020 08:40:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598258431;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oi/gwlF9UK0Dj6KRXzgzltwh1bdA+sQUViRUrZHY+us=;
        b=e+FZ645cd6LWZaO7VwD/zzo7QB6pxc2qPdp59/DCjgQbWRy01pZhvh6HRG26aXG8wA0y1Y
        dh4UzG9XZB/bfbPpNpos0BW0yt70tpew2rRK7goJrJKV/hUuj1JxkCENj0HTqNVib0c4Au
        qW6MjqHX4Dm6jtFhgkEwKDLpPRMjVoPsv1Xpx9iObrfaBdOMpYuqQouUqWgrgVuaJ6zCS1
        Gpg8F5Jhc3h4nhC9ShjlkihdgGpPuO7dTrCVlXraf0w2b9UZHALom3+bCs4Yhxiv6l5Rg8
        jUkd43dsXtKdhuX2a4cXYiaCnGfSjoEABMZF7v5hfntidl179bFhJS7RjLB/ZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598258431;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oi/gwlF9UK0Dj6KRXzgzltwh1bdA+sQUViRUrZHY+us=;
        b=LeesnAIKOWqiZTpc1slbnxt20lb2DgEyxCGdI7DlF6wLeYyoebq8gowR8XUeF/crZggwoT
        4TIT3dkWg0XgyWCg==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fsgsbase] x86/entry/64: Correct the comment over
 SAVE_AND_SET_GSBASE
Cc:     Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821090710.GE12181@zn.tnic>
References: <20200821090710.GE12181@zn.tnic>
MIME-Version: 1.0
Message-ID: <159825843012.389.11997668879998573740.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/fsgsbase branch of tip:

Commit-ID:     0b2c605fa4ee3117c00b97b7af67791576b28f88
Gitweb:        https://git.kernel.org/tip/0b2c605fa4ee3117c00b97b7af67791576b28f88
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 20 Aug 2020 11:10:15 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 24 Aug 2020 10:23:40 +02:00

x86/entry/64: Correct the comment over SAVE_AND_SET_GSBASE

Add the proper explanation why an LFENCE is not needed in the FSGSBASE
case.

Fixes: c82965f9e530 ("x86/entry/64: Handle FSGSBASE enabled paranoid entry/exit")
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200821090710.GE12181@zn.tnic
---
 arch/x86/entry/entry_64.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 70dea93..bf78de4 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -840,8 +840,9 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 	 * retrieve and set the current CPUs kernel GSBASE. The stored value
 	 * has to be restored in paranoid_exit unconditionally.
 	 *
-	 * The MSR write ensures that no subsequent load is based on a
-	 * mispredicted GSBASE. No extra FENCE required.
+	 * The unconditional write to GS base below ensures that no subsequent
+	 * loads based on a mispredicted GS base can happen, therefore no LFENCE
+	 * is needed here.
 	 */
 	SAVE_AND_SET_GSBASE scratch_reg=%rax save_reg=%rbx
 	ret
