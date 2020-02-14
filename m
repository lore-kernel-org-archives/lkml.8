Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316AFC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0684A206CC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581700590;
	bh=XNDD2meNX5BtVFSvRvL9MggIIc57XvcHUhfEtjDcsms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xh3AewRanDXCMfA0hAM8GZLaX/iecGFdlFCrBQdU1quVABDjxLSELpt6J0IRCtOBr
	 /Q6yoOOvTylGVQuDti8UHeLBxiQ+O1qQ/6JmB7ttCQBqQabgz+D1A6eIvi5eLDrUjE
	 H1xVFZ3Bx5NuE4+iiSZKmlQ/3kNe2LE3CD2HNi/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391867AbgBNQLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:11:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:36432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391577AbgBNQKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:10:48 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 561F1222C2;
        Fri, 14 Feb 2020 16:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696641;
        bh=XNDD2meNX5BtVFSvRvL9MggIIc57XvcHUhfEtjDcsms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qSrn1tQy82VBaD5pC/zaQ9cF+q9TCh9c/JQ2lDnEExCBiiCp1hGiv7UCPop4T/PyC
         qmeCKghIXtsrAn3FZ42KmT3YTAaqdBZlRSKxboCZwM3s2bgGl1N+Dkxy4NvQk9Zb3k
         gMKXPsxa48uGunVlsBlh5YzHH0B6HO4sxOr0MB4k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qing Xu <m1s5p6688@gmail.com>, Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 418/459] mwifiex: Fix possible buffer overflows in mwifiex_cmd_append_vsie_tlv()
Date:   Fri, 14 Feb 2020 11:01:08 -0500
Message-Id: <20200214160149.11681-418-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

