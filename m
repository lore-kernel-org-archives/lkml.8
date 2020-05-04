Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371D8C47258
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04B5E206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QdYuwAE0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgEDTDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 15:03:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47821 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725981AbgEDTDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 15:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588618981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VWGsgsBT9IcIoK3tsJvtcUFAcT5JE1pgJJwKU1y5cyQ=;
        b=QdYuwAE0GIgtl85WfVl1UGjxQXso0hzjxhsZvklQ4UhPLw1eZKuocoDASu13urSlIYlPoT
        nOhX+qrLoA2VFndMcxYkrv4o3nR5meaPRyK2HKZHifDYA2wSCcBXfq4KpolMSjvbqLvP88
        RrA7cAGxfNqRZ9xdyjxkumuT3bpOUo0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-n250Z6kGNcGSWT8ZWKcleg-1; Mon, 04 May 2020 15:02:57 -0400
X-MC-Unique: n250Z6kGNcGSWT8ZWKcleg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6A87462;
        Mon,  4 May 2020 19:02:55 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-235.ams2.redhat.com [10.36.114.235])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83BC4385;
        Mon,  4 May 2020 19:02:52 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        kexec@lists.infradead.org, Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v3 2/3] kexec_file: Don't place kexec images on IORESOURCE_MEM_DRIVER_MANAGED
Date:   Mon,  4 May 2020 21:02:26 +0200
Message-Id: <20200504190227.18269-3-david@redhat.com>
In-Reply-To: <20200504190227.18269-1-david@redhat.com>
References: <20200504190227.18269-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory flagged with IORESOURCE_MEM_DRIVER_MANAGED is special - it won't b=
e
part of the initial memmap of the kexec kernel and not all memory might b=
e
accessible. Don't place any kexec images onto it.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/kexec_file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index faa74d5f6941..bb05fd52de85 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -540,6 +540,11 @@ static int locate_mem_hole_callback(struct resource =
*res, void *arg)
 	unsigned long sz =3D end - start + 1;
=20
 	/* Returning 0 will take to next memory range */
+
+	/* Don't use memory that will be detected and handled by a driver. */
+	if (res->flags & IORESOURCE_MEM_DRIVER_MANAGED)
+		return 0;
+
 	if (sz < kbuf->memsz)
 		return 0;
=20
--=20
2.25.3

