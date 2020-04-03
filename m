Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70F9C2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD563206E9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfnGlLgU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403991AbgDCQGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:06:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44399 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403868AbgDCQGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:06:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id m17so9117620wrw.11;
        Fri, 03 Apr 2020 09:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IWqKdCVyF/z0Jc9mD3yRP7UIaHgfLawKN8WXGvn4s4c=;
        b=GfnGlLgUcYQIhYNkEieLbOd0BRlWORaqkq+5m0qgwVo5hzUcRhv8tTxl1be5jb/9KC
         FBBtRRg9JRTJegE9didYrrlZ+eV7nagVkB//sCytQSRNLF7Jg6PSwoC//w/26ZBJUTDm
         qXHvr4l+mvZfQalJct1p/EDlLHXqXABIPVPu9GYAwcU/ZHj5aTWHSvXbpAa1/2p+Kdhs
         y9V2XGB/sZsCbWmjr3Rw8xwBATsq+00Qc/SsPalm1TGo7lAkc4THILYVGwNI9sq6JTRs
         W7XzrPbwy9iDU5ooIxt3yiDlNCfSgZ1GDq2SgRJKtwPJCEbfjJx38P45StiCQff5HFge
         hwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IWqKdCVyF/z0Jc9mD3yRP7UIaHgfLawKN8WXGvn4s4c=;
        b=o4w82XjCamT05qdQtLQAmHCag38UolFarxPeXq+0gLWBOJKvnQzmSEXN4gMIFfYqvi
         M6/RBSo0zhRtDomOo5s7esYFJuv9DliE/VGjijJ4HSnZFj/1xR0WABHPFevZsBN4bGn+
         JlR8DLO2KK2IrsT20le72aWRxXoIxzgzpimhVthJf4GK/0uAbrEVcP5BU9mgvGjdKxJy
         oH+u+HAU7BHFBgFpks/EjUFY2ebD0QYlnqbzL36VyAx3OvDSqwP+RxvtjHjet8scn6S8
         r7+y2n1QOD3KeKD3i0bG9z9rKAUMizjRQlvmMo4rLkOKljioUFZn3wm0xVYTX/kXVOvq
         4FlA==
X-Gm-Message-State: AGi0PuYWUDP7nCyo/JzMON9dFiySHddJrDbvnaBxYQC1YTgjDyYl/sY1
        bKa22IXCzZQxy2lylDmh0AoiEARsX4kO
X-Google-Smtp-Source: APiQypLlwCkpYa4n/r1Dl73HpNAoUEjQYzF0myq5wOhev5KOXnIYY8OsFiBS/1oEbMxa6ypryajfqw==
X-Received: by 2002:adf:ed4a:: with SMTP id u10mr9412066wro.399.1585929958228;
        Fri, 03 Apr 2020 09:05:58 -0700 (PDT)
Received: from ninjahost.lan (host-92-23-85-227.as13285.net. [92.23.85.227])
        by smtp.gmail.com with ESMTPSA id l12sm12351426wrt.73.2020.04.03.09.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 09:05:57 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Russell King <linux@armlinux.org.uk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:CYBERPRO FB DRIVER),
        dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
        linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER)
Subject: [PATCH 2/5] video: Add missing annotation for cyber2000fb_enable_ddc() and cyber2000fb_disable_ddc()
Date:   Fri,  3 Apr 2020 17:05:02 +0100
Message-Id: <20200403160505.2832-3-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200403160505.2832-1-jbi.octave@gmail.com>
References: <0/5>
 <20200403160505.2832-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports warnings at cyber2000fb_enable_ddc()
	and cyber2000fb_disable_ddc()

warning: context imbalance in cyber2000fb_enable_ddc()
	- wrong count at exit

warning: context imbalance in cyber2000fb_disable_ddc()
	- unexpected unlock

The root cause is the missing annotation at cyber2000fb_enable_ddc()
	and cyber2000fb_disable_ddc()

Add the missing __acquires(&cfb->reg_b0_lock) annotation
Add the missing __releases(&cfb->reg_b0_lock) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/video/fbdev/cyber2000fb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/cyber2000fb.c b/drivers/video/fbdev/cyber2000fb.c
index 460826a7ad55..513f58f28b0f 100644
--- a/drivers/video/fbdev/cyber2000fb.c
+++ b/drivers/video/fbdev/cyber2000fb.c
@@ -1160,12 +1160,14 @@ EXPORT_SYMBOL(cyber2000fb_detach);
 #define DDC_SDA_IN	(1 << 6)
 
 static void cyber2000fb_enable_ddc(struct cfb_info *cfb)
+	__acquires(&cfb->reg_b0_lock)
 {
 	spin_lock(&cfb->reg_b0_lock);
 	cyber2000fb_writew(0x1bf, 0x3ce, cfb);
 }
 
 static void cyber2000fb_disable_ddc(struct cfb_info *cfb)
+	__releases(&cfb->reg_b0_lock)
 {
 	cyber2000fb_writew(0x0bf, 0x3ce, cfb);
 	spin_unlock(&cfb->reg_b0_lock);
-- 
2.24.1

