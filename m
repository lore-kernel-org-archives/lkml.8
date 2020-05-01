Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41C5C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF0E12054F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588341478;
	bh=IvnIlFMbhj0nrYkNzgTz4tdNuMiJpw3099iWLQmHY7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g8ruuEDIR7onk/iNxcAMKgp1cAi6dUBu+Z/3ABpxv0OEr9nW+5ghqxZBEAdZT6G9Z
	 QFWhwPBT4/o3tBSM8IoYE1vSAtplRn5DxCGlcmMRmUVU96uuhbNQ1mRPtYPkqLDIgB
	 7pyZSIUOl1EeJV1wT5jrprIoD1Ou+Sl84xextc2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbgEAN56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:57:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730042AbgEANaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:30:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98A77208D6;
        Fri,  1 May 2020 13:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588339852;
        bh=IvnIlFMbhj0nrYkNzgTz4tdNuMiJpw3099iWLQmHY7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q8NUBnj3Wg3alJyo/6Im9xqDAuKteg5Z78ljgcp4yPhIOkIxFE9eTNLhsqls1vAXh
         ctXIv1NI1o2K9Nd85/vzNsEr/vY+ULtZ3fowr/VCghfpWSsANVNH8UEDnDVYrJZxDJ
         ZicmN9htN0PN7QFUjbV9cQRudgJ0iVFy9OBKvzJo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Erhard F." <erhard_f@mailbox.org>,
        Frank Rowand <frank.rowand@sony.com>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 73/80] of: unittest: kmemleak on changeset destroy
Date:   Fri,  1 May 2020 15:22:07 +0200
Message-Id: <20200501131536.264804356@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131513.810761598@linuxfoundation.org>
References: <20200501131513.810761598@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index aeb6d3009ae92..144d123f6ea4f 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -539,6 +539,10 @@ static void __init of_unittest_changeset(void)
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



