Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AADC2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7627212CC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758393;
	bh=v0htEInix3o5gc4RsvVAu/GUiZzHgtPZQ3jdjRnLrtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JW2+PYg1Ko/yE0SB41hUBwyqgDRDXJzxfaFElGFEIj91kofeV+56zA0J7AEIfKCfj
	 Biu+ELtaSVzY5tG8Ax4jXkDJQ01Mkcp4bXzciLdFKT5ACA0BZ4hK+50ulCQrxBh8yq
	 D6JQPSWz95zbRDozkhjCuYw+e5YXb/Va8mdOH/zE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387469AbgDAQ0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:26:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387629AbgDAQ0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:26:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4491920BED;
        Wed,  1 Apr 2020 16:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758380;
        bh=v0htEInix3o5gc4RsvVAu/GUiZzHgtPZQ3jdjRnLrtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YV6aN0jvXpP/kmMJeKGretjwchPQWawuuegOAyO1xfWR2srwekOC24AE21/ENYb+C
         7hwtN8rq+NefnuH90gjW/pxHV8CRt7ti4dQLI930vYPfjU55mW5u2UKrSBk1i8aeYV
         Jnobt5lDAv3/pu2kS0X4RzhcN7TjofZWOMScAN/w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH 4.19 071/116] afs: Fix some tracing details
Date:   Wed,  1 Apr 2020 18:17:27 +0200
Message-Id: <20200401161552.079867997@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161542.669484650@linuxfoundation.org>
References: <20200401161542.669484650@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

commit 4636cf184d6d9a92a56c2554681ea520dd4fe49a upstream.

Fix a couple of tracelines to indicate the usage count after the atomic op,
not the usage count before it to be consistent with other afs and rxrpc
trace lines.

Change the wording of the afs_call_trace_work trace ID label from "WORK" to
"QUEUE" to reflect the fact that it's queueing work, not doing work.

Fixes: 341f741f04be ("afs: Refcount the afs_call struct")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/afs/rxrpc.c             |    4 ++--
 include/trace/events/afs.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -159,7 +159,7 @@ void afs_put_call(struct afs_call *call)
 	int n = atomic_dec_return(&call->usage);
 	int o = atomic_read(&net->nr_outstanding_calls);
 
-	trace_afs_call(call, afs_call_trace_put, n + 1, o,
+	trace_afs_call(call, afs_call_trace_put, n, o,
 		       __builtin_return_address(0));
 
 	ASSERTCMP(n, >=, 0);
@@ -654,7 +654,7 @@ static void afs_wake_up_async_call(struc
 
 	u = atomic_fetch_add_unless(&call->usage, 1, 0);
 	if (u != 0) {
-		trace_afs_call(call, afs_call_trace_wake, u,
+		trace_afs_call(call, afs_call_trace_wake, u + 1,
 			       atomic_read(&call->net->nr_outstanding_calls),
 			       __builtin_return_address(0));
 
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -94,7 +94,7 @@ enum afs_edit_dir_reason {
 	EM(afs_call_trace_free,			"FREE ") \
 	EM(afs_call_trace_put,			"PUT  ") \
 	EM(afs_call_trace_wake,			"WAKE ") \
-	E_(afs_call_trace_work,			"WORK ")
+	E_(afs_call_trace_work,			"QUEUE")
 
 #define afs_fs_operations \
 	EM(afs_FS_FetchData,			"FS.FetchData") \


