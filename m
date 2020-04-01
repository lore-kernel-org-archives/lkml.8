Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CB2C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813C020857
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759095;
	bh=ctrYX3pfBTM62WA3edoDko5eDSVbvGqOt2cG3g/6zwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HNoasymv9ExnocpfDCzbSzxC9+DfW9dX2G2NkRvPN+FLt8o++EF7Y3yv451G/8wTf
	 y9K5Fq/BWAoNRwciEQkvxsdT1ymuiwe2GqzcDTs4QJB24ZBUB3BMkthoHCzE/mGMZR
	 Bt3/Jr+/fW+63EhHqKjSMhtPaTLoxgAmov7xpFPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389079AbgDAQiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:38:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389055AbgDAQiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:38:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25D05214DB;
        Wed,  1 Apr 2020 16:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759083;
        bh=ctrYX3pfBTM62WA3edoDko5eDSVbvGqOt2cG3g/6zwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gRPI5tR0qlzBgnnl7mMjTE5A+hSv5440jTV42tnB9meLMNjh47y2Kr1ybo/VCXe/H
         vzZZpV5af+TqPH9wYtn6rcsyhJx2PHYqJTXRgOEtygoT4LH1gd3O1gLCtmBJMAxXpz
         yTdj+PdlPkf2uZCQVkjyfeL0MI/07+X65dqQimgs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 071/102] Input: raydium_i2c_ts - use true and false for boolean values
Date:   Wed,  1 Apr 2020 18:18:14 +0200
Message-Id: <20200401161544.665703693@linuxfoundation.org>
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

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

[ Upstream commit 6cad4e269e25dddd7260a53e9d9d90ba3a3cc35a ]

Return statements in functions returning bool should use true or false
instead of an integer value.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/touchscreen/raydium_i2c_ts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index a99fb5cac5a0e..76cdc145c0912 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -466,7 +466,7 @@ static bool raydium_i2c_boot_trigger(struct i2c_client *client)
 		}
 	}
 
-	return 0;
+	return false;
 }
 
 static bool raydium_i2c_fw_trigger(struct i2c_client *client)
@@ -492,7 +492,7 @@ static bool raydium_i2c_fw_trigger(struct i2c_client *client)
 		}
 	}
 
-	return 0;
+	return false;
 }
 
 static int raydium_i2c_check_path(struct i2c_client *client)
-- 
2.20.1



