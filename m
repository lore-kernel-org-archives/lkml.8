Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D28C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 103AF2073E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585057485;
	bh=mvF+8DJswgww3SrqFXIL4DAo4Hpgzr3yTYJuJvmcW+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zQA6dGuSi1j/hWv2w2AXRsxYHmmOUt2rX56/bcdF9DCsAUi+OwpEFvY7e5lK7eZmY
	 MydJByo/6Qn2OosmOl5CDJET8bS4Swkc9gtLkZR3U9JLu1RuGfzztA71oi77ogPzD3
	 ihzRlbl1Feh1uFAxxnYN9e/Y3qhBQG1bNz4Ozwtc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgCXNon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:44:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727384AbgCXNnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:43:19 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 926042080C;
        Tue, 24 Mar 2020 13:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585057398;
        bh=mvF+8DJswgww3SrqFXIL4DAo4Hpgzr3yTYJuJvmcW+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GQHiP5Di2CColS/bMHYHHf55p6x3rXQoqPRCaqJQNmBBnOwRtq8lW03xm2O+lEICV
         Q7seOAiwNKQzY/25pkSU8UpAWXNO4fcyfKIpnSzhkUOwI450tV1rE20x91FHTWCG2p
         M6tXJYb+ZOgj+THtqXVuaKG+83TV7sX7g7eq7TxM=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jGjps-0025qu-Jf; Tue, 24 Mar 2020 14:43:16 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v2 04/20] media: reorganize the drivers menu options
Date:   Tue, 24 Mar 2020 14:42:57 +0100
Message-Id: <3b18b5ba614d354fead81fce1bbcd3f94026d1e8.1585057134.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1585057134.git.mchehab+huawei@kernel.org>
References: <cover.1585057134.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comments before some of the drivers support look
weird, because their Kconfig have their own "comment"
directive inside it. So, rearrange them to make it
look a little nicer for the ones with are not too
familiar with the media system.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/Kconfig | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index 4af21fa73fcf..586d8931d9fc 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -87,6 +87,8 @@ config MEDIA_CEC_SUPPORT
 	  Say Y when you have an HDMI receiver, transmitter or a USB CEC
 	  adapter that supports HDMI CEC.
 
+comment "Media core options"
+
 source "drivers/media/cec/Kconfig"
 
 source "drivers/media/mc/Kconfig"
@@ -166,17 +168,17 @@ comment "Media drivers"
 
 source "drivers/media/usb/Kconfig"
 source "drivers/media/pci/Kconfig"
+source "drivers/media/radio/Kconfig"
+
+# Common driver options
+source "drivers/media/common/Kconfig"
 source "drivers/media/platform/Kconfig"
 source "drivers/media/mmc/Kconfig"
-source "drivers/media/radio/Kconfig"
 
 comment "Supported FireWire (IEEE 1394) Adapters"
 	depends on DVB_CORE && FIREWIRE
 source "drivers/media/firewire/Kconfig"
 
-# Common driver options
-source "drivers/media/common/Kconfig"
-
 comment "Media ancillary drivers (tuners, sensors, i2c, spi, frontends)"
 
 #
-- 
2.24.1

