Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8396C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8995D20760
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591664158;
	bh=9Xe4Sx5w74/rmD8c1252EWSqEacJPDGX8bb4wGGi3ZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZeRjifysqrkPLFW5r5/Hycrq1v1Xi/O7Zwbqc3ssOspATCPYIME3R4fufKAdtsF7U
	 KDjpr1+1IYtfFaQ8tLpQv2koM2evAp1mzRRzIqKtSld0RRbbop0IpXQAFXvR4MM3R2
	 S9Hh/R3pZQv691rTPARDb23XgyzGGKLO2zNF69H8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbgFIAz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:55:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728367AbgFHXJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:09:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B33A20CC7;
        Mon,  8 Jun 2020 23:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657751;
        bh=9Xe4Sx5w74/rmD8c1252EWSqEacJPDGX8bb4wGGi3ZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tgfPkNMgvrVt1p6LND8sY3HJRuPjGcW/yXFyZTH4/owneW9v7dY0vz4os1ND9TMbX
         mwN21jKI9Bn93SzlNe0vH5z6m64pf0Ln9JCFxRm+RqDR8QIvJ5rgmPtUPOrRS34Xdg
         OMyfPXDTMgoKp672lSHzWtDrxTUmmd9BC43BN9Bw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.7 138/274] drm/bridge: fix stack usage warning on old gcc
Date:   Mon,  8 Jun 2020 19:03:51 -0400
Message-Id: <20200608230607.3361041-138-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 78b0d99a68ecdc84728c99f4fef71942e9ecf35a ]

Some older versions of gcc badly optimize code that passes
an inline function argument into another function by reference,
causing huge stack usage:

drivers/gpu/drm/bridge/tc358768.c: In function 'tc358768_bridge_pre_enable':
drivers/gpu/drm/bridge/tc358768.c:840:1: error: the frame size of 2256 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]

Use a temporary variable as a workaround and add a comment pointing
to the gcc bug.

Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20200428215408.4111675-1-arnd@arndb.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358768.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 1b39e8d37834..6650fe4cfc20 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -178,6 +178,8 @@ static int tc358768_clear_error(struct tc358768_priv *priv)
 
 static void tc358768_write(struct tc358768_priv *priv, u32 reg, u32 val)
 {
+	/* work around https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715 */
+	int tmpval = val;
 	size_t count = 2;
 
 	if (priv->error)
@@ -187,7 +189,7 @@ static void tc358768_write(struct tc358768_priv *priv, u32 reg, u32 val)
 	if (reg < 0x100 || reg >= 0x600)
 		count = 1;
 
-	priv->error = regmap_bulk_write(priv->regmap, reg, &val, count);
+	priv->error = regmap_bulk_write(priv->regmap, reg, &tmpval, count);
 }
 
 static void tc358768_read(struct tc358768_priv *priv, u32 reg, u32 *val)
-- 
2.25.1

