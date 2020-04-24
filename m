Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD12EC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A128520767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587731218;
	bh=Wu+vYA794mwY+sZ6ty1ffNeuXRRrOC0XMoMhp0KuxDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LOvzqJ3/eetThplmj4rtzcrl68IxSTgcvTioW73/0NDPRN1yNOMyJqhjGN/AopPHR
	 J62LgOL6tmNucCPfYAcmsjYTay6eiSUinff1Zb3yaS5mgxfAq5dc6yO19kffs1kkDq
	 LcDTipSTSVgvEk1gLcEJlqmmQtGGfxnt3y5QSeho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgDXM06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:26:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728529AbgDXMYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:24:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C21021569;
        Fri, 24 Apr 2020 12:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587731084;
        bh=Wu+vYA794mwY+sZ6ty1ffNeuXRRrOC0XMoMhp0KuxDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xccxXdYu7zK1iAbMicXc0PEbgZiHM4ipVIvFJiawoPQDTjmtRD2P1LQjjAmTqS+Yk
         /GdUlQaeGqTTNvpT71wKza0NE260yGv/xK+k2zI0cMKwb3pCAsYdbXHHA5zYmMtG90
         M8RYwLEaRWg3OzPXGw7MBL2kgZPWY0SfD1mJy9qQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Frank Rowand <frank.rowand@sony.com>,
        "Erhard F ." <erhard_f@mailbox.org>, Rob Herring <robh@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 20/21] of: unittest: kmemleak on changeset destroy
Date:   Fri, 24 Apr 2020 08:24:18 -0400
Message-Id: <20200424122419.10648-20-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424122419.10648-1-sashal@kernel.org>
References: <20200424122419.10648-1-sashal@kernel.org>
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
index 4bf6a9db6ac0c..aaec4a9fa2bc4 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -605,6 +605,10 @@ static void __init of_unittest_changeset(void)
 	unittest(!of_changeset_revert(&chgset), "revert failed\n");
 
 	of_changeset_destroy(&chgset);
+
+	of_node_put(n1);
+	of_node_put(n2);
+	of_node_put(n21);
 #endif
 }
 
-- 
2.20.1

