Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C392C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9C120692
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sslab.ics.keio.ac.jp header.i=@sslab.ics.keio.ac.jp header.b="f4PZ9Bp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgDIPCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 11:02:39 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:47027 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgDIPCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 11:02:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id k191so5079326pgc.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 08:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sslab.ics.keio.ac.jp; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dvyI036P6l3pT4bwTfgpCwEd0qlAqIVfCnEFYrQjFgY=;
        b=f4PZ9Bp7DWyP45o1+1dY6OVR9t/Zn2U4t5xNaMLvMds4J0mo8zf/NBp6vUIk9mngXh
         Y/A5NFrZtyE6uz8iwlOW5p/92lllpK6egMiWRFzyA+Ba9vXeCKQMG+IHqkdKSwo5rgGa
         OEFxEe6JIVdZf8iaj0THuN4IQubcC6Di5dUeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dvyI036P6l3pT4bwTfgpCwEd0qlAqIVfCnEFYrQjFgY=;
        b=qlawE4hBmr/5bUCwB0JtbQP0NwYPgAy0IJizWd0AOBtI7ru90AJCOLrZKzqR1f0T5N
         Nypok4aWThdfjCAqbr6OUuvAecQmoyF75L+DfVEPis+PXI2FgbC14pirB6iWBpFaUJVn
         qiUfpfwP6qvPSE681IE79GJ/EDw7qfPLBHbMiWS2WqrycIlO/Ehnz+eOF+7eoGfnChgh
         7t0L/O5UR5RyCIsb0gEVJGJqydQBAhV+J2IU+I0q71cVcT7eag2FAcAGv8yM2gNX8Gxw
         Bii3A0SLiy7KoZN2wVhN3HaZWJGeB3I8LExW/df0rqoT8jkrfBo/mJhbKk1b5Di830V0
         oV6A==
X-Gm-Message-State: AGi0PuY/9ew1DCiXxsdubFAG5HW+ss51Vc/DJHCQV5ga2cvGpXG+5Mrz
        1bUD4sRa+/pmLFhIXcYMYg8m4A==
X-Google-Smtp-Source: APiQypJTXJxBJ9WbxJJfFI/qBsLnEp2Iq0pi46An/bRVCiraAMsH8JrHzqke9DjnO90Z7gNY5xGcAw==
X-Received: by 2002:a63:6cc5:: with SMTP id h188mr12079390pgc.337.1586444557551;
        Thu, 09 Apr 2020 08:02:37 -0700 (PDT)
Received: from brooklyn.i.sslab.ics.keio.ac.jp (sslab-relay.ics.keio.ac.jp. [131.113.126.173])
        by smtp.googlemail.com with ESMTPSA id a3sm2823068pfi.60.2020.04.09.08.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 08:02:36 -0700 (PDT)
From:   Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Cc:     keitasuzuki.park@sslab.ics.keio.ac.jp,
        takafumi.kubota1012@sslab.ics.keio.ac.jp,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        oss-drivers@netronome.com (open list:NETRONOME ETHERNET DRIVERS),
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] nfp: Fix memory leak in nfp_resource_acquire()
Date:   Thu,  9 Apr 2020 15:02:07 +0000
Message-Id: <20200409150210.15488-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a memory leak in nfp_resource_acquire(). res->mutex is
alllocated in nfp_resource_try_acquire(). However, when
msleep_interruptible() or time_is_before_eq_jiffies() fails, it falls
into err_fails path where res is freed, but res->mutex is not.

Fix this by changing call to free to nfp_resource_release().

Signed-off-by: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
---
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c
index ce7492a6a98f..95e7bdc95652 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c
@@ -200,7 +200,7 @@ nfp_resource_acquire(struct nfp_cpp *cpp, const char *name)
 
 err_free:
 	nfp_cpp_mutex_free(dev_mutex);
-	kfree(res);
+	nfp_resource_relase(res);
 	return ERR_PTR(err);
 }
 
-- 
2.17.1

