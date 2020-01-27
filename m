Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608EEC33CB1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 11:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E908206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 11:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WOHG+cMh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbgA0LUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 06:20:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50222 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726761AbgA0LUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 06:20:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580124007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=a64pVqUTrkjyj1R0S75PhNQzXOORT+IQ+JnPk87wEEM=;
        b=WOHG+cMhbeD+Dc5rhNbkOsIxWcJKANOp3gYxmU1GjJNUA5pamfwT7KaCMsc0O8nt23a631
        qxszcM+RCUL/pYkWZu/l897S+9bQv5cOgGoc5jf/s40rP7yHPno/lJNv+wf24yKVUCpFBD
        I8fMGkmXIGVYGBQJ+m8twlqKWwOhB3Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-khbFAkcuO5WYMgiy2NBV-Q-1; Mon, 27 Jan 2020 06:04:32 -0500
X-MC-Unique: khbFAkcuO5WYMgiy2NBV-Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CAD4C8024ED;
        Mon, 27 Jan 2020 11:04:30 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.36.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1067719E9C;
        Mon, 27 Jan 2020 11:04:25 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 0/3] mm: drop superfluous section checks when onlining/offlining
Date:   Mon, 27 Jan 2020 12:04:21 +0100
Message-Id: <20200127110424.5757-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's drop some superfluous section checks on the onlining/offlining path=
.

David Hildenbrand (3):
  drivers/base/memory.c: drop section_count
  drivers/base/memory.c: drop pages_correctly_probed()
  mm/page_ext.c: drop pfn_present() check when onlining

 drivers/base/memory.c  | 59 +++---------------------------------------
 include/linux/memory.h |  1 -
 mm/page_ext.c          |  5 +---
 3 files changed, 4 insertions(+), 61 deletions(-)

--=20
2.24.1

