Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8677CC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55AB32192A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579197808;
	bh=vF+m8hLWBYBYcX86G22Uo9puk7KaPTDLePvT7xAYpJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vMLg3AOLE8V0wKa9GAzk7gKp4nx2/vIUCReWVtqlYngRwa9gWhptxUJAuT7prs/O0
	 p6idTp5x1hCC4cAkrI+zO5aT5eSZdVvB7U126bfFD+HTqOuTTx1A4HtRcyAROKNvim
	 dSqlBM/3BsMZbuV0Xu9Yi8SpAxHr7dOqmZLgkDx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393712AbgAPRkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:40:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:56658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393556AbgAPRj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:39:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A24524710;
        Thu, 16 Jan 2020 17:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196395;
        bh=vF+m8hLWBYBYcX86G22Uo9puk7KaPTDLePvT7xAYpJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R01jFIGb0WxH+xGSZ+9xQy2HmiACQS+SpxIQ2I73//4w2fViwozpy9dkKIl7TtjW8
         EWfQf0CWvYFmCoMD6HwR4zQpEXKdxYOfLzPR1DMkUhK4nBv51gkXTh8faM0msoZnR0
         KCtdZ++nnjojnztLKqWUFOag6xF4XxPm6FbhD0hw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.9 174/251] ALSA: aoa: onyx: always initialize register read value
Date:   Thu, 16 Jan 2020 12:35:23 -0500
Message-Id: <20200116173641.22137-134-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes@sipsolutions.net>

[ Upstream commit f474808acb3c4b30552d9c59b181244e0300d218 ]

A lot of places in the driver use onyx_read_register() without
checking the return value, and it's been working OK for ~10 years
or so, so probably never fails ... Rather than trying to check the
return value everywhere, which would be relatively intrusive, at
least make sure we don't use an uninitialized value.

Fixes: f3d9478b2ce4 ("[ALSA] snd-aoa: add snd-aoa")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/aoa/codecs/onyx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/aoa/codecs/onyx.c b/sound/aoa/codecs/onyx.c
index a04edff8b729..ae50d59fb810 100644
--- a/sound/aoa/codecs/onyx.c
+++ b/sound/aoa/codecs/onyx.c
@@ -74,8 +74,10 @@ static int onyx_read_register(struct onyx *onyx, u8 reg, u8 *value)
 		return 0;
 	}
 	v = i2c_smbus_read_byte_data(onyx->i2c, reg);
-	if (v < 0)
+	if (v < 0) {
+		*value = 0;
 		return -1;
+	}
 	*value = (u8)v;
 	onyx->cache[ONYX_REG_CONTROL-FIRSTREGISTER] = *value;
 	return 0;
-- 
2.20.1

