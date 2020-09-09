Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A788C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 05:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE05D21D6C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 05:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599628494;
	bh=7K3jUsErLpQlMX6dJuyBZsgk6m4DY/904IJTlVtc5EE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HoSUdml9+gru3kFUjWvbBeOMs3qYj/4XXDWmw9lMBZH9fZpSRFJ8D0y3VKbLWnWJb
	 dO6brLqUAbHBpAdnSg4y2L2A1QJ8XjkpodtzP/s8+x4cO6pjQ357ZmAg3a6UJvHX8Q
	 5f3FyUEs5Mi+DW1k3OgPTRuuvTNiPsFk6ROQfgOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgIIFOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 01:14:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbgIIFOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 01:14:51 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B15C821D46;
        Wed,  9 Sep 2020 05:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599628489;
        bh=7K3jUsErLpQlMX6dJuyBZsgk6m4DY/904IJTlVtc5EE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dAi5eJ3dul7Pe5F9XEfakKzDqVtwpgz7yCkHR+rlqgR/yKXDodKKuavz9THbncywi
         fqKS4Pshmd3/rJQ+hb5FqUwSkNmDPrr1S/W8bTwR/AO8ONA5w1sWQpZtcX/6qrLaEk
         CwoJUTt2Dk0PQLpWL6BMwsHvpf+j3dodXHsIBE7M=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kFsRS-00BfBt-GH; Wed, 09 Sep 2020 07:14:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v3 2/2] docs: trace: ring-buffer-design.rst: use the new SPDX tag
Date:   Wed,  9 Sep 2020 07:14:33 +0200
Message-Id: <dbc9bd9ab30c6862e465343239e82102cbdc0f39.1599628249.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599628249.git.mchehab+huawei@kernel.org>
References: <cover.1599628249.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPDX v3.10 gained support for GFDL-1.2 with no invariant sections:

	https://spdx.org/licenses/GFDL-1.2-no-invariants-only.html

Let's use it, instead of keeping a license text for this file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/trace/ring-buffer-design.rst | 26 +---------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/Documentation/trace/ring-buffer-design.rst b/Documentation/trace/ring-buffer-design.rst
index 9c8d22a53d6c..c5d77fcbb5bc 100644
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
+.. SPDX-License-Identifier: GPL-2.0 OR GFDL-1.2-no-invariants-only
 
 ===========================
 Lockless Ring Buffer Design
-- 
2.26.2

