Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A242C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D214924691
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814913;
	bh=gUM2bLXqfzQKZ+c5hKz9WG1J6s0LEcOPNaGjFh9flRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rJ3gPSQoVBofaukbKJfngTwMmZ2I554xTu8tEKvqd0k5NG0YxbOBgjYYYHC5Zy8pa
	 tPwTJk4Ix8eGaW4TOwVaI/F3j0uxf714EnmzcJWxPj2hO2mpMf/lngsKjKP0QLbzJh
	 a2Kgy5FwZ/Uww/qroaM1YXZRJHVyTd51LwxOPT88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731911AbgB0Osc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:48:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:38110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729873AbgB0Nm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:42:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09AC421D7E;
        Thu, 27 Feb 2020 13:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582810979;
        bh=gUM2bLXqfzQKZ+c5hKz9WG1J6s0LEcOPNaGjFh9flRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=znEQOmQ5YCsMA1xqo2I8nyrPqwJNq+h74Q/wzQMCGFrHDtfJ+ze3F6WG1ItWb+QB2
         i3xKzywBr3JxmZh116XZ824cQf8O2Vg7j+IsHKoXevIHpl0HtHpayOteKIeAjDaibS
         dPE3dm+EQmoiLadVxStqj4L0zcnVGtzflHigPgmo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 071/113] hostap: Adjust indentation in prism2_hostapd_add_sta
Date:   Thu, 27 Feb 2020 14:36:27 +0100
Message-Id: <20200227132223.135548395@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132211.791484803@linuxfoundation.org>
References: <20200227132211.791484803@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit b61156fba74f659d0bc2de8f2dbf5bad9f4b8faf ]

Clang warns:

../drivers/net/wireless/intersil/hostap/hostap_ap.c:2511:3: warning:
misleading indentation; statement is not part of the previous 'if'
[-Wmisleading-indentation]
        if (sta->tx_supp_rates & WLAN_RATE_5M5)
        ^
../drivers/net/wireless/intersil/hostap/hostap_ap.c:2509:2: note:
previous statement is here
        if (sta->tx_supp_rates & WLAN_RATE_2M)
        ^
1 warning generated.

This warning occurs because there is a space before the tab on this
line. Remove it so that the indentation is consistent with the Linux
kernel coding style and clang no longer warns.

Fixes: ff1d2767d5a4 ("Add HostAP wireless driver.")
Link: https://github.com/ClangBuiltLinux/linux/issues/813
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/hostap/hostap_ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/hostap/hostap_ap.c b/drivers/net/wireless/hostap/hostap_ap.c
index c995ace153ee6..30171d4c47187 100644
--- a/drivers/net/wireless/hostap/hostap_ap.c
+++ b/drivers/net/wireless/hostap/hostap_ap.c
@@ -2570,7 +2570,7 @@ static int prism2_hostapd_add_sta(struct ap_data *ap,
 		sta->supported_rates[0] = 2;
 	if (sta->tx_supp_rates & WLAN_RATE_2M)
 		sta->supported_rates[1] = 4;
- 	if (sta->tx_supp_rates & WLAN_RATE_5M5)
+	if (sta->tx_supp_rates & WLAN_RATE_5M5)
 		sta->supported_rates[2] = 11;
 	if (sta->tx_supp_rates & WLAN_RATE_11M)
 		sta->supported_rates[3] = 22;
-- 
2.20.1



