Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB5DC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951CA24690
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579194827;
	bh=1SjJAlZJgHXI8ZPZc0v1AGoOUn/u9gQxhzVoZQ7cp+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ffh9ecg4pn4WQjB4f70F52HTTN5INDs9oAebPfx5DSJ63NYZUzuJP5EpiD32fPTfd
	 IWm8ox1+ZOSUl8LNHMkBNdRqlthWgAIirUPWXCPkCIt3g2f5Qc8G85MWbe7KpgBfN/
	 IO41ZxGgOx+8TrWGndL5VFL3tKK2qsvmhGfOA0tw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390398AbgAPRNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:13:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:59276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390792AbgAPRNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:13:40 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71FDA20684;
        Thu, 16 Jan 2020 17:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194820;
        bh=1SjJAlZJgHXI8ZPZc0v1AGoOUn/u9gQxhzVoZQ7cp+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QVDhz4Gc3ShC7HIjy2Bv+vQyJi2qU/UJlXBnhz/1VN9skNE0XEqm/KpW8pMChUykm
         YKFVveM8qfXsbeXRC4bR3PbDR3jqlVapT8Mt3CfgQ3UY2ehdBBvh5hMNENHgxmDttp
         C5slQxzIE2QhKLSt52Po7RwhbBPhI48TxbIGuQ30=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 4.19 625/671] rtlwifi: Remove unnecessary NULL check in rtl_regd_init
Date:   Thu, 16 Jan 2020 12:04:23 -0500
Message-Id: <20200116170509.12787-362-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 091c6e9c083f7ebaff00b37ad13562d51464d175 ]

When building with Clang + -Wtautological-pointer-compare:

drivers/net/wireless/realtek/rtlwifi/regd.c:389:33: warning: comparison
of address of 'rtlpriv->regd' equal to a null pointer is always false
[-Wtautological-pointer-compare]
        if (wiphy == NULL || &rtlpriv->regd == NULL)
                              ~~~~~~~~~^~~~    ~~~~
1 warning generated.

The address of an array member is never NULL unless it is the first
struct member so remove the unnecessary check. This was addressed in
the staging version of the driver in commit f986978b32b3 ("Staging:
rtlwifi: remove unnecessary NULL check").

While we are here, fix the following checkpatch warning:

CHECK: Comparison to NULL could be written "!wiphy"
35: FILE: drivers/net/wireless/realtek/rtlwifi/regd.c:389:
+       if (wiphy == NULL)

Fixes: 0c8173385e54 ("rtl8192ce: Add new driver")
Link:https://github.com/ClangBuiltLinux/linux/issues/750
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtlwifi/regd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/regd.c b/drivers/net/wireless/realtek/rtlwifi/regd.c
index 1bf3eb25c1da..72ca370331fb 100644
--- a/drivers/net/wireless/realtek/rtlwifi/regd.c
+++ b/drivers/net/wireless/realtek/rtlwifi/regd.c
@@ -427,7 +427,7 @@ int rtl_regd_init(struct ieee80211_hw *hw,
 	struct wiphy *wiphy = hw->wiphy;
 	struct country_code_to_enum_rd *country = NULL;
 
-	if (wiphy == NULL || &rtlpriv->regd == NULL)
+	if (!wiphy)
 		return -EINVAL;
 
 	/* init country_code from efuse channel plan */
-- 
2.20.1

