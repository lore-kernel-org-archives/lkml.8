Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5EFC55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 09:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E701420700
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 09:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQOt7vwe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgDYJcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 05:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725837AbgDYJcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 05:32:02 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB8DC09B04A;
        Sat, 25 Apr 2020 02:32:02 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mq3so4941953pjb.1;
        Sat, 25 Apr 2020 02:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=OrhRU4pM7PRuJGTCGNz4BDBM5P7xxyvw6CquCiJROmU=;
        b=EQOt7vwe3J5Yw5pqZP6SVbz4b4XRk4+rT0vZ2BdEda1r3tYPyVMsnPOMK9tyjaTLtt
         PzO6DVlE7E0+KXYhwSl89KznPPvxCeknWoWLf6dCeael7P6WCr8+AJItydxJCOKyfrzD
         mvNkKw3IMMI8/Ba81P8KrjXljJV9afGLYgLm004IAmSDsDMfM72JZbxr7A3wp8M8rbW2
         Do14o5/Vdtg4W/nGATT1bUrKIrMtDEIRtAoGDhOogWxihzu0R9qzB3W4ryneXp37vsTe
         taStEXgah9RI7hQVXDbl4+VAv/xSbaupoF8hFu6DaZMudGfXsvJtDiNQZ6Izl6HjZ9tS
         ilNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=OrhRU4pM7PRuJGTCGNz4BDBM5P7xxyvw6CquCiJROmU=;
        b=NJ8vtKO8N3Mnps4mD+4xD40/7VoF3ut9zky1m4gynFmp166mLHlkeDcRwN8foJbHL7
         bvkY4qUr6u8WtBjRN12n0ivUi1jJuK8sqyZwlzImZTj7ljQlG05B5Ru6qnyOF84Pnco6
         A9ahXv94CseQRA6msQFjpSyaqIJAWyuMwzO1JJjMvsWo35eW5ES4fnwmPySbpr+MqlDr
         VNaXsentN2+5SCtjvyfYRMBvpviw0TVDZJVOu+gsqkeyKIMMWeUwSUeJxEWs/pFC8laE
         iN5OZxNsxg/dX51soa5vbcEVMbYB5chBd3zYcgwNywc7v/ra4oDW4X05jpJ9dWL+cqED
         W1bg==
X-Gm-Message-State: AGi0PuYNGs5THYtfQazLv9NGKU/H4a1EVspUm34mU6r/1JECJ407R6KY
        sJUujz1Erqg326mp+siIeyv+ftUwzu0=
X-Google-Smtp-Source: APiQypJani3j9cnNIba//W8Jd7UQJVzEw5zoKVe6pb7+qoaLzxc6SHuqhq3dM0AQHx6G070CcgEvKQ==
X-Received: by 2002:a17:902:108:: with SMTP id 8mr13089795plb.200.1587807122073;
        Sat, 25 Apr 2020 02:32:02 -0700 (PDT)
Received: from saurav ([219.91.254.47])
        by smtp.gmail.com with ESMTPSA id l1sm6680885pjr.17.2020.04.25.02.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 02:32:01 -0700 (PDT)
Date:   Sat, 25 Apr 2020 15:01:55 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     b-liu@ti.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] Usb: Musb: Fix external abort on non-linefetch on musb_core
Message-ID: <20200425093153.GA17731@saurav>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While accessing the usb mode/vbus from sysfs. Below error
came on kernel version 4.19.

On latest kernel vserion api name changed. Therefore API
name and backtrace API names are different.

Backtrace:
[  821.910695] [<bf078fc0>] (musb_default_readl [musb_hdrc]) from [<bf0af738>] (dsps_musb_set_mode+0x38/0x12c [musb_dsps])
[  821.922059] [<bf0af700>] (dsps_musb_set_mode [musb_dsps]) from [<bf07899c>] (musb_mode_store+0xc8/0x12c [musb_hdrc])
[  821.933105]  r7:a0010013 r6:0000000b r5:cd79d200 r4:cb634010
[  821.939096] [<bf0788d4>] (musb_mode_store [musb_hdrc]) from [<c0425184>] (dev_attr_store+0x20/0x2c)
[  821.948593]  r7:cd79d200 r6:c5abbf78 r5:00000000 r4:bf0788d4
[  821.954549] [<c0425164>] (dev_attr_store) from [<c0285b08>] (sysfs_kf_write+0x48/0x4c)
[  821.962859]  r5:00000000 r4:c0425164
[  821.966620] [<c0285ac0>] (sysfs_kf_write) from [<c0285274>] (kernfs_fop_write+0xfc/0x1fc)
[  821.975200]  r5:00000000 r4:cd79d080
[  821.978966] [<c0285178>] (kernfs_fop_write) from [<c020ec00>] (__vfs_write+0x34/0x120)
[  821.987280]  r10:00000000 r9:0000000b r8:00000000 r7:0000000b r6:c5abbf78 r5:c0285178
[  821.995493]  r4:cb67a3c0
[  821.998160] [<c020ebcc>] (__vfs_write) from [<c020fae8>] (vfs_write+0xa8/0x170)
[  822.005835]  r9:0000000b r8:00000000 r7:c5abbf78 r6:000def80 r5:cb67a3c0 r4:0000000b
[  822.013969] [<c020fa40>] (vfs_write) from [<c02108d0>] (SyS_write+0x44/0x98)
[  822.021371]  r9:0000000b r8:000def80 r7:00000000 r6:00000000 r5:cb67a3c0 r4:cb67a3c0
[  822.029517] [<c021088c>] (SyS_write) from [<c010d8a0>] (ret_fast_syscall+0x0/0x3c)
[  822.037467]  r9:c5aba000 r8:c010daa8 r7:00000004 r6:b6f0ad58 r5:000def80 r4:0000000b
[  822.045599] Code: e1a0c00d e92dd800 e24cb004 e0801001 (e5910000)
[  822.052013] ---[ end trace 4090e262fde955c3 ]---

Without pm_runtime_{get,put}_sync calls in place,
Similar issue come on "mode_show" and "vbus_store" also.

fix- call pm_runtime_{get,put}_sync before reading/writing

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/usb/musb/musb_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index d590110539ab..eb55d9b1c86f 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1861,10 +1861,12 @@ mode_show(struct device *dev, struct device_attribute *attr, char *buf)
 	struct musb *musb = dev_to_musb(dev);
 	unsigned long flags;
 	int ret;
-
+
+	pm_runtime_get_sync(dev);
 	spin_lock_irqsave(&musb->lock, flags);
 	ret = sprintf(buf, "%s\n", usb_otg_state_string(musb->xceiv->otg->state));
 	spin_unlock_irqrestore(&musb->lock, flags);
+	pm_runtime_put_sync(dev);
 
 	return ret;
 }
@@ -1876,7 +1878,8 @@ mode_store(struct device *dev, struct device_attribute *attr,
 	struct musb	*musb = dev_to_musb(dev);
 	unsigned long	flags;
 	int		status;
-
+
+	pm_runtime_get_sync(dev);
 	spin_lock_irqsave(&musb->lock, flags);
 	if (sysfs_streq(buf, "host"))
 		status = musb_platform_set_mode(musb, MUSB_HOST);
@@ -1887,6 +1890,7 @@ mode_store(struct device *dev, struct device_attribute *attr,
 	else
 		status = -EINVAL;
 	spin_unlock_irqrestore(&musb->lock, flags);
+	pm_runtime_put_sync(dev);
 
 	return (status == 0) ? n : status;
 }
@@ -1905,6 +1909,7 @@ vbus_store(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 	}
 
+	pm_runtime_get_sync(dev);
 	spin_lock_irqsave(&musb->lock, flags);
 	/* force T(a_wait_bcon) to be zero/unlimited *OR* valid */
 	musb->a_wait_bcon = val ? max_t(int, val, OTG_TIME_A_WAIT_BCON) : 0 ;
@@ -1912,6 +1917,7 @@ vbus_store(struct device *dev, struct device_attribute *attr,
 		musb->is_active = 0;
 	musb_platform_try_idle(musb, jiffies + msecs_to_jiffies(val));
 	spin_unlock_irqrestore(&musb->lock, flags);
+	pm_runtime_put_sync(dev);
 
 	return n;
 }
-- 
2.20.1

