Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A844C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9492074F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586254978;
	bh=HDOf5iL2WzIZq9OFWuzWL8Xs5UhCelii0BSjOQdYEbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bHHpxD2laZavt4kwxup0njGfjiXnrM/fAEC64I7iA3cpH/28ZLp6hIptgIqYuPrBM
	 Gd3JqfhUsx26zqwaDJadjpOW3OtVt0qICMl/fIq4kvjG4IMq0xwSKPZ0lqzbRYFcdD
	 DGOhMVyKNZoENjrr7EoM31qi4YtnSMsjLLDgxHc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgDGKW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:22:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728303AbgDGKWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:22:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B56B22074F;
        Tue,  7 Apr 2020 10:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586254972;
        bh=HDOf5iL2WzIZq9OFWuzWL8Xs5UhCelii0BSjOQdYEbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ord3UGA7Zf40tNvJVcCdxKNUQdxiOSjZhB8w9PAm9XanuFe27MvxMV++tkt0f8FIG
         08yVscuvWWTRsScZ2uG7p+Q4IJBZy6lfpIC5wk5SmfHiurqUhPuqGj36UFhvUmbDuJ
         ykMjCCpwgfvLcUtTytfvNq5nYr5+DrMikz1+/hlk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 07/36] tools/power turbostat: Fix gcc build warnings
Date:   Tue,  7 Apr 2020 12:21:40 +0200
Message-Id: <20200407101455.227110989@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200407101454.281052964@linuxfoundation.org>
References: <20200407101454.281052964@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Len Brown <len.brown@intel.com>

[ Upstream commit d8d005ba6afa502ca37ced5782f672c4d2fc1515 ]

Warning: ‘__builtin_strncpy’ specified bound 20 equals destination size
	[-Wstringop-truncation]

reduce param to strncpy, to guarantee that a null byte is always copied
into destination buffer.

Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 5d0fddda842c4..78507cd479bb4 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5323,9 +5323,9 @@ int add_counter(unsigned int msr_num, char *path, char *name,
 	}
 
 	msrp->msr_num = msr_num;
-	strncpy(msrp->name, name, NAME_BYTES);
+	strncpy(msrp->name, name, NAME_BYTES - 1);
 	if (path)
-		strncpy(msrp->path, path, PATH_BYTES);
+		strncpy(msrp->path, path, PATH_BYTES - 1);
 	msrp->width = width;
 	msrp->type = type;
 	msrp->format = format;
-- 
2.20.1



