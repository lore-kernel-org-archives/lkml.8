Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CE1C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 00:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7CA20768
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 00:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnC3UEHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgDJAz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 20:55:56 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39635 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDJAz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 20:55:56 -0400
Received: by mail-pj1-f66.google.com with SMTP id z3so202553pjr.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 17:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J35XnT5P/sGKG4JKDM9MuIGnt++VGp4aXhMY2OLBrXU=;
        b=MnC3UEHjeIVUqRxITh2+l3QRwhsLJx1ThcsjuPhC6MvTlN0Cilc0HcGYbEJ+8sCWs9
         +u+gynv/Zqalik5BkpJ2nD3r4LhvTCEq0lN83u4SVRHj1kLFp02/E0VgXMLE4WKk4Iir
         Q+jGhuiW8BpO00HE2Mwz6fXLlparMukSCfMgkmTx5CXwz05vj4vT7tDXqhRXLHQO0lZN
         T2FMCAFGuYaLpT2QWCKYLxvVVElr6XblzmbpXop/JurE9ecD2JP4eEaHi2SDhsYpoM2A
         1935SxSJ5b1infYXWVhWXwJfnjAH1RwXwTmxZAtYl4HT9P3mFz9LFzBeoxdDbjw2aXnN
         wnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J35XnT5P/sGKG4JKDM9MuIGnt++VGp4aXhMY2OLBrXU=;
        b=aU/5sSdaCiocDUuU0P0iGHt0cLKVlYHqS8O/QJm+7RWPe+U3b6Em4aW5WGpQD4FLsu
         XWdlEEvfKUTqS6TPEwiamWNouPzir/YcmaS0lDhxUAAhnF+fLuc00x8TO9tOt3A0hTL6
         nk5O/hd+vI4szzbkN8K6y3yel0YGIJf8Xi8cjDwaSp3ZLzboyRc0wS/f2n51ltOwnWcx
         v4svcKQbVMXKjnVCiOG0bfs36nBgI/9OLgbwsJduClN3LaaVuTq+G139UFvYbaCdmCGS
         imYVY0vmmt0nlI7+WvYBTy7EvTc3ydPzYMOKy7QinGdQzRSP7ibv6Bl69//KeujlrVcu
         XZdw==
X-Gm-Message-State: AGi0PuZQgpL+Cw8u0o2qFWGRieAjpfmsAilDRnKiaiqDY6t9XT5AmSyi
        +kii2P2mRn9oP+kc1uuGZOZub/TZl7g=
X-Google-Smtp-Source: APiQypIcx27oirNb2w2wXy7xozJhAz+KFvH7LQqNrTwruyoaMTks74aT/MiHzFPe6HRTneSwdBBxOQ==
X-Received: by 2002:a17:90a:e552:: with SMTP id ei18mr82300pjb.173.1586480155878;
        Thu, 09 Apr 2020 17:55:55 -0700 (PDT)
Received: from localhost.localdomain (220-136-86-171.dynamic-ip.hinet.net. [220.136.86.171])
        by smtp.gmail.com with ESMTPSA id x11sm281343pfp.204.2020.04.09.17.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 17:55:55 -0700 (PDT)
From:   Adam Barber <barberadam995@gmail.com>
To:     tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Adam Barber <barberadam995@gmail.com>
Subject: [PATCH] ALSA: hda/realtek - Enable the headset mic on Asus FX505DT
Date:   Fri, 10 Apr 2020 08:55:33 +0800
Message-Id: <20200410005533.4802-1-barberadam995@gmail.com>
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

