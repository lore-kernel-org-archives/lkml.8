Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7BCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6626820663
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594135730;
	bh=QHZHaMRGai+vdVgWa6RY1S8eqxxr2yVw5NNDIaD0tBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=as3x5DarHyFfBF8lgN1eOnJ57+QMC1W9uwkW3hwbOfDHWmH3vRAi6oTiBu0se1Wb8
	 /TPLmiWx7l5wStx1Gkbmto80Bh1SOi74rR+mwHG9D4b2Ya2F30JvPMuUtgMidPg+fo
	 bdha+7cISVfwxCwiQbuiBsT12i6DXhYJuxbwM9yk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbgGGP2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:28:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729856AbgGGPZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:25:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A5662078D;
        Tue,  7 Jul 2020 15:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594135544;
        bh=QHZHaMRGai+vdVgWa6RY1S8eqxxr2yVw5NNDIaD0tBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TtCJh2DWra6aCOmHTcJRlHxEQjWvWrzv2+inlaQDmYrrTeuA1CEdTprroxsAdqCA4
         SVoNqqphn6qBv33xYc8KeW5NY7oF6rLLE62FmOpXfTXDvMgbkoSSTtDkdZLiujrmJ4
         f+3rJabw3QPO+MsfzV2Y4aBJfz0K4RkHZmbWD794=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Michael Shych <michaelsh@mellanox.com>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 083/112] i2c: mlxcpld: check correct size of maximum RECV_LEN packet
Date:   Tue,  7 Jul 2020 17:17:28 +0200
Message-Id: <20200707145804.931875973@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145800.925304888@linuxfoundation.org>
References: <20200707145800.925304888@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit 597911287fcd13c3a4b4aa3e0a52b33d431e0a8e ]

I2C_SMBUS_BLOCK_MAX defines already the maximum number as defined in the
SMBus 2.0 specs. I don't see a reason to add 1 here. Also, fix the errno
to what is suggested for this error.

Fixes: c9bfdc7c16cb ("i2c: mlxcpld: Add support for smbus block read transaction")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Michael Shych <michaelsh@mellanox.com>
Tested-by: Michael Shych <michaelsh@mellanox.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-mlxcpld.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mlxcpld.c b/drivers/i2c/busses/i2c-mlxcpld.c
index 2fd717d8dd30e..71d7bae2cbcad 100644
--- a/drivers/i2c/busses/i2c-mlxcpld.c
+++ b/drivers/i2c/busses/i2c-mlxcpld.c
@@ -337,9 +337,9 @@ static int mlxcpld_i2c_wait_for_tc(struct mlxcpld_i2c_priv *priv)
 		if (priv->smbus_block && (val & MLXCPLD_I2C_SMBUS_BLK_BIT)) {
 			mlxcpld_i2c_read_comm(priv, MLXCPLD_LPCI2C_NUM_DAT_REG,
 					      &datalen, 1);
-			if (unlikely(datalen > (I2C_SMBUS_BLOCK_MAX + 1))) {
+			if (unlikely(datalen > I2C_SMBUS_BLOCK_MAX)) {
 				dev_err(priv->dev, "Incorrect smbus block read message len\n");
-				return -E2BIG;
+				return -EPROTO;
 			}
 		} else {
 			datalen = priv->xfer.data_len;
-- 
2.25.1



