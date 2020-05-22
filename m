Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577F0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 23:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A54320723
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 23:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DT5vkd0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387420AbgEVXmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 19:42:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36321 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726546AbgEVXmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 19:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590190958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mbvdctjClQbp0Jrz489CT4trpZjcuEg4KIRu2UYcXZ4=;
        b=DT5vkd0Liz8W+5WtZEb3PPall7w+Kx8vIvDIMD4vF1hdCiuPSFjtrowG2+CXj5yBZaLnrb
        dxDwCRYkkaclerlCXGmp04UMEUvYYNrUwGnAR5sYk4xV6cKOjF26BnPCnGN6rwhdiAjpDA
        EVgHlD3rZYpAHieLlTB6VDxSAbEogWM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-j7pi3hFmOI2JIEubdNxo2g-1; Fri, 22 May 2020 19:42:35 -0400
X-MC-Unique: j7pi3hFmOI2JIEubdNxo2g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55DD680183C;
        Fri, 22 May 2020 23:42:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BCA060BE2;
        Fri, 22 May 2020 23:42:32 +0000 (UTC)
Subject: [PATCH net 0/2] rxrpc: Fix a warning and a leak [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Qiushi Wu <wu000273@umn.edu>,
        Markus Elfring <Markus.Elfring@web.de>, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Sat, 23 May 2020 00:42:32 +0100
Message-ID: <159019095229.999797.5088700147400532632.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Here are a couple of fixes for AF_RXRPC:

 (1) Fix an uninitialised variable warning.

 (2) Fix a leak of the ticket on error in rxkad.

The patches are tagged here:

	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
	rxrpc-fixes-20200523-v2

and can also be found on the following branch:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

David
---
Qiushi Wu (1):
      rxrpc: Fix a memory leak in rxkad_verify_response()


 fs/afs/fs_probe.c | 2 +-
 net/rxrpc/rxkad.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)


