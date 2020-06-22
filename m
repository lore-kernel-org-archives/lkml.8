Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EB2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 163B92073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592865853;
	bh=2xIrVg64kndWbqniUMgYzth4/meHGaDYEbL6L9UyYO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zaqXm8be+pTcaxYqZnuknxeGHqsjjDbbl0aypt3zPqaFEIxSV4IgxvBiTdBHJDO/C
	 Osd3vf/hV8g2MLBcJfkiIVzJpWTpqPamT40/6bP0owrBR3jDl6UursX4RqmDuSI5Rb
	 nHLbih0Ng7GKGiGGI1OKbA1aEc0XpgRmw2fIlZHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbgFVWoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:44:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731298AbgFVWnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:43:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D7DA207DD;
        Mon, 22 Jun 2020 22:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592865790;
        bh=2xIrVg64kndWbqniUMgYzth4/meHGaDYEbL6L9UyYO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nSmrBE2p+eUHlDu46RKValV2hgi5pLwx+ofxOE6OvwhHhZGaAbnZpS4TYJA9NY6rK
         jG9I87cY7OsS9GozbeH1svg2BFVz6EfYhns6gH0YZsBsnMKUKEhST1/Wziw/j6Hf+y
         a532pbUHRYUIVx2OqfJKzbdutFqbyTxupuk2WGeg=
From:   Sasha Levin <sashal@kernel.org>
To:     peterz@infradead.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jolsa@redhat.com, alexey.budankov@linux.intel.com,
        songliubraving@fb.com, acme@redhat.com, allison@lohutok.net,
        sashal@kernel.org
Subject: [PATCH v3 06/14] tools bitmap: add bitmap_clear definition
Date:   Mon, 22 Jun 2020 18:42:50 -0400
Message-Id: <20200622224258.1208588-7-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622224258.1208588-1-sashal@kernel.org>
References: <20200622224258.1208588-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed as a result of de4643a77356 ("locking/lockdep: Reuse lock
chains that have been freed").

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bitmap.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
index b6bc037623fc1..873176c501e43 100644
--- a/tools/lib/bitmap.c
+++ b/tools/lib/bitmap.c
@@ -101,3 +101,23 @@ int __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
 			BITMAP_LAST_WORD_MASK(bits));
 	return result != 0;
 }
+
+void bitmap_clear(unsigned long *map, unsigned int start, int len)
+{
+	unsigned long *p = map + BIT_WORD(start);
+	const unsigned int size = start + len;
+	int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
+	unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
+
+	while (len - bits_to_clear >= 0) {
+		*p &= ~mask_to_clear;
+		len -= bits_to_clear;
+		bits_to_clear = BITS_PER_LONG;
+		mask_to_clear = ~0UL;
+		p++;
+	}
+	if (len) {
+		mask_to_clear &= BITMAP_LAST_WORD_MASK(size);
+		*p &= ~mask_to_clear;
+	}
+}
-- 
2.25.1

