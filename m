Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D764C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F75E2074F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586954033;
	bh=O9zMXw7EVV/7T8D8FIM99Vc76xzMBdRqHU46kaUojBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SXsTMmAp7NcSYoneIbxjAtoV6nfOXS9E+UztCRlVFaL0G3dxhTIGdgCn1SGCW5uOj
	 AtC2BT1GxBZyA0kK1pJS6IbXtEV/TB6e9bm7blmZW2BMahFJ/7D4hnlzKIOscB1NHV
	 WDQS+bOOOGqpS+krcd7X2Gu8wm0L42/UmHTGmsAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369725AbgDOMdt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:33:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409085AbgDOLob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:44:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFB2F2173E;
        Wed, 15 Apr 2020 11:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586951070;
        bh=O9zMXw7EVV/7T8D8FIM99Vc76xzMBdRqHU46kaUojBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GJO0xgEUOwWBopgJrTgJPK/wfnGuqzanrqO94CV8r+PnKa67CkIURlN+Fuxu6kUa5
         59WpfGhE9MSFSiWcf5Oa1HGunKm7XPE7RSSWEA85f5AQXVTN4OQ7/jl80j0YpBbU0B
         g+PBeBL3gvrNSVm55713+YTbgHQLn6qX/abUl1PA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-nvdimm@lists.01.org
Subject: [PATCH AUTOSEL 5.5 102/106] libnvdimm: Out of bounds read in __nd_ioctl()
Date:   Wed, 15 Apr 2020 07:42:22 -0400
Message-Id: <20200415114226.13103-102-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415114226.13103-1-sashal@kernel.org>
References: <20200415114226.13103-1-sashal@kernel.org>
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
index a8b5159685699..09087c38fabdc 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -1042,8 +1042,10 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
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

