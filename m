Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204FDC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED5C32068E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592203852;
	bh=0FDpCcyOHs9npTrM/vqzM1KDRzFZDNDM09XG5SNpJz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QychR3R6BjVYQMeF+ZIRc4XaeRZIrOPkPybWYWsCd0SgtIvNH5HL1AjBf9+SRSpJz
	 8sfpz0psy5EIJTgWFVg3rjKRVPrWp4wzwWOaxcZbiFyZ/xg1+fbIPPCVtZIpQ79Cya
	 0YU1PA7ZJ17e8ZDjBfjNPfm9LQ5UGo6aZ9qkJSRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgFOGuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:50:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728859AbgFOGuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:50:35 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A51892100A;
        Mon, 15 Jun 2020 06:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592203832;
        bh=0FDpCcyOHs9npTrM/vqzM1KDRzFZDNDM09XG5SNpJz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W9ZHBzolfkL/P5RA3uP23OUFke8vJoCSfAKpRVi7IESjbSVanSsJLvn/75KkXyVsO
         APryu/rRaFWpHaHMLdRKwWcKlE4vz6pIT2jXciJXjrfIhfHXMO49GxNcfL3IAk1IB7
         FFOOAo9ZI7c0we+0hdeIIHXvlpuRjwBIQWD8Up4s=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jkiww-009o78-QD; Mon, 15 Jun 2020 08:50:30 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 22/22] docs: staging: use small font for literal includes
Date:   Mon, 15 Jun 2020 08:50:27 +0200
Message-Id: <2657bf99f750a9c53539c1a4085492a0daaa6d10.1592203650.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592203650.git.mchehab+huawei@kernel.org>
References: <cover.1592203650.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The normal font is too big to display 80 columns, causing extra
breaks to be added at weird places.

change to the footnotesize, as this would fit a little bit
better.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/staging/index.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/staging/index.rst b/Documentation/staging/index.rst
index 8cc9d94b0a13..184e6aece0a7 100644
--- a/Documentation/staging/index.rst
+++ b/Documentation/staging/index.rst
@@ -19,17 +19,41 @@ Unsorted Documentation
 Atomic Types
 ============
 
+.. raw:: latex
+
+    \footnotesize
+
 .. include:: ../atomic_t.txt
    :literal:
 
+.. raw:: latex
+
+    \normalsize
+
 Atomic bitops
 =============
 
+.. raw:: latex
+
+    \footnotesize
+
 .. include:: ../atomic_bitops.txt
    :literal:
 
+.. raw:: latex
+
+    \normalsize
+
 Memory Barriers
 ===============
 
+.. raw:: latex
+
+    \footnotesize
+
 .. include:: ../memory-barriers.txt
    :literal:
+
+.. raw:: latex
+
+    \normalsize
-- 
2.26.2

