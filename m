Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A79DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 402B9221FC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592445500;
	bh=V4vmO660+mBPK5zXExoxZj7uOMJXgvE67NAPbI/hdiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WAbO2kKDI3Q0qyxgiDPi91ne1J6rIyc4KGkz/EXAnqgkcQn1t7IQf89TinzRxfVny
	 nJdwF+IPrEbij1TUfJIhUQTz4hrCprhy8OWt5UdyUv3c/ry3v0t62Al6WpeOl+t9mS
	 W7vbX688TNP1U3EG3/GGki7B+zj5iTcrsV7ujPfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbgFRBY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:24:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730572AbgFRBVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:21:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C754A214DB;
        Thu, 18 Jun 2020 01:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443303;
        bh=V4vmO660+mBPK5zXExoxZj7uOMJXgvE67NAPbI/hdiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XHIzBx9AF6s34DArCWL5mj3scFc3Pz0NF3pYfFmGTm2HDuDbvnh+kp5s/fc4LW421
         JXPouHL3YSPy783A9tNkxMxqOXqbzMx+kGY/A+kl9QWHmUX5OVpHSyjynQtzZN0GQ1
         Jr90G/VDiVskqV8PovzoRassdAE+1xrLo5TGRzNU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Alexander Fomichev <fomichev.ru@gmail.com>,
        Jon Mason <jdmason@kudzu.us>, Sasha Levin <sashal@kernel.org>,
        linux-ntb@googlegroups.com
Subject: [PATCH AUTOSEL 5.4 242/266] NTB: perf: Fix support for hardware that doesn't have port numbers
Date:   Wed, 17 Jun 2020 21:16:07 -0400
Message-Id: <20200618011631.604574-242-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Logan Gunthorpe <logang@deltatee.com>

[ Upstream commit b54369a248c2e033bfcf5d6917e08cf9d73d54a6 ]

Legacy drivers do not have port numbers (but is reliably only two ports)
and was broken by the recent commit that added mult-port support to
ntb_perf. This is especially important to support the cross link
topology which is perfectly symmetric and cannot assign unique port
numbers easily.

Hardware that returns zero for both the local port and the peer should
just always use gidx=0 for the only peer.

Fixes: 5648e56d03fa ("NTB: ntb_perf: Add full multi-port NTB API support")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Allen Hubbe <allenbh@gmail.com>
Tested-by: Alexander Fomichev <fomichev.ru@gmail.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ntb/test/ntb_perf.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 3817eadab2cf..281170887ad0 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -1423,6 +1423,16 @@ static int perf_init_peers(struct perf_ctx *perf)
 	if (perf->gidx == -1)
 		perf->gidx = pidx;
 
+	/*
+	 * Hardware with only two ports may not have unique port
+	 * numbers. In this case, the gidxs should all be zero.
+	 */
+	if (perf->pcnt == 1 &&  ntb_port_number(perf->ntb) == 0 &&
+	    ntb_peer_port_number(perf->ntb, 0) == 0) {
+		perf->gidx = 0;
+		perf->peers[0].gidx = 0;
+	}
+
 	for (pidx = 0; pidx < perf->pcnt; pidx++) {
 		ret = perf_setup_peer_mw(&perf->peers[pidx]);
 		if (ret)
-- 
2.25.1

