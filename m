Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBF9C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0212C206E9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PoLncuub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389946AbgDBSsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 14:48:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60528 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389123AbgDBSsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 14:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585853311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bo/SIfmVuQxtNcfVHbbkR511KgXolpkFsV3XDhMlwBo=;
        b=PoLncuubioGu6//VRpBc+LwFNSx8m6pFcglP1wVmg+WwcZWYUSEsh/JvBMjCXnsFTcoYXu
        tt/btx6wH9cLy4SA4LdcIt5I08J6J7BZY8aen+2cHKDe0Snvs1V3n6dSi6a60oa/Ct66Cu
        GCAMAeCRdvT+zwDyd/foR9Jr+ovNLZ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-zGOKMzHDPR6yJnmedVHzOQ-1; Thu, 02 Apr 2020 14:48:29 -0400
X-MC-Unique: zGOKMzHDPR6yJnmedVHzOQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6946A8017F5;
        Thu,  2 Apr 2020 18:48:27 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-29.ams2.redhat.com [10.36.114.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B1D660BF3;
        Thu,  2 Apr 2020 18:48:25 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Hildenbrand <david@redhat.com>, stable@vger.kernel.org
Subject: [PATCH v1 1/5] KVM: s390: vsie: Fix region 1 ASCE sanity shadow address checks
Date:   Thu,  2 Apr 2020 20:48:15 +0200
Message-Id: <20200402184819.34215-2-david@redhat.com>
In-Reply-To: <20200402184819.34215-1-david@redhat.com>
References: <20200402184819.34215-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case we have a region 1 ASCE, our shadow/g3 address can have any value=
.
Unfortunately, (-1UL << 64) is undefined and triggers sometimes,
rejecting valid shadow addresses when trying to walk our shadow table
hierarchy.

The result is that the prefix cannot get mapped and will loop basically
forever trying to map it (-EAGAIN loop).

After all, the broken check is only a sanity check, our table shadowing
code in kvm_s390_shadow_tables() already checks these conditions, injecti=
ng
proper translation exceptions. Turn it into a WARN_ON_ONCE().

Fixes: 4be130a08420 ("s390/mm: add shadow gmap support")
Cc: <stable@vger.kernel.org> # v4.8+
Reported-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/gmap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 2fbece47ef6f..f3dbc5bdde50 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -787,14 +787,18 @@ static void gmap_call_notifier(struct gmap *gmap, u=
nsigned long start,
 static inline unsigned long *gmap_table_walk(struct gmap *gmap,
 					     unsigned long gaddr, int level)
 {
+	const int asce_type =3D gmap->asce & _ASCE_TYPE_MASK;
 	unsigned long *table;
=20
 	if ((gmap->asce & _ASCE_TYPE_MASK) + 4 < (level * 4))
 		return NULL;
 	if (gmap_is_shadow(gmap) && gmap->removed)
 		return NULL;
-	if (gaddr & (-1UL << (31 + ((gmap->asce & _ASCE_TYPE_MASK) >> 2)*11)))
+
+	if (WARN_ON_ONCE(asce_type !=3D _ASCE_TYPE_REGION1) &&
+			 gaddr & (-1UL << (31 + (asce_type >> 2) * 11)))
 		return NULL;
+
 	table =3D gmap->table;
 	switch (gmap->asce & _ASCE_TYPE_MASK) {
 	case _ASCE_TYPE_REGION1:
--=20
2.25.1

