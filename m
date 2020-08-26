Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FF0C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D2202224D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598449641;
	bh=7K3jUsErLpQlMX6dJuyBZsgk6m4DY/904IJTlVtc5EE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Aezl4EdAoWtxLh82vjBE7Z8df/h2j4kWUGz3iz7g73OTeRzxHbjfFbyZ8AAE50b6G
	 I6wkLHKufZYF+98aYbOFlvCq9jsVaG/QYKd0JYwSuz6Wb9wNziiSJH98H0SQUy7iuK
	 yJQ0TFSQNTtYuorivz4lgdLMV48Kv32OygT+g6qE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730441AbgHZNrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:47:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730408AbgHZNq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:46:56 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CE3D22B49;
        Wed, 26 Aug 2020 13:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598449615;
        bh=7K3jUsErLpQlMX6dJuyBZsgk6m4DY/904IJTlVtc5EE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fa5olesmcC8ARkqksZX0++ym1yo5Ta6l/oaxRpvoyLFESaYNLRnVN6cj3X67mZVAI
         x79igucw0Rm4Yw/AqzSrDA1NaB/pG2uYk//15wpHlhRb2oTPnT1Zrp5vGyy3Nmh7+Q
         K4HRGVyaNWaz1vtQ371p85x6Lu6Td7t5GSG91J+g=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kAvlN-002L54-Iz; Wed, 26 Aug 2020 15:46:53 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
Subject: [PATCH v2 2/2] docs: trace: ring-buffer-design.rst: use the new SPDX tag
Date:   Wed, 26 Aug 2020 15:46:52 +0200
Message-Id: <cafc8049c31440de6fe7b115d0346fa0308bd354.1598449136.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1598449136.git.mchehab+huawei@kernel.org>
References: <cover.1598449136.git.mchehab+huawei@kernel.org>
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

