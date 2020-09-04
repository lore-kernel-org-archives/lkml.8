Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552EFC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 21:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 172F62098B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 21:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgIDVwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 17:52:00 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:50934 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728161AbgIDVv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 17:51:57 -0400
Received: from [78.134.95.246] (port=33500 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1kEJch-0004Q2-3K; Fri, 04 Sep 2020 23:51:55 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-media@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 3/3] media: docs: v4l2-subdev: move generic paragraph to the introduction
Date:   Fri,  4 Sep 2020 23:51:41 +0200
Message-Id: <20200904215141.20862-3-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904215141.20862-1-luca@lucaceresoli.net>
References: <20200904215141.20862-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This paragraph provides generic information to explain what v4l2_subdev is
useful for. Placing it in the middle of paragraphs describing the details
of subdev registration does not make much sense. Move it near the beginning
of the section when the v4l2_subdev idea has just been introduced and
before going into its details.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 Documentation/driver-api/media/v4l2-subdev.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/driver-api/media/v4l2-subdev.rst b/Documentation/driver-api/media/v4l2-subdev.rst
index fb66163deb38..1c1e3f9da142 100644
--- a/Documentation/driver-api/media/v4l2-subdev.rst
+++ b/Documentation/driver-api/media/v4l2-subdev.rst
@@ -12,6 +12,12 @@ Usually these are I2C devices, but not necessarily. In order to provide the
 driver with a consistent interface to these sub-devices the
 :c:type:`v4l2_subdev` struct (v4l2-subdev.h) was created.
 
+The advantage of using :c:type:`v4l2_subdev` is that it is a generic struct and
+does not contain any knowledge about the underlying hardware. So a driver might
+contain several subdevs that use an I2C bus, but also a subdev that is
+controlled through GPIO pins. This distinction is only relevant when setting
+up the device, but once the subdev is registered it is completely transparent.
+
 Each sub-device driver must have a :c:type:`v4l2_subdev` struct. This struct
 can be stand-alone for simple sub-devices or it might be embedded in a larger
 struct if more state information needs to be stored. Usually there is a
@@ -235,12 +241,6 @@ it can call ``v4l2_subdev_notify(sd, notification, arg)``. This macro checks
 whether there is a ``notify()`` callback defined and returns ``-ENODEV`` if not.
 Otherwise the result of the ``notify()`` call is returned.
 
-The advantage of using :c:type:`v4l2_subdev` is that it is a generic struct and
-does not contain any knowledge about the underlying hardware. So a driver might
-contain several subdevs that use an I2C bus, but also a subdev that is
-controlled through GPIO pins. This distinction is only relevant when setting
-up the device, but once the subdev is registered it is completely transparent.
-
 In the **asynchronous** case subdevice probing can be invoked independently of
 the bridge driver availability. The subdevice driver then has to verify whether
 all the requirements for a successful probing are satisfied. This can include a
-- 
2.28.0

