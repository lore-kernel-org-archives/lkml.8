Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629ADC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E15320737
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598461277;
	bh=xWAdoVZA2pXnZlSGTDF0cdD/4tTL0G8PPVUPrv8x9Jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N+YzWptLk6rUtTlpti44c7I9WTd8Trc8Dt+aS5pC9Ek9h7aUf1JswFbEIKjtlc50C
	 qn18EYKfcwIoa+TM5fY8kfS56bsrXnE916+GTPODL1rxQRbbZKkPymt6ExyGsu4wv8
	 vgz/PREM2uucnOzZhHEKwK2g1QX5uhhnri9srQRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgHZRBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 13:01:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727042AbgHZRAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 13:00:49 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 519A6206F0;
        Wed, 26 Aug 2020 17:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598461249;
        bh=xWAdoVZA2pXnZlSGTDF0cdD/4tTL0G8PPVUPrv8x9Jc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y66M8Wm67IaMyPg6zykhHu9kr2Evld0jibbvnzoGkGZxlgEXbv5llvaLLtI8uBKfz
         CVM7oLI7Iitu3ASgr7BK/aijEjf0GCF+635e2qT42qxRiShOrfiooPscJhfpIDIa4g
         Io+nWN1J2OqpscOAdOp2j9uxBOApJVxyujwjJONM=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 1/2] selftests/x86/fsgsbase: Reap a forgotten child
Date:   Wed, 26 Aug 2020 10:00:45 -0700
Message-Id: <e7700a503f30e79ab35a63103938a19893dbeff2.1598461151.git.luto@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1598461151.git.luto@kernel.org>
References: <cover.1598461151.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ptrace() test forgot to reap its child.  Reap it.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 tools/testing/selftests/x86/fsgsbase.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index 998319553523..0056e2597f53 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -517,6 +517,9 @@ static void test_ptrace_write_gsbase(void)
 
 END:
 	ptrace(PTRACE_CONT, child, NULL, NULL);
+	wait(&status);
+	if (!WIFEXITED(status))
+		printf("[WARN]\tChild didn't exit cleanly.\n");
 }
 
 int main()
-- 
2.25.4

