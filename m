Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC90C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63C2C20836
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jIsHNkQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgGCJxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 05:53:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24538 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726053AbgGCJxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593770013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0PGiJVpJLRg1xkJmVjcLSvVDlRTvj62k3+35QdFjYI8=;
        b=jIsHNkQFbxXqj5QvkJkNtInFGJsZ89nTYeFDQCc8Cc0CyBuMOzWiWm226IUt1OuoY6ENXM
        0NWnOVJEoeBUhIvM01NLxhbpn3pLJJ8AfY+zdEEVQ/eQWww7OEqKauRabnVT3SFx2JptpC
        7a1CFVoehcszh89RGZP1gsR3Y/Ik/Uk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-lP1u1ZQFMk6FNoHo3j0ckA-1; Fri, 03 Jul 2020 05:53:30 -0400
X-MC-Unique: lP1u1ZQFMk6FNoHo3j0ckA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E24DF800401;
        Fri,  3 Jul 2020 09:53:28 +0000 (UTC)
Received: from max.home.com (unknown [10.40.192.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0ED9C6111F;
        Fri,  3 Jul 2020 09:53:26 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [RFC v2 0/2] Fix gfs2 readahead deadlocks
Date:   Fri,  3 Jul 2020 11:53:23 +0200
Message-Id: <20200703095325.1491832-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's an improved version.  If the IOCB_NOIO flag can be added right
away, we can just fix the locking in gfs2.

Thanks,
Andreas

Andreas Gruenbacher (2):
  fs: Add IOCB_NOIO flag for generic_file_read_iter
  gfs2: Rework read and page fault locking

 fs/gfs2/aops.c     | 45 +--------------------------------------
 fs/gfs2/file.c     | 52 ++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/fs.h |  1 +
 mm/filemap.c       | 17 +++++++++++++--
 4 files changed, 67 insertions(+), 48 deletions(-)

-- 
2.26.2

