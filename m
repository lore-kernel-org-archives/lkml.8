Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890FCC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5566E208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585044947;
	bh=cL0BLqma9/afGrVRw6wv2HjXvWZfwS9SlngDwmWrnZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JASv/P2INZDiGv5E1otaBDWnPm5KtatEbDiEXd+VTTMvy9QGnnY22yz9X1xsLzdUT
	 zpmNUZfR0HdDQrxV0EiNuqCd9f4zYznR1CXVASo9dZ4qXDJ4zpmjePo9yaVakydL3v
	 wyXH0Y9m4bYx1gTS5xzdTvlVygMz71krRaXGZ0RI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgCXKPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:15:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727223AbgCXKPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:15:24 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C28A208C3;
        Tue, 24 Mar 2020 10:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585044924;
        bh=cL0BLqma9/afGrVRw6wv2HjXvWZfwS9SlngDwmWrnZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xaMrM1WJqlhassxyORzCJF4GD78bOdmVw79ntqzgrNzlUKFm5JSQFjoK7d1PoDiv7
         WRhOWhT1pfotXHEB4EXzgeRLV5bXLK+30mTxdugaQghn1jWrnWJ5wjHu3iqS+Ny5Ix
         ELl4W0WrNUN1O6I/1usSDwT8dur9/FWElu10ut/k=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jGgag-001pjd-BX; Tue, 24 Mar 2020 11:15:22 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 5/8] media: Kconfig: update the MEDIA_SUPPORT help message
Date:   Tue, 24 Mar 2020 11:15:18 +0100
Message-Id: <33b555ba214d4fd5bf9c30752a303f89a296cbec.1585044374.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1585044374.git.mchehab+huawei@kernel.org>
References: <cover.1585044374.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are more things than just cameras and TV devices on
media. Update the help message accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index 586d8931d9fc..18dea82d76d7 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -18,8 +18,10 @@ menuconfig MEDIA_SUPPORT
 	tristate "Multimedia support"
 	depends on HAS_IOMEM
 	help
-	  If you want to use Webcams, Video grabber devices and/or TV devices
-	  enable this option and other options below.
+	  If you want to use media devices, including Webcams, Video grabber
+	  devices and/or TV devices, V4L2 codecs, etc, enable this option
+	  and other options below.
+
 	  Additional info and docs are available on the web at
 	  <https://linuxtv.org>
 
-- 
2.24.1

