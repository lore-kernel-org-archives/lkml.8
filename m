Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D85C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 235B820731
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jisq6GbO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aY6r3Pg0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgIJS60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:58:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41884 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbgIJSzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:55:06 -0400
Date:   Thu, 10 Sep 2020 18:54:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599764080;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Qldr24ZABIko766Gx//VbWWMqXYF18LhWtWeiqzwtIw=;
        b=jisq6GbOJAxMIKv5XxZCD8bMLvfzZz82EXUOiy7xgs5aLA9KCqlZD5sEMJPLUTf3KjxE+/
        NE9ROqdj5qCGYDpulaaDq/mqCmCJMUc5wi1OMLuBzSGFW1WY1gvpla8HD8h6WWq7EGlfrE
        1+Y6lOqPRpftbOK6+PA+TXv+HlpH7MlVPwvjtCznBpGtBDCrya8IbJEOKV01+K9uHhnsMG
        7JnI/6QhbsEzc7mn+omGDmy8cTyLlJeGT3Cj1Kbd2iWkB8nSy0r8+aav7qHUVKtwRjwuBd
        P8d5+LNYbMocPUczk6ww9onyoyWTr+l2zg3tXi1k0gaMj6WF4qp2B/v+hulCBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599764080;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Qldr24ZABIko766Gx//VbWWMqXYF18LhWtWeiqzwtIw=;
        b=aY6r3Pg0mjUbqere7IyZn4fFIZL/DDInioK6lPanDnrj3fk1eVfhVmhhcwNNGaburh7aVj
        hT2hu+jo5OjglkBw==
From:   "tip-bot2 for Julien Thierry" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Skip ORC entry creation for non-text sections
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159976407967.20229.8320651008758701134.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     3eaecac88a17f7fdf29561a197dc728f7f697c60
Gitweb:        https://git.kernel.org/tip/3eaecac88a17f7fdf29561a197dc728f7f697c60
Author:        Julien Thierry <jthierry@redhat.com>
AuthorDate:    Tue, 25 Aug 2020 13:47:41 +01:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Tue, 01 Sep 2020 17:19:11 -05:00

objtool: Skip ORC entry creation for non-text sections

Orc generation is only done for text sections, but some instructions
can be found in non-text sections (e.g. .discard.text sections).

Skip setting their orc sections since their whole sections will be
skipped for orc generation.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/orc_gen.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index e6b2363..22fe439 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -18,6 +18,9 @@ int create_orc(struct objtool_file *file)
 		struct cfi_reg *cfa = &insn->cfi.cfa;
 		struct cfi_reg *bp = &insn->cfi.regs[CFI_BP];
 
+		if (!insn->sec->text)
+			continue;
+
 		orc->end = insn->cfi.end;
 
 		if (cfa->base == CFI_UNDEFINED) {
