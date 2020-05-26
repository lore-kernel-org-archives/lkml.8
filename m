Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B84DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 06:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 598872087D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 06:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCm9i8vD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbgEZGmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 02:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgEZGmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 02:42:13 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EF2C061A0E;
        Mon, 25 May 2020 23:42:12 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id s19so16667025edt.12;
        Mon, 25 May 2020 23:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=epNgORMkMUjQM1HJoGhYNDvLREi6hqAWQ+HHuUx5oQA=;
        b=jCm9i8vDYHxadEy85yOQF9hCW7pPngLMjzudSBP6uyic88SIOutHgLQGbPrz7tL620
         PhmmRMgCrs7eS9MJfKyTJoYOBwbXaYjM1++N02ym79Cj+Yj0GPyKHHO4FGMGR+PHVREv
         RkV6Tg/n76oQ0euXYdAI71vv6GpyedB3bSrkevbHN6qlfAdH3/sktCn3t/ldj1N/O110
         1OWUSVGBhuRaF1CwGEvPfDzA87wZ24uQrfioFirskmzNuBB35gOY09/z3pSBB1FrNm4N
         2Sr+hKoYsZlS7IRPxPyD0u2EhcUEo872WGyen5o68vCUu58qbR1Wks8tk0pbOGv6V6e3
         n6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=epNgORMkMUjQM1HJoGhYNDvLREi6hqAWQ+HHuUx5oQA=;
        b=Q3MndWQJNWxVtxe1vgNuqP5vnOBiIxTnCOaAuH8U7y15SPqr/EiK88kegqmE+TxkW7
         w3cWg6cMOc1K7IPuXareYWt1OpMSoYsWyUf84lk9V479llitPVrLI/7Zj75KENNezZGc
         CulgJYXTgA8r40v3739MsIG95Wgb0dJUuGhI2x2QuYUOFFVDpK2tNUyWpbaUnXoxfLA9
         djnz7GdQXw4/+wpQo4LC1CXGLB/KCzdtEDgHxEHHmJiWBbA/n41lET3JTk71KmNyFEOb
         42d5ZpZ334DBbQKyxAZiFOy/zQE2qDkKz7u0XX4fCVFf7RRuZjj3rtHoPeja/x1m3nBU
         6Hqg==
X-Gm-Message-State: AOAM5331tBpa1bkT3tXV0Yv/IsRE49/7F6EeZ+D1cT/OF2dXal9LBzda
        InYM+0/AEcXg0siGXXzL1E0=
X-Google-Smtp-Source: ABdhPJzWVhTULfViaUSztBzQyqU1jJtBLgVZY5ewApMINBnYD59qRXLAvDSurLa2F1m7U13J1rHAuw==
X-Received: by 2002:a50:9e21:: with SMTP id z30mr10115849ede.347.1590475330929;
        Mon, 25 May 2020 23:42:10 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d83:f700:a58b:70a4:9fe8:b41f])
        by smtp.gmail.com with ESMTPSA id ld9sm16932149ejb.30.2020.05.25.23.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 23:42:10 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Michel Lespinasse <walken@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] doc: filesystems: format tables in locking properly
Date:   Tue, 26 May 2020 08:41:59 +0200
Message-Id: <20200526064159.11361-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 28df3d1539de ("nfsd: clients don't need to break their own
delegations") introduced lm_breaker_owns_lease and documented that in the
according table. Commit 43dbd0e7e62b ("mmap locking API: convert mmap_sem
comments") renamed mmap_sem to mmap_lock in another table. Both changes
created a table entry longer than the content before, but did not adjust
the tables. Hence, make htmldocs warns about malformed tables.

Adjust the tables to address the warning.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Michel, Vlastimil, please ack this patch.

Andrew, please pick this minor doc fix patch into your -next tree, where
patch "mmap locking API: convert mmap_sem comments" has been applied.


 Documentation/filesystems/locking.rst | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 318605de83f3..faf7f4abd54d 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -433,15 +433,15 @@ prototypes::
 
 locking rules:
 
-==========		=============	=================	=========
-ops			inode->i_lock	blocked_lock_lock	may block
-==========		=============	=================	=========
-lm_notify:		yes		yes			no
-lm_grant:		no		no			no
-lm_break:		yes		no			no
-lm_change		yes		no			no
-lm_breaker_owns_lease:	no		no			no
-==========		=============	=================	=========
+======================		=============	=================	=========
+ops				inode->i_lock	blocked_lock_lock	may block
+======================		=============	=================	=========
+lm_notify:			yes		yes			no
+lm_grant:			no		no			no
+lm_break:			yes		no			no
+lm_change			yes		no			no
+lm_breaker_owns_lease:		no		no			no
+======================		=============	=================	=========
 
 buffer_head
 ===========
@@ -616,9 +616,9 @@ prototypes::
 
 locking rules:
 
-=============	========	===========================
+=============	=========	===========================
 ops		mmap_lock	PageLocked(page)
-=============	========	===========================
+=============	=========	===========================
 open:		yes
 close:		yes
 fault:		yes		can return with page locked
@@ -626,7 +626,7 @@ map_pages:	yes
 page_mkwrite:	yes		can return with page locked
 pfn_mkwrite:	yes
 access:		yes
-=============	========	===========================
+=============	=========	===========================
 
 ->fault() is called when a previously not present pte is about
 to be faulted in. The filesystem must find and return the page associated
-- 
2.17.1

