Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6CBC433EB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FE2C22B40
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFGhCOo8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387694AbgGWDXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 23:23:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34247 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728902AbgGWDXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 23:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595474589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=NDgoEGWosDZ+OM1ZqFdb1fsmC8c2DTCKfhr+32UzbUM=;
        b=HFGhCOo8Q8Tmz/vLKiLls+W5fpIl5ZvFHDvxLqawVdFFfOXiDOhyEDDEed32mOv1pH9am2
        jeSLzX4WRn41uQiSNMcF0AKUkvFDt81DTCaRbin0DRXVJhPT9Gkps+gvH+8UveUz7u9jhg
        44BfHvXe3Q2skKxb7JagMjEpnetIzTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-SHZaXwHgMGind-VCYjSQOg-1; Wed, 22 Jul 2020 23:23:05 -0400
X-MC-Unique: SHZaXwHgMGind-VCYjSQOg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5406118A1DF4;
        Thu, 23 Jul 2020 03:23:04 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-53.pek2.redhat.com [10.72.13.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24C845C1BD;
        Thu, 23 Jul 2020 03:23:01 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org, bhe@redhat.com
Subject: [PATCH v2 3/4] doc/vm: fix typo in the hugetlb admin documentation
Date:   Thu, 23 Jul 2020 11:22:47 +0800
Message-Id: <20200723032248.24772-4-bhe@redhat.com>
In-Reply-To: <20200723032248.24772-1-bhe@redhat.com>
References: <20200723032248.24772-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change 'pecify' to 'Specify'.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
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

