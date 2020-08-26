Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301C0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 07:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0661820767
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 07:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598426911;
	bh=cBZ3Gb+SQy3R6NrwPSw69ZFfRmSEAixJtgbTl9nTZa4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=jlwBkqQCAfZyQQgxapeZz3SfoIL05AQil5yJ7IwWKl2cmJrZuAo7U45yvJ5J2BaaR
	 N7hxHADajby3qYoQlLbyuqjHSCn5ThrYeba6HETNcowBbh9MXBDQHySV2S1CXTmJK6
	 qgW+hxVIivZG7VWA9MHrswHfiCy+g/7NV6GLkUb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgHZH23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 03:28:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbgHZH22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 03:28:28 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E534B2071E;
        Wed, 26 Aug 2020 07:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598426908;
        bh=cBZ3Gb+SQy3R6NrwPSw69ZFfRmSEAixJtgbTl9nTZa4=;
        h=From:To:Cc:Subject:Date:From;
        b=E7sWpsx9KISTMma4faGLO3PWiUxhHzKmDcjQwtIr+2b0Ulb67RkdGd4JwiWeFnGq2
         5qzRgaIfjIucMnUe056rwt0xBAUyLqf8w0I/3R6XZXh04d++STsH4W6vJ+HPKEW4XO
         OdhllpIrmDqJwnyxCl23/ZN5JbHGWDIpffQBF7Pk=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kApr7-001RrA-SP; Wed, 26 Aug 2020 09:28:25 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH] docs: trace: ring-buffer-design.rst: use the new SPDX tag
Date:   Wed, 26 Aug 2020 09:28:24 +0200
Message-Id: <290d101bee434e54acec13778c67c77802fbc953.1598426895.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPDX v3.10 gained support for GFDL-1.2 with no invariant sections:

	https://spdx.org/licenses/GFDL-1.2-invariants-only.html

Let's use it, instead of keeping a license text for this file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/trace/ring-buffer-design.rst | 26 +---------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/Documentation/trace/ring-buffer-design.rst b/Documentation/trace/ring-buffer-design.rst
index 9c8d22a53d6c..a76435610b58 100644
--- a/Documentation/trace/ring-buffer-design.rst
+++ b/Documentation/trace/ring-buffer-design.rst
@@ -1,28 +1,4 @@
-.. This file is dual-licensed: you can use it either under the terms
-.. of the GPL 2.0 or the GFDL 1.2 license, at your option. Note that this
-.. dual licensing only applies to this file, and not this project as a
-.. whole.
-..
-.. a) This file is free software; you can redistribute it and/or
-..    modify it under the terms of the GNU General Public License as
-..    published by the Free Software Foundation version 2 of
-..    the License.
-..
-..    This file is distributed in the hope that it will be useful,
-..    but WITHOUT ANY WARRANTY; without even the implied warranty of
-..    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-..    GNU General Public License for more details.
-..
-.. Or, alternatively,
-..
-.. b) Permission is granted to copy, distribute and/or modify this
-..    document under the terms of the GNU Free Documentation License,
-..    Version 1.2 version published by the Free Software
-..    Foundation, with no Invariant Sections, no Front-Cover Texts
-..    and no Back-Cover Texts. A copy of the license is included at
-..    Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GPL-2.0 OR GFDL-1.2 WITH no-invariant-sections
+.. SPDX-License-Identifier: GPL-2.0 OR GFDL-1.2-invariants-only
 
 ===========================
 Lockless Ring Buffer Design
-- 
2.26.2

