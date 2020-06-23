Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15BEC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A048E20791
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592905992;
	bh=wN0P/QDy192u7/6MjOrYNxlOo/vHTCArMdyL+uoVyLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YvlluAyB4NAfy4pfQvtDPwJcnR3iYaY24HLANnqtjhfUF6MtUrYzkECj0jEdJeOC1
	 TGxtDA6aW/NJFRwcwXok9OiHYntbKERKE+zl87sedcSkIKmo5fyEBbLahVo2CA3Sx5
	 5gB77YuCuMoM0eR9e/qbT4fPRyxOmErid3yDKhvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732253AbgFWJxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:53:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732159AbgFWJxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:53:06 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D0E4207BB;
        Tue, 23 Jun 2020 09:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592905986;
        bh=wN0P/QDy192u7/6MjOrYNxlOo/vHTCArMdyL+uoVyLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dmIEa/0pPyp7xDIhVh8Wqd2L3sWHJRza0P4YFVRNC4EF7LSSFM5q5CjXI9JqiGEl0
         pYXoc0n5qrXpoJPYTCIMhdvTTTFfZxlcdA3KfwrDxR/5S9Zva86Ps7ndy5OaPZNxzw
         1T20ps3huYb7y1pKXvPq0pOqtX8w9MDQAaRM7Ldc=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jnfc0-004C3d-EM; Tue, 23 Jun 2020 11:53:04 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 8/9] docs: Add remaining Documentation/*.txt at staging/index.rst
Date:   Tue, 23 Jun 2020 11:53:01 +0200
Message-Id: <7db59daca912312ef750fd05359d801a7d80573e.1592905407.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592905407.git.mchehab+huawei@kernel.org>
References: <cover.1592905407.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few text files that aren't yet at the docs building
system.

Add those to the staging/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/staging/index.rst | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/staging/index.rst b/Documentation/staging/index.rst
index 8cc9d94b0a13..8e98517675ca 100644
--- a/Documentation/staging/index.rst
+++ b/Documentation/staging/index.rst
@@ -19,17 +19,14 @@ Unsorted Documentation
 Atomic Types
 ============
 
-.. include:: ../atomic_t.txt
-   :literal:
+.. literalinclude:: ../atomic_t.txt
 
 Atomic bitops
 =============
 
-.. include:: ../atomic_bitops.txt
-   :literal:
+.. literalinclude:: ../atomic_bitops.txt
 
 Memory Barriers
 ===============
 
-.. include:: ../memory-barriers.txt
-   :literal:
+.. literalinclude:: ../memory-barriers.txt
-- 
2.26.2

