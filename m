Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6277DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38D43207D0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591037519;
	bh=G//XOzUJ0Xz0SRGApteYh963dc2gtUMjNDCmrwGsjoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=abpI3xmnqj9Qr4AiMIyZLamQvVYrUX88MZG1o4HHPmGCDP52Jy6Nkn5MU4ybwpKbt
	 KcCiNDUyShmM7IXrscXiU75L1/qk8d1AEbiEaEKOqR3qlKOpZ+He6WkTJ7MijA1DAd
	 bv8SihPWmRdXhCVsG0G0lCF8cyqChh9DRIpliUvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbgFASv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:51:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729735AbgFASEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:04:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04DF7206E2;
        Mon,  1 Jun 2020 18:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034671;
        bh=G//XOzUJ0Xz0SRGApteYh963dc2gtUMjNDCmrwGsjoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JwjQqk0oeyp08+gQYndAiAYF+0RJKeMZk9FrEE7p0lNTZ7toIY5IDHuU15U+QNmIH
         iUdjQJkMurbUuf2bBDgZTtKU9Xfy368maKNGLCrtdvoLuoQoMsHzsZXGC0h6B8n+Y5
         xKwcW1ivr5wiBaU7zhPcb8p0LAPIHRnyO4rqNV8E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Changming Liu <liu.changm@northeastern.edu>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 57/95] ALSA: hwdep: fix a left shifting 1 by 31 UB bug
Date:   Mon,  1 Jun 2020 19:53:57 +0200
Message-Id: <20200601174030.222878432@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174020.759151073@linuxfoundation.org>
References: <20200601174020.759151073@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changming Liu <liu.changm@northeastern.edu>

[ Upstream commit fb8cd6481ffd126f35e9e146a0dcf0c4e8899f2e ]

The "info.index" variable can be 31 in "1 << info.index".
This might trigger an undefined behavior since 1 is signed.

Fix this by casting 1 to 1u just to be sure "1u << 31" is defined.

Signed-off-by: Changming Liu <liu.changm@northeastern.edu>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/BL0PR06MB4548170B842CB055C9AF695DE5B00@BL0PR06MB4548.namprd06.prod.outlook.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/hwdep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/hwdep.c b/sound/core/hwdep.c
index 26e71cf05f1e..600ab2eb1b50 100644
--- a/sound/core/hwdep.c
+++ b/sound/core/hwdep.c
@@ -231,12 +231,12 @@ static int snd_hwdep_dsp_load(struct snd_hwdep *hw,
 	if (info.index >= 32)
 		return -EINVAL;
 	/* check whether the dsp was already loaded */
-	if (hw->dsp_loaded & (1 << info.index))
+	if (hw->dsp_loaded & (1u << info.index))
 		return -EBUSY;
 	err = hw->ops.dsp_load(hw, &info);
 	if (err < 0)
 		return err;
-	hw->dsp_loaded |= (1 << info.index);
+	hw->dsp_loaded |= (1u << info.index);
 	return 0;
 }
 
-- 
2.25.1



