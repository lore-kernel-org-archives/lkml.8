Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2279CC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF51212CC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jsf7tieB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbgCaQlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:41:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48759 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730442AbgCaQlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585672881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=nd7Gh30+KWUdOyvGmSbatOjKf7ovcNZnk/aeAwQ6Fao=;
        b=Jsf7tieB6j70F0l6ViJQ2vnmiN15Wgw2zUX6KCMsZMJepyY6z9VFhdsmYzGu5bl4N8e2es
        nhzwTSNuvDSmj1aE7iftt9yFA4Lbvlauypnpa/jy6p77PDN9mS1BVPm5lfKX2rMtRVh6Ps
        BH6t0wJjsV1ZUMruHAwfqWsn1TgYsF4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-GneUZMFCObGSONu0jxtUkw-1; Tue, 31 Mar 2020 12:41:19 -0400
X-MC-Unique: GneUZMFCObGSONu0jxtUkw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0ECC1937FF9;
        Tue, 31 Mar 2020 16:40:49 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C7E595D9CA;
        Tue, 31 Mar 2020 16:40:49 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id B612086392;
        Tue, 31 Mar 2020 16:40:49 +0000 (UTC)
Date:   Tue, 31 Mar 2020 12:40:49 -0400 (EDT)
From:   Bob Peterson <rpeterso@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <328533763.19799053.1585672849599.JavaMail.zimbra@redhat.com>
In-Reply-To: <1136650016.19797621.1585672680530.JavaMail.zimbra@redhat.com>
Subject: GFS2 changes for the 5.7 merge window
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.112.79, 10.4.195.15]
Thread-Topic: GFS2 changes for the 5.7 merge window
Thread-Index: 7YnYufhNdP3LDDib+sLMkcBQ+0495Q==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you please pull the following changes for gfs2?

Thanks,

Bob Peterson

The following changes since commit 6e5e41e2dc4e4413296d5a4af54ac92d7cd52317:

  gfs2: fix O_SYNC write handling (2020-02-06 18:49:41 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-5.7

for you to fetch changes up to 75b46c437f6b0f8e37032a407c7373f85f5c26a8:

  gfs2: Fix oversight in gfs2_ail1_flush (2020-03-30 07:55:35 -0500)

----------------------------------------------------------------
We've got a lot of patches (39) for this merge window. Most of these patches
are related to corruption that occurs when journals are replayed.
For example:

   1. A node fails while writing to the file system.
   2. Other nodes use the metadata that was once used by the failed node.
   3. When the node returns to the cluster, its journal is replayed,
      but the older metadata blocks overwrite the changes from step 2.

- Fixed the recovery sequence to prevent corruption during journal replay.
- Many bug fixes found during recovery testing.
- New improved file system withdraw sequence.
- Fixed how resource group buffers are managed.
- Fixed how metadata revokes are tracked and written.
- Improve processing of IO errors hit by daemons like logd and quotad.
- Improved error checking in metadata writes.
- Fixed how qadata quota data structures are managed.

----------------------------------------------------------------
Andreas Gruenbacher (9):
      gfs2: Split gfs2_lm_withdraw into two functions
      gfs2: Report errors before withdraw
      gfs2: Remove usused cluster_wide arguments of gfs2_consist functions
      gfs2: Turn gfs2_consist into void functions
      gfs2: Return bool from gfs2_assert functions
      gfs2: Clean up inode initialization and teardown
      gfs2: Switch to list_{first,last}_entry
      gfs2: Split gfs2_rsqa_delete into gfs2_rs_delete and gfs2_qa_put
      gfs2: Remove unnecessary gfs2_qa_{get,put} pairs

Bob Peterson (30):
      gfs2: Introduce concept of a pending withdraw
      gfs2: clear ail1 list when gfs2 withdraws
      gfs2: Rework how rgrp buffer_heads are managed
      gfs2: log error reform
      gfs2: Only complain the first time an io error occurs in quota or log
      gfs2: Ignore dlm recovery requests if gfs2 is withdrawn
      gfs2: move check_journal_clean to util.c for future use
      gfs2: Allow some glocks to be used during withdraw
      gfs2: Force withdraw to replay journals and wait for it to finish
      gfs2: fix infinite loop when checking ail item count before go_inval
      gfs2: Add verbose option to check_journal_clean
      gfs2: Issue revokes more intelligently
      gfs2: Prepare to withdraw as soon as an IO error occurs in log write
      gfs2: Check for log write errors before telling dlm to unlock
      gfs2: Do log_flush in gfs2_ail_empty_gl even if ail list is empty
      gfs2: Withdraw in gfs2_ail1_flush if write_cache_pages fails
      gfs2: drain the ail2 list after io errors
      gfs2: Don't demote a glock until its revokes are written
      gfs2: Do proper error checking for go_sync family of glops functions
      gfs2: flesh out delayed withdraw for gfs2_log_flush
      gfs2: don't allow releasepage to free bd still used for revokes
      gfs2: allow journal replay to hold sd_log_flush_lock
      gfs2: leaf_dealloc needs to allocate one more revoke
      gfs2: Additional information when gfs2_ail1_flush withdraws
      gfs2: eliminate gfs2_rsqa_alloc in favor of gfs2_qa_alloc
      gfs2: Change inode qa_data to allow multiple users
      gfs2: don't lock sd_log_flush_lock in try_rgrp_unlink
      gfs2: instrumentation wrt ail1 stuck
      gfs2: change from write to read lock for sd_log_flush_lock in journal replay
      gfs2: Fix oversight in gfs2_ail1_flush

 fs/gfs2/acl.c        |   7 +-
 fs/gfs2/aops.c       |  11 +-
 fs/gfs2/bmap.c       |   9 +-
 fs/gfs2/dir.c        |   3 +-
 fs/gfs2/file.c       |  43 +++---
 fs/gfs2/glock.c      | 137 ++++++++++++++---
 fs/gfs2/glops.c      | 157 +++++++++++++++----
 fs/gfs2/incore.h     |  27 +++-
 fs/gfs2/inode.c      |  53 +++----
 fs/gfs2/lock_dlm.c   |  52 +++++++
 fs/gfs2/log.c        | 288 ++++++++++++++++++++++++-----------
 fs/gfs2/log.h        |   1 +
 fs/gfs2/lops.c       |  14 +-
 fs/gfs2/meta_io.c    |   3 +-
 fs/gfs2/ops_fstype.c |  59 ++------
 fs/gfs2/quota.c      |  76 ++++++----
 fs/gfs2/quota.h      |   4 +-
 fs/gfs2/recovery.c   |  12 +-
 fs/gfs2/rgrp.c       |  88 ++++-------
 fs/gfs2/rgrp.h       |   4 +-
 fs/gfs2/super.c      | 112 +++++++++-----
 fs/gfs2/super.h      |   1 -
 fs/gfs2/sys.c        |   5 +-
 fs/gfs2/trans.c      |   4 +
 fs/gfs2/util.c       | 419 ++++++++++++++++++++++++++++++++++++++++-----------
 fs/gfs2/util.h       |  76 +++++++---
 fs/gfs2/xattr.c      |  12 +-
 27 files changed, 1168 insertions(+), 509 deletions(-)

