Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD4CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76077207C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e5IPL9QS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388194AbgFIUam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 16:30:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57993 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731078AbgFIUak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 16:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591734639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NWthi4+vrXEX/1oiVdu5yh/nfH9kWltS19ynUlwFR9Y=;
        b=e5IPL9QSBtPGlesklqyznOVmIdJc08+mJe2DKcoA93bvHftZ+wfAiYVjsJgXcVDDKiuQKE
        UFvZFbaiWlkdT9OZ7FgmQs9K7Z2nQdCNtDgfjyPk90U/X7VLvcpD/Ecm8wQNcn65uPuJIl
        Nerc+ltjaCq9UjnWbPA1MgGqZbvxRXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-5qSl20efM7ypRXiyD12wPQ-1; Tue, 09 Jun 2020 16:30:37 -0400
X-MC-Unique: 5qSl20efM7ypRXiyD12wPQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF449835B40;
        Tue,  9 Jun 2020 20:30:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-66.rdu2.redhat.com [10.10.114.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 54969768C1;
        Tue,  9 Jun 2020 20:30:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, keescook@chromium.org,
        chengzhihao1@huawei.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] afs: Misc small fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3071962.1591734633.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 09 Jun 2020 21:30:33 +0100
Message-ID: <3071963.1591734633@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a set of small patches to fix some things, most of them minor.
Would you prefer I defer and submit it again after -rc1?

 (1) Fix a memory leak in afs_put_sysnames().

 (2) Fix an oops in AFS file locking.

 (3) Fix new use of BUG().

 (4) Fix debugging statements containing %px.

 (5) Remove afs_zero_fid as it's unused.

 (6) Make afs_zap_data() static.

David
---
The following changes since commit aaa2faab4ed8e5fe0111e04d6e168c028fe2987=
f:

  Merge tag 'for-linus-5.8-ofs1' of git://git.kernel.org/pub/scm/linux/ker=
nel/git/hubcap/linux (2020-06-05 16:44:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/afs-fixes-20200609

for you to fetch changes up to c68421bbad755a280851afff0fb236dd4e53e684:

  afs: Make afs_zap_data() static (2020-06-09 18:17:14 +0100)

----------------------------------------------------------------
AFS fixes

----------------------------------------------------------------
David Howells (5):
      afs: Fix file locking
      afs: Fix use of BUG()
      afs: Fix debugging statements with %px to be %p
      afs: Remove afs_zero_fid as it's not used
      afs: Make afs_zap_data() static

Zhihao Cheng (1):
      afs: Fix memory leak in afs_put_sysnames()

 fs/afs/dir.c       | 2 +-
 fs/afs/flock.c     | 2 +-
 fs/afs/inode.c     | 2 +-
 fs/afs/internal.h  | 2 --
 fs/afs/proc.c      | 1 +
 fs/afs/vl_alias.c  | 5 +++--
 fs/afs/yfsclient.c | 2 --
 7 files changed, 7 insertions(+), 9 deletions(-)

