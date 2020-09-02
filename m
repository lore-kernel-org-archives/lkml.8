Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A85C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C90A02083B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="S1ka07XL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vOM8SLwb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgIBSGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:06:43 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41175 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726567AbgIBSGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:06:34 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 45A6A5C0150;
        Wed,  2 Sep 2020 14:06:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 02 Sep 2020 14:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=BMorf3eXecNKl
        H7Og7d/a2LFgjFUH2s538ZL40vPoMM=; b=S1ka07XLcVy/MEwyYQQLdq5MMrvIN
        BVYTs5kA1XKydBgD2prQYhC1XuYcqKuRwdpwxsoVZrMrzc53vwZ/VbdMAmqud4e7
        kcnpPpJ8dMaXpFQKb+A4iUvq1ZL+MmQJuKKY2IutfabDsDVU5YwAimNJrOx2BHip
        c9mzFK/v58rZKkga3x6/Rz+EW70taXa1N1LeiuDgAhHbGP6n0SqAmHiSKr70x/IG
        XBOZFT6UteDCDRGVB7glRFjp+fDSy4OqaV0UVhXtX0LtlwvPLxNHNClY54xMyhvK
        tHjq7cMNJaBA8YBeEr4uLXbvFcb+QjrmHRUSlx1DZu51dvO7ypr/HQHvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=BMorf3eXecNKlH7Og7d/a2LFgjFUH2s538ZL40vPoMM=; b=vOM8SLwb
        2XsKEmgyTZDsilXBWFEx1lOB7+OIn7JslP62C+9Kph3REvyh3/GFAEAyVXq2/QZE
        AQ3H/bf7YjdsHmRDiGCPUOHmp2OHVZL+y7PJspOe9tMOBIxhtZX1rWyvvWibKj/g
        T21vTpO43QPP76Cc2T53VZygIY5GgBCzQaYVfqZhCSNxP5QQuDsBC7e4Gq0+OHN2
        lBYfdxh8cl+PoqgszrYsm866A6F14rodJKPT1elM9ArxIR90Z1s0HG9UabNDNdxQ
        xLycRN8KL5gBOD/KvLcNMmLFZoSAkpZ5AYHJSQAp6CgbdRpUXG+XSJDBAeyd3Vfv
        MVFjRKKObf3SCQ==
X-ME-Sender: <xms:J99PX76dUOfiz1hoQ4Zq8enqRCnhHH6VdAIho7UX4BwJdniNk6nHGg>
    <xme:J99PXw76KWI2q8-63pvOt0VdqP4ohr2Q4ViIhdeQ2rW72JrxFTjCq8Ntlb6UvqS1h
    t9XJsQ_yAc_G5Qb9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhf
    ffveektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphep
    uddvrdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:J99PXydk0CLV7KXZbBV4ZV6xCy13mk6FzzwOlCDzsFhwktufiOkSBw>
    <xmx:J99PX8IajXey4R1cmtPEVQpwZkxXL8OGUxDyduvKQrtgJF_e4MwYFQ>
    <xmx:J99PX_J0OtBdjE5tjvjGKBKR-CwnHUcA-o4WSYht779a8YrvjR0LYQ>
    <xmx:KN9PX8ojXsFnJHyZkGycYQjS7uuJuDddCcjsuOr71IWRKoxGWcvFzw>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6E1A43060272;
        Wed,  2 Sep 2020 14:06:31 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>
Cc:     Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 03/16] mm: proc: add 1GB THP kpageflag.
Date:   Wed,  2 Sep 2020 14:06:15 -0400
Message-Id: <20200902180628.4052244-4-zi.yan@sent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902180628.4052244-1-zi.yan@sent.com>
References: <20200902180628.4052244-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Bit 27 is used to identify 1GB THP.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 fs/proc/page.c                         | 2 ++
 include/uapi/linux/kernel-page-flags.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index f3b39a7d2bf3..e4e2ad3612c9 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -161,6 +161,8 @@ u64 stable_page_flags(struct page *page)
 			u |= BIT_ULL(KPF_ZERO_PAGE);
 			u |= BIT_ULL(KPF_THP);
 		}
+		if (compound_order(head) == HPAGE_PUD_ORDER)
+			u |= 1 << KPF_PUD_THP;
 	} else if (is_zero_pfn(page_to_pfn(page)))
 		u |= BIT_ULL(KPF_ZERO_PAGE);
 
diff --git a/include/uapi/linux/kernel-page-flags.h b/include/uapi/linux/kernel-page-flags.h
index 6f2f2720f3ac..cdeb33ab655c 100644
--- a/include/uapi/linux/kernel-page-flags.h
+++ b/include/uapi/linux/kernel-page-flags.h
@@ -36,5 +36,7 @@
 #define KPF_ZERO_PAGE		24
 #define KPF_IDLE		25
 #define KPF_PGTABLE		26
+#define KPF_PUD_THP		27
+
 
 #endif /* _UAPILINUX_KERNEL_PAGE_FLAGS_H */
-- 
2.28.0

