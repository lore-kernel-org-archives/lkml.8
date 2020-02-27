Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B26C3F34F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB90246A0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811413;
	bh=2Q4c/sIWhZgo3m9iu4W8f4+/LGZhyEmn/WSfWt0XLVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SXccsajeR6nVZQ6Yh2Kt557WzxxTSnjflmfcyFl5BEgabmvkitkxWsxbmSuAY2TGV
	 XUhAp7yZcB1PrGylY+WyT/rlOWDqbYi09zN/SjZii7bncUZeeAhNiWa3AqNPBYT5rZ
	 R0a90V2PWQbvt3XTmnb6AxuhPgefJWkifYa/ixdI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbgB0NuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:50:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:47644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731073AbgB0Nt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:49:56 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B16E20801;
        Thu, 27 Feb 2020 13:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811396;
        bh=2Q4c/sIWhZgo3m9iu4W8f4+/LGZhyEmn/WSfWt0XLVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hDthhUVL02rE8cgDyIZ4XB02HMMNo0ll6h/zx4Ra405OFFgFF+xi2seFQLlFLZK8j
         2dmxuYxK1Dv+/muLNLBJnNpmMKg26bsr7AEkFyuVms/YNjZvk2oAvpuyDLdfyQnSKD
         qCyG22K41LovwV7EZEhbNu72Oym9UuAOubN8Bl/Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jaihind Yadav <jaihindyadav@codeaurora.org>,
        Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 115/165] selinux: ensure we cleanup the internal AVC counters on error in avc_update()
Date:   Thu, 27 Feb 2020 14:36:29 +0100
Message-Id: <20200227132247.860676364@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132230.840899170@linuxfoundation.org>
References: <20200227132230.840899170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jaihind Yadav <jaihindyadav@codeaurora.org>

[ Upstream commit 030b995ad9ece9fa2d218af4429c1c78c2342096 ]

In AVC update we don't call avc_node_kill() when avc_xperms_populate()
fails, resulting in the avc->avc_cache.active_nodes counter having a
false value.  In last patch this changes was missed , so correcting it.

Fixes: fa1aa143ac4a ("selinux: extended permissions for ioctls")
Signed-off-by: Jaihind Yadav <jaihindyadav@codeaurora.org>
Signed-off-by: Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
[PM: merge fuzz, minor description cleanup]
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/avc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 52f3c550abcc4..f3c473791b698 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -865,7 +865,7 @@ static int avc_update_node(u32 event, u32 perms, u8 driver, u8 xperm, u32 ssid,
 	if (orig->ae.xp_node) {
 		rc = avc_xperms_populate(node, orig->ae.xp_node);
 		if (rc) {
-			kmem_cache_free(avc_node_cachep, node);
+			avc_node_kill(node);
 			goto out_unlock;
 		}
 	}
-- 
2.20.1



