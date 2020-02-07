Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1538EC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DEB20720
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YbsQGTMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgBGLut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 06:50:49 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21503 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726819AbgBGLus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 06:50:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581076247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fgY5TfoFESSa0CLmdbmkF6pEQWYwKrgwy9/oHoOBqbI=;
        b=YbsQGTMZeNoPc+CAVDKHmZ7+H6s5inDpgD9T5nkox9HRCgKZxp5HcDeV1mKWxEDTzQiXTv
        Obm/IY2C6talkWLrRvnPRe7Z9Lj7v/MEVKJIkf1h9Rx4MIdJVknTwCC729aYebfdQWLeQZ
        vh1Lfs99ROmW4jsBkA/kOwjvEGmTt9k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-zm6gwxHCO4GliKe3tVjomA-1; Fri, 07 Feb 2020 06:50:46 -0500
X-MC-Unique: zm6gwxHCO4GliKe3tVjomA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30D8F101FC61;
        Fri,  7 Feb 2020 11:50:45 +0000 (UTC)
Received: from max.com (ovpn-204-44.brq.redhat.com [10.40.204.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D0FF7FB60;
        Fri,  7 Feb 2020 11:50:41 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] GFS2 changes for the 5.6 merge window (2)
Date:   Fri,  7 Feb 2020 12:50:39 +0100
Message-Id: <20200207115039.48920-1-agruenba@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

could you please pull the following additional changes for gfs2?

Thanks a lot,
Andreas

The following changes since commit a62aa6f7f50a9a0af5e07d98774f8a7b439d39=
0f:

  Merge tag 'gfs2-for-5.6' of git://git.kernel.org/pub/scm/linux/kernel/g=
it/gfs2/linux-gfs2 (2020-01-31 13:07:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/=
gfs2-for-5.6-2

for you to fetch changes up to 6e5e41e2dc4e4413296d5a4af54ac92d7cd52317:

  gfs2: fix O_SYNC write handling (2020-02-06 18:49:41 +0100)

----------------------------------------------------------------
Changes in gfs2:

- Fix a bug in Abhi Das's journal head lookup improvements that can cause=
 a
  valid journal to be rejected.
- Fix an O_SYNC write handling bug reported by Christoph Hellwig.

----------------------------------------------------------------
Abhi Das (1):
      gfs2: fix gfs2_find_jhead that returns uninitialized jhead with seq=
 0

Andreas Gruenbacher (1):
      gfs2: fix O_SYNC write handling

Christoph Hellwig (1):
      gfs2: move setting current->backing_dev_info

 fs/gfs2/file.c | 72 +++++++++++++++++++++++++---------------------------=
------
 fs/gfs2/lops.c |  2 +-
 2 files changed, 32 insertions(+), 42 deletions(-)

