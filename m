Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33828C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A98520738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597926236;
	bh=kJJouGqpk7y9KGYIB/qSQlzNKFugPURJbr0dDf5g/yA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pBW28NXsgBh2hEZpeOLVCWxAIPPwNlsTY+Pg2Hj0l96UbzYvvkU9FlDJDzEizGv90
	 DShXyRJra5/EXZBOffSQyryvY4pW424h92KulW5sjM1nhq/z5laMYlm1od0NihV2K9
	 PkDKauqcr8p6m6g9/d1p2W8NIGCvIR3u5ytjIfG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbgHTMXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:23:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730122AbgHTJyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:54:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0ADC2075E;
        Thu, 20 Aug 2020 09:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917265;
        bh=kJJouGqpk7y9KGYIB/qSQlzNKFugPURJbr0dDf5g/yA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QyfOAVaMgack5iDwMSp6YLmg7mtBmPJjVTbEv7n+sq2/C91/whCtVzy3qu582G/gD
         BRkRfo+sIEeG95IwI/MdkuOC7+VG33GFDYTSATvqlnXM0VUleSx0b2HJ2A8PyNR/54
         XiEfbe9s6bf2UjkyCL/gFeNN5AOsAAs9/WVjFRpM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 62/92] selftests/powerpc: ptrace-pkey: Dont update expected UAMOR value
Date:   Thu, 20 Aug 2020 11:21:47 +0200
Message-Id: <20200820091540.840199409@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091537.490965042@linuxfoundation.org>
References: <20200820091537.490965042@linuxfoundation.org>
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



