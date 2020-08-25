Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4524BC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DBB32072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgHYE4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:56:45 -0400
Received: from smtprelay0088.hostedemail.com ([216.40.44.88]:33320 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728089AbgHYE4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:56:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 2EF52181D330D;
        Tue, 25 Aug 2020 04:56:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lead12_050acb727059
X-Filterd-Recvd-Size: 1870
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Aug 2020 04:56:43 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 01/29] coding-style.rst: Avoid comma statements
Date:   Mon, 24 Aug 2020 21:55:58 -0700
Message-Id: <2a97b738bba335434461a5a918053a49c1fb6af4.1598331148.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1598331148.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commas are not how statements are terminated.
Always use semicolons and braces if necessary.

Signed-off-by: Joe Perches <joe@perches.com>
---
 Documentation/process/coding-style.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 98227226c4e5..a1e061149e0d 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -69,9 +69,26 @@ something to hide:
 	if (condition) do_this;
 	  do_something_everytime;
 
+Don't use commas to avoid using braces:
+
+.. code-block:: c
+
+	if (condition)
+		do_this(), do_that();
+
+Always uses braces for multiple statements:
+
+.. code-block:: c
+
+	if (condition) {
+		do_this();
+		do_that();
+	}
+
 Don't put multiple assignments on a single line either.  Kernel coding style
 is super simple.  Avoid tricky expressions.
 
+
 Outside of comments, documentation and except in Kconfig, spaces are never
 used for indentation, and the above example is deliberately broken.
 
-- 
2.26.0

