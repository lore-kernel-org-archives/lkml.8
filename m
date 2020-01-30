Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA9EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EABA205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580410239;
	bh=LQYGm44o3kuZaSKrPBpL9FgbVJTuNAROgwlpse27PMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jVN5CL0ZCegRMOYq6VrSkWmncf2CyASeb+Sfy2ONRlaIzAWj4p4LyZ3KSi0z1ncsO
	 OzghGtpQylk5t52EOsco7vjPA+ErUzEDA8EuUQ4DlI1v5+bgW1ZGSf9yEKv7uhfDOg
	 wlcFTuFgI7NxESpVI3LOQQ1m67jp8FyQRtwqjadQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731658AbgA3Sui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:50:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:56780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730795AbgA3Sqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:46:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02CB220CC7;
        Thu, 30 Jan 2020 18:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580409998;
        bh=LQYGm44o3kuZaSKrPBpL9FgbVJTuNAROgwlpse27PMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=105BQyWwLAolPlqfyYqlQFPgOufq77LoScN1SZcl6/Ox8Nijq6xwFfZvQ54dtMJLC
         a2f8RfoW+HsV0TBTo/G30gFsx0EouTWkHJGxU6qA2Bnbj67BfHuQs36Emi7aqoKopD
         IiOSngWJF8zsT3M0xqrXMfgf1UO4my70XdM2Inqw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+1d1597a5aa3679c65b9f@syzkaller.appspotmail.com,
        Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
        Amitkumar Karwar <amit.karwar@redpinesignals.com>,
        Johan Hovold <johan@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 5.4 101/110] rsi: fix use-after-free on probe errors
Date:   Thu, 30 Jan 2020 19:39:17 +0100
Message-Id: <20200130183625.643309472@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183613.810054545@linuxfoundation.org>
References: <20200130183613.810054545@linuxfoundation.org>
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


