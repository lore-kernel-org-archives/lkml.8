Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E89C2BA19
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 01:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0F8821924
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 01:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587261495;
	bh=HMEfugFBvc5umQcTHnoaP2Bt0YBDBgmi/pSbN/qFl8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LRRrhJS5azyP/sGdpVckX22kdWYFa9KuUdiH1AVIEy3qAkSm/KwdtrEIyXzoGkPzG
	 VFbYraCFtn+AyrCSM46m3IT1Jbkr01S2jDOqwYBjE+lw2rBHgkpNc5222fyRfTVZcJ
	 u7932+TKCz/FSSeqoJHOqCssf/Xn2P0svSZDG8ZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgDSB6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 21:58:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbgDSB6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 21:58:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E49982223D;
        Sun, 19 Apr 2020 01:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587261487;
        bh=HMEfugFBvc5umQcTHnoaP2Bt0YBDBgmi/pSbN/qFl8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lTOYfcXWT0f25ln/WQNPQ7DoCDyW9BX7jYyEEQOYLCRphLc8jpDhydQKs7fY0z4d7
         n85qJRYFJIXUU67sBo8yX8+xQSsozvLDfvzzBBjkrEYF8OUu4jGy4BKY2GidsQ3eIc
         1e4xpYsJBfOdpwkGkqSLkC8ILGS0aXHr0ZFklepw=
From:   Sasha Levin <sashal@kernel.org>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        alexey.budankov@linux.intel.com, songliubraving@fb.com,
        acme@redhat.com, allison@lohutok.net,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v2 07/12] tools bitmap: add bitmap_clear definition
Date:   Sat, 18 Apr 2020 21:57:49 -0400
Message-Id: <20200419015754.24456-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419015754.24456-1-sashal@kernel.org>
References: <20200419015754.24456-1-sashal@kernel.org>
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
2.20.1

