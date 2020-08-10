Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C53C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18AED2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597087013;
	bh=an2qDyvexFxr4rBh8yzEGHY2b5T586DGONdlqCE5QIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=17RDzyxT9VZ9pow0E/s9WbTsqJ/rgatKHEVXKpRAd1DzKvWbB7WP3345c9uV6bxNJ
	 dtboTh2XXQcPqAfw03L9D6/w8mCcrE9iK8zWgYNRXLQfxxoz2GwClASAj/SZm0z3MF
	 qFlX3TahiPFfGHgioUooTke4SEvRMH4Xpz4UIsY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbgHJTQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:16:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730036AbgHJTOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:14:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A0F722C9E;
        Mon, 10 Aug 2020 19:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597086873;
        bh=an2qDyvexFxr4rBh8yzEGHY2b5T586DGONdlqCE5QIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fCA62dI73dTMum8I+wgANHDED3NCJvF7ztmYN4uV22yw23nBHJ/8cR/sS/lTWZ33N
         Kx7mWOq5e5rwuUo23sYB4ZoOPVokYTuMeMcxF8gnB+7telbrdRUccnazbNceHt9P31
         AyoGZzB37HqD5AiQTjPvXvK2b/EfIgQACumYc788=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Prasanna Kerekoppa <prasanna.kerekoppa@cypress.com>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 10/17] brcmfmac: To fix Bss Info flag definition Bug
Date:   Mon, 10 Aug 2020 15:14:11 -0400
Message-Id: <20200810191418.3795394-10-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810191418.3795394-1-sashal@kernel.org>
References: <20200810191418.3795394-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prasanna Kerekoppa <prasanna.kerekoppa@cypress.com>

[ Upstream commit fa3266541b13f390eb35bdbc38ff4a03368be004 ]

Bss info flag definition need to be fixed from 0x2 to 0x4
This flag is for rssi info received on channel.
All Firmware branches defined as 0x4 and this is bug in brcmfmac.

Signed-off-by: Prasanna Kerekoppa <prasanna.kerekoppa@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
Signed-off-by: Wright Feng <wright.feng@cypress.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200604071835.3842-6-wright.feng@cypress.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
index 59013572fbe3f..d6a4a08fd3c44 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
@@ -30,7 +30,7 @@
 #define BRCMF_ARP_OL_PEER_AUTO_REPLY	0x00000008
 
 #define	BRCMF_BSS_INFO_VERSION	109 /* curr ver of brcmf_bss_info_le struct */
-#define BRCMF_BSS_RSSI_ON_CHANNEL	0x0002
+#define BRCMF_BSS_RSSI_ON_CHANNEL	0x0004
 
 #define BRCMF_STA_WME              0x00000002      /* WMM association */
 #define BRCMF_STA_AUTHE            0x00000008      /* Authenticated */
-- 
2.25.1

