Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC3CC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC6582068E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592203844;
	bh=+YB9j5KRX8bJJCciec3l9jzw9TCQBre/YEU3QDQFNpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nq7p5qEf9pqhdfGhPDyAHEP9QE5O0Cs2xfnrM5I9o7My55MByK+2EZ8MTeB4WV2Cu
	 BIXqyb6QleODGbnT8Q+RJMJpRxaccUwVOT5apzDNTC8glb7Nm32cOK23StXRcNi37i
	 80QQDzCpsr5D9N53ZltOzSDyHbXL6TOzW5VZtvdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgFOGun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:50:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728614AbgFOGuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:50:35 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B3C1208C3;
        Mon, 15 Jun 2020 06:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592203832;
        bh=+YB9j5KRX8bJJCciec3l9jzw9TCQBre/YEU3QDQFNpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ShdKLzigIfIbQS+JnF76g0mB3+PWJaxlGDJvW6pQ7OekuOFAg+haB+1QYQCgST/4M
         xuuvYjxaDg0xgmx/Epi34L56/PQilUjlCnY4o4pQSDnNxKiKkAiMl5/EaRfBKFB2qQ
         Pbl9X9FN7yRPUk6tsRN51IW+Pux8DgzgVFTBg6L0=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jkiww-009o6T-Et; Mon, 15 Jun 2020 08:50:30 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 14/22] docs: arm64: convert perf.txt to ReST format
Date:   Mon, 15 Jun 2020 08:50:19 +0200
Message-Id: <c99bebf166559e9098a9eb78fb2eab2847fffb05.1592203650.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592203650.git.mchehab+huawei@kernel.org>
References: <cover.1592203650.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file is almost in ReST. All it needs is a rename and
adding a :field: for the two fields at the beginning
(author and date).

While here, add a proper SPDX header, and use the standard
markup for document titles, just for consistency.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/arm64/index.rst              | 1 +
 Documentation/arm64/{perf.txt => perf.rst} | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)
 rename Documentation/arm64/{perf.txt => perf.rst} (95%)

diff --git a/Documentation/arm64/index.rst b/Documentation/arm64/index.rst
index 09cbb4ed2237..d9665d83c53a 100644
--- a/Documentation/arm64/index.rst
+++ b/Documentation/arm64/index.rst
@@ -14,6 +14,7 @@ ARM64 Architecture
     hugetlbpage
     legacy_instructions
     memory
+    perf
     pointer-authentication
     silicon-errata
     sve
diff --git a/Documentation/arm64/perf.txt b/Documentation/arm64/perf.rst
similarity index 95%
rename from Documentation/arm64/perf.txt
rename to Documentation/arm64/perf.rst
index 0d6a7d87d49e..9c76a97baf28 100644
--- a/Documentation/arm64/perf.txt
+++ b/Documentation/arm64/perf.rst
@@ -1,8 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
 Perf Event Attributes
 =====================
 
-Author: Andrew Murray <andrew.murray@arm.com>
-Date: 2019-03-06
+:Author: Andrew Murray <andrew.murray@arm.com>
+:Date: 2019-03-06
 
 exclude_user
 ------------
-- 
2.26.2

