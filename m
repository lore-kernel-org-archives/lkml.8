Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9897FC33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6052D207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQgZaYw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgAMLeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 06:34:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20391 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728766AbgAMLeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 06:34:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578915245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=F9UfA1kCjxLqXDTyh3i8q9zpKCBTPBJEr4a8UqF/50E=;
        b=gQgZaYw2wjrQvFqlwT53nF9RCzElzAXdexfoEq69x8Mxjrt0QtxDQynYCM+WReIpf1yz4B
        x+JJZrejNP8E7R20EvKJhRmzOrK4nXo+f3P4O8w/MiJkjDHxKrq81uc7IuQTPgGov98qq8
        LLw7DV+OlFYF5TBQaXINtJcKIlvlXWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-beBc6JIaNjmF-kkSAtGMbg-1; Mon, 13 Jan 2020 06:34:02 -0500
X-MC-Unique: beBc6JIaNjmF-kkSAtGMbg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F30E10054E3;
        Mon, 13 Jan 2020 11:34:00 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-201.ams2.redhat.com [10.36.117.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 60EA87C468;
        Mon, 13 Jan 2020 11:33:55 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 0/2] mm/memory_hotplug: pass in nid to online_pages()
Date:   Mon, 13 Jan 2020 12:33:52 +0100
Message-Id: <20200113113354.6341-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify onlining code and get rid of find_memory_block(). Pass in the
nid from the memory block we are trying to online directly, instead of
manually looking it up.

David Hildenbrand (2):
  mm/memory_hotplug: pass in nid to online_pages()
  drivers/base/memory.c: get rid of find_memory_block()

 drivers/base/memory.c          | 15 ++++-----------
 include/linux/memory.h         |  1 -
 include/linux/memory_hotplug.h |  3 ++-
 mm/memory_hotplug.c            | 13 ++-----------
 4 files changed, 8 insertions(+), 24 deletions(-)

--=20
2.24.1

