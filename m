Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CB0C35242
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 18:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C11322464
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 18:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbgBHS3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 13:29:36 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33450 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727465AbgBHS3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 13:29:33 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1j0UrC-0003a5-Pw; Sat, 08 Feb 2020 18:29:30 +0000
Received: from ben by deadeye with local (Exim 4.93)
        (envelope-from <ben@decadent.org.uk>)
        id 1j0UrB-000CJA-Jd; Sat, 08 Feb 2020 18:29:29 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "David S. Miller" <davem@davemloft.net>,
        "John W. Linville" <linville@tuxdriver.com>,
        "Denis Efremov" <efremov@linux.com>,
        "Kalle Valo" <kvalo@codeaurora.org>,
        "Rajkumar Manoharan" <rmanohar@qca.qualcomm.com>
Date:   Sat, 08 Feb 2020 18:19:09 +0000
Message-ID: <lsq.1581185940.263713177@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 010/148] ath9k_hw: fix uninitialized variable data
In-Reply-To: <lsq.1581185939.857586636@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.82-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Denis Efremov <efremov@linux.com>

commit 80e84f36412e0c5172447b6947068dca0d04ee82 upstream.

Currently, data variable in ar9003_hw_thermo_cal_apply() could be
uninitialized if ar9300_otp_read_word() will fail to read the value.
Initialize data variable with 0 to prevent an undefined behavior. This
will be enough to handle error case when ar9300_otp_read_word() fails.

Fixes: 80fe43f2bbd5 ("ath9k_hw: Read and configure thermocal for AR9462")
Cc: Rajkumar Manoharan <rmanohar@qca.qualcomm.com>
Cc: John W. Linville <linville@tuxdriver.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Denis Efremov <efremov@linux.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/wireless/ath/ath9k/ar9003_eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
@@ -4107,7 +4107,7 @@ static void ar9003_hw_thermometer_apply(
 
 static void ar9003_hw_thermo_cal_apply(struct ath_hw *ah)
 {
-	u32 data, ko, kg;
+	u32 data = 0, ko, kg;
 
 	if (!AR_SREV_9462_20_OR_LATER(ah))
 		return;

