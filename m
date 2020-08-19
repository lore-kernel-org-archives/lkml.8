Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDCCC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E3982072D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NabiQ+mu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3FoGRte/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgHSMek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:34:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39074 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbgHSMdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:33:23 -0400
Date:   Wed, 19 Aug 2020 12:33:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597840394;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TsI/rhy/8f4Hvtj1f9EJtnH1VWuaJfzJEaYXJUkvKPw=;
        b=NabiQ+mutOIdWwZYVlexpiQIXKL82EaRWGC6ACY/+bDi5k43x6U1cZuJvXjHb58s3uNNgA
        bFpDFU0/qgju//r9zJoN9I/cSewRvyvhhGRZNFmkGNKQO/3QqVFCiNkFm7Ch/PVTQXEjTe
        hR6cX/1UhB7frc/HDcS+bKvINnHIKh2tVNP1AQNox+omW1P6zUAXGghvD48yMkBiOkmCct
        wsufShjpPW3DeZ3arW57ImZrJhmZGYd76EKdW5FIWx9p1slIZbhZpX23ZrSNxBQtbCxqfl
        NxaheJw7dr5t4HNZxb7x8bi7Fp0L4GpsT4L6fI03CqQvSa0BTgncdMwx4CmnfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597840394;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TsI/rhy/8f4Hvtj1f9EJtnH1VWuaJfzJEaYXJUkvKPw=;
        b=3FoGRte/stjjlzf/Wq5z24QlYjz4m2Qc5HfEV1iJKaXFQE9RaE0O3eKlHFgUeju2mtCA40
        +QQBushohXN9pFBg==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Remove unused struct mbm_state::chunks_bw
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200708163929.2783-2-james.morse@arm.com>
References: <20200708163929.2783-2-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <159784039364.3192.17266951701377723520.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     abe8f12b44250d02937665033a8b750c1bfeb26e
Gitweb:        https://git.kernel.org/tip/abe8f12b44250d02937665033a8b750c1bfeb26e
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 08 Jul 2020 16:39:20 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 18 Aug 2020 16:51:55 +02:00

x86/resctrl: Remove unused struct mbm_state::chunks_bw

Nothing reads struct mbm_states's chunks_bw value, its a copy of
chunks. Remove it.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lkml.kernel.org/r/20200708163929.2783-2-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/internal.h | 2 --
 arch/x86/kernel/cpu/resctrl/monitor.c  | 3 +--
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 5ffa322..72bb210 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -283,7 +283,6 @@ struct rftype {
  * struct mbm_state - status for each MBM counter in each domain
  * @chunks:	Total data moved (multiply by rdt_group.mon_scale to get bytes)
  * @prev_msr	Value of IA32_QM_CTR for this RMID last time we read it
- * @chunks_bw	Total local data moved. Used for bandwidth calculation
  * @prev_bw_msr:Value of previous IA32_QM_CTR for bandwidth counting
  * @prev_bw	The most recent bandwidth in MBps
  * @delta_bw	Difference between the current and previous bandwidth
@@ -292,7 +291,6 @@ struct rftype {
 struct mbm_state {
 	u64	chunks;
 	u64	prev_msr;
-	u64	chunks_bw;
 	u64	prev_bw_msr;
 	u32	prev_bw;
 	u32	delta_bw;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 837d7d0..d6b92d7 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -279,8 +279,7 @@ static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
 		return;
 
 	chunks = mbm_overflow_count(m->prev_bw_msr, tval, rr->r->mbm_width);
-	m->chunks_bw += chunks;
-	m->chunks = m->chunks_bw;
+	m->chunks += chunks;
 	cur_bw = (chunks * r->mon_scale) >> 20;
 
 	if (m->delta_comp)
