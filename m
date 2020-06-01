Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0FDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BAB0206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591035365;
	bh=sn8Keq0WlrH2oMOMaqzuef1suUNEu90hJWl2+RdW0To=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UuT7EYumQmjOmruB13CpSAXVBmFL/DaqcIEeay5mc9/cb0IczuO+5lDLibTEuOyz9
	 eTrrqxaXvBLVIMLf2UeliR3XP1e6gsBvJcsqtIEr2D/P/9Y/DP04QMouIWnLf8+gbh
	 p+MCuMqJJm0JgSZwSuEFE3VkiiSKj6Y86P334VPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731648AbgFASQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:16:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731635AbgFASPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:15:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C938206E2;
        Mon,  1 Jun 2020 18:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035354;
        bh=sn8Keq0WlrH2oMOMaqzuef1suUNEu90hJWl2+RdW0To=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mTjoy2soXhs24kMTj/aihA8KisFATFip3VdM45JQdYSkbVExVuwcjLEM7nGrWrQf7
         G4TM1ITMblGszYgOXyaJ/pVXhURzvU0vM+pA6FeY8V96FKT4lIDc0wZxvcwLbA3jtZ
         iPWpUv/reJZbKpMdAozLCBF8YGz81pqAQTjYAhLk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jerry Lee <leisurelysw24@gmail.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 121/177] libceph: ignore pool overlay and cache logic on redirects
Date:   Mon,  1 Jun 2020 19:54:19 +0200
Message-Id: <20200601174058.667370971@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174048.468952319@linuxfoundation.org>
References: <20200601174048.468952319@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerry Lee <leisurelysw24@gmail.com>

[ Upstream commit 890bd0f8997ae6ac0a367dd5146154a3963306dd ]

OSD client should ignore cache/overlay flag if got redirect reply.
Otherwise, the client hangs when the cache tier is in forward mode.

[ idryomov: Redirects are effectively deprecated and no longer
  used or tested.  The original tiering modes based on redirects
  are inherently flawed because redirects can race and reorder,
  potentially resulting in data corruption.  The new proxy and
  readproxy tiering modes should be used instead of forward and
  readforward.  Still marking for stable as obviously correct,
  though. ]

Cc: stable@vger.kernel.org
URL: https://tracker.ceph.com/issues/23296
URL: https://tracker.ceph.com/issues/36406
Signed-off-by: Jerry Lee <leisurelysw24@gmail.com>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ceph/osd_client.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index af868d3923b9..834019dbc6b1 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -3652,7 +3652,9 @@ static void handle_reply(struct ceph_osd *osd, struct ceph_msg *msg)
 		 * supported.
 		 */
 		req->r_t.target_oloc.pool = m.redirect.oloc.pool;
-		req->r_flags |= CEPH_OSD_FLAG_REDIRECTED;
+		req->r_flags |= CEPH_OSD_FLAG_REDIRECTED |
+				CEPH_OSD_FLAG_IGNORE_OVERLAY |
+				CEPH_OSD_FLAG_IGNORE_CACHE;
 		req->r_tid = 0;
 		__submit_request(req, false);
 		goto out_unlock_osdc;
-- 
2.25.1



