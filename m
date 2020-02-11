Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8B9C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB79C20708
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbgBKQWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 11:22:38 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37254 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbgBKQWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:22:37 -0500
Received: by mail-qt1-f194.google.com with SMTP id w47so8367285qtk.4;
        Tue, 11 Feb 2020 08:22:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8vKDSqnHXMxM6UbZpMgqezFGV7iFRtf6ymNXpe/ujkk=;
        b=Hc6Hz7OqJzPL7sRwAcwm8QOlAlpiB840p+7ZPAUZmlWZ9rTTkNMZx0++qtypqwipRr
         cW+Bx8qqgqfsROW+yJBa0XPTT7x80h6KY9QL4JG0I89l4K5C7VghBMJ6tm4vvfBJwiGn
         jyZA6brpc7HZcGSc2gaH5/YMuAE0M/R41o5oabXL0dUXnWpPLEZ7LZGLk2zL73qFq19s
         taZg++R9/60EQk0mpvmzanwp3LS7pZGRlufwgYFXktc4eY0Zgd8HHAh6j9gIOs2KGk20
         j1h/kggHT1n8yiQACufAkzyMiTS/yRoFpaR3yX0RnvvuCidNjfyFyPgnTEt46A4IBOiL
         omGw==
X-Gm-Message-State: APjAAAVujYpJl1FaGZ3/WmiTzbLmtQVxfEqOQGUD+HXRbI/gHjVKQqWG
        SY6Lu5T14cE9FtQt3kBgBb8=
X-Google-Smtp-Source: APXvYqwwPXIFhlNKe/TmTl7Jr5C5T5vcDNDRHUN6KwtQ8wLSYF8MesauojL3eZcGJXM+s29O2pi9lw==
X-Received: by 2002:aed:38c2:: with SMTP id k60mr3178211qte.375.1581438156499;
        Tue, 11 Feb 2020 08:22:36 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v10sm2312403qtq.58.2020.02.11.08.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 08:22:36 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: Apply sample rate quirk for Audioengine D1
Date:   Tue, 11 Feb 2020 11:22:35 -0500
Message-Id: <20200211162235.1639889-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Audioengine D1 (0x2912:0x30c8) does support reading the sample rate,
but it returns the rate in byte-reversed order.

When setting sampling rate, the driver produces these warning messages:
[168840.944226] usb 3-2.2: current rate 4500480 is different from the runtime rate 44100
[168854.930414] usb 3-2.2: current rate 8436480 is different from the runtime rate 48000
[168905.185825] usb 3-2.1.2: current rate 30465 is different from the runtime rate 96000

As can be seen from the hexadecimal conversion, the current rate read
back is byte-reversed from the rate that was set.

44100 == 0x00ac44, 4500480 == 0x44ac00
48000 == 0x00bb80, 8436480 == 0x80bb00
96000 == 0x017700,   30465 == 0x007701

Rather than implementing a new quirk to reverse the order, just skip
checking the rate to avoid spamming the log.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 3a5242e383b2..7f558f4b4520 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1440,6 +1440,7 @@ bool snd_usb_get_sample_rate_quirk(struct snd_usb_audio *chip)
 	case USB_ID(0x1395, 0x740a): /* Sennheiser DECT */
 	case USB_ID(0x1901, 0x0191): /* GE B850V3 CP2114 audio interface */
 	case USB_ID(0x21b4, 0x0081): /* AudioQuest DragonFly */
+	case USB_ID(0x2912, 0x30c8): /* Audioengine D1 */
 		return true;
 	}
 
-- 
2.24.1

