Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD47C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75B2E2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgHQO2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:28:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:55152 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728669AbgHQO2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:28:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DCA04AB8B;
        Mon, 17 Aug 2020 14:29:09 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Coly Li <colyli@suse.de>, Dan Williams <dan.j.williams@intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2] docs: update trusted-encrypted.rst
Date:   Mon, 17 Aug 2020 22:28:37 +0800
Message-Id: <20200817142837.5224-1-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameters in tmp2 commands are outdated, people are not able to
create trusted key by the example commands.

This patch updates the paramerters of tpm2 commands, they are verified
by tpm2-tools-4.1 with Linux v5.8 kernel.

Signed-off-by: Coly Li <colyli@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: James Bottomley <jejb@linux.ibm.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>
---
Changelog:
v2: remove the change of trusted key related operation.
v1: initial version.

 Documentation/security/keys/trusted-encrypted.rst | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index 9483a7425ad5..1da879a68640 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -39,10 +39,9 @@ With the IBM TSS 2 stack::
 
 Or with the Intel TSS 2 stack::
 
-  #> tpm2_createprimary --hierarchy o -G rsa2048 -o key.ctxt
+  #> tpm2_createprimary --hierarchy o -G rsa2048 -c key.ctxt
   [...]
-  handle: 0x800000FF
-  #> tpm2_evictcontrol -c key.ctxt -p 0x81000001
+  #> tpm2_evictcontrol -c key.ctxt 0x81000001
   persistentHandle: 0x81000001
 
 Usage::
-- 
2.26.2

