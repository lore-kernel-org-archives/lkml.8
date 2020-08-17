Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50644C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 256F720716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597693582;
	bh=gWkKBLqrFyWOSdK7if2G2dxRkh8/ELMIAsFk2X3V7AE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kp3NxSZSLMnRWrWpe2ffY8xZo/LGS12PS/T3e/V1/NMfWccZ0JjNtBke272ryZJIU
	 +gbzBSnCWdT0qpP0ZVfqqMxZLCfG6tz9VgggxJvILz76+f+aO6O5F8/OLusL4Op3mL
	 aGw2/3NFbAk63xHl3HM/FoEGnF3v7zfWyaxxB/00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbgHQTqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:46:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729360AbgHQPVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:21:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E62F207D3;
        Mon, 17 Aug 2020 15:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597677692;
        bh=gWkKBLqrFyWOSdK7if2G2dxRkh8/ELMIAsFk2X3V7AE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2l6P3DpknOknM90+KPhTNTysoWeXi6ohLiXLG/aaBs9z2HB4Afp1AS6TkGAjNcpzJ
         KV+DVeVcu1rPU/kjTAV/gQvi2mTi88wOlEIj5U4j9WAVb/icTt1mWbd6Y3DB7rKL+t
         /tlBlA6axk6bRf0PErglntRe1AOu9HyHh439tPiI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 073/464] nvme-multipath: fix logic for non-optimized paths
Date:   Mon, 17 Aug 2020 17:10:26 +0200
Message-Id: <20200817143837.268973244@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Wilck <mwilck@suse.com>

[ Upstream commit 3f6e3246db0e6f92e784965d9d0edb8abe6c6b74 ]

Handle the special case where we have exactly one optimized path,
which we should keep using in this case.

Fixes: 75c10e732724 ("nvme-multipath: round-robin I/O policy")
Signed off-by: Martin Wilck <mwilck@suse.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/multipath.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 66509472fe06a..fe8f7f123fac7 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -246,6 +246,12 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
 			fallback = ns;
 	}
 
+	/* No optimized path found, re-check the current path */
+	if (!nvme_path_is_disabled(old) &&
+	    old->ana_state == NVME_ANA_OPTIMIZED) {
+		found = old;
+		goto out;
+	}
 	if (!fallback)
 		return NULL;
 	found = fallback;
-- 
2.25.1



