Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB53C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E766520737
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgD1VyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:54:25 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:44633 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgD1VyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:54:24 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N6LIF-1j5YGB1AzJ-016ghU; Tue, 28 Apr 2020 23:54:10 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: fix stack usage warning on old gcc
Date:   Tue, 28 Apr 2020 23:53:54 +0200
Message-Id: <20200428215408.4111675-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iHy77Rgu9/Qf8z+D5jGM8zx0JRD4tfbl7zP0c3hDGD/7Ft21SO3
 I4IsJ+jGm/bVAWJqL1Rgf8I2wrapU26otg4sIofhMQb4XOZnwxaw31TkmIbV3Vlrbsbo54Q
 P/dVYkN3nJTFgE7FH/ZOxI7PtDR5ElP19dDF4HjIELGFelpb9qmkGN6N5JtO+SltH/uj40E
 u1b00TzYaa+Jebr1QgvEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L/hkBWoUTWU=:bxdNUJcDA92RjQs7Q9QheM
 QaDyFm0mRKkwmCMy1a0hjVZpquNsrPNbdFKl//hzhASrhSfI+Gheh2b0astjApDRPCLgxrswt
 egURzEGVfCqKE10n/8+Y0APtrnX9MjRb7pbHdZVcK7w7Xpo9ahfsmcibn8HczBc4ut3ICeuRL
 Hy35WFSdVEC7Yj0EXPEiMwHCWuYB0UTm7KZ6ep2c97qg0En0DB9eFytqqJdXtnd0Nc1TkQxwv
 iCO5wTaDNlt7ybbZzSVA6eH6XMri1zKO6wHdMESMbk5TtTAebz4qzanlBB1IIcuWJkPkTBFMo
 ux7nSD03mSQtQmz4IQJjfG0aIi6d2NGNyM2zT3dRPcwQyUfHwLfqRal9QHpQhtZR7O7Kq2ZvT
 bGoxwqZ8LjCMh3Yrj+/NN0iUb5k6fN9LfFHHTj3k0P8r2GiWuWmcni+XzGH8/9M20QsdzHlju
 Q1VrxfFhXeEQn7o08nEaCNa9YuTeyEPCe73nmLw6dFh1Kzlm5IvhOXaOQ68hKZLG/qx2wic1b
 V+KeQDH2Du2SrZ3r4fne5t63amyneyrMRXS5PGb8GNqvnIsUCjha0m+tjhtj5AZUdhMVybTGC
 miRpldWtpPTjOXvaeWCsUH4NUHisorKza7HhxubccmW9QrsaJpffPL17Y1Sk+F2sMZZACDYBp
 4JwBe/Opi/K/ccx2Rqn39JOiLjXw08FdevcWgFiiYMhyXaKfGZCtz48KSwaUUft1ewrKPNwTI
 mmccUZrDPDF68mtgKgpGYBywesmUvDkM1XfwO3vGd6ScMzcAPZ4ZP72ajdmC82zxH3Zh6ln2D
 bp+nQsgzlJTgITvS11vzPCFG7qC3L+ShsNvVbGGHQCjcV43nEA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some older versions of gcc badly optimize code that passes
an inline function argument into another function by reference,
causing huge stack usage:

drivers/gpu/drm/bridge/tc358768.c: In function 'tc358768_bridge_pre_enable':
drivers/gpu/drm/bridge/tc358768.c:840:1: error: the frame size of 2256 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]

Use a temporary variable as a workaround and add a comment pointing
to the gcc bug.

Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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
2.26.0

