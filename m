Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB19C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FEFC20708
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgGIIC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:02:28 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:55959 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgGIICL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 04:02:11 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 70E56E000E;
        Thu,  9 Jul 2020 08:02:09 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-i3c@lists.infradead.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Conor Culhane <conor.culhane@silvaco.com>,
        Rajeev Huralikoppi <rajeev.huralikoppi@silvaco.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 4/4] MAINTAINERS: Add Silvaco I3C master
Date:   Thu,  9 Jul 2020 10:01:59 +0200
Message-Id: <20200709080159.2178-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200709080159.2178-1-miquel.raynal@bootlin.com>
References: <20200709080159.2178-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Conor and myself as maintainers.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 496fd4eafb68..7e44a06fd5da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15587,6 +15587,14 @@ S:	Maintained
 F:	Documentation/fb/sm712fb.rst
 F:	drivers/video/fbdev/sm712*
 
+SILVACO I3C DUAL-ROLE MASTER
+M:	Miquel Raynal <miquel.raynal@bootlin.com>
+M:	Conor Culhane <conor.culhane@silvaco.com>
+L:	linux-i3c@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/i3c/svc,i3c-master.yaml
+F:	drivers/i3c/master/svc-i3c-master.c
+
 SIMPLE FIRMWARE INTERFACE (SFI)
 S:	Obsolete
 W:	http://simplefirmware.org/
-- 
2.20.1

