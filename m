Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA078C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7EE2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581701073;
	bh=kLfit3+l6JmuMoFIOggjqVIq/2lixWIxyIbQSNqbNQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n5+znrtF0S4Iy4ZaErbYiPMTDMiuydBkwGJUk3H2vBCTVtt6Y57tjRRpZbwvtU0Io
	 XsderKF01sv76BWhGTuipZBLaAA6YwrUxxkXwrdUSMVYYSZ1WhrqguNgLhWtag8d6M
	 x1Oe1QgfO53ts2n7a/7KzH56Zn5fLF54QQisbD8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391177AbgBNQJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:09:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:60898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391041AbgBNQIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:08:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEFA524650;
        Fri, 14 Feb 2020 16:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696523;
        bh=kLfit3+l6JmuMoFIOggjqVIq/2lixWIxyIbQSNqbNQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ew8I3fD8octTW5/AllIfI7K7dKQaFLoRuc7XHXRpeCesXr/4fGuIOE3NuDByg3wyL
         TZ0ReqmEfwndqRaOfPKqZgjXpTziDZbazeQG14tqrz9BkImdfU2+VQq/OUR5LmWI6w
         AS4pf2ovRcVUCsOmg0uFY9N/UIEZw1p5maVFQOFI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.4 323/459] ALSA: usb-audio: unlock on error in probe
Date:   Fri, 14 Feb 2020 10:59:33 -0500
Message-Id: <20200214160149.11681-323-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit a3afa29942b84b4e2548beacccc3a68b8d77e3dc ]

We need to unlock before we returning on this error path.

Fixes: 73ac9f5e5b43 ("ALSA: usb-audio: Add boot quirk for MOTU M Series")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/20200115174604.rhanfgy4j3uc65cx@kili.mountain
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index e6a618a239948..54f9ce38471e6 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -599,7 +599,7 @@ static int usb_audio_probe(struct usb_interface *intf,
 	if (! chip) {
 		err = snd_usb_apply_boot_quirk_once(dev, intf, quirk, id);
 		if (err < 0)
-			return err;
+			goto __error;
 
 		/* it's a fresh one.
 		 * now look for an empty slot and create a new card instance
-- 
2.20.1

