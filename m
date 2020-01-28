Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8B7C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FB1246A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221583;
	bh=y5naaX/jk2tPD3PXMjWnK2jYPzGwF+1sy9ZDxHDE3wE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Vj2G1UOiQ119bAVWlL+bmzvJ5uKJPvYgH+WcR8URHtqM1I2tLGXEwytPEKFWJNB8
	 WDB9pF7xPblA/NS0hGOxBa9tTqsicE6vVt3X0H+Mwx5/pxY0pqJE60KcT9HrrLxpfN
	 MXhyrRuyzFRolrhcslD8CS009VeansHh5YSSg2UM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbgA1O0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:26:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:53650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732452AbgA1O0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:26:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2D1E24686;
        Tue, 28 Jan 2020 14:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221575;
        bh=y5naaX/jk2tPD3PXMjWnK2jYPzGwF+1sy9ZDxHDE3wE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zYIogUywl2TprQmEodTBIYfethGeF8OHlqLesn+D8Vpv795jTuvjgaXr2p9N0X3hb
         mdCRrZhSDkqIucLkVTkkqZLjpkBH6bGMibUW6PSevhlOK0E1K+K3BLlbMB1VIyunDf
         hKeIe5PTDYee30MgrPT9FK1dyVtXfcx5EgbKcAU0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Wen Huang <huangwenabc@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.9 265/271] libertas: Fix two buffer overflows at parsing bss descriptor
Date:   Tue, 28 Jan 2020 15:06:54 +0100
Message-Id: <20200128135912.316442577@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Huang <huangwenabc@gmail.com>

commit e5e884b42639c74b5b57dc277909915c0aefc8bb upstream.

add_ie_rates() copys rates without checking the length
in bss descriptor from remote AP.when victim connects to
remote attacker, this may trigger buffer overflow.
lbs_ibss_join_existing() copys rates without checking the length
in bss descriptor from remote IBSS node.when victim connects to
remote attacker, this may trigger buffer overflow.
Fix them by putting the length check before performing copy.

This fix addresses CVE-2019-14896 and CVE-2019-14897.
This also fix build warning of mixed declarations and code.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Wen Huang <huangwenabc@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/marvell/libertas/cfg.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

--- a/drivers/net/wireless/marvell/libertas/cfg.c
+++ b/drivers/net/wireless/marvell/libertas/cfg.c
@@ -272,6 +272,10 @@ add_ie_rates(u8 *tlv, const u8 *ie, int
 	int hw, ap, ap_max = ie[1];
 	u8 hw_rate;
 
+	if (ap_max > MAX_RATES) {
+		lbs_deb_assoc("invalid rates\n");
+		return tlv;
+	}
 	/* Advance past IE header */
 	ie += 2;
 
@@ -1789,6 +1793,9 @@ static int lbs_ibss_join_existing(struct
 	struct cmd_ds_802_11_ad_hoc_join cmd;
 	u8 preamble = RADIO_PREAMBLE_SHORT;
 	int ret = 0;
+	int hw, i;
+	u8 rates_max;
+	u8 *rates;
 
 	lbs_deb_enter(LBS_DEB_CFG80211);
 
@@ -1849,9 +1856,12 @@ static int lbs_ibss_join_existing(struct
 	if (!rates_eid) {
 		lbs_add_rates(cmd.bss.rates);
 	} else {
-		int hw, i;
-		u8 rates_max = rates_eid[1];
-		u8 *rates = cmd.bss.rates;
+		rates_max = rates_eid[1];
+		if (rates_max > MAX_RATES) {
+			lbs_deb_join("invalid rates");
+			goto out;
+		}
+		rates = cmd.bss.rates;
 		for (hw = 0; hw < ARRAY_SIZE(lbs_rates); hw++) {
 			u8 hw_rate = lbs_rates[hw].bitrate / 5;
 			for (i = 0; i < rates_max; i++) {


