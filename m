Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3265C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 04:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85FAC2078A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 04:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388542AbgFXEvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 00:51:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:15214 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728766AbgFXEvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 00:51:40 -0400
IronPort-SDR: 7qeXWbjgoE6V/dJ+wtzc4f9TiCHOlLKBSzwg0daeNygn6ZSRRC+CEB+2663DUL+dcXfwkm91Gp
 Q97hoj4zDy6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="123999147"
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; 
   d="scan'208";a="123999147"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 21:51:40 -0700
IronPort-SDR: 0qtYB5tBDcBf9X83UB3uzm0y53IR4KJAL9y5mgpxS914y30pU61YwBxp0cnNZkeJe4Pqejdwbl
 1PDbDYSjngTg==
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; 
   d="scan'208";a="275576140"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 21:51:40 -0700
Subject: [PATCH] libnvdimm/security: Fix key lookup permissions
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 23 Jun 2020 21:35:26 -0700
Message-ID: <159297332630.1304143.237026690015653759.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of commit 8c0637e950d6 ("keys: Make the KEY_NEED_* perms an enum rather
than a mask") lookup_user_key() needs an explicit declaration of what it
wants to do with the key. Add KEY_NEED_SEARCH to fix a warning with the
below signature, and fixes the inability to retrieve a key.

    WARNING: CPU: 15 PID: 6276 at security/keys/permission.c:35 key_task_permission+0xd3/0x140
    [..]
    RIP: 0010:key_task_permission+0xd3/0x140
    [..]
    Call Trace:
     lookup_user_key+0xeb/0x6b0
     ? vsscanf+0x3df/0x840
     ? key_validate+0x50/0x50
     ? key_default_cmp+0x20/0x20
     nvdimm_get_user_key_payload.part.0+0x21/0x110 [libnvdimm]
     nvdimm_security_store+0x67d/0xb20 [libnvdimm]
     security_store+0x67/0x1a0 [libnvdimm]
     kernfs_fop_write+0xcf/0x1c0
     vfs_write+0xde/0x1d0
     ksys_write+0x68/0xe0
     do_syscall_64+0x5c/0xa0
     entry_SYSCALL_64_after_hwframe+0x49/0xb3

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Suggested-by: David Howells <dhowells@redhat.com>
Fixes: 8c0637e950d6 ("keys: Make the KEY_NEED_* perms an enum rather than a mask")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/security.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
index 89b85970912d..4cef69bd3c1b 100644
--- a/drivers/nvdimm/security.c
+++ b/drivers/nvdimm/security.c
@@ -95,7 +95,7 @@ static struct key *nvdimm_lookup_user_key(struct nvdimm *nvdimm,
 	struct encrypted_key_payload *epayload;
 	struct device *dev = &nvdimm->dev;
 
-	keyref = lookup_user_key(id, 0, 0);
+	keyref = lookup_user_key(id, 0, KEY_NEED_SEARCH);
 	if (IS_ERR(keyref))
 		return NULL;
 

