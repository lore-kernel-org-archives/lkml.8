Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEA8C2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CFA82075E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586360867;
	bh=usYkvESU4Pm1qI9SJ4cKzhimcRKZU8+i2x+WdqicQE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I1pEwLJzaWYAjzaNylQC2ffcZ4hEd0L6vGwLzqCSTfVnC3gQhlh0b1PH207OtSrMj
	 uyyiCMyaKt/fT0y0ESG3zU49nbLHokxOzO6QoAwewg2lPzi2i41JYp6/99s5hmLBy6
	 3jrC2GB/BDfDRDfKUDzj5nCXHI4NzIE9Z26FEYpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbgDHPrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:47:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729699AbgDHPqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:46:33 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08E1A221F7;
        Wed,  8 Apr 2020 15:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360792;
        bh=usYkvESU4Pm1qI9SJ4cKzhimcRKZU8+i2x+WdqicQE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RoJNJPA0e7Vn1dRueBWJY/nBqTqZ3Xmi7oVYEJ19BPGorxmppzNbB+LE1Fi1CZAPU
         tRl7o+AbPuvJ3OGPlLEk6WMBML1yPdlV1iukvKHvPqymnsY+Wcxa5PnHvnXXTjxa7I
         NHQb2JMsI54oYVHgCEXaAbdgm2Yc+Ji1zDiulDs8=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMCuM-000cCo-8F; Wed, 08 Apr 2020 17:46:30 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 32/35] docs: LaTeX/PDF: drop list of documents
Date:   Wed,  8 Apr 2020 17:46:24 +0200
Message-Id: <864e075058c8a3c2c6a27b05ec4231efafd27bb5.1586359676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586359676.git.mchehab+huawei@kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The building system can auto-generate a list of documents since
commit: 9d42afbe6bd4 ("docs: pdf: add all Documentation/*/index.rst to PDF output").

The added logic there allows keeping the existing list, but
there's not real reason to keep it. Now, the media document
has gone (it was split into tree).

So, it sounds about time to get rid of the manual entries,
and let the script to generate it automatically instead.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/conf.py | 38 --------------------------------------
 1 file changed, 38 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 9ae8e9abf846..f6a1bc07c410 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -388,44 +388,6 @@ if major == 1 and minor < 6:
 #  author, documentclass [howto, manual, or own class]).
 # Sorted in alphabetical order
 latex_documents = [
-    ('admin-guide/index', 'linux-user.tex', 'Linux Kernel User Documentation',
-     'The kernel development community', 'manual'),
-    ('core-api/index', 'core-api.tex', 'The kernel core API manual',
-     'The kernel development community', 'manual'),
-    ('crypto/index', 'crypto-api.tex', 'Linux Kernel Crypto API manual',
-     'The kernel development community', 'manual'),
-    ('dev-tools/index', 'dev-tools.tex', 'Development tools for the Kernel',
-     'The kernel development community', 'manual'),
-    ('doc-guide/index', 'kernel-doc-guide.tex', 'Linux Kernel Documentation Guide',
-     'The kernel development community', 'manual'),
-    ('driver-api/index', 'driver-api.tex', 'The kernel driver API manual',
-     'The kernel development community', 'manual'),
-    ('filesystems/index', 'filesystems.tex', 'Linux Filesystems API',
-     'The kernel development community', 'manual'),
-    ('admin-guide/ext4', 'ext4-admin-guide.tex', 'ext4 Administration Guide',
-     'ext4 Community', 'manual'),
-    ('filesystems/ext4/index', 'ext4-data-structures.tex',
-     'ext4 Data Structures and Algorithms', 'ext4 Community', 'manual'),
-    ('gpu/index', 'gpu.tex', 'Linux GPU Driver Developer\'s Guide',
-     'The kernel development community', 'manual'),
-    ('input/index', 'linux-input.tex', 'The Linux input driver subsystem',
-     'The kernel development community', 'manual'),
-    ('kernel-hacking/index', 'kernel-hacking.tex', 'Unreliable Guide To Hacking The Linux Kernel',
-     'The kernel development community', 'manual'),
-    ('media/index', 'media.tex', 'Linux Media Subsystem Documentation',
-     'The kernel development community', 'manual'),
-    ('networking/index', 'networking.tex', 'Linux Networking Documentation',
-     'The kernel development community', 'manual'),
-    ('process/index', 'development-process.tex', 'Linux Kernel Development Documentation',
-     'The kernel development community', 'manual'),
-    ('security/index', 'security.tex', 'The kernel security subsystem manual',
-     'The kernel development community', 'manual'),
-    ('sh/index', 'sh.tex', 'SuperH architecture implementation manual',
-     'The kernel development community', 'manual'),
-    ('sound/index', 'sound.tex', 'Linux Sound Subsystem Documentation',
-     'The kernel development community', 'manual'),
-    ('userspace-api/index', 'userspace-api.tex', 'The Linux kernel user-space API guide',
-     'The kernel development community', 'manual'),
 ]
 
 # Add all other index files from Documentation/ subdirectories
-- 
2.25.2

