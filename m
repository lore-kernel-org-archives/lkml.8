Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A620C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 22:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 216E520829
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 22:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gdQD5y6v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgHMWZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 18:25:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59424 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726603AbgHMWZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 18:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597357507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=yxNRiQrx7jKrwqPVqJOBjS+SoNbDq2E96xAtNxIltTg=;
        b=gdQD5y6vN+YPE6OHWm9JCBm/SZ/m4Gpxm6wxXd+1Rj8rCyiQ58Rx2R5QLBQUFBHcxQTzyy
        zLyquyeyO6xrHv+ZMhHGOMJFP8GjJhBxOJ87ZLh8qJHM11+0Zl0N7/2PRLUSbkTkrPosuk
        hswqORMGeBNccZNtXQd+7S+7EaBqgPg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-y64BYWaiO0qlmg8L8KInlg-1; Thu, 13 Aug 2020 18:25:05 -0400
X-MC-Unique: y64BYWaiO0qlmg8L8KInlg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34D2D18B9EC0;
        Thu, 13 Aug 2020 22:25:04 +0000 (UTC)
Received: from mkenigsb.bos.com (ovpn-119-235.rdu2.redhat.com [10.10.119.235])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10F74747A1;
        Thu, 13 Aug 2020 22:24:59 +0000 (UTC)
From:   Matthew Kenigsberg <mkenigs@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, dzickus@redhat.com,
        Matthew Kenigsberg <mkenigs@redhat.com>
Subject: [PATCH] tools/bpftool: Fix uninitialized error
Date:   Thu, 13 Aug 2020 16:24:31 -0600
Message-Id: <20200813222431.25884-1-mkenigs@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static analyzer showed following the code path at
tools/bpf/bpftool/main.c:308 leads to returning err when uninitialized
		if (n_argc < 0)
			goto err_close;

Initializing err to -1 fixes the uninitialized return and prevents
having to add a 3rd err = -1 line.

Signed-off-by: Matthew Kenigsberg <mkenigs@redhat.com>
---
 tools/bpf/bpftool/main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 4a191fcbeb82..a60164fe2b72 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -245,7 +245,7 @@ static int do_batch(int argc, char **argv)
 	int n_argc;
 	FILE *fp;
 	char *cp;
-	int err;
+	int err = -1;
 	int i;
 
 	if (argc < 2) {
@@ -289,7 +289,6 @@ static int do_batch(int argc, char **argv)
 			    strlen(contline) == 0) {
 				p_err("missing continuation line on command %d",
 				      lines);
-				err = -1;
 				goto err_close;
 			}
 
@@ -299,7 +298,6 @@ static int do_batch(int argc, char **argv)
 
 			if (strlen(buf) + strlen(contline) + 1 > sizeof(buf)) {
 				p_err("command %d is too long", lines);
-				err = -1;
 				goto err_close;
 			}
 			buf[strlen(buf) - 2] = '\0';
-- 
2.18.1

