Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246A0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00F9C207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HfU7GCZ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387536AbgGWDXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 23:23:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60591 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733155AbgGWDXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 23:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595474581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=/cAlRa4t+4m+3uaHHv0KjsCFJbdWWUQ8JXAF4245fFo=;
        b=HfU7GCZ3gShF3kia/ZHkRzXbRH6R8FdjcKXnhfP1M6kR46Gd3mNuo4oQdwTFUvF8mWWARw
        gSGcpYPjPcLM+NnL9kAq6qkCjWc+tfkBPNbxD5ahPTnPTSf+fGPApXlso/o4dXVfhodWlV
        L4PiWNG+vFGN6b/ZR0yT9rFiArOlgXA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-xtW9UXObMlObdaypLGxF0g-1; Wed, 22 Jul 2020 23:22:57 -0400
X-MC-Unique: xtW9UXObMlObdaypLGxF0g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB83118A1DED;
        Thu, 23 Jul 2020 03:22:55 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-53.pek2.redhat.com [10.72.13.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D1D0D5C1BD;
        Thu, 23 Jul 2020 03:22:49 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org, bhe@redhat.com
Subject: [PATCH v2 0/4] mm/hugetlb: Small cleanup and improvement
Date:   Thu, 23 Jul 2020 11:22:44 +0800
Message-Id: <20200723032248.24772-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 is here:
https://lore.kernel.org/linux-mm/20200720062623.13135-1-bhe@redhat.com/

Patch 1~3 are small clean up.

Patch 4 is adding warning message when the number of persistent huge
pages is not changed to the exact value written to the sysfs or proc
nr_hugepages file.

v1->v2:
  Drop the old patch 1/5 in v1 post, which was thought as typo, while
  actually another kind of abbreviation.

  Updated patch log of patch 4 which is rephrased by Mike. And move the
  added message logging code after the hugetlb_lock dropping, this is
  suggested by Mike.


Baoquan He (4):
  mm/hugetlb.c: make is_hugetlb_entry_hwpoisoned return bool
  mm/hugetlb.c: Remove the unnecessary non_swap_entry()
  doc/vm: fix typo in the hugetlb admin documentation
  mm/hugetl.c: warn out if expected count of huge pages adjustment is
    not achieved

 Documentation/admin-guide/mm/hugetlbpage.rst |  2 +-
 mm/hugetlb.c                                 | 27 +++++++++++++++-----
 2 files changed, 21 insertions(+), 8 deletions(-)

-- 
2.17.2

