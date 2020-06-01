Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F13C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD809206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591034960;
	bh=xtOu0BkIPNelKFK0gXCMhqXoqae2xudnbZ6hnlXt4CI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BueVlmg5Dj7kj1qqqI+A1HMMXKJ69XWZ8q0b1yjPsSAmiBgCdhK3ZZghJASDjKxZ8
	 CnPyIluwVeMDqZXUQZAhzb0J4e0FDjpYIYY89vriiYvO1HkyBSz1kYJAZ5wQ5wPREF
	 c2rNBOFblqNduR/fZOjQU82iVfWC+JkU2SufDm80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730864AbgFASJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:09:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729952AbgFASJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:09:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1BD82068D;
        Mon,  1 Jun 2020 18:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034955;
        bh=xtOu0BkIPNelKFK0gXCMhqXoqae2xudnbZ6hnlXt4CI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VPT3/G+pH+ubYEFsb2L8qyMvdrfGWN7w7gkKYXcwFqm94qEDVTvFgtJkrZ5Gz2tA1
         gY4F/SHnJkBpzLX+UYN525MQ9dWcgt3Hg5WZtDJ89M0fKhAls1LO/xIpTgIH3y5y0u
         GIgiJ0zyK/qk7gGmteX+QFAxxcwJfwKvTLlD6sh8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Changming Liu <liu.changm@northeastern.edu>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 087/142] ALSA: hwdep: fix a left shifting 1 by 31 UB bug
Date:   Mon,  1 Jun 2020 19:54:05 +0200
Message-Id: <20200601174046.921061890@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174037.904070960@linuxfoundation.org>
References: <20200601174037.904070960@linuxfoundation.org>
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
index 00cb5aed10a9..28bec15b0959 100644
--- a/sound/core/hwdep.c
+++ b/sound/core/hwdep.c
@@ -216,12 +216,12 @@ static int snd_hwdep_dsp_load(struct snd_hwdep *hw,
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



