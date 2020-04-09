Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA6DC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB3920730
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vTO45h5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbgDIUqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 16:46:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46895 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgDIUqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 16:46:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id f13so7009352wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 13:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lD1Rt/y2uoNW+nfIN7RZ4aTdLWF/Ni9UbL6zK1y9lCs=;
        b=vTO45h5qjxpUO0RZop+vt4zHCddVEsZg/knGJrQn7U+9DGy67NQQXrh5TsjLyQKFxk
         SVJ4ctNyC2RjMmwReBBiXEmv8qAjR3Axw/byAo3Pj/w49nw5+YMtL7twgpeAPoGbZCXz
         0M02Fe5dDpE5jg4qlkoUgpj0CcHSn0dZMW+4a9LjQ08lCk/CqL7jcpvzC/MgKDixMzXI
         zhXzxMDFp9Sh8EKc30sXOVpooFDSWETY3fGnVyR4YswQIh47peeB/Dk0Dl0CGxVXN59v
         Bk9e5sMiVdKHPKW3NqBcvwElouV/WMgTem0s+CQZIvqdiBLGHj72A9ZM9/VBArivHXP3
         vIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lD1Rt/y2uoNW+nfIN7RZ4aTdLWF/Ni9UbL6zK1y9lCs=;
        b=SJWtuAsJVxKYeUnRgmZeR+zaLivvm+58GVsKH5WOCyx68XuvdE/xeBo/wZFoKFKrxp
         OLRWyvRGc9HUtJq5JqUHd5rhxWXTFN/ljlTO5EVg2nOxvr0ZrdtrOsoqx5JiX20TxJlQ
         3dVj0qA6Agt3UnX7UGNqC2IULAM3QDODCGULo2eYrwtDGaxsuPx7y5lDbIyOwfoWhiuA
         nutZTHXJaujRUSNdT2/2uud/Q5cAbQGU6VoUa+yUpC1fU4dqnSTYGmD8jQh+hVhD/XV9
         zacqFqvh5cUlEX2P0fH7nHv2pf0iwSy4OeHkIG7rk3gIkmmi1uq7YBzbSqkvBq2y3tYd
         QOXg==
X-Gm-Message-State: AGi0PuZPeYUtXHu1u/hXTSI7mVl8Hkm6/Uq+7huI8ABYuoHePc+LZjiB
        UMiqI1viS/HD9wrFh8qsSdC2Xak3jJY=
X-Google-Smtp-Source: APiQypLKK0n4RrvpfsZv9DWiFKMNRxBOXEgwdl/5+7rT+wUMjrtPZmlVoDQbKd2WnWBKMbZfIRzE8w==
X-Received: by 2002:a5d:5228:: with SMTP id i8mr1038315wra.156.1586465176507;
        Thu, 09 Apr 2020 13:46:16 -0700 (PDT)
Received: from localhost.localdomain ([89.208.134.182])
        by smtp.gmail.com with ESMTPSA id c18sm40639876wrx.5.2020.04.09.13.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 13:46:15 -0700 (PDT)
From:   Leonid Bloch <lb.workbox@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Leonid Bloch <lb.workbowx@gmail.com>
Subject: [PATCH] rtc: Do not sync CMOS clock when CONFIG_RTC_SYSTOHC is not set
Date:   Thu,  9 Apr 2020 23:46:07 +0300
Message-Id: <20200409204607.8280-1-lb.workbox@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to documentation in 'drivers/rtc/Kconfig', if
'CONFIG_RTC_SYSTOHC' is set, then:

'''
The system time (wall clock) will be stored in the RTC specified by
RTC_HCTOSYS_DEVICE approximately every 11 minutes if userspace reports
synchronized NTP status.
'''

However in reality, even if 'CONFIG_RTC_SYSTOHC' is not set, the RTC
is still sometimes synced with the system time: at least when the RTC
driver is 'rtc_cmos', in certain situations. This commit prevents that.

Signed-off-by: Leonid Bloch <lb.workbox@gmail.com>
---
 kernel/time/ntp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 069ca78fb0bf..58260ca75c64 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -535,9 +535,6 @@ static void sync_rtc_clock(void)
 	struct timespec64 adjust, now;
 	int rc;
 
-	if (!IS_ENABLED(CONFIG_RTC_SYSTOHC))
-		return;
-
 	ktime_get_real_ts64(&now);
 
 	adjust = now;
@@ -613,6 +610,9 @@ static bool sync_cmos_clock(void)
  */
 static void sync_hw_clock(struct work_struct *work)
 {
+	if (!IS_ENABLED(CONFIG_RTC_SYSTOHC))
+		return;
+
 	if (!ntp_synced())
 		return;
 
-- 
2.26.0

