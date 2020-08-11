Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A088C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 02:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D60622083B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 02:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sazrgxW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgHKCSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 22:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgHKCSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 22:18:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C072C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 19:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Io8apDkHl90fNuwfNfSyMnczqiJIuxxWPBPfjcKqWx4=; b=sazrgxW0+wrzKMrzxsFEeGMCO8
        Pj9XSgdlBA1AQOJzjF1Bm3mwRxrJjO8wS0NsoU2zcsx7WcxKL71iePVO/GS4OeSYaigRfZ4pbSb3D
        1uDm9pE4ccfPUD5nLohbiNnspvtTOM3hVbEEN/uai+r/OmIwUXj7CYe34DhK3LHemZxHGuyyie5UL
        hOFK99hUdWSoPy1v386l/ToKXUd0RIrzISD6hqJK6YwrLxb8+POoycWtdAI89mJSFOCWbnMnLEbVK
        /ZkQUhwt612qFHhkvEmxDiBIZaGiMdWxATEl8SPtuSIOyjWDb3DuSNBd2X7rQEz+yPk6vSU7JQ+qj
        j3q6DVYg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5JsH-0006qe-3Y; Tue, 11 Aug 2020 02:18:50 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        ocfs2-devel@oss.oracle.com
Subject: [PATCH] fs: ocfs2: delete repeated words in comments
Date:   Mon, 10 Aug 2020 19:18:45 -0700
Message-Id: <20200811021845.25134-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop duplicated words {the, and} in comments.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: ocfs2-devel@oss.oracle.com
---
 fs/ocfs2/alloc.c      |    2 +-
 fs/ocfs2/localalloc.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200807.orig/fs/ocfs2/alloc.c
+++ linux-next-20200807/fs/ocfs2/alloc.c
@@ -6013,7 +6013,7 @@ int __ocfs2_flush_truncate_log(struct oc
 		goto out;
 	}
 
-	/* Appending truncate log(TA) and and flushing truncate log(TF) are
+	/* Appending truncate log(TA) and flushing truncate log(TF) are
 	 * two separated transactions. They can be both committed but not
 	 * checkpointed. If crash occurs then, both two transaction will be
 	 * replayed with several already released to global bitmap clusters.
--- linux-next-20200807.orig/fs/ocfs2/localalloc.c
+++ linux-next-20200807/fs/ocfs2/localalloc.c
@@ -677,7 +677,7 @@ int ocfs2_reserve_local_alloc_bits(struc
 		/*
 		 * Under certain conditions, the window slide code
 		 * might have reduced the number of bits available or
-		 * disabled the the local alloc entirely. Re-check
+		 * disabled the local alloc entirely. Re-check
 		 * here and return -ENOSPC if necessary.
 		 */
 		status = -ENOSPC;
