Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BE1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B91AC221E6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592444222;
	bh=S/dfhmVg5yg53heeH9fkj8IYGpGQXXRipsorqyEQV6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E/LK7nJdMhCNHF2CB7s3M628yc3FmsCUJduL7k3tisRtmuK9RM5QbCs0s+l+XIojF
	 j5yiLIFE3OtyAWnOBrGdvTfzUAJP0MbsH6CiQuTCz+buk3hlY1/myg1gnIR9YpDCcD
	 MeXjOOcoPWGkOhgXf4LDGez8Q1ISrzZ6IY7B1YQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732874AbgFRBhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:37:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731881AbgFRBax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:30:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1C3520FC3;
        Thu, 18 Jun 2020 01:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443852;
        bh=S/dfhmVg5yg53heeH9fkj8IYGpGQXXRipsorqyEQV6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QBHShcJvULO4BIsqKuto3n/SrsBLDrOuVrxT0HPxyKFlEKK4LDba2rAX0y6+OtlWS
         2Asl6jn080RZ/+q1YJHX6pooZf3xms7MYN74gx+PEIU13tIKV/2oMO/L4Qs2g1cwLl
         u07tuPYjp958vgrLRmn+e+YhcF8GMdDRGqrR8gX4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 36/60] tty: n_gsm: Fix SOF skipping
Date:   Wed, 17 Jun 2020 21:29:40 -0400
Message-Id: <20200618013004.610532-36-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618013004.610532-1-sashal@kernel.org>
References: <20200618013004.610532-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gregory CLEMENT <gregory.clement@bootlin.com>

[ Upstream commit 84d6f81c1fb58b56eba81ff0a36cf31946064b40 ]

For at least some modems like the TELIT LE910, skipping SOF makes
transfers blocking indefinitely after a short amount of data
transferred.

Given the small improvement provided by skipping the SOF (just one
byte on about 100 bytes), it seems better to completely remove this
"feature" than make it optional.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Link: https://lore.kernel.org/r/20200512115323.1447922-3-gregory.clement@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/n_gsm.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 6060c3e8925e..08aaf993221e 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -685,7 +685,6 @@ static void gsm_data_kick(struct gsm_mux *gsm)
 {
 	struct gsm_msg *msg, *nmsg;
 	int len;
-	int skip_sof = 0;
 
 	list_for_each_entry_safe(msg, nmsg, &gsm->tx_list, list) {
 		if (gsm->constipated && msg->addr)
@@ -707,15 +706,10 @@ static void gsm_data_kick(struct gsm_mux *gsm)
 			print_hex_dump_bytes("gsm_data_kick: ",
 					     DUMP_PREFIX_OFFSET,
 					     gsm->txframe, len);
-
-		if (gsm->output(gsm, gsm->txframe + skip_sof,
-						len - skip_sof) < 0)
+		if (gsm->output(gsm, gsm->txframe, len) < 0)
 			break;
 		/* FIXME: Can eliminate one SOF in many more cases */
 		gsm->tx_bytes -= msg->len;
-		/* For a burst of frames skip the extra SOF within the
-		   burst */
-		skip_sof = 1;
 
 		list_del(&msg->list);
 		kfree(msg);
-- 
2.25.1

