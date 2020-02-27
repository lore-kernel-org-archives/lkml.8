Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C705C3F341
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D2F20578
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811244;
	bh=NIrM7BfuNSEny7YRm6JIMrDLMQQVbW6fopKZ/JMJ/88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yAxxTauVNmZZvs6IN6evVe+4KJLV6lRYqUIqXiOGPJxLohRp7GpzdNdBE3nWFtsfo
	 iNzUSm+kNNmM/kdWGVJyOyrXSiVUeX6P0IQtLL8WniEc3cnAd8NxpXrYBUc3719Q0H
	 lYHAKd1+Co0uqFYXbdHQuxh9+wNuZswX1evG4dXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730683AbgB0NrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:47:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:43732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730348AbgB0NrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:47:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B3A920578;
        Thu, 27 Feb 2020 13:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811237;
        bh=NIrM7BfuNSEny7YRm6JIMrDLMQQVbW6fopKZ/JMJ/88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BOg9oAY/C9AsFET3gZGSLOc0MfYCSspI62FD1FdQ8zsjG2szdDPHGs5bHZo7bFjaU
         uVNKAY2tmxeN6Y+SIiWYV1jhK8e103z/FxTlsFZmfjKl6+Vu1knaoON3UbfWdqWJLF
         UGODkYIJBczW6SpHe3iBaeZ3oEbFM8K0B6fTPnsg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Phong Tran <tranmanphong@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 056/165] rtlwifi: rtl_pci: Fix -Wcast-function-type
Date:   Thu, 27 Feb 2020 14:35:30 +0100
Message-Id: <20200227132239.574306684@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132230.840899170@linuxfoundation.org>
References: <20200227132230.840899170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phong Tran <tranmanphong@gmail.com>

[ Upstream commit cb775c88da5d48a85d99d95219f637b6fad2e0e9 ]

correct usage prototype of callback in tasklet_init().
Report by https://github.com/KSPP/linux/issues/20

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index e15b462d096bf..21b7cb845bf40 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -1095,13 +1095,15 @@ done:
 	return ret;
 }
 
-static void _rtl_pci_irq_tasklet(struct ieee80211_hw *hw)
+static void _rtl_pci_irq_tasklet(unsigned long data)
 {
+	struct ieee80211_hw *hw = (struct ieee80211_hw *)data;
 	_rtl_pci_tx_chk_waitq(hw);
 }
 
-static void _rtl_pci_prepare_bcn_tasklet(struct ieee80211_hw *hw)
+static void _rtl_pci_prepare_bcn_tasklet(unsigned long data)
 {
+	struct ieee80211_hw *hw = (struct ieee80211_hw *)data;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
@@ -1223,10 +1225,10 @@ static void _rtl_pci_init_struct(struct ieee80211_hw *hw,
 
 	/*task */
 	tasklet_init(&rtlpriv->works.irq_tasklet,
-		     (void (*)(unsigned long))_rtl_pci_irq_tasklet,
+		     _rtl_pci_irq_tasklet,
 		     (unsigned long)hw);
 	tasklet_init(&rtlpriv->works.irq_prepare_bcn_tasklet,
-		     (void (*)(unsigned long))_rtl_pci_prepare_bcn_tasklet,
+		     _rtl_pci_prepare_bcn_tasklet,
 		     (unsigned long)hw);
 	INIT_WORK(&rtlpriv->works.lps_change_work,
 		  rtl_lps_change_work_callback);
-- 
2.20.1



