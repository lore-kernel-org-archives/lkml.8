Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBFEC433F2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D28362078E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595858858;
	bh=RaFzk8/MP30nvxKII4UvXIlBJ607amNEXrGwQu6xw08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I1BaJ0OdwFIjs1lVXHW+lOe4epUcoeG40Nb4NGzsR3FpXNxm19IW7hA4vr41aP6rd
	 /7ZEK50iunmjC9kvmJ4HBWdHlng8vhlcP82V9J6I++2kfE8tVld+86R3QRArKQ6qNj
	 9fRN9xKRgYRc/SIJKCOV+WvAVYTxqytLPuepyKkE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbgG0OHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:07:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729240AbgG0OHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:07:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46B7E20775;
        Mon, 27 Jul 2020 14:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595858854;
        bh=RaFzk8/MP30nvxKII4UvXIlBJ607amNEXrGwQu6xw08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zIdkILiNKfUnGQZ1TwhVMoYbfPdDL5Sgc/CxoUNBvXVG8+LkV62JAyyzco3Jjwea1
         FQG/ZADl2X9niXjphrcCGRa1u07msTdKUg+XZgcX4yadp5rdr38e0QUp6Nw1sCEljp
         lA8ChB1tBhYVBkUDC0c7FmW4JFkF2/2XW9vnTAyo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 37/64] Input: add `SW_MACHINE_COVER`
Date:   Mon, 27 Jul 2020 16:04:16 +0200
Message-Id: <20200727134913.001039879@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134911.020675249@linuxfoundation.org>
References: <20200727134911.020675249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Merlijn Wajer <merlijn@wizzup.org>

[ Upstream commit c463bb2a8f8d7d97aa414bf7714fc77e9d3b10df ]

This event code represents the state of a removable cover of a device.
Value 0 means that the cover is open or removed, value 1 means that the
cover is closed.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
Link: https://lore.kernel.org/r/20200612125402.18393-2-merlijn@wizzup.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mod_devicetable.h        | 2 +-
 include/uapi/linux/input-event-codes.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index eba777807fc04..6f8eb1238235f 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -293,7 +293,7 @@ struct pcmcia_device_id {
 #define INPUT_DEVICE_ID_LED_MAX		0x0f
 #define INPUT_DEVICE_ID_SND_MAX		0x07
 #define INPUT_DEVICE_ID_FF_MAX		0x7f
-#define INPUT_DEVICE_ID_SW_MAX		0x0f
+#define INPUT_DEVICE_ID_SW_MAX		0x10
 #define INPUT_DEVICE_ID_PROP_MAX	0x1f
 
 #define INPUT_DEVICE_ID_MATCH_BUS	1
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 61769d4b7dbac..bce76e55a3c82 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -793,7 +793,8 @@
 #define SW_LINEIN_INSERT	0x0d  /* set = inserted */
 #define SW_MUTE_DEVICE		0x0e  /* set = device disabled */
 #define SW_PEN_INSERTED		0x0f  /* set = pen inserted */
-#define SW_MAX			0x0f
+#define SW_MACHINE_COVER	0x10  /* set = cover closed */
+#define SW_MAX			0x10
 #define SW_CNT			(SW_MAX+1)
 
 /*
-- 
2.25.1



