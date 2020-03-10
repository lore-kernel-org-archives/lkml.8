Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA94C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2FD2467D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845936;
	bh=ssKvFUgnI1L6vedipqOf+KiYAXpk4XNBlD8QG1x3TBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jaLHl6IaKbGOSvt+sOSVeIgcAHxjKVJdi3cOYDNMXv+0OekS9vpOhWIp7ubWNtk9E
	 IBnwOHuiNhSSV3r4eZXRT5q0oi4L7DzlEDWBApAKuVHLgrz3ZKoFY/fU8MvojEinX4
	 S3r8xmhfiP6gVXeXBndyS+xYIQbHLLzbaq6Tlxwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731549AbgCJNMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:12:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731539AbgCJNMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:12:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFF7520409;
        Tue, 10 Mar 2020 13:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845932;
        bh=ssKvFUgnI1L6vedipqOf+KiYAXpk4XNBlD8QG1x3TBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EptAk6H63AjxDHLj+KxiIhWzC1cBnoz133pt2Hp+kH8itHvEFpxiIjtDP2MQyPhWL
         Jr+GBwExJ2zpF2xyEhJAAqZ+2AXmU9yhzsr5YM8g1miSOe1gQ3ppcu8qJ8DVhe+So6
         JvTmkkU62HSv/M3bSj1go0d2XfZT/FnNUgGTmoFM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 07/86] ALSA: hda: do not override bus codec_mask in link_get()
Date:   Tue, 10 Mar 2020 13:44:31 +0100
Message-Id: <20200310124531.200272158@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310124530.808338541@linuxfoundation.org>
References: <20200310124530.808338541@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

[ Upstream commit 43bcb1c0507858cdc95e425017dcc33f8105df39 ]

snd_hdac_ext_bus_link_get() does not work correctly in case
there are multiple codecs on the bus. It unconditionally
resets the bus->codec_mask value. As per documentation in
hdaudio.h and existing use in client code, this field should
be used to store bit flag of detected codecs on the bus.

By overwriting value of the codec_mask, information on all
detected codecs is lost. No current user of hdac is impacted,
but use of bus->codec_mask is planned in future patches
for SOF.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20200206200223.7715-1-kai.vehmanen@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/ext/hdac_ext_controller.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/hda/ext/hdac_ext_controller.c b/sound/hda/ext/hdac_ext_controller.c
index 60cb00fd0c693..84b44cdae28a1 100644
--- a/sound/hda/ext/hdac_ext_controller.c
+++ b/sound/hda/ext/hdac_ext_controller.c
@@ -262,6 +262,7 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_link_power_down_all);
 int snd_hdac_ext_bus_link_get(struct hdac_bus *bus,
 				struct hdac_ext_link *link)
 {
+	unsigned long codec_mask;
 	int ret = 0;
 
 	mutex_lock(&bus->lock);
@@ -283,9 +284,11 @@ int snd_hdac_ext_bus_link_get(struct hdac_bus *bus,
 		 *  HDA spec section 4.3 - Codec Discovery
 		 */
 		udelay(521);
-		bus->codec_mask = snd_hdac_chip_readw(bus, STATESTS);
-		dev_dbg(bus->dev, "codec_mask = 0x%lx\n", bus->codec_mask);
-		snd_hdac_chip_writew(bus, STATESTS, bus->codec_mask);
+		codec_mask = snd_hdac_chip_readw(bus, STATESTS);
+		dev_dbg(bus->dev, "codec_mask = 0x%lx\n", codec_mask);
+		snd_hdac_chip_writew(bus, STATESTS, codec_mask);
+		if (!bus->codec_mask)
+			bus->codec_mask = codec_mask;
 	}
 
 	mutex_unlock(&bus->lock);
-- 
2.20.1



