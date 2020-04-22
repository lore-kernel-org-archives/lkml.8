Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE43C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB2022075A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551369;
	bh=O9zMXw7EVV/7T8D8FIM99Vc76xzMBdRqHU46kaUojBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tj1KSe6zZZF6uOoqiYvXXOpvLizSlA2pFLScNMhJixEdzB1iNE9XwFtC+FDArVn9S
	 uODAVGfOjgQQ6yrXXoXPcemEc3OcmK5TtrywwcNJQaK12jvbRyT2MNFFMO1RzYnQVf
	 MUInSYBiTbhgSd2kDtnM8iVL+XYqanlojiUpyCv4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgDVK05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:26:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730757AbgDVK0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:26:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F4792071E;
        Wed, 22 Apr 2020 10:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587551200;
        bh=O9zMXw7EVV/7T8D8FIM99Vc76xzMBdRqHU46kaUojBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k0VvD+17dMscCCiH27ZbPvXdBrnbh9yuZSXS8FvbpOyzZaGaMRiqGY+ihgU8BLv4G
         pZ7YFG3lK38F0IGkGPS9FE5XVKUIItsXgbSqzR87NET3owCtXk2NMl11RbbTJedmcu
         3Ou/tl7Yxv3vbzAQYkEoihnpPrI16EDFOUyJw0AU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 141/166] libnvdimm: Out of bounds read in __nd_ioctl()
Date:   Wed, 22 Apr 2020 11:57:48 +0200
Message-Id: <20200422095103.758784613@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095047.669225321@linuxfoundation.org>
References: <20200422095047.669225321@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



