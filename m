Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FA6C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B3A20721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580748448;
	bh=hKiHU1a63UxaLAHfhkLxunuN0U4UHhCWDSp0Il/mFMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qwaHDxxb0Yy/2qVSu2voGLu+Nr5oeN2wkAy+lSfXCY+f7NX/7NOFJ1I+I30f25bvK
	 EdYarmIDxfN0++VfcBcdvg12oF6EcdMgBPC/r2DOaS+AccNX5yap5mAOy521zI+1Nw
	 Fa+SfxJzBvd7C1+5xqGFiWvwbmHJjzfwd1NA84IA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbgBCQ11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:27:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:38678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728526AbgBCQ1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:27:24 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 900E02086A;
        Mon,  3 Feb 2020 16:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747244;
        bh=hKiHU1a63UxaLAHfhkLxunuN0U4UHhCWDSp0Il/mFMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q0qV/7Qk6MHXsFoOzGzdtKqqlfGxGHFcJ8CJ0tVfEix9mcqbJWgZ0jn9QONk1uFO7
         b0U8csIWPNGe4dEjO8/bQlSDTbYg1YqGE6iJcxANupmy2xMj6abZ3hJ9dK+0o3UygQ
         ax6Hmb8z9plfBLCIww5nSuqw/Ep+wZ2ZjP4Cug2k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Vladis Dronov <vdronov@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 51/68] Input: aiptek - use descriptors of current altsetting
Date:   Mon,  3 Feb 2020 16:19:47 +0000
Message-Id: <20200203161913.376134472@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161904.705434837@linuxfoundation.org>
References: <20200203161904.705434837@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

[ Upstream commit cfa4f6a99fb183742cace65ec551b444852b8ef6 ]

Make sure to always use the descriptors of the current alternate setting
to avoid future issues when accessing fields that may differ between
settings.

Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Vladis Dronov <vdronov@redhat.com>
Link: https://lore.kernel.org/r/20191210113737.4016-4-johan@kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/tablet/aiptek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
index 5a7e5e073e526..3b5bccad4a1bb 100644
--- a/drivers/input/tablet/aiptek.c
+++ b/drivers/input/tablet/aiptek.c
@@ -1733,7 +1733,7 @@ aiptek_probe(struct usb_interface *intf, const struct usb_device_id *id)
 
 	aiptek->inputdev = inputdev;
 	aiptek->intf = intf;
-	aiptek->ifnum = intf->altsetting[0].desc.bInterfaceNumber;
+	aiptek->ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
 	aiptek->inDelay = 0;
 	aiptek->endDelay = 0;
 	aiptek->previousJitterable = 0;
-- 
2.20.1



