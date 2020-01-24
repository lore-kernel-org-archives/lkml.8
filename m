Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF35C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EACA420708
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864096;
	bh=rnhwOF+2UVt9CkBK/0GblsqHqiFcdsckfuiHrZkOFZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2n1304Wy9jlxTotaFv1rxZAtwNq3xwDKe/aIj/0eS9N7EGeWGvSyCK8jcIGXH8Pdu
	 0a1IpAlZNjpjffCss5ZapeiYNyrfQwDqCnavVG9jIMpGVKWOucNqyRAno9IT+UvTqd
	 TFbrOIWFBtDP5GS6CaSfcyL0EVL6fIX/Tx1aUS2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389639AbgAXLIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:08:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:43592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389627AbgAXLIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:08:10 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0D772077C;
        Fri, 24 Jan 2020 11:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864089;
        bh=rnhwOF+2UVt9CkBK/0GblsqHqiFcdsckfuiHrZkOFZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rc32MGGdvKLRVyC1A/uu/t68bAboVi1EhTcAcI8HPGH4L1uZLbJyZoipb08G+W3Qo
         yxmyeUADQxE0ZzT0GLCMTeY2QM3y99rnqWaEz68bmkUmDkGU8j+K5CwmI8HvOnb/iV
         r8FXmWKXGsXwPyBQ5K5HVxN1onA8RkfzmgHNWA6E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sara Sharon <sara.sharon@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 169/639] iwlwifi: mvm: fix RSS config command
Date:   Fri, 24 Jan 2020 10:25:39 +0100
Message-Id: <20200124093108.327092097@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 9808d954dca29..c7e2b88cd5abb 100644
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



