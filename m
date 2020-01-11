Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653F5C3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 09:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33FF02072E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 09:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578736425;
	bh=Zoz73Dzh16pD7OKodj6miQbo8eLdSB8KwPVWZllNx/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s+YMGEm3VXuhxCyc9lilj2mY0mdLQmiAsHaLjaamxE9RpbBlywoISz3inrs3tw8H6
	 MZpNLHQ6ep/pekXvHdkb31qkd6YrGNru+ASumrb5zsEkPIUcDcPBGZ8VcMMTXH21VR
	 YCnlzLn7SJ1trE2SYha2jE/5t/WJm3ph93jloioo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbgAKJxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 04:53:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:40942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728767AbgAKJxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 04:53:44 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1AEE2077C;
        Sat, 11 Jan 2020 09:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578736423;
        bh=Zoz73Dzh16pD7OKodj6miQbo8eLdSB8KwPVWZllNx/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FtlmUdfhalQfFnUxHXM+NllZGhe7bdggD6WZqIe3Kxv0BD9Sl5lo6b533b90Tem7p
         ymf0IghF2f0bRMHfe15c8FT+VbpC/oWzqYUE8jUSPBqK3N9A8nkQcnSHcfuFly6Hsb
         d9bY7V3G6snCBBPnSSDU2+25JW0jSvLrqxDJPBvY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 14/59] Revert "perf report: Add warning when libunwind not compiled in"
Date:   Sat, 11 Jan 2020 10:49:23 +0100
Message-Id: <20200111094841.123572631@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094835.417654274@linuxfoundation.org>
References: <20200111094835.417654274@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 59b706ce44dbfd35a428f2cbad47794ce5dce1eb.

This change depends on more changes that didn't exist in 4.9 and older.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-report.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 0f7ebac1846b..f256fac1e722 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -285,13 +285,6 @@ static int report__setup_sample_type(struct report *rep)
 				PERF_SAMPLE_BRANCH_ANY))
 		rep->nonany_branch_mode = true;
 
-#ifndef HAVE_LIBUNWIND_SUPPORT
-	if (dwarf_callchain_users) {
-		ui__warning("Please install libunwind development packages "
-			    "during the perf build.\n");
-	}
-#endif
-
 	return 0;
 }
 
-- 
2.20.1



