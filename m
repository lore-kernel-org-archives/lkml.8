Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C3BC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4CB2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579194046;
	bh=bEgqGDvIekdC+jCIEuWqKdDWTz3GB/UQAEQBREeG/W4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lC5YC5Z6clECrVqPrkA5ZQpCNrmA5Ip+P/q1OjX4jagV0khJ1G6JylnnOcSS03XUL
	 myStcBF5YUatZfXYSChWtE3MXOS2DX+zmTNEib0QLp/FCP0r3w6R6g9g8RhHmQAEkM
	 k54+Kj4B4J+DZooiWLoO1hkJvwQHAcWOmCmLGRJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387883AbgAPRAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:00:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:50390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387852AbgAPRAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:00:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D74A620730;
        Thu, 16 Jan 2020 17:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194034;
        bh=bEgqGDvIekdC+jCIEuWqKdDWTz3GB/UQAEQBREeG/W4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l8uB9lFTiryH7dcqxUsWGMV5lOVJaAsB1hTaPY5a5NorqihW5h44p1nawDeEoQ1qn
         dSZ6uGM5TE9aksGUNyjn4jgX0yaMsfhbg3FE8dRoyNNuzrDoncj3zY2br7N5UF5Br4
         XcX1Lae2SCvEtv9S5xu3cgwpSciVwwO5UUjLhio4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sara Sharon <sara.sharon@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 153/671] iwlwifi: mvm: fix RSS config command
Date:   Thu, 16 Jan 2020 11:51:02 -0500
Message-Id: <20200116165940.10720-36-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165940.10720-1-sashal@kernel.org>
References: <20200116165940.10720-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sara Sharon <sara.sharon@intel.com>

[ Upstream commit 608dce95db10b8ee1a26dbce3f60204bb69812a5 ]

The hash mask is a bitmap, so we should use BIT() on
the enum values.

Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Fixes: 43413a975d06 ("iwlwifi: mvm: support rss queues configuration command")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 9808d954dca2..c7e2b88cd5ab 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -110,12 +110,12 @@ static int iwl_send_rss_cfg_cmd(struct iwl_mvm *mvm)
 	int i;
 	struct iwl_rss_config_cmd cmd = {
 		.flags = cpu_to_le32(IWL_RSS_ENABLE),
-		.hash_mask = IWL_RSS_HASH_TYPE_IPV4_TCP |
-			     IWL_RSS_HASH_TYPE_IPV4_UDP |
-			     IWL_RSS_HASH_TYPE_IPV4_PAYLOAD |
-			     IWL_RSS_HASH_TYPE_IPV6_TCP |
-			     IWL_RSS_HASH_TYPE_IPV6_UDP |
-			     IWL_RSS_HASH_TYPE_IPV6_PAYLOAD,
+		.hash_mask = BIT(IWL_RSS_HASH_TYPE_IPV4_TCP) |
+			     BIT(IWL_RSS_HASH_TYPE_IPV4_UDP) |
+			     BIT(IWL_RSS_HASH_TYPE_IPV4_PAYLOAD) |
+			     BIT(IWL_RSS_HASH_TYPE_IPV6_TCP) |
+			     BIT(IWL_RSS_HASH_TYPE_IPV6_UDP) |
+			     BIT(IWL_RSS_HASH_TYPE_IPV6_PAYLOAD),
 	};
 
 	if (mvm->trans->num_rx_queues == 1)
-- 
2.20.1

