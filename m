Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD980C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828F3214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580410422;
	bh=LQYGm44o3kuZaSKrPBpL9FgbVJTuNAROgwlpse27PMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WU0PlQYeH4KXHFSaFO3DaMbqmxoR6LRMwaLUFpBXp+w6yT5Wcm1tQdfL7du1xeJtn
	 v9EUW4ejzbRfI7QZoNdm65IC0qGQ8puFrO8DvdA5SUi1n0wFEXdOAYgD2D9dBlo3qq
	 plV3x2IO4cvGCT4xLbQkT8J4Txyd+CyYnbznAVWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbgA3SlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:41:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:49228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730133AbgA3SlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:41:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B2B9214DB;
        Thu, 30 Jan 2020 18:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580409678;
        bh=LQYGm44o3kuZaSKrPBpL9FgbVJTuNAROgwlpse27PMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vY7mCGWNuLHfbw46cXmbi2WPYQfunDVJ9mrLgwCY3NQw3O+sFS8GgWgVU77I1TZUK
         i+o3BjfcQmUEhoi3MfiN8SYCI69N/1CbO84oMLg/RaKCT155QuW2Xk3uMv7rO2xl7+
         leBsJp5mzs2IkHfwP0ioKTBTyGd64hGi7w93/agQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+1d1597a5aa3679c65b9f@syzkaller.appspotmail.com,
        Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
        Amitkumar Karwar <amit.karwar@redpinesignals.com>,
        Johan Hovold <johan@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 5.5 47/56] rsi: fix use-after-free on probe errors
Date:   Thu, 30 Jan 2020 19:39:04 +0100
Message-Id: <20200130183617.490446841@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183608.849023566@linuxfoundation.org>
References: <20200130183608.849023566@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 92aafe77123ab478e5f5095878856ab0424910da upstream.

The driver would fail to stop the command timer in most error paths,
something which specifically could lead to the timer being freed while
still active on I/O errors during probe.

Fix this by making sure that each function starting the timer also stops
it in all relevant error paths.

Reported-by: syzbot+1d1597a5aa3679c65b9f@syzkaller.appspotmail.com
Fixes: b78e91bcfb33 ("rsi: Add new firmware loading method")
Cc: stable <stable@vger.kernel.org>     # 4.12
Cc: Prameela Rani Garnepudi <prameela.j04cs@gmail.com>
Cc: Amitkumar Karwar <amit.karwar@redpinesignals.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/rsi/rsi_91x_hal.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/net/wireless/rsi/rsi_91x_hal.c
+++ b/drivers/net/wireless/rsi/rsi_91x_hal.c
@@ -622,6 +622,7 @@ static int bl_cmd(struct rsi_hw *adapter
 	bl_start_cmd_timer(adapter, timeout);
 	status = bl_write_cmd(adapter, cmd, exp_resp, &regout_val);
 	if (status < 0) {
+		bl_stop_cmd_timer(adapter);
 		rsi_dbg(ERR_ZONE,
 			"%s: Command %s (%0x) writing failed..\n",
 			__func__, str, cmd);
@@ -737,10 +738,9 @@ static int ping_pong_write(struct rsi_hw
 	}
 
 	status = bl_cmd(adapter, cmd_req, cmd_resp, str);
-	if (status) {
-		bl_stop_cmd_timer(adapter);
+	if (status)
 		return status;
-	}
+
 	return 0;
 }
 
@@ -828,10 +828,9 @@ static int auto_fw_upgrade(struct rsi_hw
 
 	status = bl_cmd(adapter, EOF_REACHED, FW_LOADING_SUCCESSFUL,
 			"EOF_REACHED");
-	if (status) {
-		bl_stop_cmd_timer(adapter);
+	if (status)
 		return status;
-	}
+
 	rsi_dbg(INFO_ZONE, "FW loading is done and FW is running..\n");
 	return 0;
 }
@@ -849,6 +848,7 @@ static int rsi_hal_prepare_fwload(struct
 						  &regout_val,
 						  RSI_COMMON_REG_SIZE);
 		if (status < 0) {
+			bl_stop_cmd_timer(adapter);
 			rsi_dbg(ERR_ZONE,
 				"%s: REGOUT read failed\n", __func__);
 			return status;


