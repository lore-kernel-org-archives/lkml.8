Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A10C2D0FB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11F0120731
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbgELWbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:31:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:25447 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728882AbgELWbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:31:48 -0400
IronPort-SDR: Mpm2tyBtMrfgdAZOGe+NJbBaY9ENyEst9D4s3Ka3kx0dHLSqCpWuAHQx2OJ8US+4qOQHV4QErY
 nb7e1Ne+vjaA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 15:31:47 -0700
IronPort-SDR: PkKMECiNmvqqPI4TDZD5CIFKF391voNoPr2ze+x9t+fvBjQJK13e5+G4jVhLoyziseMrRMYcyz
 jsJ7LlMf6V9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,385,1583222400"; 
   d="scan'208";a="463709859"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.155])
  by fmsmga005.fm.intel.com with ESMTP; 12 May 2020 15:31:45 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        =?UTF-8?q?=E4=BA=BF=E4=B8=80?= <teroincn@gmail.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next] mei: release me_cl object reference
Date:   Wed, 13 May 2020 01:31:40 +0300
Message-Id: <20200512223140.32186-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Allow me_cl object to be freed by releasing the reference
that was acquired  by one of the search functions:
__mei_me_cl_by_uuid_id() or __mei_me_cl_by_uuid()

Cc: <stable@vger.kernel.org>
Reported-by: 亿一 <teroincn@gmail.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 204d807e755b..b32c825a0945 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -266,6 +266,7 @@ void mei_me_cl_rm_by_uuid(struct mei_device *dev, const uuid_le *uuid)
 	down_write(&dev->me_clients_rwsem);
 	me_cl = __mei_me_cl_by_uuid(dev, uuid);
 	__mei_me_cl_del(dev, me_cl);
+	mei_me_cl_put(me_cl);
 	up_write(&dev->me_clients_rwsem);
 }
 
@@ -287,6 +288,7 @@ void mei_me_cl_rm_by_uuid_id(struct mei_device *dev, const uuid_le *uuid, u8 id)
 	down_write(&dev->me_clients_rwsem);
 	me_cl = __mei_me_cl_by_uuid_id(dev, uuid, id);
 	__mei_me_cl_del(dev, me_cl);
+	mei_me_cl_put(me_cl);
 	up_write(&dev->me_clients_rwsem);
 }
 
-- 
2.21.3

