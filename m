Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD8FC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3574F21534
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598974790;
	bh=K7rQBmF2o/HDSQ0ZPX0Bc+/MKqPqW6lr/a49UeaCeTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hpF1uiqAXsAnCTihMD2sXQ7dNmTrw3XJlrxQvG42mLSLMvEqLFASQZIxm8y0Tztvz
	 4UTlg4N2PXdF7ciQ+iRi9kyhK2qgPVK5AS0fH9Df5JWzVoqroIJC00vSUuQjUGrgcq
	 wOiHot1e63Ydj5yUYPArtcgTGP4DcOdCNbC4hOj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731477AbgIAPjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:39:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731374AbgIAPh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:37:58 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62C4C20E65;
        Tue,  1 Sep 2020 15:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974677;
        bh=K7rQBmF2o/HDSQ0ZPX0Bc+/MKqPqW6lr/a49UeaCeTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lAtraqI2g35wlhSgDnIy8ifFYcfJiHPkYvwqyaamlkGVuzeZfT2HY6eIIvqUA+GcJ
         DlENX7K9dcoIh+wyvIlmLzL3+QsCkg/IUV8L6M4Fv+12ajVeI5WsyaOvf0rn+7aueG
         hKZzNR2z34x1LpETPKQLsbs5fyFD9VOt58xtlBu8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 022/255] platform/chrome: cros_ec_sensorhub: Fix EC timestamp overflow
Date:   Tue,  1 Sep 2020 17:07:58 +0200
Message-Id: <20200901151001.832235108@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gwendal Grignou <gwendal@chromium.org>

[ Upstream commit e48bc01ed5adec203676c735365373b31c3c7600 ]

EC is using 32 bit timestamps (us), and before converting it to 64bit
they were not casted, so it would overflow every 4s.
Regular overflow every ~70 minutes was not taken into account either.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/chrome/cros_ec_sensorhub_ring.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
index 24e48d96ed766..b1c641c72f515 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub_ring.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
@@ -419,9 +419,7 @@ cros_ec_sensor_ring_process_event(struct cros_ec_sensorhub *sensorhub,
 			 * Disable filtering since we might add more jitter
 			 * if b is in a random point in time.
 			 */
-			new_timestamp = fifo_timestamp -
-					fifo_info->timestamp  * 1000 +
-					in->timestamp * 1000;
+			new_timestamp = c - b * 1000 + a * 1000;
 			/*
 			 * The timestamp can be stale if we had to use the fifo
 			 * info timestamp.
-- 
2.25.1



