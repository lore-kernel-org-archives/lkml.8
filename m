Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF4CC47257
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 414D324958
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588347522;
	bh=Wxx2oZbffutV8kZPE3MJgAW1A6mvkVwLXA6qbKHYI+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C6DbWIxjlthygxo0T9lsfX2gZsUnTYqT6Flpey6VJsM0WeK/rEG8C4VuD6PNNdQPg
	 IRVzjXb+4NJgmtLTnlfsDvrgg1IlCVhbeRvHjQKDJLUPmqMsYrMIfMj9jJB1ExlW+0
	 lfkVTL9ATq1Jvyn7z2ct2cjlpUkCl72lQJrOw70o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbgEAPil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 11:38:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729695AbgEAPiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:38:04 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDC402495F;
        Fri,  1 May 2020 15:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588347483;
        bh=Wxx2oZbffutV8kZPE3MJgAW1A6mvkVwLXA6qbKHYI+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rfM8V6Z4PW8OsyUOKTiP1boqw/qb2pGyw9a/n5oSNBoMicxJILMs0dg5b48RThhuE
         f8qpHXy21M+N77Z18ZVQLlBtFXJpsOZtU6bs758LQyNpMhLpfsY6aeOAPZY0yncal1
         nTObY1IwE1yllaBMKBfwUFE5AfEWGEMsmRiNM8KM=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jUXjl-00FE4v-5Q; Fri, 01 May 2020 17:38:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 08/14] docs: move kobject and kref docs into the core-api book
Date:   Fri,  1 May 2020 17:37:52 +0200
Message-Id: <f385af13b4a6d3ff8c89beedd4506900e79ca72e.1588345503.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588345503.git.mchehab+huawei@kernel.org>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both documents are documenting Kernel core objects. So, add
them into the core-api book.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/core-api/index.rst              | 1 +
 Documentation/core-api/kobject.rst            | 2 +-
 Documentation/{kref.txt => core-api/kref.rst} | 0
 3 files changed, 2 insertions(+), 1 deletion(-)
 rename Documentation/{kref.txt => core-api/kref.rst} (100%)

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index 49a885e83a55..eeac63ba17c3 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -31,6 +31,7 @@ Library functionality that is used throughout the kernel.
    :maxdepth: 1
 
    kobject
+   kref
    assoc_array
    xarray
    idr
diff --git a/Documentation/core-api/kobject.rst b/Documentation/core-api/kobject.rst
index 1f62d4d7d966..44c02be65475 100644
--- a/Documentation/core-api/kobject.rst
+++ b/Documentation/core-api/kobject.rst
@@ -210,7 +210,7 @@ statically and will warn the developer of this improper usage.
 If all that you want to use a kobject for is to provide a reference counter
 for your structure, please use the struct kref instead; a kobject would be
 overkill.  For more information on how to use struct kref, please see the
-file Documentation/kref.txt in the Linux kernel source tree.
+file Documentation/core-api/kref.rst in the Linux kernel source tree.
 
 
 Creating "simple" kobjects
diff --git a/Documentation/kref.txt b/Documentation/core-api/kref.rst
similarity index 100%
rename from Documentation/kref.txt
rename to Documentation/core-api/kref.rst
-- 
2.25.4

