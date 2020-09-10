Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85140C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33A0020684
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+q+IN+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbgIJKAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:00:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36604 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730817AbgIJJ7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599731985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HsRNqO1jNDthQ2jBVeyD19nc312WnF2mZEFoahg3RLo=;
        b=C+q+IN+KgmRM/M3Wno/mhP4ckfy0Xfo7X0YNd7XHaaiK/ITA7npbaltq0snWkhl3YClG2Y
        LzNW8CkKGcQqX2CVW2qe8nsrMfCES4KlHFnp087dwuYfovx394mhM5gOUNGpi8ZpZ0bh6x
        eWvQSSbXQD2avhXZHxh4+1a+JOESbwU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-Qdh9D_A_MaC2_Fiv7Cem4w-1; Thu, 10 Sep 2020 05:59:43 -0400
X-MC-Unique: Qdh9D_A_MaC2_Fiv7Cem4w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AD828018A1;
        Thu, 10 Sep 2020 09:59:42 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-123.bne.redhat.com [10.64.54.123])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 647E77E173;
        Thu, 10 Sep 2020 09:59:40 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v2 1/3] arm64/mm: Remove CONT_RANGE_OFFSET
Date:   Thu, 10 Sep 2020 19:59:34 +1000
Message-Id: <20200910095936.20307-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro was introduced by commit <ecf35a237a85> ("arm64: PTE/PMD
contiguous bit definition") at the beginning. It's only used by
commit <348a65cdcbbf> ("arm64: Mark kernel page ranges contiguous"),
which was reverted later by commit <667c27597ca8>. This makes the
macro unused.

This removes the unused macro (CONT_RANGE_OFFSET).

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index d400a4d9aee2..8a399e666837 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -98,8 +98,6 @@
 #define CONT_PMDS		(1 << (CONT_PMD_SHIFT - PMD_SHIFT))
 #define CONT_PMD_SIZE		(CONT_PMDS * PMD_SIZE)
 #define CONT_PMD_MASK		(~(CONT_PMD_SIZE - 1))
-/* the numerical offset of the PTE within a range of CONT_PTES */
-#define CONT_RANGE_OFFSET(addr) (((addr)>>PAGE_SHIFT)&(CONT_PTES-1))
 
 /*
  * Hardware page table definitions.
-- 
2.23.0

