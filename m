Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7ADC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 01:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70588207F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 01:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="anZX3nB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgG3Bqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 21:46:36 -0400
Received: from crapouillou.net ([89.234.176.41]:45620 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgG3Bqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 21:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1596073593; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=Nkzm7+SJ8S0uEbvir2Ri0RhcYGlcBnAXNM+14mPSXL4=;
        b=anZX3nB5q5L6g50HathDLjTJiZbwhJK3gileOtgVQag/sofblzgPv/nmyQzVwaMjE8O6tN
        +DDSbOrRyAe5/uobD41naAIW5QU7xFz6u+AAaZMvLakumbkD5jzAj4B6JTU+z96WANmdSW
        gmvYh5toPPH6on/mMuh/Sy2gnUzXJNI=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     od@zcrc.me, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 0/3] More ingenic-drm IPU cleanups
Date:   Thu, 30 Jul 2020 03:46:23 +0200
Message-Id: <20200730014626.83895-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A few more patches to the ingenic-drm IPU driver.

Patch [1/3] fixes the behaviour on newer SoCs at high resolutions /
framerates.

Patch [2/3] drops YUV 4:2:2 support on the JZ4725B SoC because of what I
think is a hardware bug.

Patch [3/3] makes the IPU clock enabled/disabled when needed.

Cheers,
-Paul

Paul Cercueil (3):
  drm/ingenic: ipu: Only restart manually on older SoCs
  drm/ingenic: ipu: Remove YUV422 from supported formats on JZ4725B
  drm/ingenic: ipu: Only enable clock when needed

 drivers/gpu/drm/ingenic/ingenic-ipu.c | 38 +++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 5 deletions(-)

-- 
2.27.0

