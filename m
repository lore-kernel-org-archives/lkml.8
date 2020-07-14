Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B1CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D372077D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSDD6Oor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgGNNFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:05:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39526 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726354AbgGNNFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594731921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=6VIoOR5Zq1Eiat1CGdfDl2SCC7HipCcOifvnlXpfoZM=;
        b=dSDD6Oor+i8plV7dOuIihMZwjU3vWVYFBF2oP5TePkhDWQU3E8cQyL+DUv1ueAPhMGncSv
        JlSTEuqVSeuHXeTRFPIeGVSJMpaAEt0+MKgREFMVMufNwilCTWbGtzRQXAZeLmVCodIj8L
        3Yf0ulkOrP7oP0EqRgUJviMALmhz/h0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-cZoKZhCvPuSzp2ujv3ravg-1; Tue, 14 Jul 2020 09:05:18 -0400
X-MC-Unique: cZoKZhCvPuSzp2ujv3ravg-1
Received: by mail-qt1-f200.google.com with SMTP id x6so12533252qtf.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 06:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6VIoOR5Zq1Eiat1CGdfDl2SCC7HipCcOifvnlXpfoZM=;
        b=QgybBT1IthZyJGAHyjLz+qsNAr7DXhS1wiJFZTZ9mW6/jIr6ubvtChdumDn4ZMpMjO
         DUw6/wIQ40NaHz3dcMvYrILAdW0JzNNYjD4yMq/j1HNUYNy9gLMY72aXtktzCSIX2eec
         iiZfsSOdPxX1zZjp9ffMie1PzA6DWBrRNbvzPssj+dmT5Uu2rxH+imfG6OMbNX+NZk1P
         uG6yxZsXw41SuGVjahwAEbvquqduD8aTd4LWyB9VZAkQgx9FlWdmbV63SrdVlKQLFE+P
         xbRWJBy0ROEIzZq1qtsgsTfesVcZhi07G2fICt5HQ8JJq16259mVG3BemogUxR2gQeF6
         OiGg==
X-Gm-Message-State: AOAM532ib5sQkPhySW8veWkXhn8bBtyKPjW/ZEjrLY4m/MVIRVHHrnnX
        LV1ssxdUBzKB/o6fKlWGH5gUTvyqq98UmkD7f9pbs6gTCcDARUsWALSXTXJ8gdJs9FZANeiXuPP
        Gwt4ZyeizvoIfGzHH3G3/nUIO
X-Received: by 2002:ac8:197b:: with SMTP id g56mr4449149qtk.105.1594731917837;
        Tue, 14 Jul 2020 06:05:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVKa3PW5ERXw99RIG+5uzKIILhRlDiEsTBc59MTNrGF1RtX7vID/XbIEyJTmTUVgPSjNdDnA==
X-Received: by 2002:ac8:197b:: with SMTP id g56mr4449125qtk.105.1594731917573;
        Tue, 14 Jul 2020 06:05:17 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b53sm23888483qtc.65.2020.07.14.06.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 06:05:16 -0700 (PDT)
From:   trix@redhat.com
To:     jack@suse.cz, william.kucharski@oracle.com, jeffm@suse.com,
        willy@infradead.org, joseph.qi@linux.alibaba.com,
        liao.pingfang@zte.com.cn
Cc:     reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] reiserfs : fix improper free in reiserfs_get_block
Date:   Tue, 14 Jul 2020 06:05:09 -0700
Message-Id: <20200714130509.11791-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis flags this error

inode.c:1083:5: warning: Argument to kfree() is the address of the
  local variable 'unf_single', which is not memory allocated by
  malloc() [unix.Malloc]
                                kfree(un);
                                ^~~~~~~~~
Assignment of 'un'

	/*
	 * We use this in case we need to allocate
	 * only one block which is a fastpath
	 */
	unp_t unf_single = 0;

	...

	if (blocks_needed == 1) {
		un = &unf_single;
	} else {
		un = kcalloc(min(blocks_needed, max_to_insert),
			     UNFM_P_SIZE, GFP_NOFS);
		if (!un) {
			un = &unf_single;
			blocks_needed = 1;
			max_to_insert = 0;
		}
	}

The logic to free 'un'

	if (blocks_needed != 1)
		kfree(un);

Because the kcalloc failure falls back to using unf_single,
the if-check for the free is wrong.

So improve the check.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/reiserfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index 1509775da040..4d62148e43e6 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -1079,7 +1079,7 @@ int reiserfs_get_block(struct inode *inode, sector_t block,
 						     UNFM_P_SIZE *
 						     blocks_needed);
 
-			if (blocks_needed != 1)
+			if (un != &unf_single)
 				kfree(un);
 
 			if (retval) {
-- 
2.18.1

