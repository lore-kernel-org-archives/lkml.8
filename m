Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3873C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B52E20C09
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658650;
	bh=sn8Keq0WlrH2oMOMaqzuef1suUNEu90hJWl2+RdW0To=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i6AiNFYXgnqOY9Xv4LwfzYtsUBC4i5K9QPowSSHF+qpnLpk8h7SuAXBYHTXIyjP/F
	 61u9WOgIMdh7E0+rn6NOoiPmmbUzPsxIjEjvxmx29lEpUqm60GkRGhRquzu+W81fdX
	 CTC9EKIZXit9cnmFGu9Z0PFmNHbVG6Jauvo4zh0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbgFHXYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:24:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728395AbgFHXSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:18:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2362620823;
        Mon,  8 Jun 2020 23:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658325;
        bh=sn8Keq0WlrH2oMOMaqzuef1suUNEu90hJWl2+RdW0To=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lz+X0UzdbPgLWiR3vCKPD2v4+VAoYznhAOGMECW6TDFv/2wzfxorCDyr2Dd4mHeud
         2tjkXrMsNnKKv9IusGEKjJtky1ia86xR72srLGpN1elGvN/QlWwHViMXnSX83g+RQ0
         mPxd5Vo9pft9ZDIKJuIzArBwQ+/LEJNOCwUSz1aE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jerry Lee <leisurelysw24@gmail.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 325/606] libceph: ignore pool overlay and cache logic on redirects
Date:   Mon,  8 Jun 2020 19:07:30 -0400
Message-Id: <20200608231211.3363633-325-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

