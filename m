Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2F8C33CA4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 09:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749952077C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 09:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578736756;
	bh=dttOYxbFUmZTQ08wNe1y48EEtGukWONk3FPYnvKnQpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TdDtTs4EWwUh2MRdkELMkAASvprVJwKd0iygmXByTbGx4TwdUnmLW3nuIt4aILrHb
	 wPPkFhBpSbZtR+PZF0yVtyaohA8xZlFqqTvREArBrSEX1obcTmURVgI0emVpaVlIeB
	 TOvnnmGd2A6cxNCFGj3FrlaqeAUR2U8bnhaDO/HM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbgAKJ7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 04:59:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:53596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729143AbgAKJ7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 04:59:14 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A6CC2077C;
        Sat, 11 Jan 2020 09:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578736754;
        bh=dttOYxbFUmZTQ08wNe1y48EEtGukWONk3FPYnvKnQpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V9czFErIkcrJOFRdlAIHv86V+gVHMALzmv+KkO7pZoU87C1Gasz7Vfo8TLSXqg491
         ikRZB3c0kBavFPlgVzQeb8004C08G9J6aq2FhFip9YWMeN2WT4IMspFFXBRgANT0h3
         MnD7GgcHaWEtNcA9OtDE3VhkAXgw3l+2qsh0eMf4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 18/91] Revert "perf report: Add warning when libunwind not compiled in"
Date:   Sat, 11 Jan 2020 10:49:11 +0100
Message-Id: <20200111094850.366473395@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094844.748507863@linuxfoundation.org>
References: <20200111094844.748507863@linuxfoundation.org>
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
index 33ff5c843346..6e88460cd13d 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -292,13 +292,6 @@ static int report__setup_sample_type(struct report *rep)
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



