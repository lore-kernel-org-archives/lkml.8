Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72308C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411C7246AA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Huc4nSFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgB1J6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 04:58:39 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38428 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726413AbgB1J6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:58:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582883917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eLTzVywpCI6O5gjHw18zgQ6Xjgb+LJcKXSKnwdCMRbw=;
        b=Huc4nSFNTOm9tv9cc8U3b9S7ymOoB1RiPHhSB86//U7OM+X6SWeBUSQFPtEn0xDzny7Kkf
        hhWqVQZ7DXWMPQ37QhaIDXiTxpqPqhx8/7MhwR3sdGwJp14ZwDXvpnxNz9/w2PtTZrgsfx
        MyG2KOkZFk4RXyWJNhpvZ9rHIM8yEBY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-Gsr-x1hANzei_YA3dUEg1Q-1; Fri, 28 Feb 2020 04:58:31 -0500
X-MC-Unique: Gsr-x1hANzei_YA3dUEg1Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57F4F18FE861;
        Fri, 28 Feb 2020 09:58:30 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-180.ams2.redhat.com [10.36.117.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56F8990793;
        Fri, 28 Feb 2020 09:58:20 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 0/2] mm/memory_hotplug: __add_pages() and __remove_pages() cleanups
Date:   Fri, 28 Feb 2020 10:58:17 +0100
Message-Id: <20200228095819.10750-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the follow up of:
	"[PATCH v1] mm/memory_hotplug: Easier calculation to get pages to
	 next section boundary" [1]

Cleanups as a follow up on commit 52fb87c81f11 ("mm/memory_hotplug:
cleanup __remove_pages()").

v1 -> v2:
- "mm/memory_hotplug: simplify calculation of number of pages in
   __remove_pages()"
-- Rephrased subject/description, but left patch as is
- "mm/memory_hotplug: cleanup __add_pages()"
-- Make the logic match the logic in __remove_pages()

[1] https://lkml.kernel.org/r/20200205135251.37488-1-david@redhat.com

David Hildenbrand (2):
  mm/memory_hotplug: simplify calculation of number of pages in
    __remove_pages()
  mm/memory_hotplug: cleanup __add_pages()

 mm/memory_hotplug.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

--=20
2.24.1

