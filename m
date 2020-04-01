Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546F0C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD9A2137B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758318;
	bh=ju9jzuweHEC9zUnzeZroCg+THE1tuUWhorT4dxRQXn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VqMoUofXKgbMH5+eVxmW/NOGJdGCoS++ltVCi0rYakaA8M6KeS+RzHoro5JXvYJsv
	 XE1jqeyNgjVpGnYPl6sUL1pgsRqDFkuL6dqoDWPDJWwuFVGi2aqFRCZHLZPplnGezi
	 jDdp+TUosq08mSDZukaafrVu128mKZYRllW7U3fE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387776AbgDAQZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:25:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387553AbgDAQZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:25:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C10A820BED;
        Wed,  1 Apr 2020 16:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758301;
        bh=ju9jzuweHEC9zUnzeZroCg+THE1tuUWhorT4dxRQXn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xXSP3uh1WIOCpExuzna1k/aywoWaHzbxE8hQU0W7Hn6JcV67i1/kG+m6kgNgACAja
         5NG0oLKCBBBih0ygZC6vMQNsDhuKcaA3ryw0mJaOaJUZURRIyY4dSJI6SLJrjh5dGB
         +sQUOjdVdTP473fvukSYMEEmUNJ1rWUP7+N8tjCQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.19 048/116] Input: raydium_i2c_ts - fix error codes in raydium_i2c_boot_trigger()
Date:   Wed,  1 Apr 2020 18:17:04 +0200
Message-Id: <20200401161548.698182140@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161542.669484650@linuxfoundation.org>
References: <20200401161542.669484650@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 32cf3a610c35cb21e3157f4bbf29d89960e30a36 upstream.

These functions are supposed to return negative error codes but instead
it returns true on failure and false on success.  The error codes are
eventually propagated back to user space.

Fixes: 48a2b783483b ("Input: add Raydium I2C touchscreen driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/20200303101306.4potflz7na2nn3od@kili.mountain
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/touchscreen/raydium_i2c_ts.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -441,7 +441,7 @@ static int raydium_i2c_write_object(stru
 	return 0;
 }
 
-static bool raydium_i2c_boot_trigger(struct i2c_client *client)
+static int raydium_i2c_boot_trigger(struct i2c_client *client)
 {
 	static const u8 cmd[7][6] = {
 		{ 0x08, 0x0C, 0x09, 0x00, 0x50, 0xD7 },
@@ -466,10 +466,10 @@ static bool raydium_i2c_boot_trigger(str
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
@@ -492,7 +492,7 @@ static bool raydium_i2c_fw_trigger(struc
 		}
 	}
 
-	return false;
+	return 0;
 }
 
 static int raydium_i2c_check_path(struct i2c_client *client)


