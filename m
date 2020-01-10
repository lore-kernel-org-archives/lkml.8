Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6A9C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 22:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52ADC20678
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 22:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578694026;
	bh=UuWWOuAb9bUEnIgY1/pbzbTQNEUgrUtxVu6Qt6xaOuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uwV/lz1vEvK0jAm5A0YPQqkD2yVvTH8It1UQUQO7wmkOwUlsjoRpbNYi9DvEAdZSt
	 zv5zo+xilRTtwmDgbTOlXS3tKhfFCwgHB+PT8DU3QcDdzgkUB/F2L/wOe40JkvwpcF
	 JjC/rr/v+lKcXcoUsg8XX7NB2siKY128Z/HtFaTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgAJWHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 17:07:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:52446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbgAJWGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 17:06:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEA052072E;
        Fri, 10 Jan 2020 22:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578693962;
        bh=UuWWOuAb9bUEnIgY1/pbzbTQNEUgrUtxVu6Qt6xaOuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CjDo2Y1v+peGTHf97HRQvyZqL2t+ZRQwvl+UoJhwgt/4sDvXR7euukWR0wqxH9etd
         VrFateyLG8KMmATFmc9qhTlwcrUW968BZ4shQGW9kEarzcSrxnjuBycTknNAbJdE5w
         jUkopSSmfwp5KXAaJs1LGlmm4JEtseQsFHWcisOI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandra Winter <wintera@linux.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 06/11] s390/qeth: Fix vnicc_is_in_use if rx_bcast not set
Date:   Fri, 10 Jan 2020 17:05:50 -0500
Message-Id: <20200110220556.28505-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110220556.28505-1-sashal@kernel.org>
References: <20200110220556.28505-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandra Winter <wintera@linux.ibm.com>

[ Upstream commit e8a66d800471e2df7f0b484e2e46898b21d1fa82 ]

Symptom: After vnicc/rx_bcast has been manually set to 0,
	bridge_* sysfs parameters can still be set or written.
Only occurs on HiperSockets, as OSA doesn't support changing rx_bcast.

Vnic characteristics and bridgeport settings are mutually exclusive.
rx_bcast defaults to 1, so manually setting it to 0 should disable
bridge_* parameters.

Instead it makes sense here to check the supported mask. If the card
does not support vnicc at all, bridge commands are always allowed.

Fixes: caa1f0b10d18 ("s390/qeth: add VNICC enable/disable support")
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_l2_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 66bc6f1ffd34..c238b190b3c9 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -2285,8 +2285,7 @@ int qeth_l2_vnicc_get_timeout(struct qeth_card *card, u32 *timeout)
 /* check if VNICC is currently enabled */
 bool qeth_l2_vnicc_is_in_use(struct qeth_card *card)
 {
-	/* if everything is turned off, VNICC is not active */
-	if (!card->options.vnicc.cur_chars)
+	if (!card->options.vnicc.sup_chars)
 		return false;
 	/* default values are only OK if rx_bcast was not enabled by user
 	 * or the card is offline.
-- 
2.20.1

