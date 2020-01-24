Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9781EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E28F2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579863610;
	bh=yqDdAP7xTemVVOnjv6iA4MQlsYveHUOMTAuoXetQcgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JC9MsrRw+hNKIm1FXIMS2+1J8J+BezkyesillYxU09JTtg1jwtnl53cnMeSdmVGS6
	 ea4hxZIMplzPUEHp5EelXOJ1DXUCVTxqAN6Yt+MT+MZaWlMvQtthb3d+lnuLzJgtQv
	 CYqLPCG4ESn2aIIoQYqIGL9ImqBt4ssKLV7I/mFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732980AbgAXLAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:00:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:58894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732904AbgAXLAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:00:07 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80B392071A;
        Fri, 24 Jan 2020 11:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579863606;
        bh=yqDdAP7xTemVVOnjv6iA4MQlsYveHUOMTAuoXetQcgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lzlqJdpC4ojs8yHXgWQk37xiD6q+fgSSQVsfo+62bxDDA8VMUDq/3jfqJvOUUaZtL
         3uB/9149kKp7DvYKGGJOXDzJVHR/sDji3Ic7udKgQJnQ9ECnQCErPs3y1BBv8dEwOK
         tie2Bq2+a72JbC/e5+BSbx37MExbiqbNOGz1VOPg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 025/639] ALSA: hda: fix unused variable warning
Date:   Fri, 24 Jan 2020 10:23:15 +0100
Message-Id: <20200124093050.429263453@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anders Roxell <anders.roxell@linaro.org>

[ Upstream commit 5b03006d5c58ddd31caf542eef4d0269bcf265b3 ]

When CONFIG_X86=n function azx_snoop doesn't use the variable chip it
only returns true.

sound/pci/hda/hda_intel.c: In function ‘dma_alloc_pages’:
sound/pci/hda/hda_intel.c:2002:14: warning: unused variable ‘chip’ [-Wunused-variable]
  struct azx *chip = bus_to_azx(bus);
              ^~~~

Create a inline function of azx_snoop.

Fixes: a41d122449be ("ALSA: hda - Embed bus into controller object")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_controller.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index 8a9dd4767b1ec..63cc10604afc7 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -176,11 +176,10 @@ struct azx {
 #define azx_bus(chip)	(&(chip)->bus.core)
 #define bus_to_azx(_bus)	container_of(_bus, struct azx, bus.core)
 
-#ifdef CONFIG_X86
-#define azx_snoop(chip)		((chip)->snoop)
-#else
-#define azx_snoop(chip)		true
-#endif
+static inline bool azx_snoop(struct azx *chip)
+{
+	return !IS_ENABLED(CONFIG_X86) || chip->snoop;
+}
 
 /*
  * macros for easy use
-- 
2.20.1



