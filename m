Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DA4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAA3121924
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592578718;
	bh=Rf+/owul+CG1XcnLh7G/H67RI/5knus/0Lkvl89ilTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YVZ+F/XL7Z+2MG5/PoqNw9ZfeAc0yizbUGcW5avYhiRZzf6R5zZGvPLBlr+rL3+io
	 Cc7NlqXQsdfMwMNMwHcaLNFvQhnKBA25n66NhCmSzm2IQ2dIkffdZvhO+qqA3cumP+
	 dOLEsYzdwBBTKPI+OxrIG+wL44+FelQY9/q7qFVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389987AbgFSO6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:58:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:54172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390384AbgFSO6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:58:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA24221852;
        Fri, 19 Jun 2020 14:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578704;
        bh=Rf+/owul+CG1XcnLh7G/H67RI/5knus/0Lkvl89ilTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cISw6pGZP+OHlRAnUNS+gT/vCjY0KTtMwfXmy61k4qBFcVn82AHpr62ciAGtIUmJG
         J1n4JChA+nkFEOMUtVI1MQR5Nl+wSc2H38wRbO+BylPhY9MgXLYWfmY+EE4mGFf7hX
         5jSyfC5wJHoxD9o6aXxVqbCc9g5DFRJKU5QE1UN0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bogdan Togorean <bogdan.togorean@analog.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 094/267] drm: bridge: adv7511: Extend list of audio sample rates
Date:   Fri, 19 Jun 2020 16:31:19 +0200
Message-Id: <20200619141653.377605203@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bogdan Togorean <bogdan.togorean@analog.com>

[ Upstream commit b97b6a1f6e14a25d1e1ca2a46c5fa3e2ca374e22 ]

ADV7511 support sample rates up to 192kHz. CTS and N parameters should
be computed accordingly so this commit extend the list up to maximum
supported sample rate.

Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200413113513.86091-2-bogdan.togorean@analog.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_audio.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
index 1b4783d45c53..3a218b56a008 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
@@ -20,13 +20,15 @@ static void adv7511_calc_cts_n(unsigned int f_tmds, unsigned int fs,
 {
 	switch (fs) {
 	case 32000:
-		*n = 4096;
+	case 48000:
+	case 96000:
+	case 192000:
+		*n = fs * 128 / 1000;
 		break;
 	case 44100:
-		*n = 6272;
-		break;
-	case 48000:
-		*n = 6144;
+	case 88200:
+	case 176400:
+		*n = fs * 128 / 900;
 		break;
 	}
 
-- 
2.25.1



