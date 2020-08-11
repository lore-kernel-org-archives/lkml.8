Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AEDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 00:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E38D20734
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 00:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="b0kw9AqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgHKAWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 20:22:53 -0400
Received: from crapouillou.net ([89.234.176.41]:38556 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725969AbgHKAWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 20:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1597105370; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=6HpYuenQaNHxSqUID5eIAEraqgAyWkjcmY0PScFv6AU=;
        b=b0kw9AqL7sEZAw2Xo2MLNe4qjsR78FVvun91EhjAYavWPJaID7P91cbGBx7muQK07wjgB+
        T1BOXFtRWCJqZtZ6OspMDoVWxTUSP7M0vdnR/K0qoTqhQDfRgTmdiWhWfqs5Kbr/RLAguu
        twSOPR+FIYm/NawNXz1TyQnuE3Y+Mhs=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 0/5] drm/panel: A few cleanups and improvements
Date:   Tue, 11 Aug 2020 02:22:35 +0200
Message-Id: <20200811002240.55194-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

Here's a list of 5 patches that bring some cleanups and improvements.

Patches 1-2 clean up the novatek,nt39016 code to remove custom handling
of the backlight and to add the missing carriage returns on error
messages.

Patches 3-5 updates the modes list of the sharp,ls020b1dd01d panel, to
make it use 'struct drm_display_mode' instead of 'struct
display_timing', modify the timings to get a perfect 60.00 Hz rate, and
add a 50 Hz mode.

Cheers,
-Paul

Paul Cercueil (5):
  drm/panel: novatek,nt39016: Handle backlight the standard way
  drm/panel: novatek,nt39016: Add missing CR to error messages
  drm/panel: simple: Convert sharp,ls020b1dd01d from timings to
    videomode
  drm/panel: simple: Tweak timings of sharp,ls020b1dd01d for perfect
    60Hz
  drm/panel: simple: Add 50Hz mode for sharp,ls020b1dd01d

 drivers/gpu/drm/panel/panel-novatek-nt39016.c | 34 ++++++----------
 drivers/gpu/drm/panel/panel-simple.c          | 40 +++++++++++++------
 2 files changed, 40 insertions(+), 34 deletions(-)

-- 
2.28.0

