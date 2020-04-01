Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0F7C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0146D206F8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759090;
	bh=SLuziyPDhy/Krr1/3ovv/97FsHO/PgRPxTZKFAYm9Mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AqpQlzBFFwqc3SaGvc5nAxfb5/VPo+5R29EBeW61roGBobZSk5K1zJjuX0sLYj3Zx
	 8uqEHgQc4bPbFg4Lhi5UySsMenc9wqoC465e0rga31+4r4v0dCypHQdCtKS99fwajg
	 KAjLUbN3mjheO6liWwXP2TgHD18hnwlmDPtdrYao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388911AbgDAQiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:38:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388751AbgDAQiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:38:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A764E20772;
        Wed,  1 Apr 2020 16:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759086;
        bh=SLuziyPDhy/Krr1/3ovv/97FsHO/PgRPxTZKFAYm9Mc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jLvPAOa9gQHMD/POCaeggS9ebTkPdlMHz58EjSBfgJoPcHzF4IoJ8urjMLbCTPaBa
         jKM5NFeBTr6H4R8OnfAoGu4Lo8DHk9i9Bxu+OovXovzyZcBMuQ9GqjZ7TiL0w0/9kp
         ZdKrAYlUfmB7imfISiHHiA1qRiMXRZEVTrspuqFA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 072/102] Input: raydium_i2c_ts - fix error codes in raydium_i2c_boot_trigger()
Date:   Wed,  1 Apr 2020 18:18:15 +0200
Message-Id: <20200401161544.760720853@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161530.451355388@linuxfoundation.org>
References: <20200401161530.451355388@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 32cf3a610c35cb21e3157f4bbf29d89960e30a36 ]

These functions are supposed to return negative error codes but instead
it returns true on failure and false on success.  The error codes are
eventually propagated back to user space.

Fixes: 48a2b783483b ("Input: add Raydium I2C touchscreen driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/20200303101306.4potflz7na2nn3od@kili.mountain
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/touchscreen/raydium_i2c_ts.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index 76cdc145c0912..1f5b6b5b1018a 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -441,7 +441,7 @@ static int raydium_i2c_write_object(struct i2c_client *client,
 	return 0;
 }
 
-static bool raydium_i2c_boot_trigger(struct i2c_client *client)
+static int raydium_i2c_boot_trigger(struct i2c_client *client)
 {
 	static const u8 cmd[7][6] = {
 		{ 0x08, 0x0C, 0x09, 0x00, 0x50, 0xD7 },
@@ -466,10 +466,10 @@ static bool raydium_i2c_boot_trigger(struct i2c_client *client)
 		}
 	}
 
-	return false;
+	return 0;
 }
 
-static bool raydium_i2c_fw_trigger(struct i2c_client *client)
+static int raydium_i2c_fw_trigger(struct i2c_client *client)
 {
 	static const u8 cmd[5][11] = {
 		{ 0, 0x09, 0x71, 0x0C, 0x09, 0x00, 0x50, 0xD7, 0, 0, 0 },
@@ -492,7 +492,7 @@ static bool raydium_i2c_fw_trigger(struct i2c_client *client)
 		}
 	}
 
-	return false;
+	return 0;
 }
 
 static int raydium_i2c_check_path(struct i2c_client *client)
-- 
2.20.1



