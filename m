Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA17C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADCF4208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340332;
	bh=B1uZsd6re70zLVq6PjRevFnz2XLlg1hnPKISIIgjAf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AjLFj/KAqaegyYnPfa2Lns4ztbnx1WdYB+wQNPC2z7cQfZk/QyzqEM1WWPswRa8Rw
	 vy81QwXbUk3Fn7Y69CrqTWdOW7nXj0rE8XwvFla1RIw9eITFFx+E89SM1JphJCX8Qi
	 rb5Z0n2584F/Npa7tNsN2QJnl8xdTjPUVprNI1Pc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731097AbgEANiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:38:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729163AbgEANir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:38:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81B14205C9;
        Fri,  1 May 2020 13:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340327;
        bh=B1uZsd6re70zLVq6PjRevFnz2XLlg1hnPKISIIgjAf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jVWCa9kborbPU5w3HTqBix+g4vdJRI2B/41K+r5oW3zQ3xf8gFUaJwcbfyhtY7L+l
         5THK4+rHZnhyjFwz9igAmWRH5WJcv0sZ5tNjanopWv7UBEG4aFQ/zxejDlb6KPN4P3
         37C13VgDqf0/Tml5RrtuGdvVEJ69/f2i2VRorD4Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH 5.4 10/83] afs: Fix to actually set AFS_SERVER_FL_HAVE_EPOCH
Date:   Fri,  1 May 2020 15:22:49 +0200
Message-Id: <20200501131526.444132472@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131524.004332640@linuxfoundation.org>
References: <20200501131524.004332640@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

commit 69cf3978f3ada4e54beae4ad44868b5627864884 upstream.

AFS keeps track of the epoch value from the rxrpc protocol to note (a) when
a fileserver appears to have restarted and (b) when different endpoints of
a fileserver do not appear to be associated with the same fileserver
(ie. all probes back from a fileserver from all of its interfaces should
carry the same epoch).

However, the AFS_SERVER_FL_HAVE_EPOCH flag that indicates that we've
received the server's epoch is never set, though it is used.

Fix this to set the flag when we first receive an epoch value from a probe
sent to the filesystem client from the fileserver.

Fixes: 3bf0fb6f33dd ("afs: Probe multiple fileservers simultaneously")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/afs/cmservice.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -169,7 +169,7 @@ static int afs_record_cm_probe(struct af
 
 	spin_lock(&server->probe_lock);
 
-	if (!test_bit(AFS_SERVER_FL_HAVE_EPOCH, &server->flags)) {
+	if (!test_and_set_bit(AFS_SERVER_FL_HAVE_EPOCH, &server->flags)) {
 		server->cm_epoch = call->epoch;
 		server->probe.cm_epoch = call->epoch;
 		goto out;


