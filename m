Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A61C433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B701922B4D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQGITha4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgGTG0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 02:26:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57604 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727047AbgGTG0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 02:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595226402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=DQ44GDDWOoXYijKBtSDKp9+gTvNU3hs5hK0piRtS5Tg=;
        b=dQGITha4bL1QThg+vq7EmwRfy+aqtEdfwZiWeWDHbUreXe7Z7LRu/rI+jUov60DB4ibV0r
        av5FHMNM4DDUijQ4kEMXb3XvDPbDavev5pbW49hF8TfyHQCTSEO/QYrKh1oimrvmKE3L8N
        9wPJ6DZhv+hS5OScU2Cdhm41o+K/gfM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-Kcn4X5S3PRqPllyNyug-rw-1; Mon, 20 Jul 2020 02:26:37 -0400
X-MC-Unique: Kcn4X5S3PRqPllyNyug-rw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF0208014D4;
        Mon, 20 Jul 2020 06:26:36 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-150.pek2.redhat.com [10.72.12.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA1337852D;
        Mon, 20 Jul 2020 06:26:34 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, bhe@redhat.com
Subject: [PATCH 4/5] doc/vm: fix typo in in the hugetlb admin documentation
Date:   Mon, 20 Jul 2020 14:26:22 +0800
Message-Id: <20200720062623.13135-5-bhe@redhat.com>
In-Reply-To: <20200720062623.13135-1-bhe@redhat.com>
References: <20200720062623.13135-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change 'pecify' to 'Specify'.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 Documentation/admin-guide/mm/hugetlbpage.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index 015a5f7d7854..f7b1c7462991 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -131,7 +131,7 @@ hugepages
 	parameter is preceded by an invalid hugepagesz parameter, it will
 	be ignored.
 default_hugepagesz
-	pecify the default huge page size.  This parameter can
+	Specify the default huge page size.  This parameter can
 	only be specified once on the command line.  default_hugepagesz can
 	optionally be followed by the hugepages parameter to preallocate a
 	specific number of huge pages of default size.  The number of default
-- 
2.17.2

