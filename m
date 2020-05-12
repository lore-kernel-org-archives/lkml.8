Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA26C54E4B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7405820836
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="GiFn5PvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgELGRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 02:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725536AbgELGRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 02:17:01 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BE3C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 23:17:00 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id s69so705309pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 23:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qAP5dzqVjJ1/UNcW8HWgPzFOYDWg70LyvfFQzRXxTzQ=;
        b=GiFn5PvRBAiNNSCjp3LSNNPQLCb2Lrne6Y8zq48dgtp4CcMRhQi+O+K2Dwztn34F7R
         7Vkukl7I0TfGaEdCPWB4DF1jmBihUlw4HH0+7CkUQMgvhUYPOrXoIyMLtR3SuQYc1gQj
         7Z+LIz8qDkGoMqCnW2t+PqSKZWm0lBJ8E9MZ3EhdbGQGgL3GmbpyH6K22bEvTLj9+eKr
         uGZ56MOYu7dHCmcxLPueWE8F7wd7krI6pr7Vmr6fB6RZq1j1pUi3k4ScwGbnWb1gWqPu
         5yWjw3ebMnKYPfmJRatOH/zfp5q2xiXRjb7IUTWxFTRKkXYKhTvc103RJQfdqEofoShb
         ofXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qAP5dzqVjJ1/UNcW8HWgPzFOYDWg70LyvfFQzRXxTzQ=;
        b=gbdqjWRToVvBSIklRnckE5TfQStFs7EEbOx5xZOd0+838l45l0yBCAac9rTlBKvevp
         AoNyNddONK9KpRsAoPWzPgcYEw3OLAu2lOwnbH4oiI6E51yAUkDtk39xp6oAv9XvdNHZ
         pBQ6IzXpoop+cF/CECWMT3l0iQnaeziKEqxhUbdv1P/v2g2l21oIsl5r61comzccUFAu
         KWAEBbm7+8QgZNe6OCzKTFSX+Vk+1HDcitv2cH+x+Kz6q7TXh4wVuoBkpWzhFOMoVmko
         RdA34Cc6sMbroeMqsqwKASefRObFtq4S+nEyRw1dtRJ+xjFFQkkBLdpcfJ1XR/APybDO
         5xjA==
X-Gm-Message-State: AGi0PuaB/kMmuPGHRex4V97OSrtCdzR6JAMP0GrOuVn/ZjkUoc3STVVM
        i8u52aTUPf3czPgywyfs2I36Ow==
X-Google-Smtp-Source: APiQypJbf1szRLV+fkXX/8u/vx+eHe31O5PTgScOEapJLc6RobEu0dNQebD5n2VIxPWzClVYUjNR/w==
X-Received: by 2002:a17:90a:30e7:: with SMTP id h94mr28196449pjb.225.1589264219649;
        Mon, 11 May 2020 23:16:59 -0700 (PDT)
Received: from starnight.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.googlemail.com with ESMTPSA id m14sm9660554pgk.56.2020.05.11.23.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 23:16:59 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com, Jian-Hong Pan <jian-hong@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Subject: [PATCH 2/3] ALSA: hda/realtek - Enable headset mic of ASUS UX550GE with ALC295
Date:   Tue, 12 May 2020 14:15:26 +0800
Message-Id: <20200512061525.133985-2-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512061525.133985-1-jian-hong@endlessm.com>
References: <20200512061525.133985-1-jian-hong@endlessm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASUS laptop UX550GE with ALC295 can't detect the headset microphone
until ALC295_FIXUP_ASUS_MIC_NO_PRESENCE quirk applied.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6c996df16201..dcb97b39be6e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8003,6 +8003,10 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x12, 0x90a60130},
 		{0x17, 0x90170110},
 		{0x21, 0x03211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1043, "ASUS", ALC295_FIXUP_ASUS_MIC_NO_PRESENCE,
+		{0x12, 0x90a60120},
+		{0x17, 0x90170110},
+		{0x21, 0x04211030}),
 	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1043, "ASUS", ALC295_FIXUP_ASUS_MIC_NO_PRESENCE,
 		{0x12, 0x90a60130},
 		{0x17, 0x90170110},
-- 
2.26.2

