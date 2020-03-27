Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD8DC2D0EB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 02:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CD9206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 02:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="ZprMO5g5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgC2C2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 22:28:01 -0400
Received: from ushosting.nmnhosting.com ([66.55.73.32]:35428 "EHLO
        ushosting.nmnhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbgC2C2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 22:28:00 -0400
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
        by ushosting.nmnhosting.com (Postfix) with ESMTPS id 9F2462DC6831;
        Fri, 27 Mar 2020 18:12:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
        s=201810a; t=1585293142;
        bh=HPdDJ0enxYWuoioAjwzepK5FMG95uTKM1kU7cOk1haY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZprMO5g5LCg0oRdH2K3uXz8l4c6L9W1d9Mxd3y9LbAARGZu9kt6uIz9A3MEUOedWV
         g7DqMLDrr2m/TH6d6yrJtFgEOg9BlrSv1R2NLozkVnU6OkgsrVmJx9BBn8aI/Sn62O
         w/5CiI+YX0ODTMBr8YVhJA07fuOcUVGHda3b5a9mGukeXcANsMAjZc4Gg4MUBM/PoJ
         Jnr9+eXE1sX7vtXdpSE1woIPFaLHakSy5NHhRbC+k3KhNv5RH6TZ6A/u+iDAiiRCE5
         N06lRZtlEVFMlb5wR4Jid5B9ENUsU6ZZPEVYF/txRgiW4MKAS+CcjtkONcUOSmYaD9
         ppYmaM2ef6S8tshDUjxJypHcy1+sz3bZZrRF+2nIuWjpwN2hZGDxRVKHsZfKZhVqQF
         sblZp70rrN6e/kpXRz/acmkv2yO8Fa77dlC3P84DeB/nV2oDsJDuyI07z13vZ/Bmuj
         o26AIi8KDpxo1HfGM10O/KoPFg3TtC7iqbL2WVTgVmat/MkiiY9qOLW8neZfNnPbUY
         Yfawn1JU84te5v7VgBv+fKxvfyGbsXV1RLhC09q4r5qhGolccVrWWCbRAXVplfwLiE
         ko6h2lMIzDuDXQc0NNcn6PH9aJ9muG0dIOvlWkH8pN4W1vzD3LNkEswpP0E7Hqf3M9
         jksprRXa8oR2y8sUhkAlZwgY=
Received: from localhost.lan ([10.0.1.179])
        by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTP id 02R7C4Ab045934;
        Fri, 27 Mar 2020 18:12:14 +1100 (AEDT)
        (envelope-from alastair@d-silva.org)
From:   "Alastair D'Silva" <alastair@d-silva.org>
To:     alastair@d-silva.org
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org
Subject: [PATCH v4 02/25] mm/memory_hotplug: Allow check_hotplug_memory_addressable to be called from drivers
Date:   Fri, 27 Mar 2020 18:11:39 +1100
Message-Id: <20200327071202.2159885-3-alastair@d-silva.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327071202.2159885-1-alastair@d-silva.org>
References: <20200327071202.2159885-1-alastair@d-silva.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Fri, 27 Mar 2020 18:12:14 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When setting up OpenCAPI connected persistent memory, the range check may
not be performed until quite late (or perhaps not at all, if the user does
not establish a DAX device).

This patch makes the range check callable so we can perform the check while
probing the OpenCAPI Persistent Memory device.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
---
 include/linux/memory_hotplug.h | 5 +++++
 mm/memory_hotplug.c            | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index f4d59155f3d4..9a19ae0d7e31 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -337,6 +337,11 @@ static inline void __remove_memory(int nid, u64 start, u64 size) {}
 extern void set_zone_contiguous(struct zone *zone);
 extern void clear_zone_contiguous(struct zone *zone);
 
+#ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
+int check_hotplug_memory_addressable(unsigned long pfn,
+				     unsigned long nr_pages);
+#endif /* CONFIG_MEMORY_HOTPLUG_SPARSE */
+
 extern void __ref free_area_init_core_hotplug(int nid);
 extern int __add_memory(int nid, u64 start, u64 size);
 extern int add_memory(int nid, u64 start, u64 size);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0a54ffac8c68..14945f033594 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -276,8 +276,8 @@ static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
 	return 0;
 }
 
-static int check_hotplug_memory_addressable(unsigned long pfn,
-					    unsigned long nr_pages)
+int check_hotplug_memory_addressable(unsigned long pfn,
+				     unsigned long nr_pages)
 {
 	const u64 max_addr = PFN_PHYS(pfn + nr_pages) - 1;
 
-- 
2.24.1

