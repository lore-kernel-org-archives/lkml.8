Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DEEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6C4320782
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SjHvu6t6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgGCNjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 09:39:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47620 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726048AbgGCNje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 09:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593783573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EtLhU2i77FUsXNVo6j8K13haqXLSgGlY+OveqDaP62E=;
        b=SjHvu6t61KO3gOcrERoyu/WE5h0skCGm9V2Yb03idyEh3FGchE22hfXiXiQWQrz2GSr9KX
        MvNUOrL2X9ByEM5B36ychPkBCAZyYZHZb8RuJSuMZobERfVpgYcYrb8XqEsx0JkjOfxz27
        PoMY7oVrYRg8aBKMYUK20KnEcG4TqIs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-6sH34XU6PR28k09ORBufAA-1; Fri, 03 Jul 2020 09:39:31 -0400
X-MC-Unique: 6sH34XU6PR28k09ORBufAA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 420861902EA8;
        Fri,  3 Jul 2020 13:39:30 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-0.ams2.redhat.com [10.36.114.0])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A2AA67AC75;
        Fri,  3 Jul 2020 13:39:28 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: [PATCH v1 4/9] s390/vmemmap: cleanup when vmemmap_populate() fails
Date:   Fri,  3 Jul 2020 15:39:12 +0200
Message-Id: <20200703133917.39045-5-david@redhat.com>
In-Reply-To: <20200703133917.39045-1-david@redhat.com>
References: <20200703133917.39045-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup what we partially added in case vmemmap_populate() fails.

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/vmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 16e109c292bf5..bcddabd509da8 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -364,6 +364,8 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	}
 	ret = 0;
 out:
+	if (ret)
+		vmemmap_free(start, end, altmap);
 	return ret;
 }
 
-- 
2.26.2

