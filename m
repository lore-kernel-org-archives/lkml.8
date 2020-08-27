Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADA1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D010422B40
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uqbnw1NL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgH0PJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:09:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47227 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726894AbgH0PDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598540626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=MRq9+5xgrQHKZertQauIoLwEhLjJ0ViDikkY3PeptZU=;
        b=Uqbnw1NLtZxvw/Skw0Zl7Th5OrY5Pt+1YgckSiTRYX2730vsHUIccHYtEXClQzhEw97b2b
        4O78TIW9k5rfS7ip3La6qeVOhM0o6cwOThMq7xz3b9iIrz7+QP1gv2alXT9J+tbd8B6Suw
        4Bf5Zb1fwMhfBXjmBxPxkwUnkPC7ofI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-M4s7KFOuN96yMRqXhSKjtQ-1; Thu, 27 Aug 2020 11:03:44 -0400
X-MC-Unique: M4s7KFOuN96yMRqXhSKjtQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84579100CF7E;
        Thu, 27 Aug 2020 15:03:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-127.rdu2.redhat.com [10.10.120.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 329DD5D990;
        Thu, 27 Aug 2020 15:03:34 +0000 (UTC)
Subject: [PATCH net 0/7] rxrpc, afs: Fix probing issues
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 27 Aug 2020 16:03:33 +0100
Message-ID: <159854061331.1382667.9693163318506702951.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Here are some fixes for rxrpc and afs to fix issues in the RTT measuring in
rxrpc and thence the Volume Location server probing in afs:

 (1) Move the serial number of a received ACK into a local variable to
     simplify the next patch.

 (2) Fix the loss of RTT samples due to extra interposed ACKs causing
     baseline information to be discarded too early.  This is a particular
     problem for afs when it sends a single very short call to probe a
     server it hasn't talked to recently.

 (3) Fix rxrpc_kernel_get_srtt() to indicate whether it actually has seen
     any valid samples or not.

 (4) Remove a field that's set/woken, but never read/waited on.

 (5) Expose the RTT and other probe information through procfs to make
     debugging of this stuff easier.

 (6) Fix VL rotation in afs to only use summary information from VL probing
     and not the probe running state (which gets clobbered when next a
     probe is issued).

 (7) Fix VL rotation to actually return the error aggregated from the probe
     errors.

The patches are tagged here:

	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
	rxrpc-fixes-20200820

and can also be found on the following branch:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

David
---
David Howells (7):
      rxrpc: Keep the ACK serial in a var in rxrpc_input_ack()
      rxrpc: Fix loss of RTT samples due to interposed ACK
      rxrpc: Make rxrpc_kernel_get_srtt() indicate validity
      afs: Remove afs_vlserver->probe.have_result
      afs: Expose information from afs_vlserver through /proc for debugging
      afs: Don't use VL probe running state to make decisions outside probe code
      afs: Fix error handling in VL server rotation


 fs/afs/fs_probe.c            |   4 +-
 fs/afs/internal.h            |  14 +++--
 fs/afs/proc.c                |   5 ++
 fs/afs/vl_list.c             |   1 +
 fs/afs/vl_probe.c            |  82 ++++++++++++++++-----------
 fs/afs/vl_rotate.c           |   7 ++-
 include/net/af_rxrpc.h       |   2 +-
 include/trace/events/rxrpc.h |  27 +++++++--
 net/rxrpc/ar-internal.h      |  13 +++--
 net/rxrpc/call_object.c      |   1 +
 net/rxrpc/input.c            | 104 ++++++++++++++++++++---------------
 net/rxrpc/output.c           |  82 ++++++++++++++++++++-------
 net/rxrpc/peer_object.c      |  16 +++++-
 net/rxrpc/rtt.c              |   3 +-
 14 files changed, 241 insertions(+), 120 deletions(-)


