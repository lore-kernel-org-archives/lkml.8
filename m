Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC6EC2BA15
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 15:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E167720644
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 15:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlsGxS3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgDDPjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 11:39:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44639 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgDDPjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 11:39:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id m17so12140786wrw.11
        for <linux-kernel@vger.kernel.org>; Sat, 04 Apr 2020 08:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BF7UW8CK06SE0eBxOhlUCYg5eQ6WTl1tJij/gpor+Lk=;
        b=UlsGxS3liOFJSlyr7GF8lsqrLC75d1vpdraLA86G7MPHMfYEbTTtQgN6CGhaluGbOs
         eHWZwMiF53onIbQNEPRtAZm6C9thuw9qLmo+NsIMI9wdpQ/Rnp0zfztmOVs3+G/rgmah
         vuPQCfBygCPQ/oncThXwQfQmHOxdoRqk2v3V8Fyb5QbzayZPfkr3Zhdie3ao1wz16PSM
         MhMVqj5ONK/nZsvNr+0w2kBC/j8kxf90UuTohbrwGAojuD8u3z4nVVuRPDcAfSzmmD0d
         oWeUH7AoYf/5ZMxhST/QAXFUmAqpCV+qXp8eWOWtfg72z1Ccmo8Hqk/5ZvG+yO8M2NII
         O6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BF7UW8CK06SE0eBxOhlUCYg5eQ6WTl1tJij/gpor+Lk=;
        b=GlNB8R/FtghOqhtq5KHs/+zcmN9YJ9EWb6VH98kCzxZmfrK6iFiAJQS2DLerSvk9Mn
         iOQj+bq0VaWDZmyTfEwwkJgmNPuijiOFoqillYzBBBaXh1GYGpmvgIFZYosI4DEOSXsk
         6S4H3KOzbohejoRzj9FYkHzqhDnflwq2q3kixKAz2Iw8DqeVSxSvwlzeTLGJ06dn33nR
         GeqyM7p1apvPvePJqMhR47b2yVaRCNCxUi7aY2zSncQn8iI9exaSspzNvEPobW5+v8Dl
         pWz9Dki3ZDsjLoCBupGAj8LhODG5N8rGXhtl7Imbd1EkPfJ5CqWhIZ4PuCa136GxLb1R
         4NkA==
X-Gm-Message-State: AGi0PuZSiHfztZ5SSMoL9ZZlaxeOwpJnyBysFQKpoR6iB8wnJgTPQ8VN
        jPaITRCskSHynEfNpNOkYlg=
X-Google-Smtp-Source: APiQypKBMaiyw7REJv645zIbS88N35C/tyuH5jaHjiwYNOlhSFZQnv4dNS4RpNaYk+oYgmendtc3Rg==
X-Received: by 2002:adf:f892:: with SMTP id u18mr14375271wrp.367.1586014742353;
        Sat, 04 Apr 2020 08:39:02 -0700 (PDT)
Received: from pc-emmanuel.ealp-net.at (84-112-96-10.cable.dynamic.surfer.at. [84.112.96.10])
        by smtp.gmail.com with ESMTPSA id z21sm189889wml.47.2020.04.04.08.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 08:39:01 -0700 (PDT)
From:   Emmanuel Pescosta <emmanuelpescosta099@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, crwulff@gmail.com
Cc:     emmanuelpescosta099@gmail.com
Subject: [PATCH] ALSA: usb-audio: Add registration quirk for Kingston HyperX Cloud Alpha S
Date:   Sat,  4 Apr 2020 17:38:43 +0200
Message-Id: <20200404153843.9288-1-emmanuelpescosta099@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the Kingston HyperX AMP, the Kingston HyperX Cloud
Alpha S (0951:16d8) uses two interfaces, but only the second
interface contains the capture stream. This patch delays the
registration until the second interface appears.

Signed-off-by: Emmanuel Pescosta <emmanuelpescosta099@gmail.com>
---
 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 86f192a3043d..a8ece1701068 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1827,6 +1827,7 @@ struct registration_quirk {
 
 static const struct registration_quirk registration_quirks[] = {
 	REG_QUIRK_ENTRY(0x0951, 0x16d8, 2),	/* Kingston HyperX AMP */
+	REG_QUIRK_ENTRY(0x0951, 0x16ed, 2),	/* Kingston HyperX Cloud Alpha S */
 	{ 0 }					/* terminator */
 };
 
-- 
2.26.0

