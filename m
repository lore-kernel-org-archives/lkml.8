Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C679C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ACB02065F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593192278;
	bh=P5ZTgqOEqubrFlz1VMbmsQWDYNF2ojtgUJjGOh04Vgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tswtuyLoSVG/FnLliqai/oZdinptFVxnWr5ht7DAqQUT9CUZzHAeLEsQjKi5OJBde
	 WaDidCv5ED6y7DQCRNh+Z/mhbiOp/5pM/AGFSZ3IFkmGWKz7J0kL5bTTq9Kf+uYFxJ
	 oB42BbFq+EZUwzBsMzYmSplSQdRLkuP+qTgbqtK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgFZRYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 13:24:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgFZRYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:24:33 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2F8820707;
        Fri, 26 Jun 2020 17:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593192272;
        bh=P5ZTgqOEqubrFlz1VMbmsQWDYNF2ojtgUJjGOh04Vgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lM7mhqWAbXUC3kPS+46Sy280d2hWzjp7mKx+Z2SZ5j00YHewQHXFhgNLmyvDlkOVZ
         NRyi2OkCXaDkXkUQ5PN6ZgqQtYohsJrLd6NlhrkXlGthriEIeaY4e6sTyuwxNEDYUn
         HuuT90Z89c+lZpRjooo53G41xLca4CFzKvk/v+AA=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH fsgsbase v2 1/4] selftests/x86/fsgsbase: Fix a comment in the ptrace_write_gsbase test
Date:   Fri, 26 Jun 2020 10:24:27 -0700
Message-Id: <901034a91a40169ec84f1f699ea86704dff762e4.1593192140.git.luto@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1593192140.git.luto@kernel.org>
References: <cover.1593192140.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A comment was unclear.  Fix it.

Fixes: 5e7ec8578fa3 ("selftests/x86/fsgsbase: Test ptracer-induced GS base write with FSGSBASE")
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 tools/testing/selftests/x86/fsgsbase.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index 9a4349813a30..f47495d2f070 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -498,7 +498,8 @@ static void test_ptrace_write_gsbase(void)
 			 * base would zero the selector.  On newer kernels,
 			 * this behavior has changed -- poking the base
 			 * changes only the base and, if FSGSBASE is not
-			 * available, this may not effect.
+			 * available, this may have no effect once the tracee
+			 * is resumed.
 			 */
 			if (gs == 0)
 				printf("\tNote: this is expected behavior on older kernels.\n");
-- 
2.25.4

