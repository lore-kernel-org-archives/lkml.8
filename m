Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80C8C35659
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7862073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YJwIqRv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbgBUPgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:36:24 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38031 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbgBUPgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:36:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id a9so2369782wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 07:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eFN2VKHrE+JD0cGAI+3A9MIQDzvF5Lgt98hOYp/CejM=;
        b=YJwIqRv9ZAZT+JufvECzrUvECj3c7vl3DwyjpavnRiTUC+BT5MwCGuUuHrmuPh5Qdx
         2k2nK57li5jZtok/isZ8Y1ljxslqxASi+smgJ7u9748rS31vEE6rk1FFWUbLXsNaFofV
         WC9+91sUznQKJ4ukv+rpRKMuxbM8RZgHoBZyWBPbD0POsX8WiOb+0mYGMRZ4w9iu5anB
         PV2NTKPrVoTm9H6mFTrDDZISPtGpVmOjN6OQMXYBeRUeZh21ze7FU98JEInnGCL2lpOo
         CK7zxw0pRThM7dM1fWfJlbzxNQP95XAMC63rKo7kS7d/iCJPCdB1RkSa+kMv8AtG/3Si
         M6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eFN2VKHrE+JD0cGAI+3A9MIQDzvF5Lgt98hOYp/CejM=;
        b=JO9AS/21+J5TmWX5VoFSpepxNOEhS+M5OXQ3iDdtrb3Uqf43LqYmvMI0AXocyDHDBO
         E/MxwS7nTFAJead+1e6npJM4096EvZzqdSCtV6QVdSY1qn0uOotDf7dS9WAk61VZ0DFb
         MbomMYcR+tCKKkxS0OToCx7iH2zI/Q53sCiMYulKcdzqqzDgwR+YPpZd5n2CZVrxNfni
         ny/41my7T3JXMDIqvzeBILs0dKppKVtAvg9fDYvcZKvmPXjDdgKBIs2VP2yOGnRNynuS
         dueVCajMlZ3UxqgMao6P5BfB/pIPrkv5HEOfgoxDSnILry4HJTT35Fh43pn8QJp3Fa1J
         EtUg==
X-Gm-Message-State: APjAAAU6gdE/VQIS5TmtZVwl9AlPuR5oBS6eqXnExsAf4vonznpKXW3R
        RmlOw9G8EgvZVRTYfjzxZrR7gA==
X-Google-Smtp-Source: APXvYqyKrZMlHSg/htp/5+30XIfFhh5aJwM5uacnmK48s3KUO/TfzxUThJS8Jhao+rZrzsLIALqGhQ==
X-Received: by 2002:a7b:c14d:: with SMTP id z13mr4597867wmi.71.1582299379163;
        Fri, 21 Feb 2020 07:36:19 -0800 (PST)
Received: from localhost.localdomain (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id z25sm4198782wmf.14.2020.02.21.07.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 07:36:18 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v2 3/3] ASoC: meson: axg-card: add toacodec support
Date:   Fri, 21 Feb 2020 16:36:07 +0100
Message-Id: <20200221153607.1585499-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221153607.1585499-1-jbrunet@baylibre.com>
References: <20200221153607.1585499-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure the axg audio card driver recognise the dai_link as a
codec-to-codec link if the cpu dai is the internal dac glue.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-card.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index 372dc696cc8e..48651631bdcf 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -303,7 +303,8 @@ static int axg_card_cpu_is_tdm_iface(struct device_node *np)
 
 static int axg_card_cpu_is_codec(struct device_node *np)
 {
-	return of_device_is_compatible(np, DT_PREFIX "g12a-tohdmitx");
+	return of_device_is_compatible(np, DT_PREFIX "g12a-tohdmitx") ||
+		of_device_is_compatible(np, DT_PREFIX "g12a-toacodec");
 }
 
 static int axg_card_add_link(struct snd_soc_card *card, struct device_node *np,
-- 
2.24.1

