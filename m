Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5C0C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4E22070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgCZKrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:47:04 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:59701 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbgCZKrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 06:47:03 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MqJyX-1je9zy3UQ7-00nNcs for <linux-kernel@vger.kernel.org>; Thu, 26 Mar
 2020 11:47:01 +0100
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 9EEAC65047A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 10:47:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8Yjv4daZk8tG for <linux-kernel@vger.kernel.org>;
        Thu, 26 Mar 2020 11:47:00 +0100 (CET)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id 427B364DE01
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 11:47:00 +0100 (CET)
Received: from pflmari.corp.cetitec.com (10.8.5.79) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 26 Mar 2020 11:47:00 +0100
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id 5049380500; Thu, 26 Mar 2020 11:35:23 +0100 (CET)
Date:   Thu, 26 Mar 2020 11:35:23 +0100
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        <devel@driverdev.osuosl.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>
Subject: [PATCH v4 3/9] media: adv748x: reduce amount of code for bitwise
 modifications of device registers
Message-ID: <88950969b1d16ff5fcd1b3458356c4cf5a9e6cff.1585218857.git.alexander.riesen@cetitec.com>
Mail-Followup-To: Alex Riesen <alexander.riesen@cetitec.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        devel@driverdev.osuosl.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <cover.1585218857.git.alexander.riesen@cetitec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1585218857.git.alexander.riesen@cetitec.com>
X-Originating-IP: [10.8.5.79]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
X-EsetResult: clean, is OK
X-EsetId: 37303A290D7F536A6D7C67
X-Provags-ID: V03:K1:YyRpucgDZcklgHG5kDe2//aOMtxra/UBP4MrhVIka4GbYm8nMk2
 i6OhcGVqaeP+tF2B8430VWPue2jRQ6wQ1jKlk0fdZc3KjEI8fkatDxvfSBOVwFsuWURTWP0
 SRH3mZh/mroXsGBdj6I9z8PqUpYQcHiEAHe0RiZNSGCfItVuyvz68vw55IKIvptkLmW+d6U
 uObAVwZ06M7IHhHitS6mQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bh27zTAUVoI=:pDIu0AHFKam/CTq4FmaoOQ
 1G7sSiQMiXz3IewKxrGVG8TLYe5lUGBgBtX4Bb6Rxd4KIDt9HxyDr90fEyzzIq1R8EV01STGZ
 vTlxfvjWja4uosMpJt0ss3LW/pz0d5PQbGz+E2HXOYd29JqqtCPT9avDejRD3uvXcs07zBGv8
 fbBXzgqq5CLGn0x4mYs4PilV/YixDbHW46mCdzVVNbFhQjPp42FDaQRqULzGlLcCNZJOpPWmI
 N8rnZ1zEzm2ok6i4k3eXLZuFeFnGeVezMa7lSMFhg/DeV4gtK+qPnGU+hhim/Jf8Qi8RIN34O
 pU4KjnY9dP86xQJ9tY+iuRCeRC1OtNE5jRpYrtsIAjAY65WIR6yEqNGKsHHgylYH62sHPkIcE
 zXXLCzl6HrLZCrdZB2aKZTaLdjtzEstzsQR9DUFfH3HgBEur1CVo9ZaSPGS4/D636LKXFebTu
 Et65FldFg9tcFgU4joBhACw4x/uV4UJ+C1vmrVeawC5sOgGS8GuvVkipPq7oPllq7uvi+rRBZ
 NAv8JPmbBgRo+ZY/kkCERYfjozQnhIJZmmyB5j8Di69FHfPhNBauWh1kWlruNZh48ifi9iyYd
 hBSqYZ4xhfmZtk71pVqqBXWINUCPgkLIXbSLtk23KeOE4LQFG2Sbk0bJPHdU4AoGfltAhUwlO
 DyEIqK2Kl6ij0BDQro96BqBXd1VqNWRhvI1/jS2HZOrGy91w+Iqoatghv3C29qpPqv7PvAQ7l
 pQT0LUV4VfSQnNj8RVMOFsL6DI4CZzmgpqC+SRB3DX8T/rITk01LshqUvNZucnLGsEMAPsvrR
 OQcC9qo6ztSOqW9psV012NlZkqVlHkjjqj74t+bWs1q7bzQNvT+8hBvc/mdiB0GPETNBRoN
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regmap provides a convenient utility for this.
The hdmi_* and dpll_* register modification macros added for symmetry
with the existing operations (io_*, sdp_*).

Signed-off-by: Alexander Riesen <alexander.riesen@cetitec.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

--
v3: remove _update name in favor of existing _clrset
---
 drivers/media/i2c/adv748x/adv748x-core.c |  6 ++++++
 drivers/media/i2c/adv748x/adv748x.h      | 14 +++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/adv748x/adv748x-core.c b/drivers/media/i2c/adv748x/adv748x-core.c
index 5c59aad319d1..8580e6624276 100644
--- a/drivers/media/i2c/adv748x/adv748x-core.c
+++ b/drivers/media/i2c/adv748x/adv748x-core.c
@@ -133,6 +133,12 @@ static int adv748x_write_check(struct adv748x_state *state, u8 page, u8 reg,
 	return *error;
 }
 
+int adv748x_update_bits(struct adv748x_state *state, u8 page, u8 reg, u8 mask,
+			u8 value)
+{
+	return regmap_update_bits(state->regmap[page], reg, mask, value);
+}
+
 /* adv748x_write_block(): Write raw data with a maximum of I2C_SMBUS_BLOCK_MAX
  * size to one or more registers.
  *
diff --git a/drivers/media/i2c/adv748x/adv748x.h b/drivers/media/i2c/adv748x/adv748x.h
index 09aab4138c3f..0a9d78c2870b 100644
--- a/drivers/media/i2c/adv748x/adv748x.h
+++ b/drivers/media/i2c/adv748x/adv748x.h
@@ -393,25 +393,33 @@ int adv748x_write(struct adv748x_state *state, u8 page, u8 reg, u8 value);
 int adv748x_write_block(struct adv748x_state *state, int client_page,
 			unsigned int init_reg, const void *val,
 			size_t val_len);
+int adv748x_update_bits(struct adv748x_state *state, u8 page, u8 reg,
+			u8 mask, u8 value);
 
 #define io_read(s, r) adv748x_read(s, ADV748X_PAGE_IO, r)
 #define io_write(s, r, v) adv748x_write(s, ADV748X_PAGE_IO, r, v)
-#define io_clrset(s, r, m, v) io_write(s, r, (io_read(s, r) & ~(m)) | (v))
+#define io_clrset(s, r, m, v) adv748x_update_bits(s, ADV748X_PAGE_IO, r, m, v)
 
 #define hdmi_read(s, r) adv748x_read(s, ADV748X_PAGE_HDMI, r)
 #define hdmi_read16(s, r, m) (((hdmi_read(s, r) << 8) | hdmi_read(s, (r)+1)) & (m))
 #define hdmi_write(s, r, v) adv748x_write(s, ADV748X_PAGE_HDMI, r, v)
+#define hdmi_clrset(s, r, m, v) \
+	adv748x_update_bits(s, ADV748X_PAGE_HDMI, r, m, v)
+
+#define dpll_read(s, r) adv748x_read(s, ADV748X_PAGE_DPLL, r)
+#define dpll_clrset(s, r, m, v) \
+	adv748x_update_bits(s, ADV748X_PAGE_DPLL, r, m, v)
 
 #define repeater_read(s, r) adv748x_read(s, ADV748X_PAGE_REPEATER, r)
 #define repeater_write(s, r, v) adv748x_write(s, ADV748X_PAGE_REPEATER, r, v)
 
 #define sdp_read(s, r) adv748x_read(s, ADV748X_PAGE_SDP, r)
 #define sdp_write(s, r, v) adv748x_write(s, ADV748X_PAGE_SDP, r, v)
-#define sdp_clrset(s, r, m, v) sdp_write(s, r, (sdp_read(s, r) & ~(m)) | (v))
+#define sdp_clrset(s, r, m, v) adv748x_update_bits(s, ADV748X_PAGE_SDP, r, m, v)
 
 #define cp_read(s, r) adv748x_read(s, ADV748X_PAGE_CP, r)
 #define cp_write(s, r, v) adv748x_write(s, ADV748X_PAGE_CP, r, v)
-#define cp_clrset(s, r, m, v) cp_write(s, r, (cp_read(s, r) & ~(m)) | (v))
+#define cp_clrset(s, r, m, v) adv748x_update_bits(s, ADV748X_PAGE_CP, r, m, v)
 
 #define tx_read(t, r) adv748x_read(t->state, t->page, r)
 #define tx_write(t, r, v) adv748x_write(t->state, t->page, r, v)
-- 
2.25.1.25.g9ecbe7eb18


