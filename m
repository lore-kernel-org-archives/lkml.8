Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB74C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63DFC20732
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UzD96LVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbgDMPSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:18:44 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46095 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729618AbgDMPSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586791120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6IDYaW1WhdG5Kf+TEtHbOlCE2l5auMcw46MIZ63bnRI=;
        b=UzD96LVS7Hn0byI+FM0cWJ8e5nI8Bt7ljnqG0C1po9kN6s99MMe4qK/hqimK4d7CQ/VTpg
        BWmAy22+z36mbGYEBHsv2VWJGS7tXjfVdd5l6ygQozXLdh/Jm9LV/LovobC7I61B/ZxyTB
        IN9Uq9RPoyvDW+IqCH3tzdTbZwlXBsY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-Q1LX0PKLOwmFMcChcNX7tw-1; Mon, 13 Apr 2020 11:18:38 -0400
X-MC-Unique: Q1LX0PKLOwmFMcChcNX7tw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 637491005509;
        Mon, 13 Apr 2020 15:18:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-224.rdu2.redhat.com [10.10.112.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58E3E272D1;
        Mon, 13 Apr 2020 15:18:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] afs: Fixes [try #2]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3061362.1586791115.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 13 Apr 2020 16:18:35 +0100
Message-ID: <3061363.1586791115@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are some fixes for the afs filesystem:

 (1) Fix the decoding of fetched file status records so that the xdr
     pointer is advanced under all circumstances.

 (2) Fix the decoding of a fetched file status record that indicates an
     inline abort (ie. an error) so that it sets the flag saying the
     decoder stored the abort code.

 (3) Fix the decoding of the result of the rename operation so that it
     doesn't skip the decoding of the second fetched file status (ie. that
     of the dest dir) in the case that the source and dest dirs were the
     same as this causes the xdr pointer not to be advanced, leading to
     incorrect decoding of subsequent parts of the reply.

 (4) Fix the dump of a bad YFSFetchStatus record to dump the full length.

 (5) Fix a race between local editing of directory contents and accessing
     the dir for reading or d_revalidate by using the same lock in both.

 (6) Fix afs_d_revalidate() to not accidentally reverse the version on a
     dentry when it's meant to be bringing it forward.

David
---
The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f313=
6:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/afs-fixes-20200413

for you to fetch changes up to 40fc81027f892284ce31f8b6de1e497f5b47e71f:

  afs: Fix afs_d_validate() to set the right directory version (2020-04-13=
 15:09:01 +0100)

----------------------------------------------------------------
AFS fixes

----------------------------------------------------------------
David Howells (6):
      afs: Fix missing XDR advance in xdr_decode_{AFS,YFS}FSFetchStatus()
      afs: Fix decoding of inline abort codes from version 1 status record=
s
      afs: Fix rename operation status delivery
      afs: Fix length of dump of bad YFSFetchStatus record
      afs: Fix race between post-modification dir edit and readdir/d_reval=
idate
      afs: Fix afs_d_validate() to set the right directory version

 fs/afs/dir.c       | 108 +++++++++++++++++++++++++++++++++---------------=
-----
 fs/afs/dir_silly.c |  22 +++++++----
 fs/afs/fsclient.c  |  27 ++++++++------
 fs/afs/yfsclient.c |  26 +++++++------
 4 files changed, 112 insertions(+), 71 deletions(-)

