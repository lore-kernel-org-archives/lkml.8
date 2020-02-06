Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB58C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50586218AC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSVM7mzr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgBFUDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 15:03:52 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51726 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgBFUDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:03:52 -0500
Received: by mail-pj1-f65.google.com with SMTP id fa20so450701pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 12:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xYVWyJLdHXKTWIk8j2ax5kw5RYDuD9TSmcROhOEWoJY=;
        b=cSVM7mzrYFyCNF+Kj+lgqxPFSKNWXl/V/LgyeDPLBBYoUM7OExyLAOvUWCSMOuuRvo
         t8zJPHvOqgb38zvrGh7yLifD+VYwDdG354v/O7sB20y5JFNaVsbRfUytZJAIZ9fzvwI9
         ePizfuuQSkWj8nvqxP8p+Fz1Xkna+crztfOEIUPJg18NuJhiTtT4mJBmlpNp2hOfuFDA
         m3l3ds2kEE41h0UGptjSXZLjZt+SdhHfF6ZDcn4l6/ZUtEF8SUsLSqdnm4TJi2cTNnI5
         zgd6VmJy0AWCnh3E6AaNxlPl4E5iooSyPGOutDu0NebTuIinzGEqJkqaFSoHVU1wtyER
         VpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xYVWyJLdHXKTWIk8j2ax5kw5RYDuD9TSmcROhOEWoJY=;
        b=nPv46czeasq8RaH3kMuLRju5wLWtMv/KYIrN4d1t4KbT6BkGtoRpL5Ymp2zfp/kaD6
         ESOGSRw9D62NRgmWSrhWzJGNAceb/UBu2n/loCB4r4c0Ewx605sfS/IM5ZYXPdROJBG9
         EJ9sHQQaW4ttFAc9PJz8+odPwA6vmw5eY6Hh7Axm2ZRhEql/YS+n4EVvVnG1dNM5mp0/
         H49qs8xi2v8kenPrrfqXcxuKR+e0x4rxayfRPyHxNGZVdWPztCfMf1lydWfMwOwHYrZX
         fKmBwp11mNn/sIlaYJbk9QdGolozMV/ODa0UBUFxH4YTXrqNBP+rdRjFwWS1jd7BZKnM
         Xw/Q==
X-Gm-Message-State: APjAAAWBZWnRkC3R9uMF8LBaFyabdRqdLmjU9HxGUdadJC4ql//Yqkq4
        Vq2RlbELmwF+P93kpm+O/yI=
X-Google-Smtp-Source: APXvYqxbcoRpfgNMOZBFNsQv9nU1i+hjpBwVkZceeq8p0EIxs08l9j5FCvV9DFkQCfLaUFcHestELw==
X-Received: by 2002:a17:90a:fe02:: with SMTP id ck2mr6475995pjb.10.1581019431482;
        Thu, 06 Feb 2020 12:03:51 -0800 (PST)
Received: from jiancai.svl.corp.google.com ([2620:15c:2ce:0:90af:5dee:afd9:7294])
        by smtp.googlemail.com with ESMTPSA id k29sm233056pfh.77.2020.02.06.12.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 12:03:50 -0800 (PST)
From:   Jian Cai <caij2003@gmail.com>
Cc:     caij2003@gmail.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: soc-core: fix an uninitialized use
Date:   Thu,  6 Feb 2020 12:03:45 -0800
Message-Id: <20200206200345.175344-1-caij2003@gmail.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed the uninitialized use of a signed integer variable ret in
soc_probe_component when all its definitions are not executed. This
caused  -ftrivial-auto-var-init=pattern to initialize the variable to
repeated 0xAA (i.e. a negative value) and triggered the following code
unintentionally.

err_probe:
	if (ret < 0)
		soc_cleanup_component(component);

Signed-off-by: Jian Cai <caij2003@gmail.com>
---
 sound/soc/soc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 068d809c349a..bfb813ba34f3 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1180,7 +1180,7 @@ static int soc_probe_component(struct snd_soc_card *card,
 		snd_soc_component_get_dapm(component);
 	struct snd_soc_dai *dai;
 	int probed = 0;
-	int ret;
+	int ret = 0;
 
 	if (!strcmp(component->name, "snd-soc-dummy"))
 		return 0;
-- 
2.25.0.341.g760bfbb309-goog

