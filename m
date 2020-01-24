Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8EBC32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239CC21734
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579875984;
	bh=32scT0FsrqoEUDsjYgI0W3WcQWq84g2u+JpsOBapiMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ALeGGQYePT8e6YA9csWGhWNOytReTSy5LPQdoH7/9NYO2eY/HNF80jEB/Wlo8Omr3
	 lbQpxIEcUcnOERr3CzqsDzDZ4tFMClvdzhqlliYK43RaI4aYBW2/2Jx2ZHAmHTqUML
	 lDMwP9nTKDZlllxRfe9drHM/PTqP8i6zrkTK/53Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389884AbgAXO0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:26:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:43612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405375AbgAXOVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:21:41 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C191424685;
        Fri, 24 Jan 2020 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579875700;
        bh=32scT0FsrqoEUDsjYgI0W3WcQWq84g2u+JpsOBapiMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AMcIkld2WApIR89XuYfHAyQO3WnmOpcSTgREno8s8MJSjOBTdnjx4xwSibBvk8G2r
         R5AqcrrBL+S+Ogh5ddAlo37Smb0jHlzoF56f0qjTrLFY3VR9cOE8+9KEL5FBSLc2tD
         e5iWsSJR2xxAaFSNZjQbV/H5Fc9fFB1vYvnzWOBY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vladis Dronov <vdronov@redhat.com>,
        Antti Laakso <antti.laakso@intel.com>,
        Richard Cochran <richardcochran@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 18/32] ptp: free ptp device pin descriptors properly
Date:   Fri, 24 Jan 2020 09:21:05 -0500
Message-Id: <20200124142119.30484-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124142119.30484-1-sashal@kernel.org>
References: <20200124142119.30484-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladis Dronov <vdronov@redhat.com>

[ Upstream commit 75718584cb3c64e6269109d4d54f888ac5a5fd15 ]

There is a bug in ptp_clock_unregister(), where ptp_cleanup_pin_groups()
first frees ptp->pin_{,dev_}attr, but then posix_clock_unregister() needs
them to destroy a related sysfs device.

These functions can not be just swapped, as posix_clock_unregister() frees
ptp which is needed in the ptp_cleanup_pin_groups(). Fix this by calling
ptp_cleanup_pin_groups() in ptp_clock_release(), right before ptp is freed.

This makes this patch fix an UAF bug in a patch which fixes an UAF bug.

Reported-by: Antti Laakso <antti.laakso@intel.com>
Fixes: a33121e5487b ("ptp: fix the race between the release of ptp_clock and cdev")
Link: https://lore.kernel.org/netdev/3d2bd09735dbdaf003585ca376b7c1e5b69a19bd.camel@intel.com/
Signed-off-by: Vladis Dronov <vdronov@redhat.com>
Acked-by: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ptp/ptp_clock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index b818f65480c15..e232233beb8f2 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -179,6 +179,7 @@ static void ptp_clock_release(struct device *dev)
 {
 	struct ptp_clock *ptp = container_of(dev, struct ptp_clock, dev);
 
+	ptp_cleanup_pin_groups(ptp);
 	mutex_destroy(&ptp->tsevq_mux);
 	mutex_destroy(&ptp->pincfg_mux);
 	ida_simple_remove(&ptp_clocks_map, ptp->index);
@@ -315,9 +316,8 @@ int ptp_clock_unregister(struct ptp_clock *ptp)
 	if (ptp->pps_source)
 		pps_unregister_source(ptp->pps_source);
 
-	ptp_cleanup_pin_groups(ptp);
-
 	posix_clock_unregister(&ptp->clock);
+
 	return 0;
 }
 EXPORT_SYMBOL(ptp_clock_unregister);
-- 
2.20.1

