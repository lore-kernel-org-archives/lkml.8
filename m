Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFCEC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F6B2072E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579202056;
	bh=mmClsEUoJmFGhUgVgelqwouSevAanyCQLZZWcbL4ygk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hm6jilBfaWMFaNVwAnIaZNP1Q+tOb/VZCQu3o5v8bGpV6pGYhZuuHcBAwf0GWZ+lZ
	 WNg8WZRw0UzRAGen1n/yfNjqOtp0XgqMhQDMom0kQAPzs5G8J4Lfdn7A11ReDrykOW
	 SH0/V9pmw8hzNyOuQRE5JDIpwryRIUNFIizMs5yU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437508AbgAPTOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:14:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:42970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731461AbgAPQ4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:56:34 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7330F21582;
        Thu, 16 Jan 2020 16:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193794;
        bh=mmClsEUoJmFGhUgVgelqwouSevAanyCQLZZWcbL4ygk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=00Y6Tyq+CIAvVZ9q9L00JygsOFebmDjiQloxPRqrLvI8lyrg6HQIY/czVl4QPR1xv
         OLyeaXzis4CeDEErbbBydpD9wo/mq9lhHvqE5UXtHgAhb9WreJy+8bWjocpgM6FSRR
         +7pULGU5Bodlru9uoe+xutJ2LwL7fzODhI6x01Z8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 4.19 065/671] staging: bcm2835-camera: fix module autoloading
Date:   Thu, 16 Jan 2020 11:44:56 -0500
Message-Id: <20200116165502.8838-65-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165502.8838-1-sashal@kernel.org>
References: <20200116165502.8838-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Wahren <stefan.wahren@i2se.com>

[ Upstream commit 3a2c20024a2b47adbf514e7f3ab79342739c3926 ]

In order to make the module bcm2835-camera load automatically, we need to
add a module alias.

Fixes: 4bebb0312ea9 ("staging/bcm2835-camera: Set ourselves up as a platform driver.")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index 068e5b9ab232..edf25922b12d 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -47,6 +47,7 @@ MODULE_DESCRIPTION("Broadcom 2835 MMAL video capture");
 MODULE_AUTHOR("Vincent Sanders");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(BM2835_MMAL_VERSION);
+MODULE_ALIAS("platform:bcm2835-camera");
 
 int bcm2835_v4l2_debug;
 module_param_named(debug, bcm2835_v4l2_debug, int, 0644);
-- 
2.20.1

