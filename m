Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81244C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540562467B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579685696;
	bh=uxoYdEa1YMvd4QmddYEXwU+ZoyC4hc6YNpLE/Vn6OP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NKUL+iXHpxEFiuwrzE4YOyE80UP/bpLbB9kL72aGYZgbw42aKO+Kuxe7L2YqG/P9D
	 mphiCsVMBpxk4tjMhriDJ26fE9aMOLEVuhSstT70vZVanrT7eYW3hsi+nYGou47spn
	 KH8253LTDxmsO7GLv5RJJo5zzxZ4nWTWXJI7feU4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbgAVJey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:34:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:49644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730486AbgAVJex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:34:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E87824686;
        Wed, 22 Jan 2020 09:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685692;
        bh=uxoYdEa1YMvd4QmddYEXwU+ZoyC4hc6YNpLE/Vn6OP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sfiIcaXetScRFNYqVohJfaPyfAdnNld5HYV33J66xls8Z4xMtF4uJZ0KDS341pedf
         NxN6ttmHMOy6pJ17EBJ3NujRkCGYWtLTh+TpjxPsVz+IdgupsX3akeFtZRtvsA7DZB
         wMSfM2JyNc8JByhPlKkCo+94I4d5FHnxklfVhzeA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.9 40/97] rtlwifi: Remove unnecessary NULL check in rtl_regd_init
Date:   Wed, 22 Jan 2020 10:28:44 +0100
Message-Id: <20200122092803.030380998@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092755.678349497@linuxfoundation.org>
References: <20200122092755.678349497@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

commit 091c6e9c083f7ebaff00b37ad13562d51464d175 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/realtek/rtlwifi/regd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/realtek/rtlwifi/regd.c
+++ b/drivers/net/wireless/realtek/rtlwifi/regd.c
@@ -427,7 +427,7 @@ int rtl_regd_init(struct ieee80211_hw *h
 	struct wiphy *wiphy = hw->wiphy;
 	struct country_code_to_enum_rd *country = NULL;
 
-	if (wiphy == NULL || &rtlpriv->regd == NULL)
+	if (!wiphy)
 		return -EINVAL;
 
 	/* init country_code from efuse channel plan */


