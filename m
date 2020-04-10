Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C97CC2BB85
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 09:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42409206F7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 09:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9ZjsgUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgDJJAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 05:00:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46621 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgDJJAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 05:00:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id k191so728929pgc.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 02:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZkHYjRBtSg5f4SMiK1TxUiRMi16PL9sTwB+WM20uZ64=;
        b=J9ZjsgUiczZp8NgMIvzvWB5725WBjM/RJM3ETufT4nu3bVy09GO4vMLhqhMy/byZ+w
         vo+84d70WduKUZAoGqNuqvO3L3YGTNVGRQLHeBT0xvVC6/FrJV2zvRAJRd4ty8PMb5Tt
         g0+jXYkHsWjFHrpSPE+s+CRj/gmbl3Rv7WCUD/IGM6r2Bgzz8R7zddjztEiUVVyR938S
         xErcScdcRTWMmUJ1wAsUr5Q+tk9ilreUASFRnxngeqEFK1kvz3Oo3xrHR8vYngsdMnCA
         ic1nIoRrOAMf0Q+H79ryH8rfyUyCJdwJ13vMYJ+ivHsD9+JgSMaTom95T/0uhV+ZjmpS
         waqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZkHYjRBtSg5f4SMiK1TxUiRMi16PL9sTwB+WM20uZ64=;
        b=gwDrQjDGc+wAsC2+i5NkfJ0UAtYFVrRAnDTYCX8mz7WMw1qd7aPzjxZqIdx+E/tyUs
         /RPxmmi3W85X/HfPwIscg+Cm8Jg5lWTcZ4lZp8NVldSFVX4pOB5FRjVWJXKD/QfzlMhm
         kOTn8Qsbg+aOk9V3T2kx1H79P7o0vpnIinXERWPc999YC5h6S4Ecd1420ttW3ulaM3oZ
         irBuPvbmWUWPj+CNtsjb9PNZpf6t/2XnCn3pt9N9c9+LxklPzaLEZw6f/tGvXXs6cY6C
         Qk5pnJWHkT0+yr25JmDgJyjM6O1JiztBHEmeAhw6djHkua7gMWZ87BkBm6R9y3h2ODHS
         Yyow==
X-Gm-Message-State: AGi0Pua7D1ren3RZQmhq3dJMq5l8TtwzCanaPCWzQmaEoMovV80cPQjU
        YQaIxPvUe2EjVXQ+mgvTTWM51wjt
X-Google-Smtp-Source: APiQypLk+xq0lULGO3RsR87xahCZO+Ow4IgPC/pNZOw3H897oD5P38ap6qd3fSWtSIcbloxXgHiRHQ==
X-Received: by 2002:aa7:96b2:: with SMTP id g18mr4166990pfk.221.1586509238563;
        Fri, 10 Apr 2020 02:00:38 -0700 (PDT)
Received: from localhost.localdomain (220-136-87-101.dynamic-ip.hinet.net. [220.136.87.101])
        by smtp.gmail.com with ESMTPSA id c8sm1244529pfj.108.2020.04.10.02.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 02:00:37 -0700 (PDT)
From:   Adam Barber <barberadam995@gmail.com>
To:     tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Adam Barber <barberadam995@gmail.com>
Subject: [PATCH] ALSA: hda/realtek - Enable the headset mic on Asus FX505DT
Date:   Fri, 10 Apr 2020 17:00:32 +0800
Message-Id: <20200410090032.2759-1-barberadam995@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Asus FX505DT with Realtek ALC233, the headset mic is connected
to pin 0x19, with default 0x411111f0.

Enable headset mic by reconfiguring the pin to an external mic
associated with the headphone on 0x21. Mic jack detection was also
found to be working.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=207131
Signed-off-by: Adam Barber <barberadam995@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f66a48154a57..5016fa50956a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7252,6 +7252,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x17d1, "ASUS UX431FL", ALC294_FIXUP_ASUS_DUAL_SPK),
 	SND_PCI_QUIRK(0x1043, 0x18b1, "Asus MJ401TA", ALC256_FIXUP_ASUS_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1043, 0x18f1, "Asus FX505DT", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x19ce, "ASUS B9450FA", ALC294_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
 	SND_PCI_QUIRK(0x1043, 0x1a30, "ASUS X705UD", ALC256_FIXUP_ASUS_MIC),
-- 
2.26.0

