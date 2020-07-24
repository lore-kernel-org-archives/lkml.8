Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AF9C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFB782063A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="nqPzkLDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgGXJZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgGXJZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:25:35 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB99FC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 02:25:34 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BCkMK3H5rz9sTF; Fri, 24 Jul 2020 19:25:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1595582733;
        bh=AVUaTO+LsSUOyxIL1KOaTrKKKaNmx2vXjDKN+mztBlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nqPzkLDgg6v5PjB1sy5QwAed8FgPbtUmFKYBrxuFskrWObQQs/p2c+gNBteuMW8f4
         EpTVY02DOksjw5VsQQvRUjRCz8Pwh5kYhQ3xdPqiVRF2dqHbOE0ynB1mkekV+ctdOY
         KBVLxyhH4U+TdiYqt00aIzeVZW8aeDVyg2q89/wrOxyMLhKClbtVPylRUoTaB/l7Cn
         1+P1Qk7+rkYJBh/dDmaa9zr9P3tfbRFaupAD6cgp2ykwdXVxW9UtOqBO9PrRootUUl
         /ggcX9ruW3hZ2RlQDdVlxhBrAe3GTvJYY2CNTQ+7vkHLJSQEmMjq7jePvq02O2DsZ7
         AqaOv2Nx0OWCQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linuxppc-dev@ozlabs.org
Cc:     dja@axtens.net, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] selftests/powerpc: Update the stack expansion test
Date:   Fri, 24 Jul 2020 19:25:26 +1000
Message-Id: <20200724092528.1578671-3-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724092528.1578671-1-mpe@ellerman.id.au>
References: <20200724092528.1578671-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the stack expansion load/store test to take into account the
new allowance of 4224 bytes below the stack pointer.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 .../selftests/powerpc/mm/stack_expansion_ldst.c        | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

v2: Update for change of size to 4224.

diff --git a/tools/testing/selftests/powerpc/mm/stack_expansion_ldst.c b/tools/testing/selftests/powerpc/mm/stack_expansion_ldst.c
index 0587e11437f5..8dbfb51acf0f 100644
--- a/tools/testing/selftests/powerpc/mm/stack_expansion_ldst.c
+++ b/tools/testing/selftests/powerpc/mm/stack_expansion_ldst.c
@@ -186,17 +186,17 @@ static void test_one_type(enum access_type type, unsigned long page_size, unsign
 	// But if we go past the rlimit it should fail
 	assert(test_one(DEFAULT_SIZE, rlim_cur + 1, type) != 0);
 
-	// Above 1MB powerpc only allows accesses within 2048 bytes of
+	// Above 1MB powerpc only allows accesses within 4224 bytes of
 	// r1 for accesses that aren't stdu
-	assert(test_one(1 * _MB + page_size - 128, -2048, type) == 0);
+	assert(test_one(1 * _MB + page_size - 128, -4224, type) == 0);
 #ifdef __powerpc__
-	assert(test_one(1 * _MB + page_size - 128, -2049, type) != 0);
+	assert(test_one(1 * _MB + page_size - 128, -4225, type) != 0);
 #else
-	assert(test_one(1 * _MB + page_size - 128, -2049, type) == 0);
+	assert(test_one(1 * _MB + page_size - 128, -4225, type) == 0);
 #endif
 
 	// By consuming 2MB of stack we test the stdu case
-	assert(test_one(2 * _MB + page_size - 128, -2048, type) == 0);
+	assert(test_one(2 * _MB + page_size - 128, -4224, type) == 0);
 }
 
 static int test(void)
-- 
2.25.1

