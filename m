Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F12C3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1EC6206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586952499;
	bh=kPuYz+x66mnO8Bd+2a9Rx3mEP4MAbIx/RUKWkxGi07U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OQBsXZvBMR8XaQtvQk0qhX8D4CBPVJaj4TRSBNKBijSL6Y+R/UatX6n1PYoxy9l9a
	 FueVAd8Edfti60gUzs1sdAIyfwYe6WtA7AtQ0VnNSYD7s6TWkV+Ujw1+lvAjcJQODL
	 ns108Llsx20j0MSL+ONTfb/bIJQAD84YAs2p9mE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441258AbgDOMIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:08:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409347AbgDOLrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:47:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31D8E20775;
        Wed, 15 Apr 2020 11:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586951248;
        bh=kPuYz+x66mnO8Bd+2a9Rx3mEP4MAbIx/RUKWkxGi07U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oPjXhTM1UH+ntKeocrsU1rIzfOhmJdMwEfsKri9f+O8Ao+fvH/Xud7u09pzMFc+Qt
         1ZW8guaQrHN9+9biOcPjylA66ZWcM08KTtDjlF/pXz1HPUm9JldKq51rXVRGoPn4Su
         7zqzPNfzOzQosSHVUfz1rY8ZCMLPBH7b6FIbmnto=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Richard Palethorpe <rpalethorpe@suse.com>,
        Kees Cook <keescook@chromium.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, security@kernel.org, wg@grandegger.com,
        mkl@pengutronix.de, davem@davemloft.net,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 14/30] slcan: Don't transmit uninitialized stack data in padding
Date:   Wed, 15 Apr 2020 07:46:55 -0400
Message-Id: <20200415114711.15381-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415114711.15381-1-sashal@kernel.org>
References: <20200415114711.15381-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Palethorpe <rpalethorpe@suse.com>

[ Upstream commit b9258a2cece4ec1f020715fe3554bc2e360f6264 ]

struct can_frame contains some padding which is not explicitly zeroed in
slc_bump. This uninitialized data will then be transmitted if the stack
initialization hardening feature is not enabled (CONFIG_INIT_STACK_ALL).

This commit just zeroes the whole struct including the padding.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Fixes: a1044e36e457 ("can: add slcan driver for serial/USB-serial CAN adapters")
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: security@kernel.org
Cc: wg@grandegger.com
Cc: mkl@pengutronix.de
Cc: davem@davemloft.net
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/slcan.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index 7c37b96ff22a7..c5a616395c490 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -147,7 +147,7 @@ static void slc_bump(struct slcan *sl)
 	u32 tmpid;
 	char *cmd = sl->rbuff;
 
-	cf.can_id = 0;
+	memset(&cf, 0, sizeof(cf));
 
 	switch (*cmd) {
 	case 'r':
@@ -186,8 +186,6 @@ static void slc_bump(struct slcan *sl)
 	else
 		return;
 
-	*(u64 *) (&cf.data) = 0; /* clear payload */
-
 	/* RTR frames may have a dlc > 0 but they never have any data bytes */
 	if (!(cf.can_id & CAN_RTR_FLAG)) {
 		for (i = 0; i < cf.can_dlc; i++) {
-- 
2.20.1

