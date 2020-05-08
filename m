Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5617C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0FF3218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942637;
	bh=KwvOtP+4R0a2cE5+I9etc0/2e14g3dLBY2UduyDPhZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WbK2dUTbJD+t7lsrzTngFQssOWraKqeh9ie/GSjFKCbZ9eSma2qHUtIML/jzczyER
	 FozTzDEwhxRgbHhcMWEtbr4WJ8kAKeT9DGULiyP4PVZp1/X5SZFm7V31ESAkge2BYO
	 nM2LwJd++ehGiaBk1ELLlHbhyQDJO1qMa1z4pJCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbgEHM5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:57:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730095AbgEHMzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:55:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 045DA24969;
        Fri,  8 May 2020 12:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942547;
        bh=KwvOtP+4R0a2cE5+I9etc0/2e14g3dLBY2UduyDPhZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kmtkjEOPl0qlWx1Dq83PG2QJ/EOJrm22CbspYI1Q9Gr4ALL0uC8+jTvvqJCogWXgI
         POtk9sO06kJDeyRD9+VOWlUwbbcmcr5ponKRDi24CLNygIcupq+EUM9XrB0tmlGjnQ
         e7hiQYHe9IrgC8yCqUzoVEO46Nhbr4vQ5paB0cGA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 21/49] ASoC: codecs: hdac_hdmi: Fix incorrect use of list_for_each_entry
Date:   Fri,  8 May 2020 14:35:38 +0200
Message-Id: <20200508123045.963551128@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123042.775047422@linuxfoundation.org>
References: <20200508123042.775047422@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

[ Upstream commit 326b509238171d37402dbe308e154cc234ed1960 ]

If we don't find any pcm, pcm will point at address at an offset from
the the list head and not a meaningful structure. Fix this by returning
correct pcm if found and NULL if not. Found with coccinelle.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20200415162849.308-1-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index e6558475e006d..f0f689ddbefe8 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -142,14 +142,14 @@ static struct hdac_hdmi_pcm *
 hdac_hdmi_get_pcm_from_cvt(struct hdac_hdmi_priv *hdmi,
 			   struct hdac_hdmi_cvt *cvt)
 {
-	struct hdac_hdmi_pcm *pcm = NULL;
+	struct hdac_hdmi_pcm *pcm;
 
 	list_for_each_entry(pcm, &hdmi->pcm_list, head) {
 		if (pcm->cvt == cvt)
-			break;
+			return pcm;
 	}
 
-	return pcm;
+	return NULL;
 }
 
 static void hdac_hdmi_jack_report(struct hdac_hdmi_pcm *pcm,
-- 
2.20.1



