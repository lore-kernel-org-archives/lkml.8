Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53493C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C96620774
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OmyJp/y0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbgFIQNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 12:13:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33782 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728888AbgFIQNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 12:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591719190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zKpZ5M/MSa2zdVQ4na34JwJsQBn+q9VK2DDsUPbUPUo=;
        b=OmyJp/y0hgTRBTQRFF3y4rgmvUt85RdrnxT5m92zQZK7VGu80v6/Ih616UF8X2lsiRZBz+
        ra95iwC3/MvFnZIR2k5VCZeUcKGllOmnECTTcO3jg0VTG+WMIY8nqlv6YtXEIXy5hjLIYR
        m63nhYtpqhP3lPuJmLCQZRIDNR9PCGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-BuP0OuJvPSufYfpqo3GjTQ-1; Tue, 09 Jun 2020 12:13:08 -0400
X-MC-Unique: BuP0OuJvPSufYfpqo3GjTQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E0DA464;
        Tue,  9 Jun 2020 16:13:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-66.rdu2.redhat.com [10.10.114.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6A751001281;
        Tue,  9 Jun 2020 16:13:05 +0000 (UTC)
Subject: [PATCH 0/6] afs: Fixes
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Dave Botsch <botsch@cnf.cornell.edu>,
        Kees Cook <keescook@chromium.org>,
        Zhihao Cheng <chengzhihao1@huawei.com>, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 09 Jun 2020 17:13:05 +0100
Message-ID: <159171918506.3038039.10915051218779105094.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a set of patches to fix some things, most of them minor.

 (1) Fix a memory leak in afs_put_sysnames().

 (2) Fix an oops in AFS file locking.

 (3) Fix new use of BUG().

 (4) Fix debugging statements containing %px.

 (5) Remove afs_zero_fid as it's unused.

 (6) Make afs_zap_data() static.

David
---
David Howells (1):
      afs: Make afs_zap_data() static


 fs/afs/dir.c       | 2 +-
 fs/afs/flock.c     | 2 +-
 fs/afs/inode.c     | 2 +-
 fs/afs/internal.h  | 2 --
 fs/afs/proc.c      | 1 +
 fs/afs/vl_alias.c  | 5 +++--
 fs/afs/yfsclient.c | 2 --
 7 files changed, 7 insertions(+), 9 deletions(-)


