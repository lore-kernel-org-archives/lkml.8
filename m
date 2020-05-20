Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEB1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A32020823
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+V6+saF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbgETKgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 06:36:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51168 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726403AbgETKgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 06:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589971004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fibGvE/yM8HBV36UGpstPnUDuVU7B8SEDeE+kJB/Hjs=;
        b=E+V6+saFumUWahjBnTFTHod7JyklgBHVT6LGlXEpGgRn7E/8TmumtEZsN+otdvh+/lp4P+
        szb8K0SdX/5geqAr1UqKF0kwwUJNo4jHtejsbV5LNEeiN8qH4LJc/RNh+YGBKDoV8RZfOH
        RAq8cW2whBmfVIdbtUNWTwvJi2TdtZw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-yublpX5AMc2VKbFNJFISDw-1; Wed, 20 May 2020 06:36:41 -0400
X-MC-Unique: yublpX5AMc2VKbFNJFISDw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1408835B44;
        Wed, 20 May 2020 10:36:39 +0000 (UTC)
Received: from localhost (ovpn-12-22.pek2.redhat.com [10.72.12.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 90D651943D;
        Wed, 20 May 2020 10:36:36 +0000 (UTC)
Date:   Wed, 20 May 2020 18:36:33 +0800
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, akpm@linux-foundation.org,
        dyoung@redhat.com, vgoyal@redhat.com
Subject: [PATCH v2] MAINTAINERS: add files related to kdump
Message-ID: <20200520103633.GW5029@MiWiFi-R3L-srv>
References: <20200520080557.13260-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520080557.13260-1-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kdump is implemented based on kexec, however some files are only
related to crash dumping and missing, add them to KDUMP entry.

Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: Dave Young <dyoung@redhat.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 83cf5c43242a..29c26e7a7a47 100644
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
+F:	kernel/crash_*.c
 
 KEENE FM RADIO TRANSMITTER DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
-- 
2.17.2

