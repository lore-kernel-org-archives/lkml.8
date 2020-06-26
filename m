Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FED1C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EA252065F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593192289;
	bh=UsPcBeVv1Rqr8ERJdYj0ADqcOXxfVl4BMzopt1LKGX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dayxt5wsRyBKthtGJyeGfqauYs6h8XEZPiAamdfcUjpmzIY5u+FG/yvnH4fqN8x2I
	 TbXSHS4xZh8/pej9IbN3ZvLS2hmUhSnNz/UEq/Efz0FZUnRLXAp1Yox9WRge88uzpv
	 l7Kw9NhYRwLdqk45aSX7znmJiWwLcimFFbpEOidc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgFZRYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 13:24:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbgFZRYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:24:34 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86841207FC;
        Fri, 26 Jun 2020 17:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593192273;
        bh=UsPcBeVv1Rqr8ERJdYj0ADqcOXxfVl4BMzopt1LKGX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zJLzWiwjdTMZ1jn9tn9WumMIdDyaqz/UJpm002x1I7fNimZDexvM4HrZqMIKf6T/1
         t5D/zwt8qLTSGOCk2VVEXDoSZz8wKYvArf/hEBczdgNPsznKoyvykNmcXy1wed59s7
         2yu1icH51tA9OM0kpK/QSsSJlNwcG+Tl5TKBU7sw=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH fsgsbase v2 2/4] selftests/x86/fsgsbase: Add a missing memory constraint
Date:   Fri, 26 Jun 2020 10:24:28 -0700
Message-Id: <432968af67259ca92d68b774a731aff468eae610.1593192140.git.luto@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1593192140.git.luto@kernel.org>
References: <cover.1593192140.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The manual call to set_thread_area() via int $0x80 was missing any
indication that the descriptor was a pointer, causing gcc to
occasionally generate wrong code.  Add the missing constraint.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 tools/testing/selftests/x86/fsgsbase.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index f47495d2f070..998319553523 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -285,7 +285,8 @@ static unsigned short load_gs(void)
 		/* 32-bit set_thread_area */
 		long ret;
 		asm volatile ("int $0x80"
-			      : "=a" (ret) : "a" (243), "b" (low_desc)
+			      : "=a" (ret), "+m" (*low_desc)
+			      : "a" (243), "b" (low_desc)
 			      : "r8", "r9", "r10", "r11");
 		memcpy(&desc, low_desc, sizeof(desc));
 		munmap(low_desc, sizeof(desc));
-- 
2.25.4

