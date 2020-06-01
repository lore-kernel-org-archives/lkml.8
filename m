Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8311C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B97AF206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591038094;
	bh=vrLs+xDMQUVAbWyqFt4x9YHsfhR9mx60FazFXQuCg90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BDiks1b0aPMqC7KdkYDEEWWDl7rgjbMEW/xheo/YEyq/MV7/NtniDJrFHT9QvTXuW
	 JZBH7gc2BrNfn6lBM+gxL7bCf58YAWwcAswfvCccuv1D1rQsHqhrXAMfZxFyTNRANv
	 7B75MX0D6MM2GAn8CxNTjW5lgDc7RHeXU3f6FthU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbgFATBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 15:01:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728409AbgFAR4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:56:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1B83206E2;
        Mon,  1 Jun 2020 17:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034160;
        bh=vrLs+xDMQUVAbWyqFt4x9YHsfhR9mx60FazFXQuCg90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oC6vdb7928kTV15z/aZV8ABz7ICC9ukjr1+mXQktObOt6Pvj0d1pgeAKMDbXQFTxy
         F5HvmUNm1UI+bhifYIRoSPibBQ7b8Jcci0PRLgd1rVysnlzIaILkV/FJdyaecKy8zD
         yO9WSYkuQgXT6RmYV8ro19nhsJO4KgFKKD2ysEfU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Changming Liu <liu.changm@northeastern.edu>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 19/48] ALSA: hwdep: fix a left shifting 1 by 31 UB bug
Date:   Mon,  1 Jun 2020 19:53:29 +0200
Message-Id: <20200601173958.202755574@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601173952.175939894@linuxfoundation.org>
References: <20200601173952.175939894@linuxfoundation.org>
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
index 36d2416f90d9..96b737adf4d2 100644
--- a/sound/core/hwdep.c
+++ b/sound/core/hwdep.c
@@ -228,14 +228,14 @@ static int snd_hwdep_dsp_load(struct snd_hwdep *hw,
 	if (copy_from_user(&info, _info, sizeof(info)))
 		return -EFAULT;
 	/* check whether the dsp was already loaded */
-	if (hw->dsp_loaded & (1 << info.index))
+	if (hw->dsp_loaded & (1u << info.index))
 		return -EBUSY;
 	if (!access_ok(VERIFY_READ, info.image, info.length))
 		return -EFAULT;
 	err = hw->ops.dsp_load(hw, &info);
 	if (err < 0)
 		return err;
-	hw->dsp_loaded |= (1 << info.index);
+	hw->dsp_loaded |= (1u << info.index);
 	return 0;
 }
 
-- 
2.25.1



