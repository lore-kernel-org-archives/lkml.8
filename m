Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461BDC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F522082F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586361332;
	bh=l+M+FJ433dJLLEDTiRxUlXpAfah9jnhjVn4Zv1/p4SQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=po2CpZBSujELQFTCG+4szZQgceibFScyB3vbn4gpQBaBx91EujEiiZVI+uNxmkxUA
	 Ggvt7zfDaUxdLTMKwTbCZf5+clGzyEQE0IoNp9R7Nyx+jhlt5ntbDln1aAwo6vLOtX
	 MX3dy0YTBCjiU0d97AyLOTCw1KcOqiEdF9seLQbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbgDHPzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:55:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729789AbgDHPz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:55:29 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B81132076D;
        Wed,  8 Apr 2020 15:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586361328;
        bh=l+M+FJ433dJLLEDTiRxUlXpAfah9jnhjVn4Zv1/p4SQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eK9h1ywUEP/eqmoz36+a0nXmuhz1pmEGRtSyKuwmI0unmc65xgmhXaWkGdCMGi6JP
         KvtcmF1lH3kJJXaW02obwgYDuwDFuyqmpAjacJLPgJh0fZ7DoYRt5dXyJkor3tCIW5
         yk0iRAlXSMEGUy1XJtrJQlQZ/X+U81kqFG/5JAeQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMD30-000cGs-WD; Wed, 08 Apr 2020 17:55:27 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Tim Bird <Tim.Bird@sony.com>,
        Markus Heiser <markus.heiser@darmarit.de>
Subject: [PATCH 3/6] scripts: sphinx-pre-install: fix a dependency hint with Ubuntu 16.04
Date:   Wed,  8 Apr 2020 17:55:22 +0200
Message-Id: <5899dbcf62ba5500a47a59eb62e8b0f567ba01aa.1586361086.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586361086.git.mchehab+huawei@kernel.org>
References: <cover.1586361086.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid the scripts to keep asking to install fonts-noto-cjk
on Ubuntu 16.04.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 46c58a5795f1..7234482475a3 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -349,7 +349,8 @@ sub give_debian_hints()
 				   "fonts-dejavu", 2);
 
 		check_missing_file(["/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc",
-				   "/usr/share/fonts/opentype/noto/NotoSerifCJK-Regular.ttc"],
+				    "/usr/share/fonts/opentype/noto/NotoSansCJK-Regular.ttc",
+				    "/usr/share/fonts/opentype/noto/NotoSerifCJK-Regular.ttc"],
 				   "fonts-noto-cjk", 2);
 	}
 
-- 
2.25.2

