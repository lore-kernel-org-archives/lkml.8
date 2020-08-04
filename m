Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6BFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 04:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11E6F206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 04:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aInUy2l/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgHDEty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 00:49:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57637 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726000AbgHDEty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 00:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596516593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=brruNto447gdGe8l1KSPKI5nKJ5Ysuz0ADqZU4+gCh4=;
        b=aInUy2l/iCOB5KOzTxMIPNarUgyJ/RctbVA5sLiR3SQzmHfpdLKP59Y175Ehx4G4XfgCvv
        2YuSlVNmBv4hrGL+PWzVxFFgisUtmrzeBfRLp2KXfl5INw1jyHrE447uda56goBWwNPF1d
        ND3sVAGRmH9VMxFkTidM/Nj2P5pXA0k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-f67KdJOHOo-JCm-z6MgtJA-1; Tue, 04 Aug 2020 00:49:48 -0400
X-MC-Unique: f67KdJOHOo-JCm-z6MgtJA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3E98E91B;
        Tue,  4 Aug 2020 04:49:47 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-21.pek2.redhat.com [10.72.12.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C42E10013D7;
        Tue,  4 Aug 2020 04:49:43 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, x86@kernel.org, hpa@zytor.com, dyoung@redhat.com,
        bhe@redhat.com, k-hagio@ab.jp.nec.com
Subject: [PATCH 1/3] x86/crash: Correct the address boundary of function parameters
Date:   Tue,  4 Aug 2020 12:49:31 +0800
Message-Id: <20200804044933.1973-2-lijiang@redhat.com>
In-Reply-To: <20200804044933.1973-1-lijiang@redhat.com>
References: <20200804044933.1973-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's carefully handle the boundary of the function parameter to make
sure that the arguments passed doesn't exceed the address range.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 arch/x86/kernel/crash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index fd87b59452a3..a8f3af257e26 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -230,7 +230,7 @@ static int elf_header_exclude_ranges(struct crash_mem *cmem)
 	int ret = 0;
 
 	/* Exclude the low 1M because it is always reserved */
-	ret = crash_exclude_mem_range(cmem, 0, 1<<20);
+	ret = crash_exclude_mem_range(cmem, 0, (1<<20)-1);
 	if (ret)
 		return ret;
 
-- 
2.17.1

