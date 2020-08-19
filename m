Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB057C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9276120738
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="be2lYuaB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hLc6AXKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgHSMer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:34:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39072 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbgHSMdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:33:19 -0400
Date:   Wed, 19 Aug 2020 12:33:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597840393;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qnBhuarp0jMz9NnCOKW9rf6t+I1ZpLqevmTEs+xmh1M=;
        b=be2lYuaBSFv31Elw9d2QOudtY6LeF7jTMNNBO+d+w0oz9wboppLqaxCiUUbKfdHy1zFYE1
        Usc4cKQNsVRGAfoZ69o6Rlum11N0xloQYFFOSV30rzf/Xq945Z5SF29qbomjAQuCbvxh7P
        UivmsU7JmX7eCd7JGz+kfeZDZbd/j52bMAiS8sB4Qg/nt2UUQqh2Q4DAjJap1W1J1M0cXV
        nD0kJ8cUUv1oNtapAtPm7jDdHRPr2noxJ7nU8k1Srk2BND97hM15WIzj8zlPSx8uaEusHO
        TNuM7Bbfk392mZG3AMw37LfMrQcHFaFbGpuksi5+c/KiaLhgUuQc8DeAwYfy2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597840393;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qnBhuarp0jMz9NnCOKW9rf6t+I1ZpLqevmTEs+xmh1M=;
        b=hLc6AXKA0BvZiEreDlaT9ajUWlx7/QIP3yKPvQ4t8xIIVRMBVTf4Za/YWNyrAxgV0R++ot
        rofV69rKqFpWaoBg==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Fix stale comment
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200708163929.2783-4-james.morse@arm.com>
References: <20200708163929.2783-4-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <159784039239.3192.17068659462211591340.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     ae0fbedd2a18cd82a2c0c5605a0a60865bc54576
Gitweb:        https://git.kernel.org/tip/ae0fbedd2a18cd82a2c0c5605a0a60865bc54576
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 08 Jul 2020 16:39:22 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 18 Aug 2020 17:02:24 +02:00

x86/resctrl: Fix stale comment

The comment in rdtgroup_init() refers to the non existent function
rdt_mount(), which has now been renamed rdt_get_tree(). Fix the
comment.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lkml.kernel.org/r/20200708163929.2783-4-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 3f844f1..b044617 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3196,7 +3196,7 @@ int __init rdtgroup_init(void)
 	 * It may also be ok since that would enable debugging of RDT before
 	 * resctrl is mounted.
 	 * The reason why the debugfs directory is created here and not in
-	 * rdt_mount() is because rdt_mount() takes rdtgroup_mutex and
+	 * rdt_get_tree() is because rdt_get_tree() takes rdtgroup_mutex and
 	 * during the debugfs directory creation also &sb->s_type->i_mutex_key
 	 * (the lockdep class of inode->i_rwsem). Other filesystem
 	 * interactions (eg. SyS_getdents) have the lock ordering:
