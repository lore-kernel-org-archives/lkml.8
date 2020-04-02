Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE40C2BA18
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBF0206E9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DuErtYTM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390072AbgDBSsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 14:48:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41407 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390010AbgDBSsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 14:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585853319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v7Q48lYxslciByEQ33ox9gAR58LiX+bslgB2j4RAZZg=;
        b=DuErtYTM+PQ7RkBZwhDtUPc960ubSlNRe3A//sZywqkvV8tYadsioHYcaTcTflhfV/hZeu
        KFio+MfLQAdKff8XfTDDLyOOP1Ea7H73d6oJ0FMVOjaFjQn/Pe+fo5IWdbMN4VfcT20hVF
        15wqSMsb/JiBneo04eLekiGq3VNlhtc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-tcmxRi3mOCKRGGysVKZOQQ-1; Thu, 02 Apr 2020 14:48:38 -0400
X-MC-Unique: tcmxRi3mOCKRGGysVKZOQQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BDD7107ACC4;
        Thu,  2 Apr 2020 18:48:36 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-29.ams2.redhat.com [10.36.114.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8801460BF3;
        Thu,  2 Apr 2020 18:48:34 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 5/5] KVM: s390: vsie: gmap_table_walk() simplifications
Date:   Thu,  2 Apr 2020 20:48:19 +0200
Message-Id: <20200402184819.34215-6-david@redhat.com>
In-Reply-To: <20200402184819.34215-1-david@redhat.com>
References: <20200402184819.34215-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's use asce_type where applicable. Also, simplify our sanity check for
valid table levels and convert it into a WARN_ON_ONCE(). Check if we even
have a valid gmap shadow as the very first step.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/gmap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index fd32ab566f57..3c801dae7988 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -790,17 +790,18 @@ static inline unsigned long *gmap_table_walk(struct=
 gmap *gmap,
 	const int asce_type =3D gmap->asce & _ASCE_TYPE_MASK;
 	unsigned long *table;
=20
-	if ((gmap->asce & _ASCE_TYPE_MASK) + 4 < (level * 4))
-		return NULL;
 	if (gmap_is_shadow(gmap) && gmap->removed)
 		return NULL;
=20
+	if (WARN_ON_ONCE(level > (asce_type >> 2) + 1))
+		return NULL;
+
 	if (WARN_ON_ONCE(asce_type !=3D _ASCE_TYPE_REGION1) &&
 			 gaddr & (-1UL << (31 + (asce_type >> 2) * 11)))
 		return NULL;
=20
 	table =3D gmap->table;
-	switch (gmap->asce & _ASCE_TYPE_MASK) {
+	switch (asce_type) {
 	case _ASCE_TYPE_REGION1:
 		table +=3D (gaddr & _REGION1_INDEX) >> _REGION1_SHIFT;
 		if (level =3D=3D 4)
--=20
2.25.1

