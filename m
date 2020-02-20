Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BAAC11D0B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A617208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HsHPYZzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgBTPBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:01:35 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21700 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728133AbgBTPBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:01:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582210894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=akPGLEa5++8awpmZaCXevB0Sy30q2hFWMSty4YYV3yA=;
        b=HsHPYZzEw6D5Z9q62uLlAPKXEFdJ5icXZntPhGVEf2TQnrQzWr3XkZnMT7bBmaRoGczJok
        e55e0bh/Y3LFHp/2u9xuA2evWn7bzcBzZitvYyfozycqaXpMHv6qJ4hY6D3HKjTGKfPeHB
        osl5gVshiLfcNaK+8NiS85LCuUNO5Uw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-2zfB-8laOpmnJ97p9pu7aA-1; Thu, 20 Feb 2020 10:01:29 -0500
X-MC-Unique: 2zfB-8laOpmnJ97p9pu7aA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32C60800D5E;
        Thu, 20 Feb 2020 15:01:28 +0000 (UTC)
Received: from jsavitz.bos.com (dhcp-17-196.bos.redhat.com [10.18.17.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE08D1001B2C;
        Thu, 20 Feb 2020 15:01:23 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org
Subject: [PATCH] mm/page_alloc: increase default min_free_kbytes bound
Date:   Thu, 20 Feb 2020 10:01:03 -0500
Message-Id: <20200220150103.5183-1-jsavitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Currently, the vm.min_free_kbytes sysctl value is capped at a hardcoded
64M in init_per_zone_wmark_min (unless it is overridden by khugepaged
initialization).

This value has not been modified since 2005, and enterprise-grade
systems now frequently have hundreds of GB of RAM and multiple 10, 40,
or even 100 GB NICs. We have seen page allocation failures on heavily
loaded systems related to NIC drivers. These issues were resolved by an
increase to vm.min_free_kbytes.

This patch increases the hardcoded value by a factor of 4 as a temporary
solution.

Further work to make the calculation of vm.min_free_kbytes more
consistent throughout the kernel would be desirable.

As an example of the inconsistency of the current method, this value is
recalculated by init_per_zone_wmark_min() in the case of memory hotplug
which will override the value set by set_recommended_min_free_kbytes()
called during khugepaged initialization even if khugepaged remains
enabled, however an on/off toggle of khugepaged will then recalculate
and set the value via set_recommended_min_free_kbytes().

Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 mm/page_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3c4eb750a199..32cbfb13e958 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7867,8 +7867,8 @@ int __meminit init_per_zone_wmark_min(void)
 		min_free_kbytes =3D new_min_free_kbytes;
 		if (min_free_kbytes < 128)
 			min_free_kbytes =3D 128;
-		if (min_free_kbytes > 65536)
-			min_free_kbytes =3D 65536;
+		if (min_free_kbytes > 262144)
+			min_free_kbytes =3D 262144;
 	} else {
 		pr_warn("min_free_kbytes is not updated to %d because user defined val=
ue %d is preferred\n",
 				new_min_free_kbytes, user_min_free_kbytes);
--=20
2.23.0

