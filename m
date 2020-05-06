Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6161AC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 23:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3948B2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 23:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgEFXxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 19:53:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:25713 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbgEFXxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 19:53:31 -0400
IronPort-SDR: XLLIKqzvonuga+k2UPeRWVcjXr7cBDGNCWbjQBbjW4uEdcIs5HHqSWivKWJlDZZK+98QNVOcSP
 s4GO/qkewjXA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 16:53:31 -0700
IronPort-SDR: umqLMPB30HB3yXKpHBIOJPUICc5dFom0UnYCxYTBiw7raABZzfarpdAzlD5SOOsWv118BlObhJ
 HfSsD7hUyTng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,361,1583222400"; 
   d="scan'208";a="260348561"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by orsmga003.jf.intel.com with ESMTP; 06 May 2020 16:53:31 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2] checkpatch: add GENL_SET_ERR_MSG et al. to 80 column exceptions
Date:   Wed,  6 May 2020 16:53:27 -0700
Message-Id: <20200506235327.3878021-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GENL_SET_ERR_MSG, NL_SET_ERR_MSG, and NL_SET_ERR_MSG_MOD macros are
used to report a string describing a specific error to userspace.

Often, these strings can exceed the normal 80 column limit. However,
just like with strings printed to the kernel log, it is preferred to
keep these on a single line.

Add these macros to the logFunctions exception list in checkpatch.pl

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
---
Changes since v1:
* add GENL_SET_ERR_MSG to the list
* Reword the commit message slightly

 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index eac40f0abd56..818a5b21587d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -471,6 +471,7 @@ our $logFunctions = qr{(?x:
 	WARN(?:_RATELIMIT|_ONCE|)|
 	panic|
 	MODULE_[A-Z_]+|
+	GENL_SET_ERR_MSG|NL_SET_ERR_MSG|NL_SET_ERR_MSG_MOD|
 	seq_vprintf|seq_printf|seq_puts
 )};
 
-- 
2.25.2

