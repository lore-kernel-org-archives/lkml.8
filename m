Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2A3C38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C11A22240
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587220996;
	bh=g+/DlI/neXXLGTI4GaNTz0Xd8LaLWlzfFIRyTD5ifOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gTEiOCkIL5+kk5Gf34uR95oZ2NwQ0S3lr7J6FU1VQqJVGaNDcpdiwjqpAmtv3/3w1
	 dUPCkid5AoOD51ztQdpahZNIczhUjk3vLVP5WzDQdeCymLYSIR1ibICs7x/0qhMyY6
	 o4EaD5yUB37iQXVQk3HvzEh+fCZdsauIAU6I2EW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgDROnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:43:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728488AbgDROnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:43:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B359321D7E;
        Sat, 18 Apr 2020 14:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587220982;
        bh=g+/DlI/neXXLGTI4GaNTz0Xd8LaLWlzfFIRyTD5ifOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WamSD2RzXoByciS6WJW8ecal9JynqDMHV0Jgj9XXwrO3+LhAfK5mSg1QEIBV/d9sl
         MIJe3UKWxmnvEMGKhi7tNb5k2UwuaCTqgby/5qXLQRwGar0t7DOURWJWwcm8OrjDm0
         UH7635233XHXcI+pz9euriJhOJsVDd6aBYzPedPY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-nvdimm@lists.01.org
Subject: [PATCH AUTOSEL 4.19 27/47] libnvdimm: Out of bounds read in __nd_ioctl()
Date:   Sat, 18 Apr 2020 10:42:07 -0400
Message-Id: <20200418144227.9802-27-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418144227.9802-1-sashal@kernel.org>
References: <20200418144227.9802-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit f84afbdd3a9e5e10633695677b95422572f920dc ]

The "cmd" comes from the user and it can be up to 255.  It it's more
than the number of bits in long, it results out of bounds read when we
check test_bit(cmd, &cmd_mask).  The highest valid value for "cmd" is
ND_CMD_CALL (10) so I added a compare against that.

Fixes: 62232e45f4a2 ("libnvdimm: control (ioctl) messages for nvdimm_bus and nvdimm devices")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/20200225162055.amtosfy7m35aivxg@kili.mountain
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvdimm/bus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 54a633e8cb5d2..48a070a37ea9b 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -984,8 +984,10 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
 			return -EFAULT;
 	}
 
-	if (!desc || (desc->out_num + desc->in_num == 0) ||
-			!test_bit(cmd, &cmd_mask))
+	if (!desc ||
+	    (desc->out_num + desc->in_num == 0) ||
+	    cmd > ND_CMD_CALL ||
+	    !test_bit(cmd, &cmd_mask))
 		return -ENOTTY;
 
 	/* fail write commands (when read-only) */
-- 
2.20.1

