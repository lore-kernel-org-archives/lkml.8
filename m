Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FFEC33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F348C20678
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XfcH2QGe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgAMOkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 09:40:45 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21386 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728643AbgAMOko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 09:40:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578926444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VWP7TBPDC/WWtI6AhL9UEcGZAEvWSrBUOBnztnDpDig=;
        b=XfcH2QGewCGHgIvzzWOezXVIrTtLCRaTnxuhm+GCxJoht/2uK03rqYDZobZz4W1TnoCobg
        dzix4OLlS6ZNGtSbjFcjugYqqtfnAq/OV14K/7HOfP6dckkndP/ubJJffWgAmdkGqbvtny
        W7VHtyhnYBuneJsJNt8Uxz7qKjz6B04=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-hlxp6qwtO6mee55SJFtWCw-1; Mon, 13 Jan 2020 09:40:42 -0500
X-MC-Unique: hlxp6qwtO6mee55SJFtWCw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB9F41800D48;
        Mon, 13 Jan 2020 14:40:40 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-201.ams2.redhat.com [10.36.117.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B277638C;
        Mon, 13 Jan 2020 14:40:36 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: [PATCH v1 0/2] mm/page_alloc: memmap_init_zone() cleanups
Date:   Mon, 13 Jan 2020 15:40:33 +0100
Message-Id: <20200113144035.10848-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two cleanups for "[PATCH] mm/page_alloc: Skip non present sections on zon=
e
initialization" [1], whereby one cleanup seems to also be a fix for a
(theoretial?) kernelcore=3Dmirror case - unless I am messing something up=
 :)

[1] https://lkml.kernel.org/r/20191230093828.24613-1-kirill.shutemov@linu=
x.intel.com

David Hildenbrand (2):
  mm/page_alloc: fix and rework pfn handling in memmap_init_zone()
  mm: factor out next_present_section_nr()

 include/linux/mmzone.h | 10 ++++++++++
 mm/page_alloc.c        | 20 ++++++++------------
 mm/sparse.c            | 10 ----------
 3 files changed, 18 insertions(+), 22 deletions(-)

--=20
2.24.1

