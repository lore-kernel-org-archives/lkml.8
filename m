Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3014C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2BD92076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586961257;
	bh=9Zz8M1MIjA+5RpaQ9/sXfDtVatFa96x0ZrFlhcdAIqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=joYmjjksFoT9/qIvB2NA+00/ftGwyQ/JLH9g/TtgVyT2ptnVoIOq1//BzXH+Pvp1E
	 P2z5nY4m4nqN/z9DSZYbGt37WzGcIqlEGFiaIfjOhX68sC8hS4aiqGfRzdm5+57VFU
	 12t18FCXw6s1DDJQA0b6jOkUf10znPLS6R1BDER4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394137AbgDOOeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:34:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394041AbgDOOc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:32:57 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DAA5218AC;
        Wed, 15 Apr 2020 14:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586961171;
        bh=9Zz8M1MIjA+5RpaQ9/sXfDtVatFa96x0ZrFlhcdAIqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n8GxPM/VdYSVfl0DhxdavS/FmgjV8ZH8ovWSuDiKUV1b23WKzeB2gt2vgEcj3cBXt
         oRGAaordgJlamgmxDg4TL+AtaxPyMk6lmoBnMz+wuNI/v1NaFfwXAYd54P0hSdfYaV
         S5p4yDRVOp/lWvzW+ONjJCjBtLcYbW7+Z5cwiHUc=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOj5t-006kP3-JQ; Wed, 15 Apr 2020 16:32:49 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 17/34] docs: filesystems: convert fuse-io.txt to ReST
Date:   Wed, 15 Apr 2020 16:32:30 +0200
Message-Id: <b266b01b333e2e9fda16ba5b4ae63284966032c6.1586960617.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586960617.git.mchehab+huawei@kernel.org>
References: <cover.1586960617.git.mchehab+huawei@kernel.org>
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
index c947df7b2a47..300e12569f54 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -85,6 +85,7 @@ Documentation for filesystem implementations.
    hfsplus
    hpfs
    fuse
+   fuse-io
    inotify
    isofs
    nilfs2
-- 
2.25.2

