Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B43C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 22:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CD862073E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 22:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593039056;
	bh=P5ZTgqOEqubrFlz1VMbmsQWDYNF2ojtgUJjGOh04Vgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C22YTgJ4lPhBgtod2nG1YEHWjdw8UmyF4A9quFm7AMJ7HVmiawPrPWvQhCVoYGSO/
	 Hs0qDnBD83PlLJpsa0/Q3hMDjK/Nrqf7MNwXWbUXPQt2NoI9PtCgr+Hv3cxUlZxwr4
	 QqetnYXtFUIyhhwBe1ui6VBVvz+iLczijWRMQDTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388443AbgFXWuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 18:50:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387974AbgFXWux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 18:50:53 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B85920768;
        Wed, 24 Jun 2020 22:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593039052;
        bh=P5ZTgqOEqubrFlz1VMbmsQWDYNF2ojtgUJjGOh04Vgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oWJHmbUzGOqAdjDNIFb/jx+hH7zLw7ubm1LlBXunFAOkAK1vF21dICPuP+1GewUSC
         OtTrJ91ZvD1IIyWC4jP6RJ82RWcdMWkJ1sBuW1zm9nmwiq7O+se1mBR/t90Po0RkDh
         VSCUILMYE94VZ78MXYv5Y16/eN/HLkWXE0oBmNfE=
From:   Andy Lutomirski <luto@kernel.org>
To:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 1/3] selftests/x86/fsgsbase: Fix a comment in the ptrace_write_gsbase test
Date:   Wed, 24 Jun 2020 15:50:48 -0700
Message-Id: <901034a91a40169ec84f1f699ea86704dff762e4.1593038991.git.luto@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1593038991.git.luto@kernel.org>
References: <cover.1593038991.git.luto@kernel.org>
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

