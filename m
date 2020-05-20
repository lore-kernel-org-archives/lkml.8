Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619EAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F0C120756
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BCUvdjCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgETG6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 02:58:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27964 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726369AbgETG6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 02:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589957881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=22TzjxdhHFi3fn0C24natifEiTLxnXkUr54Z/g+wEUs=;
        b=BCUvdjCBsf0EemBnvclEYaBY1bLa2ACyTX+yufBxQexzzmRcj9K5vxs0sJBa9xh4RQlMgh
        Ah9smhv4K5DX1zO2Rz14gt+UcnGEKFjAQk5IYuSP6USWznalKjBZeRTTo3e0tDBmptY0bm
        hIV+oukdnnzZMwPfl7EkPtQYNImL6tw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-DvYFG_85MiaNU-EosSvcVg-1; Wed, 20 May 2020 02:58:00 -0400
X-MC-Unique: DvYFG_85MiaNU-EosSvcVg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0FBC8005AA;
        Wed, 20 May 2020 06:57:58 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-246.pek2.redhat.com [10.72.13.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E92A526198;
        Wed, 20 May 2020 06:57:52 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     geert@linux-m68k.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        mst@redhat.com, Jason Wang <jasowang@redhat.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] m68k: add missing __user annotation in get_user()
Date:   Wed, 20 May 2020 14:57:50 +0800
Message-Id: <20200520065750.8401-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ptr is a pointer to userspace memory. So we need annotate it with
__user otherwise we may get sparse warnings like:

drivers/vhost/vhost.c:1603:13: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected void const *__gu_ptr @@    got unsigned int [noderef] [usertypvoid const *__gu_ptr @@
drivers/vhost/vhost.c:1603:13: sparse:    expected void const *__gu_ptr
drivers/vhost/vhost.c:1603:13: sparse:    got unsigned int [noderef] [usertype] <asn:1> *idxp

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 arch/m68k/include/asm/uaccess_mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/uaccess_mm.h b/arch/m68k/include/asm/uaccess_mm.h
index 7e85de984df1..9ae9f8d05925 100644
--- a/arch/m68k/include/asm/uaccess_mm.h
+++ b/arch/m68k/include/asm/uaccess_mm.h
@@ -142,7 +142,7 @@ asm volatile ("\n"					\
 		__get_user_asm(__gu_err, x, ptr, u32, l, r, -EFAULT);	\
 		break;							\
 	case 8: {							\
-		const void *__gu_ptr = (ptr);				\
+		const void __user *__gu_ptr = (ptr);			\
 		union {							\
 			u64 l;						\
 			__typeof__(*(ptr)) t;				\
-- 
2.20.1

