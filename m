Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41533C2D0A7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 070BE218AC
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIt2V0AI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbgIHHUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:20:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48047 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729143AbgIHHT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599549596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oAK5y1+Xvz1lIhReUB6ZQQkskl47YwSrG+rKXr4g4Tc=;
        b=dIt2V0AIblRJN4ROVR+EZdl0PTyOaEhNgDtI1/LVIHw6XwBo+UtMKoO+XKZbYvdObp5oK8
        UAFMNMnsVHDE4h20v2q9Z+zyxWEnRsUBEpGkEgannPujlk08vRetIYzXAfdTO+rt/MzXGv
        iVdgpktkWtXzNBl26H1VaMzb7gCBG8Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-zYRkH69sOAatOO8XY33R9w-1; Tue, 08 Sep 2020 03:19:54 -0400
X-MC-Unique: zYRkH69sOAatOO8XY33R9w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C17B2FD04;
        Tue,  8 Sep 2020 07:19:53 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-90.bne.redhat.com [10.64.54.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C38A1972A;
        Tue,  8 Sep 2020 07:19:51 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, anshuman.khandual@arm.com, shan.gavin@gmail.com
Subject: [PATCH 2/2] arm64/mm: Use CONT_SHIFT to define CONT_PTE_SHIFT
Date:   Tue,  8 Sep 2020 17:19:31 +1000
Message-Id: <20200908071931.47767-2-gshan@redhat.com>
In-Reply-To: <20200908071931.47767-1-gshan@redhat.com>
References: <20200908071931.47767-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro CONT_PTE_SHIFT actually depends on CONT_SHIFT, which has
been defined in page-def.h, based on CONFIG_ARM64_CONT_SHIFT. Lets
reflect the dependency.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 8a399e666837..0bd9469f4323 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -81,14 +81,12 @@
 /*
  * Contiguous page definitions.
  */
+#define CONT_PTE_SHIFT		(CONT_SHIFT + PAGE_SHIFT)
 #ifdef CONFIG_ARM64_64K_PAGES
-#define CONT_PTE_SHIFT		(5 + PAGE_SHIFT)
 #define CONT_PMD_SHIFT		(5 + PMD_SHIFT)
 #elif defined(CONFIG_ARM64_16K_PAGES)
-#define CONT_PTE_SHIFT		(7 + PAGE_SHIFT)
 #define CONT_PMD_SHIFT		(5 + PMD_SHIFT)
 #else
-#define CONT_PTE_SHIFT		(4 + PAGE_SHIFT)
 #define CONT_PMD_SHIFT		(4 + PMD_SHIFT)
 #endif
 
-- 
2.23.0

