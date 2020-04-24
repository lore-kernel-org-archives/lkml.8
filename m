Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12258C55191
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCB6A21582
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587731121;
	bh=KXJPhbBVzIkTHaGHP5HZL37C1iruhpdS90eLLxL7Ffg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mtGnS/8tmPw8ZVzvokJ7kTu95j3XGUlz/Wew0ylongwtHQFWnwACld4+XX8nGkW8J
	 dar41YvH2h2swVTsA3MYKxW9fjVNtK9s1Folg+3kVPLhJlnr2NGC9D0oVU2ycJ6AGs
	 HFfkIHMu4PIvMSTjEr6iC77Gy41UHEVZFfGaA3Pg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgDXMZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:25:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgDXMZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:25:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A757217BA;
        Fri, 24 Apr 2020 12:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587731113;
        bh=KXJPhbBVzIkTHaGHP5HZL37C1iruhpdS90eLLxL7Ffg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eWfoMLIJ+9eIGAIlSQYGf8UUZZDjWLEHGEvs9A6K5qjvZLAIQQyyls0liAiarMTHh
         MDO997V0xXPGeeopPzAtaFqJdxur7Ow+qGWuHXTuWXFgiHOhUNkMg3SfUX/+lO1y+N
         1zDWxdU18ocMvAbQ+d3oRFDG86MjbHijAf+cOO/k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Frank Rowand <frank.rowand@sony.com>,
        "Erhard F ." <erhard_f@mailbox.org>, Rob Herring <robh@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 8/8] of: unittest: kmemleak on changeset destroy
Date:   Fri, 24 Apr 2020 08:25:03 -0400
Message-Id: <20200424122503.11046-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424122503.11046-1-sashal@kernel.org>
References: <20200424122503.11046-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

[ Upstream commit b3fb36ed694b05738d45218ea72cf7feb10ce2b1 ]

kmemleak reports several memory leaks from devicetree unittest.
This is the fix for problem 1 of 5.

of_unittest_changeset() reaches deeply into the dynamic devicetree
functions.  Several nodes were left with an elevated reference
count and thus were not properly cleaned up.  Fix the reference
counts so that the memory will be freed.

Fixes: 201c910bd689 ("of: Transactional DT support.")
Reported-by: Erhard F. <erhard_f@mailbox.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/unittest.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index af9e4785b7a6e..1ee2474fa8fbb 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -544,6 +544,10 @@ static void __init of_unittest_changeset(void)
 	mutex_unlock(&of_mutex);
 
 	of_changeset_destroy(&chgset);
+
+	of_node_put(n1);
+	of_node_put(n2);
+	of_node_put(n21);
 #endif
 }
 
-- 
2.20.1

