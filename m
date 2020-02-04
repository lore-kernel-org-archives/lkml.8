Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A24C3524B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 23:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2729B21582
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 23:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYh6UQgl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgBDXuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 18:50:06 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40907 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbgBDXuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 18:50:01 -0500
Received: by mail-pg1-f195.google.com with SMTP id z7so1692404pgk.7;
        Tue, 04 Feb 2020 15:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AS+AHCuMQWIyLmWzD2RHQ/sZnkJFO9p0vLnea6pI0u8=;
        b=hYh6UQglDyvaKYQeoKHsdmWZDC9Ai1KCxDg3WYXA9VUoIowzCd1/P6UT9SMrmLJ9J6
         zmZLaE8LW+fcVnqRkgciwC0EHLKMyKBa62O/YFOfRpFD5vCgBpHzvkxHAMwjOUVIgnXn
         +cen+/dstiaG4sNS5cmApv/Gx6wAY7OwnfcsrC6Pir6ldHJIq9apbj31QSKJ6KbBlhFa
         boTTc75UybNSR9VaCqbdiRREHhq0s1gEshNYeWi8W1CG6zZkLHM3rYmQKCkR63OvtH6N
         ITzHMiADkTEhkwjX73xm3W2sOmqCQi+pgqx0kPpGobHhWbGeU3dXVaqJf/pQtTLGolZu
         Tm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AS+AHCuMQWIyLmWzD2RHQ/sZnkJFO9p0vLnea6pI0u8=;
        b=YP48QzN9ZzeP3W63m0mAMEM8OdvzmvFILi5mVgkSHzKXvXAK1DGtz15NWCdJVfyccY
         BTQC7Zx7BJHheD3SH8jy8BA3ydO/nm0zaOdTHiK6jvbwWULEPl7vFzftoPOCzuUkJgu5
         qfsnK72KB4YEOVpQh/ey56+bEKLCe+pyd2Ui9ZVDKahTHiaBGz7LQ8DkHCpR8RsrJhVd
         I8CWJBsSJCd/2DBk5XhfTXT+3cUDWgBM1tR4iyLPZ5+6ULByp7LBdZx/iGj1D3sEXN6o
         Y01b43HEMZvLflFqElHVMEk9PynmtKINxSOGNTtg65n6E04U0i6q0mpVSj8l1XEvvqej
         Mm/Q==
X-Gm-Message-State: APjAAAW09j6Ecyi+5BCbHMa3g96X4HS5F7zle55zR37+vFSqSxj0kTRD
        gf+a4MZTg8clpoQ+5wZ/tBDP0ETz
X-Google-Smtp-Source: APXvYqw+LeZ+qTjjKIp+K4eK8tkRC8y+Os5q6ehTK/O9/49qCRcVeb3fbdOVA6rXi8JN5rFy3XdDeA==
X-Received: by 2002:a63:7949:: with SMTP id u70mr33314977pgc.233.1580860200115;
        Tue, 04 Feb 2020 15:50:00 -0800 (PST)
Received: from majic.sklembedded.com (c-73-202-231-77.hsd1.ca.comcast.net. [73.202.231.77])
        by smtp.googlemail.com with ESMTPSA id u2sm24607929pgj.7.2020.02.04.15.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 15:49:59 -0800 (PST)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org, Rui Miguel Silva <rmfrfs@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 17/17] media: imx: TODO: Remove media link creation todos
Date:   Tue,  4 Feb 2020 15:49:18 -0800
Message-Id: <20200204234918.20425-18-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200204234918.20425-1-slongerbeam@gmail.com>
References: <20200204234918.20425-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the TODO items regarding media link creation, these issues are
resolved by moving media link creation to individual entity bound
callbacks and the implementation of the get_fwnode_pad operation.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
 drivers/staging/media/imx/TODO | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/drivers/staging/media/imx/TODO b/drivers/staging/media/imx/TODO
index 6f29b5ca5324..a371cdedcdb0 100644
--- a/drivers/staging/media/imx/TODO
+++ b/drivers/staging/media/imx/TODO
@@ -17,35 +17,6 @@
   decided whether this feature is useful enough to make it generally
   available by exporting to v4l2-core.
 
-- After all async subdevices have been bound, v4l2_fwnode_parse_link()
-  is used to form the media links between the devices discovered in
-  the OF graph.
-
-  While this approach allows support for arbitrary OF graphs, there
-  are some assumptions for this to work:
-
-  1. If a port owned by a device in the graph has endpoint nodes, the
-     port is treated as a media pad.
-
-     This presents problems for devices that don't make this port = pad
-     assumption. Examples are SMIAPP compatible cameras which define only
-     a single output port node, but which define multiple pads owned
-     by multiple subdevices (pixel-array, binner, scaler). Or video
-     decoders (entity function MEDIA_ENT_F_ATV_DECODER), which also define
-     only a single output port node, but define multiple pads for video,
-     VBI, and audio out.
-
-     A workaround at present is to set the port reg properties to
-     correspond to the media pad index that the port represents. A
-     possible long-term solution is to implement a subdev API that
-     maps a port id to a media pad index.
-
-  2. Every endpoint of a port owned by a device in the graph is treated
-     as a media link.
-
-     Which means a port must not contain mixed-use endpoints, they
-     must all refer to media links between V4L2 subdevices.
-
 - i.MX7: all of the above, since it uses the imx media core
 
 - i.MX7: use Frame Interval Monitor
-- 
2.17.1

