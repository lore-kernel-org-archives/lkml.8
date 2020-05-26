Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A5BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 06:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBD3A20776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 06:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="ar/mZUlI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbgEZG0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 02:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgEZG0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 02:26:34 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901E1C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 23:26:34 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 5so792673pjd.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 23:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D3oJjqxF038PAanM9YgOnN3aymIalIBeYa6R2RlB7aM=;
        b=ar/mZUlISeoa/YvBkyRo5k2xzWfkZqVsKjW76QCwIA9CSsBy0Z8NV9gfqv0Wr7ntSD
         1+G1fkBMj0jdKcK8Hie2ZKaa/8l5CaO8eKoAxmXEz771osTlC4ay4BdDoy4YlmlIUuHg
         EKbpQYiqa7ac1trIdzZ3cI8sVLoLUjLHIgPloZ8Udo1OWbME6c5eK0Xbo672MOWmMeYP
         eoZdbsNMgCAAC3PZh3/b5etXBsTe+1KAG5SluLtJOEwZZWxftzxuG0n5KfeoBmCssAle
         FFzEwSM++kKL8upc6+k1Tiep0B7otIZ0WLY7pAZt9ujpNNEajrvLAiruyCdPT/IQ8mLE
         eYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D3oJjqxF038PAanM9YgOnN3aymIalIBeYa6R2RlB7aM=;
        b=SbMZfYyX+tOcuXhSIv4o51G9No8hNYXnGH5l/MQ7iPfeAhGe0i4vmLlzMcIoFIts0l
         eNWYKb7rxmEv0nFn9CX2mhuo7WP1teQVtoVz40PTyLy2r9UKGuG36ipO/3YgUojOqF3T
         rN90emPLckh8vFdld7xOUD++9P9n584q0Uc3uuohNO6qya4ejp7r3WxX+qYynzp63CG0
         Q0EQABh01ZsKmUXeqyjxVqeObOdXRaHMXenngqGv7D4XKEkqEkBB6EcvHUtO0KjyPQbl
         QaKS3/p58cmMUImapfW/5lBONZVzJskpMUtqF8rchJAEKOalKMnfi1BNVpmh/RAF45W4
         jEag==
X-Gm-Message-State: AOAM532tbr1DcjzfN9YIAUx4o6brG4EUE4rP3ses22Rp/YACNzI/q61N
        S6y9GQF5qXPeiQP/E2YAkDhrSQ==
X-Google-Smtp-Source: ABdhPJyGUmR2KNz023iEAm+9LZ7uPanEpwEpqAX6A8/mIJrn0/OKY7UzAd/GWpw14vjA/TPT0D8SJw==
X-Received: by 2002:a17:90a:23a4:: with SMTP id g33mr24011855pje.79.1590474393881;
        Mon, 25 May 2020 23:26:33 -0700 (PDT)
Received: from localhost.localdomain (59-127-47-130.HINET-IP.hinet.net. [59.127.47.130])
        by smtp.gmail.com with ESMTPSA id i14sm14584574pfo.162.2020.05.25.23.26.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 May 2020 23:26:33 -0700 (PDT)
From:   Chris Chiu <chiu@endlessm.com>
To:     perex@perex.cz, tiwai@suse.com, benquike@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com, Chris Chiu <chiu@endlessm.com>
Subject: [PATCH] ALSA: usb: mixer: volume quirk for ESS Technology Asus USB DAC
Date:   Tue, 26 May 2020 14:26:13 +0800
Message-Id: <20200526062613.55401-1-chiu@endlessm.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Asus USB DAC is a USB type-C audio dongle for connecting to
the headset and headphone. The volume minimum value -23040 which
is 0xa600 in hexadecimal with the resolution value 1 indicates
this should be endianness issue caused by the firmware bug. Add
a volume quirk to fix the volume control problem.

Also fixes this warning:
  Warning! Unlikely big volume range (=23040), cval->res is probably wrong.
  [5] FU [Headset Capture Volume] ch = 1, val = -23040/0/1
  Warning! Unlikely big volume range (=23040), cval->res is probably wrong.
  [7] FU [Headset Playback Volume] ch = 1, val = -23040/0/1

Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 sound/usb/mixer.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 81b2db0edd5f..0b568a9fdab3 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1171,6 +1171,14 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 			cval->res = 384;
 		}
 		break;
+	case USB_ID(0x0495, 0x3042): /* ESS Technology Asus USB DAC */
+		if ((strstr(kctl->id.name, "Playback Volume") != NULL) ||
+			strstr(kctl->id.name, "Capture Volume") != NULL) {
+			cval->min >>= 8;
+			cval->max = 0;
+			cval->res = 1;
+		}
+		break;
 	}
 }
 
-- 
2.20.1

