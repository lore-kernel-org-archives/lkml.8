Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFDBC2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 21:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64E92054F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 21:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585778130;
	bh=62cXekQnZXOkh+s2siL3yDTLY6DMNJxySDo9IuHSES4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=sZvBZYyGCT+tfkfPGpGtzdzvqP05admyWwaXt5SLRFOhGmalvYSw0EkxxrzicWJl7
	 uBqXfrFAfXNAUqFFDA1C1uGVCvKVGCpsTDb+RHNZBr1yzoFTnn+E/EFYnrIkesSm6w
	 CugU6KWMcYR0igoFsYHnAnIH3dcLX5BOtXFlwEHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733144AbgDAVz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 17:55:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732357AbgDAVzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 17:55:25 -0400
Received: from lenoir.home (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 267C72054F;
        Wed,  1 Apr 2020 21:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585778124;
        bh=62cXekQnZXOkh+s2siL3yDTLY6DMNJxySDo9IuHSES4=;
        h=From:To:Cc:Subject:Date:From;
        b=qFQCqLnvhyJ3f4tddN1//ssEJSlpptpBEPVOfxTyhVLN1/cgHDEE5x2mv8hQddc9O
         rYCMrEUrAe+VgOLjVmRqLm9SwPvXFjZXWucduEIEkY8cWnzCLHPDeTZPkANaGdZJ8v
         SYJ5WWbqorKNi15xi3V0wuMS7mHOLxZ0mPIKREOo=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH] scripts: Add automatic patch review script
Date:   Wed,  1 Apr 2020 23:55:19 +0200
Message-Id: <20200401215519.22912-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the ever increasing volume of patches posted everyday, it has now
become hardly possible to keep up with a sane review pace, not even for
many single subsystems.

The only way to keep up to date would be to make the review process
automatic.

Now review, at a first glance, remain the last thing that can't be
automatized at all as it can only require a person to sit down and
figure out some opinion about some change.

Of course and as is often the case, an obvious and elegant solution was
waiting to be discovered. And it has been waiting since the creation of
the "Reviewed-by" tag.

All it takes is to simply generate a "Reviewed-by:" tag that you can pipe
to your favourite email sender. The script waits for a reasonably
random amount of time between each call, so that other reviewers don't
get too impressed and discouraged by how fast your CPU can make up an
opinion about a patchbomb.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 scripts/review_patch | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 scripts/review_patch

diff --git a/scripts/review_patch b/scripts/review_patch
new file mode 100644
index 000000000000..bf08dba2bf60
--- /dev/null
+++ b/scripts/review_patch
@@ -0,0 +1,4 @@
+#!/bin/bash
+
+sleep $RANDOM
+echo "Reviewed-by: $(git config --get user.name) <$(git config --get user.email)>"
-- 
2.25.0

