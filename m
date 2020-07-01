Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEBEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 21:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16C0220720
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 21:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OeCRAKIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgGAVIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 17:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgGAVIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 17:08:42 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C615DC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 14:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=n3MhCVUc4stdpN2Qe7L9WDOpNOr9JzTLo6XaZBRTMak=; b=OeCRAKIekfVonveM23MX3a487K
        UPN8c7BE8HI2uqDE+mA9j98eCqcctiz8v2eYUtiRId40gw/y7BJsyNolh76MzPA3QmGUUloXYxweG
        cce+/+4/TzWzTYcu/4s2K6s6iM/d5t6ryPgBDidii8xI+IMu7Z80Sj6waidY3Y5XOSsChg24/DeuB
        K0dvhrX65yKSWLeTERVnh7xLktIfWe+CsMIg+S3hwJvV3DOIKkgoTwOhBiRzWr4sSrnFVZ3ZoGC6X
        oD5OKjv/KluHFb4tvDKXFb11RIdHi+LXchW7GZTnjxuM6JFavRfGr4SBWTYU/mbARVRWOaKZhQFkI
        h7JTHOpA==;
Received: from [2601:1c0:6280:3f0::81af]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqjxz-0000hb-LV; Wed, 01 Jul 2020 21:08:27 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] sound: fix SND_HDA_GENERIC kconfig & build
Message-ID: <01233744-9625-38b3-0342-1b37250dbc72@infradead.org>
Date:   Wed, 1 Jul 2020 14:08:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kconfig warnings and lots of subsequent build errors by
adding yet another ugly select statement:

WARNING: unmet direct dependencies detected for LEDS_CLASS
  Depends on [n]: NEW_LEDS [=n]
  Selected by [y]:
  - SND_HDA_GENERIC [=y] && SOUND [=y] && !UML && SND [=y] && SND_HDA [=y] && SND_HDA_GENERIC_LEDS [=y]

WARNING: unmet direct dependencies detected for LEDS_TRIGGERS
  Depends on [n]: NEW_LEDS [=n] && LEDS_CLASS [=y]
  Selected by [y]:
  - SND_HDA_GENERIC [=y] && SOUND [=y] && !UML && SND [=y] && SND_HDA [=y] && SND_HDA_GENERIC_LEDS [=y]
  Selected by [m]:
  - MAC80211_LEDS [=y] && NET [=y] && WIRELESS [=y] && MAC80211 [=m] && LEDS_CLASS [=y]
  - IWLWIFI_LEDS [=y] && NETDEVICES [=y] && WLAN [=y] && WLAN_VENDOR_INTEL [=y] && IWLWIFI [=m] && (LEDS_CLASS [=y]=y || LEDS_CLASS [=y]=IWLWIFI [=m]) && (IWLMVM [=m] || IWLDVM [=m])

WARNING: unmet direct dependencies detected for LEDS_TRIGGER_AUDIO
  Depends on [n]: NEW_LEDS [=n] && LEDS_TRIGGERS [=y]
  Selected by [y]:
  - SND_HDA_GENERIC [=y] && SOUND [=y] && !UML && SND [=y] && SND_HDA [=y] && SND_HDA_GENERIC_LEDS [=y]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
---
 sound/pci/hda/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20200701.orig/sound/pci/hda/Kconfig
+++ linux-next-20200701/sound/pci/hda/Kconfig
@@ -221,6 +221,7 @@ comment "Set to Y if you want auto-loadi
 
 config SND_HDA_GENERIC
 	tristate "Enable generic HD-audio codec parser"
+	select NEW_LEDS if SND_HDA_GENERIC_LEDS
 	select LEDS_CLASS if SND_HDA_GENERIC_LEDS
 	select LEDS_TRIGGERS if SND_HDA_GENERIC_LEDS
 	select LEDS_TRIGGER_AUDIO if SND_HDA_GENERIC_LEDS

