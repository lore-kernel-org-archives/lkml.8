Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFBBC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6112D208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597928240;
	bh=kJJouGqpk7y9KGYIB/qSQlzNKFugPURJbr0dDf5g/yA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IWBOS/w8aQY7aRG+0JDZyec9lUQBFhPeA4fgffCGLtU8PRG6eOKbLokcG+PElhjoq
	 2Ujr+0MSkANWsLDBTioClbzlEI/GQuqq1Ow4RUNgpDnQwr4NIfXMLpZrcOtR3VwSOJ
	 JiamNtxl/FmdBV3jUWKjcr0XXWGLoH3Q6g794MyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgHTJlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:41:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728664AbgHTJk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:40:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3D53207DE;
        Thu, 20 Aug 2020 09:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916459;
        bh=kJJouGqpk7y9KGYIB/qSQlzNKFugPURJbr0dDf5g/yA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0wfeIL3d3NY/nr6fwBh/HHYxN49BfUc1KdvjQSCM+JMWyRD0cEH6ZDQk7W4AAGnwL
         FYP9vRQMhavfhT4bn2mCoZvqZoU+U1I/H5uS31m5aSSDSMd3Hy/r7JnUllSbtVgP8H
         wTCyZuSvL9QEzmP+TS3VMraqWy4UjjoaamjuFnSk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 136/204] selftests/powerpc: ptrace-pkey: Dont update expected UAMOR value
Date:   Thu, 20 Aug 2020 11:20:33 +0200
Message-Id: <20200820091613.052924066@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

[ Upstream commit 3563b9bea0ca7f53e4218b5e268550341a49f333 ]

With commit 4a4a5e5d2aad ("powerpc/pkeys: key allocation/deallocation
must not change pkey registers") we are not updating UAMOR on key
allocation. So don't update the expected uamor value in the test.

Fixes: 4a4a5e5d2aad ("powerpc/pkeys: key allocation/deallocation must not change pkey registers")
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200709032946.881753-23-aneesh.kumar@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c b/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
index bc33d748d95b4..3694613f418f6 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
@@ -101,15 +101,20 @@ static int child(struct shared_info *info)
 	 */
 	info->invalid_amr = info->amr2 | (~0x0UL & ~info->expected_uamor);
 
+	/*
+	 * if PKEY_DISABLE_EXECUTE succeeded we should update the expected_iamr
+	 */
 	if (disable_execute)
 		info->expected_iamr |= 1ul << pkeyshift(pkey1);
 	else
 		info->expected_iamr &= ~(1ul << pkeyshift(pkey1));
 
-	info->expected_iamr &= ~(1ul << pkeyshift(pkey2) | 1ul << pkeyshift(pkey3));
+	/*
+	 * We allocated pkey2 and pkey 3 above. Clear the IAMR bits.
+	 */
+	info->expected_iamr &= ~(1ul << pkeyshift(pkey2));
+	info->expected_iamr &= ~(1ul << pkeyshift(pkey3));
 
-	info->expected_uamor |= 3ul << pkeyshift(pkey1) |
-				3ul << pkeyshift(pkey2);
 	/*
 	 * Create an IAMR value different from expected value.
 	 * Kernel will reject an IAMR and UAMOR change.
-- 
2.25.1



