Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A86C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A183420730
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586360946;
	bh=flQ66rWLqLJ9tP/xDtQuASEFxj/jeRx5dEzURVCNupI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qM7p5PzMia2Et1vKUolPg8KJdmL8uUg3D8mFirHluOlMouGLvtAzN5ogHSDRfirGf
	 nOkrlch/Id2VlZuAAIMW7GrOF4fCVtfim9OBQv8jf9IU6NgTrVoAXTRFAghnRijAlg
	 Sdn1ENlk+HgWZ05D0a7wfLzfcOXUuhstWZh7lOt0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbgDHPtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:49:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729613AbgDHPqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:46:32 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BEAB20CC7;
        Wed,  8 Apr 2020 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360791;
        bh=flQ66rWLqLJ9tP/xDtQuASEFxj/jeRx5dEzURVCNupI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oylMwXQehr6LhXuN7aSCVnMUbaptl4gcCyVf+NipEOdJtnPhjzTZfXWDwu1xhNG3w
         7hRjV3p1+sz5vrH+0J+mzqyGqcc44yn2vIhte4WJSG0ZWIsrpHBt8OjmsRId7LhfJb
         mBH4eqmulUYXG1kH8dGRgHiiDqTa4EWhnlErkPBw=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMCuL-000cAv-DN; Wed, 08 Apr 2020 17:46:29 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Subject: [PATCH 09/35] futex: get rid of a kernel-docs build warning
Date:   Wed,  8 Apr 2020 17:46:01 +0200
Message-Id: <ad0a38ef26455ef71e9d1267eda7afa629686c6e.1586359676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586359676.git.mchehab+huawei@kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust whitespaces and blank lines in order to get rid of this:

	./kernel/futex.c:491: WARNING: Definition list ends without a blank line; unexpected unindent.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 kernel/futex.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/futex.c b/kernel/futex.c
index b59532862bc0..b4b9f960b610 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -486,10 +486,13 @@ static u64 get_inode_sequence_number(struct inode *inode)
  * The key words are stored in @key on success.
  *
  * For shared mappings (when @fshared), the key is:
+ *
  *   ( inode->i_sequence, page->index, offset_within_page )
+ *
  * [ also see get_inode_sequence_number() ]
  *
  * For private mappings (or when !@fshared), the key is:
+ *
  *   ( current->mm, address, 0 )
  *
  * This allows (cross process, where applicable) identification of the futex
-- 
2.25.2

