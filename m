Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D201DC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2B4820771
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595373536;
	bh=jgxeKDe5MNOpYYMOtcJM8ALY4dU7KDpKVj4adYMGaPk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ih3KrOu5D0izI+pbGfzzFM4Qhdo94Z84rClLCQjfBoS8TQaVIz4PrhLXUjT3OKJmK
	 R3VOMBwGoPXFYESemvbpRS4v3vYg+IXZmKoQf44OclUO9MPYIdCXOg/4SM+2vPsFKk
	 0hOLpdcg8vnnHkh82zCjHLhOE2cN8dkgixD8py3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731406AbgGUXSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 19:18:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:38666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgGUXSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 19:18:55 -0400
Received: from embeddedor (unknown [201.162.241.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A22CA20709;
        Tue, 21 Jul 2020 23:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595373534;
        bh=jgxeKDe5MNOpYYMOtcJM8ALY4dU7KDpKVj4adYMGaPk=;
        h=Date:From:To:Cc:Subject:From;
        b=t3rSwvnzgx2VO5BXKSh9/+8ZDwI4OFrH2SG4weoiT1rBPEcudzj5I+YgfYso79oJN
         kQkWQTzfZ/0phFDqU68eKf+zKS68U8NIztFtd9JGWfy7aWt8O//YutcqTm+q2BfORf
         GWKt7BbLiZfnUU+vXNBQVQV0L+PTk2kjTuWM2J+Y=
Date:   Tue, 21 Jul 2020 18:24:32 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2][next] i2c: mv64xxx: Use fallthrough pseudo-keyword
Message-ID: <20200721232432.GA2020@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the existing /* fall through */ comments and its variants with
the new pseudo-keyword macro fallthrough[1].

[1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Update URL. Use proper URL to Linux v5.7 documentation.
 - Add Gregory's Reviewed-by tag.

 drivers/i2c/busses/i2c-mv64xxx.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 829b8c98ae51..8d9d4ffdcd24 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -251,7 +251,7 @@ mv64xxx_i2c_fsm(struct mv64xxx_i2c_data *drv_data, u32 status)
 				MV64XXX_I2C_STATE_WAITING_FOR_ADDR_2_ACK;
 			break;
 		}
-		/* FALLTHRU */
+		fallthrough;
 	case MV64XXX_I2C_STATUS_MAST_WR_ADDR_2_ACK: /* 0xd0 */
 	case MV64XXX_I2C_STATUS_MAST_WR_ACK: /* 0x28 */
 		if ((drv_data->bytes_left == 0)
@@ -282,14 +282,14 @@ mv64xxx_i2c_fsm(struct mv64xxx_i2c_data *drv_data, u32 status)
 				MV64XXX_I2C_STATE_WAITING_FOR_ADDR_2_ACK;
 			break;
 		}
-		/* FALLTHRU */
+		fallthrough;
 	case MV64XXX_I2C_STATUS_MAST_RD_ADDR_2_ACK: /* 0xe0 */
 		if (drv_data->bytes_left == 0) {
 			drv_data->action = MV64XXX_I2C_ACTION_SEND_STOP;
 			drv_data->state = MV64XXX_I2C_STATE_IDLE;
 			break;
 		}
-		/* FALLTHRU */
+		fallthrough;
 	case MV64XXX_I2C_STATUS_MAST_RD_DATA_ACK: /* 0x50 */
 		if (status != MV64XXX_I2C_STATUS_MAST_RD_DATA_ACK)
 			drv_data->action = MV64XXX_I2C_ACTION_CONTINUE;
@@ -417,8 +417,7 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
 			"mv64xxx_i2c_do_action: Invalid action: %d\n",
 			drv_data->action);
 		drv_data->rc = -EIO;
-
-		/* FALLTHRU */
+		fallthrough;
 	case MV64XXX_I2C_ACTION_SEND_STOP:
 		drv_data->cntl_bits &= ~MV64XXX_I2C_REG_CONTROL_INTEN;
 		writel(drv_data->cntl_bits | MV64XXX_I2C_REG_CONTROL_STOP,
-- 
2.27.0

