Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547FDC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14B182087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599670654;
	bh=3KxtUZvOHKiAgK/WciaZ1QFV2+EwOYqo38o2r+Qk3fE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b378VpeOee3Hlgo2S9gw/WXTRRUl5dCR7ypgYlzk35eEf2KPuaaiCcGWITkSaUgD/
	 muPnS1c3+N+ftZU77XUl5ZuLHpEM0+WIrGdaTEfaFHrjEJN7yOyDa08E5hjFPu+npS
	 avRieFMdADo238/PT6Vzc7bA/FYn89BrSt+BJiqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbgIIQ5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:57:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730684AbgIIPvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:51:19 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A81FF2224A;
        Wed,  9 Sep 2020 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599660665;
        bh=3KxtUZvOHKiAgK/WciaZ1QFV2+EwOYqo38o2r+Qk3fE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dx5xqjFdEG1aeiFpgHF7sSGeYEIqE5ErwYsYZrZBsjQRiLhuwy8P32IVEA4DJxrEk
         FHJYYD/ZJaMOxuu1xAGMk4W6zJyDWswMhIV7+PWZsXPsNAM+rGoG4glsORI4lpgiox
         nwFpm8xIUjQhXjOuPnPRNJ0kxnOcTb82k47ZEBlE=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kG0oR-00DUXm-Q8; Wed, 09 Sep 2020 16:11:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 27/30] docs: bio: fix a kerneldoc markup
Date:   Wed,  9 Sep 2020 16:10:58 +0200
Message-Id: <1cc3c203d8e954d40030fd0755858c7ac2e890d5.1599660067.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix this warning:

	./block/bio.c:1098: WARNING: Inline emphasis start-string without end-string.

The thing is that *iter is not a valid markup.

That seems to be a typo:
	*iter -> @iter

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index ccd3ab549d41..ce9446a7b081 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1093,7 +1093,7 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
  * released.
  *
  * The function tries, but does not guarantee, to pin as many pages as
- * fit into the bio, or are requested in *iter, whatever is smaller. If
+ * fit into the bio, or are requested in @iter, whatever is smaller. If
  * MM encounters an error pinning the requested pages, it stops. Error
  * is returned only if 0 pages could be pinned.
  */
-- 
2.26.2

