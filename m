Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6B0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 09:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09C4F20781
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 09:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oGYgJqsY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgHNJRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 05:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgHNJRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 05:17:41 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5928C061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 02:17:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a14so9537723ybm.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 02:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=QsRsOCpoXcwdRIsVUMLGWKWsf8QgiczNEiWX1UbiUY4=;
        b=oGYgJqsYuUV0Hms2m3LZF+iq+NfQ6YoaeJQuq9z72NuNFa7OMslSlpLVFCZsmBJKNY
         ZaWg1WLV+vs/Ii/09pl7wGF+m/bB3EF5lLW7WI/pC3dVEM2c1ZuHHEsSSup17xqCh0Ec
         uCnsrdpI/LkrE0aBV+2tu7VnODtCWhubakNAmOVfig+qZvz/xH1E4BYlCJRCCqkq2PKD
         D7+5oFEyqcp7GrBssXUJh+wS72z4rB+PKi04rD25p4gCEkOgi9S3CC0BBwPFSrgw2CS8
         o3D4+7jfC777vMMakgcTIm1i2mvi2D1nyoPJL9heKLuQ0bfK6llK/R6otOm3LGuJNKRJ
         vOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=QsRsOCpoXcwdRIsVUMLGWKWsf8QgiczNEiWX1UbiUY4=;
        b=qwB8QWGNbNBuNE8bD4RsBe/sOLnQrzoKNr1KEsGhP9IbsYl5SYg97DrcOwMRxs6GzN
         wKhAgN0PRSfnKuE5SXOVRFCpbWHT0MJmxPCO896HQ1C36aa8hy7Wo254gZsA+qSGTmJf
         z5ybxw2DI/0x1L4PHbzvm3bcsfM8bknZO7udxZQs1Vl/B4uw94HkFXGQbiz9Qc/dtyim
         fUX+/MrCCnDyqnX1Bjyfq20G+Bb8uZxbAUqp1ZKA/TJ2yJGIHoi3vL7uPTxGobK5OcdW
         l/eJXjkiwlvgKQb7OXEfxniTfzs/bKHn81d9e+2UpuoCUqGZ1pV6K6+P2PoHzEnaSj0P
         P3Ig==
X-Gm-Message-State: AOAM531QIt0nItbNsVFhdfxUtgQoCyouzTsvzjjMm0IrzDkbmQsujlAO
        B0ZOEce2524C20Mqz4l8apzZ9PUgEBUnE5KV+ry00Q9EL5EtjPfXIJD+Ug5/uMdWL+SsdkdlUTd
        QNO3WFxr/iSrjhEgTpPJn6ZAX0xtvQUOMSYRLiX4jmT9/oy1VfmXiRXzI7ZPQGfyk35tpGZuvtK
        wbAqqG
X-Google-Smtp-Source: ABdhPJyqUdHa5EmOBsxJ8UelCFoy6G5Gk4fPgGTLmQMMoD2fMMoqIo1HcRzpjCoZNQJBP39oDw+oJT22mnXtWQ4J
X-Received: by 2002:a25:3556:: with SMTP id c83mr2374756yba.412.1597396659823;
 Fri, 14 Aug 2020 02:17:39 -0700 (PDT)
Date:   Fri, 14 Aug 2020 19:17:30 +1000
Message-Id: <20200814191654.v2.1.Iaf7638a2f2a87ff68d85fcb8dec615e41340c97f@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v2] rtc: cmos: zero-init wkalrm when reading from CMOS
From:   Victor Ding <victording@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Victor Ding <victording@google.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cmos_read_alarm() may leave certain fields of a struct rtc_wkalrm
untouched; therefore, these fields contain garbage if not properly
initialized, leading to inconsistent values when converting into
time64_t. This patch to zero initialize the struct before calling
cmos_read_alarm().

Note that this patch is not intended to produce a correct time64_t, it
is only to produce a consistent value. In the case of suspend/resume, a
correct time64_t is not necessary; a consistent value is sufficient to
correctly perform an equality test for t_current_expires and
t_saved_expires. Logic to deduce a correct time64_t is expensive and
hence should be avoided.

Signed-off-by: Victor Ding <victording@google.com>
---

Changes in v2:
    - Initialize the struct to 0 instead of -1;
    - Initialize the whole struct rtc_wkalrm.

 drivers/rtc/rtc-cmos.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index bcc96ab7793f..c633319cdb91 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -1006,6 +1006,7 @@ static int cmos_suspend(struct device *dev)
 			enable_irq_wake(cmos->irq);
 	}
 
+	memset(&cmos->saved_wkalrm, 0, sizeof(struct rtc_wkalrm));
 	cmos_read_alarm(dev, &cmos->saved_wkalrm);
 
 	dev_dbg(dev, "suspend%s, ctrl %02x\n",
@@ -1054,6 +1055,7 @@ static void cmos_check_wkalrm(struct device *dev)
 		return;
 	}
 
+	memset(&current_alarm, 0, sizeof(struct rtc_wkalrm));
 	cmos_read_alarm(dev, &current_alarm);
 	t_current_expires = rtc_tm_to_time64(&current_alarm.time);
 	t_saved_expires = rtc_tm_to_time64(&cmos->saved_wkalrm.time);
-- 
2.28.0.220.ged08abb693-goog

