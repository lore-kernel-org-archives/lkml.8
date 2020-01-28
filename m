Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DF4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEAC624691
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221457;
	bh=5YYtm9ma19c214WP3Vz1E0GoAaNZU29FxW2eDLaO3UI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TD2YaGSsy8KSrdKTDzS9/kJ83unlIeYgytguJHwzUF150xcoOVKKnuw9sOM8aOMC1
	 aU8LLVzKs+3K+2LumHD1PyBgPs1bWML3y8+HzY9F+9XHoA1oPhuorqqEA9aj0RN8yY
	 UpTZ1r8/dzdFzohd5ET4v03vu7Z8wMi4BSbAnBJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgA1OYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:24:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:50816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731405AbgA1OYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:24:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4860621739;
        Tue, 28 Jan 2020 14:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221452;
        bh=5YYtm9ma19c214WP3Vz1E0GoAaNZU29FxW2eDLaO3UI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ov0VIQwndMtRm4q57rK1Yu386ySAeoukLXNPavYY4HAaCcXaP/8tDYZUlel+Dh2DW
         b1JDUi0Yl+hVgJi7Yzi11bqVy5Om79P5hRPU1IOiCm/h6JKHdr245KlCzMVL95mnUw
         YfD3Ec9SSQX6lTRMS7idC7ZzTEJ7qOFv3D6zIQpc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 193/271] staging: greybus: light: fix a couple double frees
Date:   Tue, 28 Jan 2020 15:05:42 +0100
Message-Id: <20200128135906.949065403@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 329101244f214952606359d254ae883b7109e1a5 ]

The problem is in gb_lights_request_handler().  If we get a request to
change the config then we release the light with gb_lights_light_release()
and re-allocated it.  However, if the allocation fails part way through
then we call gb_lights_light_release() again.  This can lead to a couple
different double frees where we haven't cleared out the original values:

	gb_lights_light_v4l2_unregister(light);
	...
	kfree(light->channels);
	kfree(light->name);

I also made a small change to how we set "light->channels_count = 0;".
The original code handled this part fine and did not cause a use after
free but it was sort of complicated to read.

Fixes: 2870b52bae4c ("greybus: lights: add lights implementation")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Rui Miguel Silva <rmfrfs@gmail.com>
Link: https://lore.kernel.org/r/20190829122839.GA20116@mwanda
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/greybus/light.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
index 9f01427f35f91..1cb82cc28aa76 100644
--- a/drivers/staging/greybus/light.c
+++ b/drivers/staging/greybus/light.c
@@ -1102,21 +1102,21 @@ static void gb_lights_channel_release(struct gb_channel *channel)
 static void gb_lights_light_release(struct gb_light *light)
 {
 	int i;
-	int count;
 
 	light->ready = false;
 
-	count = light->channels_count;
-
 	if (light->has_flash)
 		gb_lights_light_v4l2_unregister(light);
+	light->has_flash = false;
 
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < light->channels_count; i++)
 		gb_lights_channel_release(&light->channels[i]);
-		light->channels_count--;
-	}
+	light->channels_count = 0;
+
 	kfree(light->channels);
+	light->channels = NULL;
 	kfree(light->name);
+	light->name = NULL;
 }
 
 static void gb_lights_release(struct gb_lights *glights)
-- 
2.20.1



