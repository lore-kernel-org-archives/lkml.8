Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DA5C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03D5D20663
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="EW0ScNjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbgG1PQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:16:51 -0400
Received: from crapouillou.net ([89.234.176.41]:38744 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730586AbgG1PQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1595949408; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=w4oYRintr6C09zqyRCO+Nd06xt5Y8NV9/ZwsT/feY0w=;
        b=EW0ScNjIk/KEALxQPnhcecrCSLlEVsahz77Yp+ATZSDpgpqoQ2QXNm39OKSKsSIAV90Qtk
        mY48JXKZp07qlEYONVhHzLvtdxCuVHbwru1FRbiNHqwkzZMQEtCiHGhydtN7vELiqv2HRp
        rbxY1NtIDh0/x5iZoGwYfa3FTyQcRJw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 0/2] Small cleanups to ingenic-drm driver
Date:   Tue, 28 Jul 2020 17:16:39 +0200
Message-Id: <20200728151641.26124-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a few cleanups to the ingenic-drm driver.
- some error paths were missing and have been added;
- the mode validation has been moved to the .mode_valid helper callback.

Cheers,
-Paul

Paul Cercueil (2):
  drm/ingenic: Handle errors of drm_atomic_get_plane_state
  drm/ingenic: Validate mode in a .mode_valid callback

 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 41 +++++++++++++++--------
 1 file changed, 27 insertions(+), 14 deletions(-)

-- 
2.27.0

