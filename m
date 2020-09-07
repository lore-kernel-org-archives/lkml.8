Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D2DC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00DC9207DE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599498078;
	bh=DV7gGrRAoLENF14ze7dE4iENAKav/G+BIt/ovTdJumY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XUqczVP39YGYtqabQ1pXx1dcGfbUTQasyuOA3TfNsJiLNfLKe8x7fOVfOOjTu4hwU
	 bXVwGJ1z9gjzOrDrX87qFE5xzPDs/Phb2M0zBl700kvvxZzqrG2DwlCEVGOLsHuSk6
	 Bt3pir/P51CJjYO3NHUWd8WKefs5/3h/sFctsqK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbgIGQds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:33:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730630AbgIGQcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:32:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A004E21532;
        Mon,  7 Sep 2020 16:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599496352;
        bh=DV7gGrRAoLENF14ze7dE4iENAKav/G+BIt/ovTdJumY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oqgJQpfFRJa+wpxEPz4PRoj1txwspRrcgUxZYV/18035SzHyK9E9KebO50Nv5czlZ
         U/vzEO6pD2aML6CAnQ1iieCZroHZpFbqjCE3sVAmue9hj0eavXKK859VkF2HF47hGs
         gB6eoSRStdODfQ0BdhMt/ccxKuvLOsYctgEcEEh0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 09/53] firestream: Fix memleak in fs_open
Date:   Mon,  7 Sep 2020 12:31:35 -0400
Message-Id: <20200907163220.1280412-9-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163220.1280412-1-sashal@kernel.org>
References: <20200907163220.1280412-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit 15ac5cdafb9202424206dc5bd376437a358963f9 ]

When make_rate() fails, vcc should be freed just
like other error paths in fs_open().

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/atm/firestream.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/atm/firestream.c b/drivers/atm/firestream.c
index cc87004d5e2d6..5f22555933df1 100644
--- a/drivers/atm/firestream.c
+++ b/drivers/atm/firestream.c
@@ -998,6 +998,7 @@ static int fs_open(struct atm_vcc *atm_vcc)
 				error = make_rate (pcr, r, &tmc0, NULL);
 				if (error) {
 					kfree(tc);
+					kfree(vcc);
 					return error;
 				}
 			}
-- 
2.25.1

