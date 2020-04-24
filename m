Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCF2C2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 05:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC04E20774
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 05:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fgNnWdwW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgDXFCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 01:02:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23931 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725919AbgDXFCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 01:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587704570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hH9lbE6SFnNo0tAhCp7KPnS9UdSxpybxkGRDirKuis4=;
        b=fgNnWdwWstWNHcJEWrSVzzSALGCnLFqWqvUiD8qAryAtzaGpR10u+P2Q79vtnttYE8UETT
        ZKNLMR3eGeJ7n439ztf+lwk2vpyTHggzwhg05eax4aC28uEglaoiaApY4cyosnsxHVGW/T
        soRMa9CBFTr01sQWYD5z2MJvD6i9riA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-VDaNjlOSO9uzyF2A73z_CQ-1; Fri, 24 Apr 2020 01:02:45 -0400
X-MC-Unique: VDaNjlOSO9uzyF2A73z_CQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07EA91800D42;
        Fri, 24 Apr 2020 05:02:44 +0000 (UTC)
Received: from localhost.localdomain.com (vpn2-54-127.bne.redhat.com [10.64.54.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 745765C1C8;
        Fri, 24 Apr 2020 05:02:40 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, steve.capper@arm.com, broonie@kernel.org,
        mark.rutland@arm.com, shan.gavin@gmail.com
Subject: [PATCH] arm64/kernel: Fix range on invalidating dcache for boot page tables
Date:   Fri, 24 Apr 2020 15:02:30 +1000
Message-Id: <20200424050230.16720-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MMU is disabled when __create_page_tables() is called. The data
cache corresponding to these two page tables, which are tracked by
@idmap_pg_dir and @init_pg_dir, is invalidated after the page tables
are populated. However, the wrong or inappropriate size have been used
and more data cache are invalidated than it need.

This fixes the issue by invalidating the data cache for these two
page tables separately as they aren't necessarily physically adjacent.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kernel/head.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 57a91032b4c2..66947873c9e7 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -398,6 +398,10 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 	 * tables again to remove any speculatively loaded cache lines.
 	 */
 	adrp	x0, idmap_pg_dir
+	mov	x1, #IDMAP_DIR_SIZE
+	dmb	sy
+	bl	__inval_dcache_area
+	adrp	x0, init_pg_dir
 	adrp	x1, init_pg_end
 	sub	x1, x1, x0
 	dmb	sy
--=20
2.23.0

