Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69B5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6DC420780
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592933763;
	bh=CEb9o2yL5eEnwlfJtCGk5Cdd+bLozxsyRisthU6Vmsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NQYqEIMwebO5+ATKBjm5a38bnFXrqbJOhnsyKnIEwCBOPnLEoD7HSxTH4+Qs5FSFr
	 6KrPRTSLT6JAZ7bA8pB/oLOk378zcYenLA0gW9G7Bd8wLs7d6YwuXYMRVVkVItfKpL
	 pUL44+6eHCXdw6jUbTPbNPnAAPQZL/2Hi7F6WIAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387457AbgFWRgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:36:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387426AbgFWRf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:35:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20C66207FB;
        Tue, 23 Jun 2020 17:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592933755;
        bh=CEb9o2yL5eEnwlfJtCGk5Cdd+bLozxsyRisthU6Vmsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dO8GABJI3pI7o2Jr888VmVheluUi+cQko3lbmd1VVMc8De95Row5+8/s0XKNb2NMW
         CLzy9wgHCaOCNdmrlZW8KQMbFdlFDOH7pkTTYPLbJUcFdvqGqWy7VRXbAGCrUHgzYL
         9l5wZUenKWojRTvY+pwPzpsBI1esv/p97bP7vs4o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-nvdimm@lists.01.org
Subject: [PATCH AUTOSEL 5.7 26/28] nvdimm/region: always show the 'align' attribute
Date:   Tue, 23 Jun 2020 13:35:21 -0400
Message-Id: <20200623173523.1355411-26-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623173523.1355411-1-sashal@kernel.org>
References: <20200623173523.1355411-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vishal Verma <vishal.l.verma@intel.com>

[ Upstream commit 543094e19c82b5d171e139d09a1a3ea0a7361117 ]

It is possible that a platform that is capable of 'namespace labels'
comes up without the labels properly initialized. In this case, the
region's 'align' attribute is hidden. Howerver, once the user does
initialize he labels, the 'align' attribute still stays hidden, which is
unexpected.

The sysfs_update_group() API is meant to address this, and could be
called during region probe, but it has entanglements with the device
'lockdep_mutex'. Therefore, simply make the 'align' attribute always
visible. It doesn't matter what it says for label-less namespaces, since
it is not possible to change their allocation anyway.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Link: https://lore.kernel.org/r/20200520225026.29426-1-vishal.l.verma@intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvdimm/region_devs.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index ccbb5b43b8b2c..4502f9c4708d0 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -679,18 +679,8 @@ static umode_t region_visible(struct kobject *kobj, struct attribute *a, int n)
 		return a->mode;
 	}
 
-	if (a == &dev_attr_align.attr) {
-		int i;
-
-		for (i = 0; i < nd_region->ndr_mappings; i++) {
-			struct nd_mapping *nd_mapping = &nd_region->mapping[i];
-			struct nvdimm *nvdimm = nd_mapping->nvdimm;
-
-			if (test_bit(NDD_LABELING, &nvdimm->flags))
-				return a->mode;
-		}
-		return 0;
-	}
+	if (a == &dev_attr_align.attr)
+		return a->mode;
 
 	if (a != &dev_attr_set_cookie.attr
 			&& a != &dev_attr_available_size.attr)
-- 
2.25.1

