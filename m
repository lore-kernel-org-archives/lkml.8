Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B7AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A06C4208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgGaUJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:09:45 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:55820 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726257AbgGaUJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 16:09:45 -0400
X-IronPort-AV: E=Sophos;i="5.75,419,1589234400"; 
   d="scan'208";a="462075190"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES256-SHA256; 31 Jul 2020 22:09:43 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, alsa-devel@alsa-project.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: doc: use correct config variable name
Date:   Fri, 31 Jul 2020 21:28:21 +0200
Message-Id: <1596223701-7558-1-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_PCM_XRUN_DEBUG should be CONFIG_SND_PCM_XRUN_DEBUG

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 Documentation/sound/designs/procfile.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/sound/designs/procfile.rst b/Documentation/sound/designs/procfile.rst
index 29a4668..e9f7e0c 100644
--- a/Documentation/sound/designs/procfile.rst
+++ b/Documentation/sound/designs/procfile.rst
@@ -91,7 +91,7 @@ PCM Proc Files
 
 ``card*/pcm*/xrun_debug``
 	This file appears when ``CONFIG_SND_DEBUG=y`` and
-	``CONFIG_PCM_XRUN_DEBUG=y``.
+	``CONFIG_SND_PCM_XRUN_DEBUG=y``.
 	This shows the status of xrun (= buffer overrun/xrun) and
 	invalid PCM position debug/check of ALSA PCM middle layer.
 	It takes an integer value, can be changed by writing to this

