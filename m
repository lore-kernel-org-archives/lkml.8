Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08DBC3B18B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E38E20675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608146;
	bh=XNDD2meNX5BtVFSvRvL9MggIIc57XvcHUhfEtjDcsms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Uw30KUXchf8HyvjWxve5ZfvxCz8fLtSr/8nvVsvQ+iSnZlfQMzhbEG5Ccs8rq8Nr1
	 JKW76TwSLdHvdix4fvyilWUicCjS9okGvO59Oz/tn4oXrMQhboMCs60QLw4W0A+aES
	 xC9pWd/mHIIP6myEia0hZdGMCwL+Hk+uXdJFP7sI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388014AbgBMPbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:31:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:53522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729524AbgBMP16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:27:58 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0A3A20661;
        Thu, 13 Feb 2020 15:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607677;
        bh=XNDD2meNX5BtVFSvRvL9MggIIc57XvcHUhfEtjDcsms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gzyq6GXvYQsCGg7P21Ak+ICWQ3r0VKHG1XceukkSYpzImWU84TxJvztOQAgXFNQCc
         HTuPS91MJ6CIQZdlFcqg6vgRhlrwepu51FqbYb9utysxKKYtdqTMPUkVw2CSToKmZX
         +QuSRgDc7rJUiGwdgUa80xEcds5ARgIyR9Yo37JM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qing Xu <m1s5p6688@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 94/96] mwifiex: Fix possible buffer overflows in mwifiex_cmd_append_vsie_tlv()
Date:   Thu, 13 Feb 2020 07:21:41 -0800
Message-Id: <20200213151914.100775833@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151839.156309910@linuxfoundation.org>
References: <20200213151839.156309910@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qing Xu <m1s5p6688@gmail.com>

[ Upstream commit b70261a288ea4d2f4ac7cd04be08a9f0f2de4f4d ]

mwifiex_cmd_append_vsie_tlv() calls memcpy() without checking
the destination size may trigger a buffer overflower,
which a local user could use to cause denial of service
or the execution of arbitrary code.
Fix it by putting the length check before calling memcpy().

Signed-off-by: Qing Xu <m1s5p6688@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/scan.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index 593c594982cb3..59f0651d148bb 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -2886,6 +2886,13 @@ mwifiex_cmd_append_vsie_tlv(struct mwifiex_private *priv,
 			vs_param_set->header.len =
 				cpu_to_le16((((u16) priv->vs_ie[id].ie[1])
 				& 0x00FF) + 2);
+			if (le16_to_cpu(vs_param_set->header.len) >
+				MWIFIEX_MAX_VSIE_LEN) {
+				mwifiex_dbg(priv->adapter, ERROR,
+					    "Invalid param length!\n");
+				break;
+			}
+
 			memcpy(vs_param_set->ie, priv->vs_ie[id].ie,
 			       le16_to_cpu(vs_param_set->header.len));
 			*buffer += le16_to_cpu(vs_param_set->header.len) +
-- 
2.20.1



