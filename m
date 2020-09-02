Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25179C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01D8D2083B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="XVaqdSTy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pCQuiEYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgIBSHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:07:39 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46339 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727947AbgIBSGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:06:42 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8D3115C01A5;
        Wed,  2 Sep 2020 14:06:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 02 Sep 2020 14:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=uOcSd2/dn38W3
        Qs9ZzkXcxJ7lzZXPjXumgXGRk3+suA=; b=XVaqdSTyUUvwRM3CSZfzfwBaRmW72
        50JZ5nA6SaruM2KVMvTK5XALc8GyKZmhjIXtgoMvme35mqwxPDZ+l3DGzRED5Klw
        hI/4FKLazf/c1W/pJy3SH3micGMvaFOYx97Kpf0UmY5TwERH1E3m37Q2sG1YQ05q
        pz6U6zcqaNjv5sVx88Oc0ey4zxLbFohFJA60Uwt5ehEkstCLEgVOPPpupFxn86DJ
        U5MBw+/9lCgE+Pd+RFC2bbtHNQARW3d+F4Ia40h8y7OkCd/qMNuzZEuPmnIdJvxu
        5dqUrBj3Pz0CxYvEvEHoOfQBc53NZtV9VdKFAlNgJ1Ray+X9wivQlBlbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=uOcSd2/dn38W3Qs9ZzkXcxJ7lzZXPjXumgXGRk3+suA=; b=pCQuiEYb
        GFhSIDEUlJCq8HAvwoXlbk/J/mROrisfgoalZO1s4ZZ8WjAa57Ax8LP2BiWefrru
        BDECL6N/1qyHb5My1GiTmtEneGFGC6LdvjkHjOw/jGuuQAPXHLu52GTPjsesTnAi
        VKcyJIrckGNPQl91h/KI5XDycDMqZD5n4+0jJLD0CJqA2OlWBeDMN4ukfaAd2I3V
        yrGHxXNDPcWC2AUZGuXhQ+LAI6/+71xH6ZA+XQVsv3EZgPOS1BcSEHEYlQsP9bFw
        WLxM7ngw8JJ8jszIy094WcNlshGbiKrMMfEZ3FHrMto5skGBi/FqPwQjloj562up
        XifL5G8cJlst9A==
X-ME-Sender: <xms:Kt9PX9mwP8srJqX5DP6FCsP_ME8dVxzWQCmznewXD3gVpE4Dbf19RA>
    <xme:Kt9PX41eA0FK5Rqs-HiCq3fhzhMYN2AdOgWSP27L2Jhb96geOpAAWtGT8_WCQpqBy
    Td_fogCbExZrqp0KQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhf
    ffveektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphep
    uddvrdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpeduvdenucfrrghrrg
    hmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:Kt9PXzpIvhyhxwlhQ035-6Tto2FQENXQJpiV6DAN7vDCs9yJZ5Gn0A>
    <xmx:Kt9PX9lIRFgExSI48kWl7cmtAVkbLvqvGf-3pSxuB8KbZRwjpjIJRA>
    <xmx:Kt9PX72-1YBT8ZwBGtAAW59oRgghG8vxYCO3VWW9M7xvEPvm7XFQlA>
    <xmx:Kt9PXwmm5TKUwt7xNES67Uy4AenDjLXU3BBJrdXadseo5G07WUc2Rw>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id CFCD73060067;
        Wed,  2 Sep 2020 14:06:33 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>
Cc:     Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 13/16] mm: thp: add a knob to enable/disable 1GB THPs.
Date:   Wed,  2 Sep 2020 14:06:25 -0400
Message-Id: <20200902180628.4052244-14-zi.yan@sent.com>
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

It does not affect existing 1GB THPs. It is similar to the knob for
2MB THPs.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/huge_mm.h | 14 ++++++++++++++
 mm/huge_memory.c        | 40 ++++++++++++++++++++++++++++++++++++++++
 mm/memory.c             |  2 +-
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index c7bc40c4a5e2..3bf8d8a09f08 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -119,6 +119,8 @@ enum transparent_hugepage_flag {
 #ifdef CONFIG_DEBUG_VM
 	TRANSPARENT_HUGEPAGE_DEBUG_COW_FLAG,
 #endif
+	TRANSPARENT_PUD_HUGEPAGE_FLAG,
+	TRANSPARENT_PUD_HUGEPAGE_REQ_MADV_FLAG,
 };
 
 struct kobject;
@@ -184,6 +186,18 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
 }
 
 bool transparent_hugepage_enabled(struct vm_area_struct *vma);
+static inline bool transparent_pud_hugepage_enabled(struct vm_area_struct *vma)
+{
+	if (transparent_hugepage_enabled(vma)) {
+		if (transparent_hugepage_flags & (1 << TRANSPARENT_PUD_HUGEPAGE_FLAG))
+			return true;
+		if (transparent_hugepage_flags &
+					(1 << TRANSPARENT_PUD_HUGEPAGE_REQ_MADV_FLAG))
+			return !!(vma->vm_flags & VM_HUGEPAGE);
+	}
+
+	return false;
+}
 
 #define HPAGE_CACHE_INDEX_MASK (HPAGE_PMD_NR - 1)
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e209c2dfc5b7..e1440a13da63 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -49,9 +49,11 @@
 unsigned long transparent_hugepage_flags __read_mostly =
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS
 	(1<<TRANSPARENT_HUGEPAGE_FLAG)|
+	(1<<TRANSPARENT_PUD_HUGEPAGE_FLAG)|
 #endif
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE_MADVISE
 	(1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG)|
+	(1<<TRANSPARENT_PUD_HUGEPAGE_REQ_MADV_FLAG)|
 #endif
 	(1<<TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG)|
 	(1<<TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG)|
@@ -199,6 +201,43 @@ static ssize_t enabled_store(struct kobject *kobj,
 static struct kobj_attribute enabled_attr =
 	__ATTR(enabled, 0644, enabled_show, enabled_store);
 
+static ssize_t enabled_1gb_show(struct kobject *kobj,
+			    struct kobj_attribute *attr, char *buf)
+{
+	if (test_bit(TRANSPARENT_PUD_HUGEPAGE_FLAG, &transparent_hugepage_flags))
+		return sprintf(buf, "[always] madvise never\n");
+	else if (test_bit(TRANSPARENT_PUD_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags))
+		return sprintf(buf, "always [madvise] never\n");
+	else
+		return sprintf(buf, "always madvise [never]\n");
+}
+
+static ssize_t enabled_1gb_store(struct kobject *kobj,
+			     struct kobj_attribute *attr,
+			     const char *buf, size_t count)
+{
+	ssize_t ret = count;
+
+	if (!memcmp("always", buf,
+		    min(sizeof("always")-1, count))) {
+		clear_bit(TRANSPARENT_PUD_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags);
+		set_bit(TRANSPARENT_PUD_HUGEPAGE_FLAG, &transparent_hugepage_flags);
+	} else if (!memcmp("madvise", buf,
+			   min(sizeof("madvise")-1, count))) {
+		clear_bit(TRANSPARENT_PUD_HUGEPAGE_FLAG, &transparent_hugepage_flags);
+		set_bit(TRANSPARENT_PUD_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags);
+	} else if (!memcmp("never", buf,
+			   min(sizeof("never")-1, count))) {
+		clear_bit(TRANSPARENT_PUD_HUGEPAGE_FLAG, &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_PUD_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags);
+	} else
+		ret = -EINVAL;
+
+	return ret;
+}
+static struct kobj_attribute enabled_1gb_attr =
+	__ATTR(enabled_1gb, 0644, enabled_1gb_show, enabled_1gb_store);
+
 ssize_t single_hugepage_flag_show(struct kobject *kobj,
 				struct kobj_attribute *attr, char *buf,
 				enum transparent_hugepage_flag flag)
@@ -305,6 +344,7 @@ static struct kobj_attribute hpage_pmd_size_attr =
 
 static struct attribute *hugepage_attr[] = {
 	&enabled_attr.attr,
+	&enabled_1gb_attr.attr,
 	&defrag_attr.attr,
 	&use_zero_page_attr.attr,
 	&hpage_pmd_size_attr.attr,
diff --git a/mm/memory.c b/mm/memory.c
index 184d8eb2d060..518f29a5903e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4305,7 +4305,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 	if (!vmf.pud)
 		return VM_FAULT_OOM;
 retry_pud:
-	if (pud_none(*vmf.pud) && __transparent_hugepage_enabled(vma)) {
+	if (pud_none(*vmf.pud) && transparent_pud_hugepage_enabled(vma)) {
 		ret = create_huge_pud(&vmf);
 		if (!(ret & VM_FAULT_FALLBACK))
 			return ret;
-- 
2.28.0

