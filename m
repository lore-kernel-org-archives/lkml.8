Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE6DC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B0F22464
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193656;
	bh=H4TGDuj/IGoXsgjHYEbP9PeZK/cLYnM2Qg5WbYMX6t8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wyhPoKX+kcoFazZWMcno77VwtmNPdZ9Oc//KcPysS1dcD+/hPWVYGD+2nDDa6ncdq
	 5ReMvpernndtJlRwVthzfFHJsVmXY+mltSaWUvtdoJcyRig+9zkwrYE7g0C7lsyqYA
	 qmkMkQSJ90wQg6CFJMLKSh8j7NpA6xBYqPOectWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbgAPQyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:54:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:38346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728921AbgAPQyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:54:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C27220730;
        Thu, 16 Jan 2020 16:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193644;
        bh=H4TGDuj/IGoXsgjHYEbP9PeZK/cLYnM2Qg5WbYMX6t8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HFY2y+5wVsgRnfh/grr4YpYsMtEWr/4pXQyoEV08VaOXdIFYdmn9MO0Mb2rzJ3M9w
         5EeB1naN0O5TRqrLlC6V1VC2tnFCzHnFOJm7CA8qO5OCZkaj2UIo0ve9ibkZ0YL4nF
         qV3qquKA7x4yvXlfN+FBRljZpV2yAbHAsKmho1is=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>, linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 175/205] um: Don't trace irqflags during shutdown
Date:   Thu, 16 Jan 2020 11:42:30 -0500
Message-Id: <20200116164300.6705-175-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 5c1f33e2a03c0b8710b5d910a46f1e1fb0607679 ]

In the main() code, we eventually enable signals just before
exec() or exit(), in order to to not have signals pending and
delivered *after* the exec().

I've observed SIGSEGV loops at this point, and the reason seems
to be the irqflags tracing; this makes sense as the kernel is
no longer really functional at this point. Since there's really
no reason to use unblock_signals_trace() here (I had just done
a global search & replace), use the plain unblock_signals() in
this case to avoid going into the no longer functional kernel.

Fixes: 0dafcbe128d2 ("um: Implement TRACE_IRQFLAGS_SUPPORT")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/os-Linux/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index 8014dfac644d..c8a42ecbd7a2 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -170,7 +170,7 @@ int __init main(int argc, char **argv, char **envp)
 	 * that they won't be delivered after the exec, when
 	 * they are definitely not expected.
 	 */
-	unblock_signals_trace();
+	unblock_signals();
 
 	os_info("\n");
 	/* Reboot */
-- 
2.20.1

