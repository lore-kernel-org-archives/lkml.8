Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018A1C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD27920838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgBXRjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:39:12 -0500
Received: from mailoutvs35.siol.net ([185.57.226.226]:51130 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726208AbgBXRjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:39:12 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 4ED395236B9;
        Mon, 24 Feb 2020 18:39:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ffxPlucRGbIH; Mon, 24 Feb 2020 18:39:09 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 03FBE5236BE;
        Mon, 24 Feb 2020 18:39:09 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 689AB5236B9;
        Mon, 24 Feb 2020 18:39:07 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] drm/sun4i: de2/de3 format fixes and updates
Date:   Mon, 24 Feb 2020 18:38:54 +0100
Message-Id: <20200224173901.174016-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently VI layer code reported wrong formats for DE2 and DE3. First
three patches are fixes. Next two patches do code refactoring to remove
redundant information, which is already included elsewhere. Last two
patches are more cosmetic.

Note: It can be argued if patch 2 is really a fix. Consider that if only
patch 1 and 3 go into stable, wrong formats will be reported for DE3 VI
layers.

Please take a look.

Best regards,
Jernej

Jernej Skrabec (7):
  drm/sun4i: de2/de3: Remove unsupported VI layer formats
  drm/sun4i: Add separate DE3 VI layer formats
  drm/sun4i: Fix DE2 VI layer format support
  drm/sun4i: de2: rgb field in de2 format struct is redundant
  drm/sun4i: de2: csc_mode in de2 format struct is mostly redundant
  drm/sun4i: de2: Don't return de2_fmt_info struct
  drm/sun4i: Sort includes in VI and UI layer code

 drivers/gpu/drm/sun4i/sun8i_mixer.c    | 159 ++++++++++++-------------
 drivers/gpu/drm/sun4i/sun8i_mixer.h    |  21 ++--
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c |  14 ++-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 106 ++++++++++++++---
 4 files changed, 183 insertions(+), 117 deletions(-)

--=20
2.25.1

