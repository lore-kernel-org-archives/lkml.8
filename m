Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CE4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFC42205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597838877;
	bh=9+A5km3rBzonFlpdLOc0whd9dr9SchgC9q+8u5/c76o=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=D6SbX9s2qa4EPmxFZkVHAxR6A8Y9oV5FXcGYcpo4Uj20c+oXX4+VMTB0T+SctU42z
	 p5Ep/BPcuJYTQjI1p30Pz6sUBrH2idqZTFcx6pHV2bGMWFojEmbh6adLbgHbuJhjTO
	 hMWkmpKy27glZ5s1vihv9/wzzFMQeDYWxss3WoBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgHSMHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:07:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728254AbgHSMGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:06:45 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32B862063A;
        Wed, 19 Aug 2020 12:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597838804;
        bh=9+A5km3rBzonFlpdLOc0whd9dr9SchgC9q+8u5/c76o=;
        h=From:To:Cc:Subject:Date:From;
        b=EqviEmp8C9kRTc1t3ll7o04U9C+mageaSvMQi+eTgEkaJAfNO+/TmnpTtKM4Nvz4H
         bxNgdgvqJkdTcKQzQkGRpyD4F9j4VO9dAwWKJ0xVSPlyt5SUUobxXDvLEKlZ5XTCkk
         Jp+IfvNW6MUMRhr2/wHylrlkek3h+ytm1EFhLeks=
From:   Leon Romanovsky <leon@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] fs: Add function declaration of simple_dname
Date:   Wed, 19 Aug 2020 15:06:40 +0300
Message-Id: <20200819120640.939889-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The simple_dname() is declared in internal header file but the
declaration is missing in d_path.c.

The compilation with W=1 generates the following GCC warning.

fs/d_path.c:311:7: warning: no previous prototype for 'simple_dname' [-Wmissing-prototypes]
  311 | char *simple_dname(struct dentry *dentry, char *buffer, int buflen)
      |       ^~~~~~~~~~~~

Fixes: 7e5f7bb08b8c ("unexport simple_dname()")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Changelog:
v1: Dropped "extern" removal chunk
v0: https://lore.kernel.org/lkml/20200819083259.919838-1-leon@kernel.org/
---
 fs/d_path.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/d_path.c b/fs/d_path.c
index 0f1fc1743302..4b89448cc78e 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -8,6 +8,8 @@
 #include <linux/prefetch.h>
 #include "mount.h"

+#include "internal.h"
+
 static int prepend(char **buffer, int *buflen, const char *str, int namelen)
 {
 	*buflen -= namelen;
--
2.26.2

