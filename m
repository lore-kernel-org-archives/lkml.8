Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AA7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBCE22065F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7rQ3oBN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgETIGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 04:06:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35326 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726436AbgETIGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 04:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589961968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=nFRT2Dwzeb1s4TncyaAvoKFX2GM9mDLYe58xsFJAsBQ=;
        b=X7rQ3oBNSzgorpV+7FI7Up+Gm/GsqzC048XZVqcCKALn2sEDTaftAyaKMZlRBBYmYuyyZO
        RTECwvkX3n9ut5GvvaQlnwjkWW43hCd4zw6iwoZhohLt/yK2vWhc+11RHYx8gMQ3fUNUmh
        XaG2HRYiljhY0L0Oc3E4U1Le+wFposI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-PybYBE1GPJ6AN7cxRRyUkQ-1; Wed, 20 May 2020 04:06:04 -0400
X-MC-Unique: PybYBE1GPJ6AN7cxRRyUkQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5F938018A5;
        Wed, 20 May 2020 08:06:03 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-22.pek2.redhat.com [10.72.12.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09DD85C1D0;
        Wed, 20 May 2020 08:05:58 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, dyoung@redhat.com,
        kexec@lists.infradead.org, vgoyal@redhat.com
Subject: [PATCH] MAINTAINERS: add files related to kdump
Date:   Wed, 20 May 2020 16:05:57 +0800
Message-Id: <20200520080557.13260-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kdump is implemented based on kexec, however some files are only
related to crash dumping and missing, add them to KDUMP entry.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 83cf5c43242a..2f9eefd33114 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9251,6 +9251,11 @@ L:	kexec@lists.infradead.org
 S:	Maintained
 W:	http://lse.sourceforge.net/kdump/
 F:	Documentation/admin-guide/kdump/
+F:	fs/proc/vmcore.c
+F:	include/linux/crash_core.h
+F:	include/linux/crash_dump.h
+F:	include/uapi/linux/vmcore.h
+F:	kernel/crash.*
 
 KEENE FM RADIO TRANSMITTER DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
-- 
2.17.2

