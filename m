Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C25C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5ACA20661
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217770;
	bh=hkDV0F8DLyWObmZCImCKkV2o6hcgmEmc5ef/rDnXpIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bH9188hGyQPzmywFtxvz5Owb/7Pv/DsdLpX2jK/8gHWBqKvbAGX67HN1Te1Tk2Gl3
	 6flx7aeuU6Vlyxi5BE2izsD966/p0QBgvDZJS1Ni3owLWC3sJe96hRmhYMRF91vas6
	 IS/vQTViztZRWCq397H2iAHNs7otkJVC85C+WU3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389019AbgAPXgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:36:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:40588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391534AbgAPXbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:31:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FF63206D9;
        Thu, 16 Jan 2020 23:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217509;
        bh=hkDV0F8DLyWObmZCImCKkV2o6hcgmEmc5ef/rDnXpIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mHhD5IO2Xuis3yl/t3SkluJs/BnUTCKtbZIcCMAHDasZqv54bxv0QBn6EdyZL1QCg
         +SxTuhx8rWH+bdZkIAZUT0rzzHjLyklDOxWSKjtFrMyOq7ERE4x9vfpkQEcQA3mM6t
         w2F4h0UCP8ctSp8QjyAamh+pVwu12VqbU82HI5CA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sanjay Konduri <sanjay.konduri@redpinesignals.com>,
        Sushant Kumar Mishra <sushant.mishra@redpinesignals.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.14 06/71] rsi: add fix for crash during assertions
Date:   Fri, 17 Jan 2020 00:18:04 +0100
Message-Id: <20200116231710.324691968@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231709.377772748@linuxfoundation.org>
References: <20200116231709.377772748@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sanjay Konduri <sanjay.konduri@redpinesignals.com>

commit abd39c6ded9db53aa44c2540092bdd5fb6590fa8 upstream.

Observed crash in some scenarios when assertion has occurred,
this is because hw structure is freed and is tried to get
accessed in some functions where null check is already
present. So, avoided the crash by making the hw to NULL after
freeing.

Signed-off-by: Sanjay Konduri <sanjay.konduri@redpinesignals.com>
Signed-off-by: Sushant Kumar Mishra <sushant.mishra@redpinesignals.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/rsi/rsi_91x_mac80211.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
@@ -218,6 +218,7 @@ void rsi_mac80211_detach(struct rsi_hw *
 		ieee80211_stop_queues(hw);
 		ieee80211_unregister_hw(hw);
 		ieee80211_free_hw(hw);
+		adapter->hw = NULL;
 	}
 
 	for (band = 0; band < NUM_NL80211_BANDS; band++) {


