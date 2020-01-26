Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E67DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 16:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E092071A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 16:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiStINCE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgAZQME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 11:12:04 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40318 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgAZQMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 11:12:03 -0500
Received: by mail-pl1-f193.google.com with SMTP id p12so2432469plr.7;
        Sun, 26 Jan 2020 08:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XwJ6zbJ/GSlSVPf4lzbzpyTBgRVNbLfcCsMPH563P88=;
        b=BiStINCETi47ij8Ysmz/ZI6Xft7bnO7sX0KTqlynJ43w3wtDW3h8/vXHDpu1M4G1EI
         Z7qILlsMhg6N3GCDjIivcJnYyNAmsbbJ5w7O9Y4e//ZPTwGHe8/vsirz2DJaeB9PM2FG
         Rgj0FymK4Qj2uZ2KFXemJFoHrrXCK1kt12ln9pOPT+HoOC0ctxQnZ1YJRXurhM/FFh+B
         B2quLBtZOsOjJpzuMc49HQSJMoE1sl4TrfwX8BnIFl+y8G71bMxDudxyOXPv3BpoJsmF
         SlQbnLHou74cDjs7TWPSE+QDIHWqP7pF2a8gzn5EQE1XVf6rmyCIREu1WiHzDBNryPMB
         ywXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XwJ6zbJ/GSlSVPf4lzbzpyTBgRVNbLfcCsMPH563P88=;
        b=s4tbXhvT3kmIXE/nt9EO5WihO/oS68ITyfwH1MnZQYB0ff1QwiDRiy5J73UAsShCDy
         eFkzcf+5qRDipSjg/HkRi4jGTHrPnMLMcI9s1lyVHHpsG1jCYLWedrotwXD+L/ayWGEQ
         KH5ISczgAeL2GmYUXLUyM2CLv4cneriqZOHicBWETVwf55UeTxDQmUOHDOr9GcpHZ8Qg
         vci5SofuCbCztGjywlmPSeTUFnydTocRqKIrQQdrQqwRQQjPPHnXbt4iST420uCWQdHC
         gDXmnj0v6zc0FbmwUdGqU14i4EF8ARlIXmJSeqGPcnJiko4bwARGR1SaOxM01QlVMFZd
         L7/Q==
X-Gm-Message-State: APjAAAWT5LRdj/oo166+IZ7WoyQGQwSMhs97/n9hAS/DA8upN7qVV88P
        X7Cy/hM6hBiGPNk0OyOcDVY=
X-Google-Smtp-Source: APXvYqyTm+GQ8cYQOS3FgVtTBy17aXa0SG63dsPQsZ2G9M59rQvA3+6BjsIjLUOhSPBkaeFQkZRlaA==
X-Received: by 2002:a17:90b:4396:: with SMTP id in22mr3009157pjb.83.1580055122957;
        Sun, 26 Jan 2020 08:12:02 -0800 (PST)
Received: from google.com ([123.201.105.2])
        by smtp.gmail.com with ESMTPSA id g9sm13056717pfm.150.2020.01.26.08.12.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 26 Jan 2020 08:12:02 -0800 (PST)
Date:   Sun, 26 Jan 2020 21:41:56 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     b-liu@ti.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] usb: musb: Fix external abort on non-linefetch
Message-ID: <20200126161156.GA20401@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.6.2-neo (NetBSD/sparc64)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While accessing the usb mode/vbus from sysfs. Below error came on kernel
version 4.19.

On latest kernel vserion api name changed. Therefore API
name and backtrace API names are different.

     [  821.908066] Backtrace:
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

Without pm_runtime_{get,put}_sync calls in place,
Similar issue come on "mode_show" and "vbus_store" also.

fix- call pm_runtime_{get,put}_sync before reading/writing
usb mode/vbus from sysfs.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
  drivers/usb/musb/musb_core.c | 6 ++++++
  1 file changed, 6 insertions(+)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 5ebf30b..a1ca8380 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1723,9 +1723,11 @@ int musb_mailbox(enum musb_vbus_id_status status)
  	unsigned long flags;
  	int ret;
  
+	pm_runtime_get_sync(dev);
  	spin_lock_irqsave(&musb->lock, flags);
  	ret = sprintf(buf, "%s\n", usb_otg_state_string(musb->xceiv->otg->state));
  	spin_unlock_irqrestore(&musb->lock, flags);
+	pm_runtime_put_sync(dev);
  
  	return ret;
  }
@@ -1738,6 +1740,7 @@ int musb_mailbox(enum musb_vbus_id_status status)
  	unsigned long	flags;
  	int		status;
  
+	pm_runtime_get_sync(dev);
  	spin_lock_irqsave(&musb->lock, flags);
  	if (sysfs_streq(buf, "host"))
  		status = musb_platform_set_mode(musb, MUSB_HOST);
@@ -1748,6 +1751,7 @@ int musb_mailbox(enum musb_vbus_id_status status)
  	else
  		status = -EINVAL;
  	spin_unlock_irqrestore(&musb->lock, flags);
+	pm_runtime_put_sync(dev);
  
  	return (status == 0) ? n : status;
  }
@@ -1766,6 +1770,7 @@ int musb_mailbox(enum musb_vbus_id_status status)
  		return -EINVAL;
  	}
  
+	pm_runtime_get_sync(dev);
  	spin_lock_irqsave(&musb->lock, flags);
  	/* force T(a_wait_bcon) to be zero/unlimited *OR* valid */
  	musb->a_wait_bcon = val ? max_t(int, val, OTG_TIME_A_WAIT_BCON) : 0 ;
@@ -1773,6 +1778,7 @@ int musb_mailbox(enum musb_vbus_id_status status)
  		musb->is_active = 0;
  	musb_platform_try_idle(musb, jiffies + msecs_to_jiffies(val));
  	spin_unlock_irqrestore(&musb->lock, flags);
+	pm_runtime_put_sync(dev);
  
  	return n;
  }
-- 
1.9.1

