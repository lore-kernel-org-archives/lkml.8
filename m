Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDA0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E8532067C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597684467;
	bh=5jqvCiKRJBHM6wCakwUncmndmrLuQZ6BD/yNkVWmES0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VI2MuM4krX9hhSz2m8D+NrSOM1kiTh+Xbk/gIrl47vthyStuU13fyrC9MkApzxS2Q
	 CfCVZL95oj+HrKljQp5Qb2jVuLfAlH5oIuvcq2VFmYYylPgCwtWh5nCRo5cGxPeXNy
	 B8rfVEP2FuKqEpy7ysg4GXDfTwpVaiagheZnVoUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389406AbgHQROZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:14:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388701AbgHQQMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:12:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5769207FF;
        Mon, 17 Aug 2020 16:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680754;
        bh=5jqvCiKRJBHM6wCakwUncmndmrLuQZ6BD/yNkVWmES0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nA4lcnB9A7hb7UfPzZXGHd5RAco8frDSqD9ile0yIy8hARrevfs2UiOrJ2NdEo1aU
         EJTcA1CjfwurVL1f1FrEE3t7KzgQi4090aNG8up0FFnMsIi8s4nM6Om0xQSjRSbU38
         UrqLLbBfnuIKF19527xx34KJdKjJR7EGU+5NL8NY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Prasanna Kerekoppa <prasanna.kerekoppa@cypress.com>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 044/168] brcmfmac: To fix Bss Info flag definition Bug
Date:   Mon, 17 Aug 2020 17:16:15 +0200
Message-Id: <20200817143735.960272076@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143733.692105228@linuxfoundation.org>
References: <20200817143733.692105228@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index d5bb81e887624..9d2367133c7c6 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
@@ -30,7 +30,7 @@
 #define BRCMF_ARP_OL_PEER_AUTO_REPLY	0x00000008
 
 #define	BRCMF_BSS_INFO_VERSION	109 /* curr ver of brcmf_bss_info_le struct */
-#define BRCMF_BSS_RSSI_ON_CHANNEL	0x0002
+#define BRCMF_BSS_RSSI_ON_CHANNEL	0x0004
 
 #define BRCMF_STA_BRCM			0x00000001	/* Running a Broadcom driver */
 #define BRCMF_STA_WME			0x00000002	/* WMM association */
-- 
2.25.1



