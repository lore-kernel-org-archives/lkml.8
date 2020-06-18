Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC68C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3EE921BE5
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592448449;
	bh=BP9HFjc57NoTov1pRptF12N5niLFQO/6En0JRztWgK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nst+g1k7C6r5RVzvgvpsA1mrhv6+TVnTdFNNe8via46oaybxglrs6QkJnJtRDGz8w
	 noRaT6vqijkJTfnGo02rbEwMbe5sMTZfXToLj17GxonvbH2ZXNpGrapmixp6Ts/+9O
	 h5qy18QGEiVyhili7pmXO3mSurM5KMM515zgF6Gs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgFRBKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:10:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:37380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbgFRBKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:10:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3465321927;
        Thu, 18 Jun 2020 01:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442616;
        bh=BP9HFjc57NoTov1pRptF12N5niLFQO/6En0JRztWgK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E5C+vkRBUuPxuH97bt+dKFNVZ/bmTBDUDJ3BMp//mLzqByEieBToPz4H8ILvyfnd2
         IoPdIylNBPE5VE2k78qWGSxXuZ2DtdETlGkvmLSGlAzn2bf6CO4uIGkl8lgphlcf71
         YpvStzRpQb8ZfpZvwEfBHdTaDaI9/Y6vmkjxYhNU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Alexander Fomichev <fomichev.ru@gmail.com>,
        Jon Mason <jdmason@kudzu.us>, Sasha Levin <sashal@kernel.org>,
        linux-ntb@googlegroups.com
Subject: [PATCH AUTOSEL 5.7 096/388] NTB: Fix the default port and peer numbers for legacy drivers
Date:   Wed, 17 Jun 2020 21:03:13 -0400
Message-Id: <20200618010805.600873-96-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Logan Gunthorpe <logang@deltatee.com>

[ Upstream commit fc8b086d9dbd57458d136c4fa70ee26f832c3a2e ]

When the commit adding ntb_default_port_number() and
ntb_default_peer_port_number()  entered the kernel there was no
users of it so it was impossible to tell what the API needed.

When a user finally landed a year later (ntb_pingpong) there were
more NTB topologies were created and no consideration was considered
to how other drivers had changed.

Now that there is a user it can be fixed to provide a sensible default
for the legacy drivers that do not implement ntb_{peer_}port_number().
Seeing ntb_pingpong doesn't check error codes returning EINVAL was also
not sensible.

Patches for ntb_pingpong and ntb_perf follow (which are broken
otherwise) to support hardware that doesn't have port numbers. This is
important not only to not break support with existing drivers but for
the cross link topology which, due to its perfect symmetry, cannot
assign unique port numbers to each side.

Fixes: 1e5301196a88 ("NTB: Add indexed ports NTB API")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Allen Hubbe <allenbh@gmail.com>
Tested-by: Alexander Fomichev <fomichev.ru@gmail.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ntb/core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/ntb/core.c b/drivers/ntb/core.c
index 2581ab724c34..c9a0912b175f 100644
--- a/drivers/ntb/core.c
+++ b/drivers/ntb/core.c
@@ -214,10 +214,8 @@ int ntb_default_port_number(struct ntb_dev *ntb)
 	case NTB_TOPO_B2B_DSD:
 		return NTB_PORT_SEC_DSD;
 	default:
-		break;
+		return 0;
 	}
-
-	return -EINVAL;
 }
 EXPORT_SYMBOL(ntb_default_port_number);
 
@@ -240,10 +238,8 @@ int ntb_default_peer_port_number(struct ntb_dev *ntb, int pidx)
 	case NTB_TOPO_B2B_DSD:
 		return NTB_PORT_PRI_USD;
 	default:
-		break;
+		return 0;
 	}
-
-	return -EINVAL;
 }
 EXPORT_SYMBOL(ntb_default_peer_port_number);
 
-- 
2.25.1

