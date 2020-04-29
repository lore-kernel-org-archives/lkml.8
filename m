Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7362C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2A2D2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X0VPNF/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgD2KV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgD2KV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 06:21:28 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFB0C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 03:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z5HLrL3i5i8JIG6fwC9yLl6toRI1qYlpF8k6Gl2JT8Q=; b=X0VPNF/W1alR4AoFIzdkm2Xhe/
        AZVuh9xdiE7TAQ6nznqpRGpvoK0pQbN0En6ZMYrat/lLF935iI0OepakqNmXX4Bqi3UBh233rvfrj
        j+vhhvkUZCArKc2r4NMIH3x79JNZ8bn52mi1ofqWHnbA6Z9MlwYY1mrLuWg6cmnV8hw2CJaJcHRMm
        wArTP8ab7NYRvr/GGQ/2RWtAYYmuPgQ3btjs4Nisdi/qB/V+P6ihqofvo9Qvz22l0vXpaaB3RIpbV
        0u/DgQGnmyVfBPA8T5NG/+AXLOSxqYgbnwHWsnNinSC3GQkyWdHRhR2RPmC+T3UyuoUxb0vRfQ6tc
        8cBDLQRg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTjpv-0001t9-Uz; Wed, 29 Apr 2020 10:21:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8140E301224;
        Wed, 29 Apr 2020 12:21:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 71232201F9F0B; Wed, 29 Apr 2020 12:21:01 +0200 (CEST)
Date:   Wed, 29 Apr 2020 12:21:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, alexandre.chartre@oracle.com
Cc:     linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org, mbenes@suse.cz
Subject: [PATCH v2.1 01-B/14] objtool: Uniquely identify alternative
 instruction groups
Message-ID: <20200429102101.GK13592@hirez.programming.kicks-ass.net>
References: <20200428191101.886208539@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428191101.886208539@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: objtool: Uniquely identify alternative instruction groups
From: Alexandre Chartre <alexandre.chartre@oracle.com>
Date: Tue, 14 Apr 2020 12:36:11 +0200

From: Alexandre Chartre <alexandre.chartre@oracle.com>

Assign a unique identifier to every alternative instruction group in
order to be able to tell which instructions belong to what
alternative.

[peterz: extracted from a larger patch]
Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   26 ++++++++++++++++++++------
 tools/objtool/check.h |    3 ++-
 2 files changed, 22 insertions(+), 7 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -770,7 +770,9 @@ static int handle_group_alt(struct objto
 			    struct instruction *orig_insn,
 			    struct instruction **new_insn)
 {
+	static unsigned int alt_group_next_index = 1;
 	struct instruction *last_orig_insn, *last_new_insn, *insn, *fake_jump = NULL;
+	unsigned int alt_group = alt_group_next_index++;
 	unsigned long dest_off;
 
 	last_orig_insn = NULL;
@@ -779,7 +781,7 @@ static int handle_group_alt(struct objto
 		if (insn->offset >= special_alt->orig_off + special_alt->orig_len)
 			break;
 
-		insn->alt_group = true;
+		insn->alt_group = alt_group;
 		last_orig_insn = insn;
 	}
 
@@ -813,6 +815,7 @@ static int handle_group_alt(struct objto
 	}
 
 	last_new_insn = NULL;
+	alt_group = alt_group_next_index++;
 	insn = *new_insn;
 	sec_for_each_insn_from(file, insn) {
 		if (insn->offset >= special_alt->new_off + special_alt->new_len)
@@ -822,6 +825,7 @@ static int handle_group_alt(struct objto
 
 		insn->ignore = orig_insn->ignore_alts;
 		insn->func = orig_insn->func;
+		insn->alt_group = alt_group;
 
 		/*
 		 * Since alternative replacement code is copy/pasted by the
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -30,12 +30,13 @@ struct instruction {
 	unsigned int len;
 	enum insn_type type;
 	unsigned long immediate;
-	bool alt_group, dead_end, ignore, ignore_alts;
+	bool dead_end, ignore, ignore_alts;
 	bool hint;
 	bool retpoline_safe;
 	s8 instr;
 	u8 visited;
 	u8 ret_offset;
+	int alt_group;
 	struct symbol *call_dest;
 	struct instruction *jump_dest;
 	struct instruction *first_jump_src;
