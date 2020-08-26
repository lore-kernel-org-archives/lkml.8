Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B57C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7D8B20838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598438833;
	bh=Ge8bCOe4Iv5pqs/jRkc5OuqiE2EUk7j6IN03gI+k+5o=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ZlePawOVNajEXvRH6qV/kbTljFsW7cMtaLbOm8Db5diV3mdbyFJm01Q0obkqvv8a0
	 4+qpYX5y0SX+rsSiDyzEXf+G6CF0o8iUHXYTfz1S+q+zIE3OfQXX20/oF9CNUKIEwV
	 5UA64dw+Nt7X3yeLI1t+nE1uoLd1qiLm8nDfQGug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgHZKrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 06:47:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgHZKrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:47:09 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0260A206EB;
        Wed, 26 Aug 2020 10:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598438829;
        bh=Ge8bCOe4Iv5pqs/jRkc5OuqiE2EUk7j6IN03gI+k+5o=;
        h=From:To:Cc:Subject:Date:From;
        b=Mj1zfS6GfOwr2mKpnxfNvtSARXgbY9Yp3zSusU5prRwb8DQhVl7wv5GTGFF94sDbd
         BWOI+4SXMWZyfUOo+3xeds1GT+/64sSQPo06opGWWbcN+pxXxyne6UDXGQBd9JJwcF
         8x1PhLw5TQO+u+zDlDIPxK0/8iI52VBvcRVgbJRI=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kAsxP-002DVF-2m; Wed, 26 Aug 2020 12:47:07 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] .gitignore: docs: ignore sphinx_*/ directories
Date:   Wed, 26 Aug 2020 12:47:05 +0200
Message-Id: <20200826104705.528522-1-mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default way of building documentation is to use
Sphinx toolchain installed via pip, inside the
Kernel tree main directory. That's what's recommended by:

	scripts/sphinx-pre-install

As it usually provides a better version of this package
than the one installed, specially on LTS distros.

So, add the directories created by running the commands
suggested by the script.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitignore b/.gitignore
index 162bd2b67bdf..d01cda8e1177 100644
--- a/.gitignore
+++ b/.gitignore
@@ -152,3 +152,6 @@ x509.genkey
 
 # Clang's compilation database file
 /compile_commands.json
+
+# Documentation toolchain
+sphinx_*/
-- 
2.26.2

