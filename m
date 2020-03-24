Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CADC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4417F20753
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585057459;
	bh=Z4NTAwq0iX+fSarX+OK5e9Qzq8rS5PhgyAmDd4W8YA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k/JtLWwrto4DvEWl72JK7Gu5PBTFjltI1feIotWFJXWEph93/m9gpcHlE5dxI1dSe
	 fCOhmxsNqNMGNo9+LY0HuyHHASh/Kx1rQsrFqsbDrwsMAmQVgbIC4sw+VIBbjeJa+5
	 Sju/SUVvTxGmIxz9TL0Q3vhHgZn00vRLljhXADB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbgCXNoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:44:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727873AbgCXNnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:43:20 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A655A20B80;
        Tue, 24 Mar 2020 13:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585057398;
        bh=Z4NTAwq0iX+fSarX+OK5e9Qzq8rS5PhgyAmDd4W8YA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y9Jku75JDvYkB1ZW0Zepm9BeRXj8SlP1/7Vuk5aH6dgZPBQ0DmDfPqdqfk1/jXHSY
         Mv9/NhPzaPdcjQU4usgK5NffHdp4NjoBmljLO3+aApyucWRQLcntp62hqMm1RGE3uE
         Jg0a9vSJuEKWic1Vjl/4qgBAETI2yImNFJZ+/lKI=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jGjps-0025ra-Tf; Tue, 24 Mar 2020 14:43:16 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v2 12/20] media: Kconfig: move DVB-specific options to dvb-core/Kconfig
Date:   Tue, 24 Mar 2020 14:43:05 +0100
Message-Id: <05153eacab4ccb6cc2ca36dbd43e8c761c2d65c5.1585057134.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1585057134.git.mchehab+huawei@kernel.org>
References: <cover.1585057134.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to cleanup the main media Kconfig, move the DVB-core
specific options to dvb-core/Kconfig.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/Kconfig          | 21 ---------------------
 drivers/media/dvb-core/Kconfig | 26 ++++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index 2f4360faed03..44aceb5e5b63 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -164,31 +164,10 @@ config DVB_CORE
 	default y
 	select CRC32
 
-config DVB_MMAP
-	bool "Enable DVB memory-mapped API (EXPERIMENTAL)"
-	depends on DVB_CORE
-	depends on VIDEO_V4L2=y || VIDEO_V4L2=DVB_CORE
-	select VIDEOBUF2_VMALLOC
 	help
-	  This option enables DVB experimental memory-mapped API, which
-	  reduces the number of context switches to read DVB buffers, as
-	  the buffers can use mmap() syscalls.
 
-	  Support for it is experimental. Use with care. If unsure,
-	  say N.
 
-config DVB_NET
-	bool "DVB Network Support"
-	default (NET && INET)
-	depends on NET && INET && DVB_CORE
-	help
-	  This option enables DVB Network Support which is a part of the DVB
-	  standard. It is used, for example, by automatic firmware updates used
-	  on Set-Top-Boxes. It can also be used to access the Internet via the
-	  DVB card, if the network provider supports it.
 
-	  You may want to disable the network support on embedded devices. If
-	  unsure say Y.
 
 # This Kconfig option is used by both PCI and USB drivers
 config TTPCI_EEPROM
diff --git a/drivers/media/dvb-core/Kconfig b/drivers/media/dvb-core/Kconfig
index 90e038d5ffd9..0f8e53692b86 100644
--- a/drivers/media/dvb-core/Kconfig
+++ b/drivers/media/dvb-core/Kconfig
@@ -3,6 +3,32 @@
 # DVB device configuration
 #
 
+config DVB_MMAP
+	bool "Enable DVB memory-mapped API (EXPERIMENTAL)"
+	depends on DVB_CORE
+	depends on VIDEO_V4L2=y || VIDEO_V4L2=DVB_CORE
+	select VIDEOBUF2_VMALLOC
+	help
+	  This option enables DVB experimental memory-mapped API, which
+	  reduces the number of context switches to read DVB buffers, as
+	  the buffers can use mmap() syscalls.
+
+	  Support for it is experimental. Use with care. If unsure,
+	  say N.
+
+config DVB_NET
+	bool "DVB Network Support"
+	default (NET && INET)
+	depends on NET && INET && DVB_CORE
+	help
+	  This option enables DVB Network Support which is a part of the DVB
+	  standard. It is used, for example, by automatic firmware updates used
+	  on Set-Top-Boxes. It can also be used to access the Internet via the
+	  DVB card, if the network provider supports it.
+
+	  You may want to disable the network support on embedded devices. If
+	  unsure say Y.
+
 config DVB_MAX_ADAPTERS
 	int "maximum number of DVB/ATSC adapters"
 	depends on DVB_CORE
-- 
2.24.1

