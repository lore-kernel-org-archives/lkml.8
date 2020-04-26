Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5916CC55186
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 01:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2698520706
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 01:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geKeVi1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgDZBfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 21:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725931AbgDZBff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 21:35:35 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A203C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 18:35:35 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 188so15598620wmc.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 18:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zMJDJfeA5eXVGIqjbISZ5/ttz+CXriZ4CrIpCaO+pAs=;
        b=geKeVi1ESc3wgnvG5vOZQFy9X/ZWBsQpQi1t9jZr9fa0vHFfkz6AWIrjqd3uLqmbxs
         RhWMBBY26+jaaOpEjXO3cVWxGnX/o0uJ6ZHIw8Mw5eiolk6OkaHJ8t4oFj3K/jiJdgc3
         fEnHYvia3Bqhj/CuJIFSJGRjwD5vtyAXP/MdZZzWVo7U3/UNXPwgTeviTxr3MUPzMTBy
         yMj36e94EeDUQg3heg7Ms4UM0bMhIiMBYV0opZFSeCYApmTPmCy0w82bwyPwmZwHoBoV
         5ImB4NvrgtxXbN36xhVEE8haLDx4SfgRIaMa9eFRAbiohkkG0IcPP1ZUhfIlNBuy4yPF
         n10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zMJDJfeA5eXVGIqjbISZ5/ttz+CXriZ4CrIpCaO+pAs=;
        b=r80njAac7MTeIlHc51nLzHRd0hBr3YB6PhxjZUOnRg02B664mjYtBXC5u4cblSYaiu
         TlmvEluERgxyzQXBvCog2OZtuE4hlfJ5Lj3RHJ9tZcKWX7Uwr4UBEkJC9wDejB7u04vH
         prw6TisXfDOjaK+Q2Vh2TNNqLkoJW9yslZJZBH/LJMipqcaBIOwFu6ELV26FMpHqAuUu
         pnAq1IUdTg4tyxv2mj0msrxr1eVjssekZIUZcqEipLGlnzj9Ay1/sDm1oTohmJt6yOG5
         jATu8dKjN5UA4wIXPq8DCydGrFpGJ2VwdX3vvAcFNGzdOwXt1Ew6PTJqO6ttOe6A8r7d
         5nnw==
X-Gm-Message-State: AGi0Puafj5VTpQ7XC9NkGsOcjjAwDlGNTsSMqbmJDGyZiNwXzyE+GQPg
        r8PXOl6kQp/B6FDqVOT9vBfVKnBE/+p0eQ==
X-Google-Smtp-Source: APiQypJE7SFdAWoHbLgBRL511YDWby4053psGjZArCo2Zm03OZhAKVCRp5Bv1FwWzBHL5Am8ZDx6XA==
X-Received: by 2002:a05:600c:441a:: with SMTP id u26mr19757889wmn.154.1587864933945;
        Sat, 25 Apr 2020 18:35:33 -0700 (PDT)
Received: from localhost.localdomain ([89.208.134.182])
        by smtp.gmail.com with ESMTPSA id e13sm5482885wrp.15.2020.04.25.18.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 18:35:33 -0700 (PDT)
From:   Leonid Bloch <lb.workbox@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Leonid Bloch <lb.workbox@gmail.com>
Subject: [PATCH] rtc: Do not sync CMOS clock when CONFIG_RTC_SYSTOHC is not set
Date:   Sun, 26 Apr 2020 04:35:21 +0300
Message-Id: <20200426013521.43087-1-lb.workbox@gmail.com>
X-Mailer: git-send-email 2.26.2
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
2.26.2

