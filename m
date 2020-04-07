Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602B7C2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A9E2074F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDR6qWtv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgDGNye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 09:54:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54322 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728573AbgDGNyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 09:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586267672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RINIddZUqq5kUQ1PrShNaCH2LZ2pehWwvKUvtGUDiTs=;
        b=TDR6qWtvyL0AhbIom4eVuJHzWby5KpF7AT99MwEzveiJH+XqSZ100UHQCmv1egOS938oLA
        hNw5NfqykEaaVOpZ7k4wZFyR051t8/n0Dg+GB+BZsf2A7OVBVEtUPYGvzsQ4w8pGiq/qUi
        HYE3Ag93AgyF/MaemBlQ5n9NLyTjjLA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-MKl6M0WKP2SXWRLZchOcBQ-1; Tue, 07 Apr 2020 09:54:25 -0400
X-MC-Unique: MKl6M0WKP2SXWRLZchOcBQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7E9185EE6E;
        Tue,  7 Apr 2020 13:54:23 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-167.ams2.redhat.com [10.36.114.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA56E7E303;
        Tue,  7 Apr 2020 13:54:16 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Paul Mackerras <paulus@samba.org>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v1 0/2] mm/memory_hotplug: remove is_mem_section_removable()
Date:   Tue,  7 Apr 2020 15:54:14 +0200
Message-Id: <20200407135416.24093-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the follow-up of "[PATCH v1] drivers/base/memory.c: indicate all
memory blocks as removable" [1], which gets rid of
is_mem_section_removable().

More details can be found in [1] and [2]

[1] https://lkml.kernel.org/r/20200128093542.6908-1-david@redhat.com
[2] https://lkml.kernel.org/r/20200117105759.27905-1-david@redhat.com

David Hildenbrand (2):
  powerpc/pseries/hotplug-memory: stop checking
    is_mem_section_removable()
  mm/memory_hotplug: remove is_mem_section_removable()

 .../platforms/pseries/hotplug-memory.c        | 26 +------
 include/linux/memory_hotplug.h                |  7 --
 mm/memory_hotplug.c                           | 75 -------------------
 3 files changed, 3 insertions(+), 105 deletions(-)

--=20
2.25.1

