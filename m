Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014FDC4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA45820775
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588022345;
	bh=MAOxLK6HazlHYC77HEsgJ+sJbHyTPFUjh3Ht7/mG/dQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CHBNLEsN+mSuTdXKQfDgcYg3vNv+QHXwmApWAlxSV4kKHZwXZfdo9AcEjWapE2ccA
	 5XFgp8axeYr1NTbNvS2qnG3yX9y4uRsmNNThIfy4NIFnpBnqX42xKO2izWDYqoAyxd
	 rItf2TfNbSMXSTEaWRKcPvMGa7tKBaIMCpZQsu5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgD0VTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 17:19:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgD0VRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:17:25 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F0E221D82;
        Mon, 27 Apr 2020 21:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588022244;
        bh=MAOxLK6HazlHYC77HEsgJ+sJbHyTPFUjh3Ht7/mG/dQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KOxmCBXRVsfMgaoS6PlzxtQfyzArhscI6VgYp24E0urWe8p2qLFhFm0NktOGnOIDA
         tqLc1CB1cOySyoI5eK47gyjoNgfg8ka8mJl2zCFvI/D1cCoPikhCN2qZOGdO4vM9dL
         9QtFe2/h7fWTr2hE2IH6ZjfysG2LQ4R7ORpiTTEE=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jTB7y-000Hki-Pj; Mon, 27 Apr 2020 23:17:22 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 14/29] docs: filesystems: convert fuse-io.txt to ReST
Date:   Mon, 27 Apr 2020 23:17:06 +0200
Message-Id: <88ec8025c1c5fc3ac5b65f1151c41ebcc696dc0e.1588021877.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588021877.git.mchehab+huawei@kernel.org>
References: <cover.1588021877.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add a SPDX header;
- Add a document title;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/{fuse-io.txt => fuse-io.rst} | 6 ++++++
 Documentation/filesystems/index.rst                    | 1 +
 2 files changed, 7 insertions(+)
 rename Documentation/filesystems/{fuse-io.txt => fuse-io.rst} (95%)

diff --git a/Documentation/filesystems/fuse-io.txt b/Documentation/filesystems/fuse-io.rst
similarity index 95%
rename from Documentation/filesystems/fuse-io.txt
rename to Documentation/filesystems/fuse-io.rst
index 07b8f73f100f..255a368fe534 100644
--- a/Documentation/filesystems/fuse-io.txt
+++ b/Documentation/filesystems/fuse-io.rst
@@ -1,3 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============
+Fuse I/O Modes
+==============
+
 Fuse supports the following I/O modes:
 
 - direct-io
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 42f3309b994e..d303d14e381a 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -84,6 +84,7 @@ Documentation for filesystem implementations.
    hfsplus
    hpfs
    fuse
+   fuse-io
    inotify
    isofs
    nilfs2
-- 
2.25.4

