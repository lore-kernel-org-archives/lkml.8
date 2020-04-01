Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EDBC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818392078B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBigKPm2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732154AbgDAKmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:42:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42830 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726974AbgDAKmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585737730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2sdMxOga1sSGGgeUHG2gZiYHcvd3Jx4eGU/ipW00igI=;
        b=KBigKPm2CXtbT6UEbko0s+OYdpDgCA3h5qOf9ruEYmtNdFZiQO1LJf1ns41SBVmfvAXZQm
        DIKDga6qyL1/oSBzkYbX1s5CY0Tfsdp8D2dBazFys1Kk8MR4hY2VfAzBG1lngsf7XvumWe
        Rj/VNYEkWOxVYMImi6Zy5uGS2ZvwyuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-h3lH7A6oNraAdPoTt9DjgQ-1; Wed, 01 Apr 2020 06:42:06 -0400
X-MC-Unique: h3lH7A6oNraAdPoTt9DjgQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BD05100550D;
        Wed,  1 Apr 2020 10:42:05 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-59.ams2.redhat.com [10.36.114.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 143F2100EBA6;
        Wed,  1 Apr 2020 10:41:56 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Yiqian Wei <yiwei@redhat.com>
Subject: [PATCH v1 0/2] mm/page_alloc: fix stalls/soft lockups with huge VMs
Date:   Wed,  1 Apr 2020 12:41:54 +0200
Message-Id: <20200401104156.11564-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two fixes for misleading stall messages / soft lockups with huge nodes /
zones during boot without CONFIG_PREEMPT.

David Hildenbrand (2):
  mm/page_alloc: fix RCU stalls during deferred page initialization
  mm/page_alloc: fix watchdog soft lockups during set_zone_contiguous()

 mm/page_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

--=20
2.25.1

