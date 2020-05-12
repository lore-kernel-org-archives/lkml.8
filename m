Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9CDC2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50B1920731
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLjhGhUV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgELWj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:39:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29720 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726031AbgELWj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589323196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Gn7nXTm0O1XhEm5zfYkiFb/JrISIuLYstdkDlREWsE8=;
        b=BLjhGhUVBS6MkMdM0L3ydl7Zzh/sJUTyOW/mn5U8My93PubPWPY08UhJUL46oK95tIzUpO
        MgoekkOsjMgcPJZpPPUMKIMRSkhapUb5arJqNXWR7y84B7anF301zX8pcoEbaotXMEbAoJ
        sdhEIv52UpQzC+WbcSsPBRipxjpPVCw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-k72NQ3s4Pdut49pbsVXbkw-1; Tue, 12 May 2020 18:39:52 -0400
X-MC-Unique: k72NQ3s4Pdut49pbsVXbkw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02ED3800687;
        Tue, 12 May 2020 22:39:51 +0000 (UTC)
Received: from optiplex-lnx.redhat.com (unknown [10.3.128.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D6B6648D7;
        Tue, 12 May 2020 22:39:49 +0000 (UTC)
From:   Rafael Aquini <aquini@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        mcgrof@kernel.org
Cc:     keescook@chromium.org, akpm@linux-foundation.org,
        yzaikin@google.com, tytso@mit.edu
Subject: [PATCH v2] kernel: sysctl: ignore out-of-range taint bits introduced via kernel.tainted
Date:   Tue, 12 May 2020 18:39:46 -0400
Message-Id: <20200512223946.888020-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users with SYS_ADMIN capability can add arbitrary taint flags
to the running kernel by writing to /proc/sys/kernel/tainted
or issuing the command 'sysctl -w kernel.tainted=...'.
These interface, however, are open for any integer value
and this might an invalid set of flags being committed to
the tainted_mask bitset.

This patch introduces a simple way for proc_taint() to ignore
any eventual invalid bit coming from the user input before
committing those bits to the kernel tainted_mask.

Signed-off-by: Rafael Aquini <aquini@redhat.com>
---
Changelog:
v2: simplify the bit iterator within proc_taint(),
    and silently drop out-of-range bits                         (akpm)

 kernel/sysctl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 8a176d8727a3..fcd46fc41206 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2628,10 +2628,9 @@ static int proc_taint(struct ctl_table *table, int write,
 		 * to everyone's atomic.h for this
 		 */
 		int i;
-		for (i = 0; i < BITS_PER_LONG && tmptaint >> i; i++) {
-			if ((tmptaint >> i) & 1)
+		for (i = 0; i < TAINT_FLAGS_COUNT; i++)
+			if ((1UL << i) & tmptaint)
 				add_taint(i, LOCKDEP_STILL_OK);
-		}
 	}
 
 	return err;
-- 
2.25.4

