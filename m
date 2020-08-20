Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F08C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EB272078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597925966;
	bh=diE3N2CBro8OHsuIjnaYGxC4OcsqUFKElYd2GeKgqc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i17f9zbWKe+ox8n+7IzQjEti/GLlunDrmCKBRn0XD3XLrlZbdwuimo0hkljwzj7zI
	 INdtmUp4/QRZMzXO2+COBiQS9CfdU4uNRGV45pzDLgsg8oaL6Ha1COHVafhEcYG6Oy
	 tmRzTUEQ9t6amrptPIw0XNVrZub5atOY5int/FGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgHTMTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:19:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730246AbgHTJ4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:56:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 652BE20855;
        Thu, 20 Aug 2020 09:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917363;
        bh=diE3N2CBro8OHsuIjnaYGxC4OcsqUFKElYd2GeKgqc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uOsuaHlGYLcZCzcDlKl9vz8J3Ig7UCJ8Pr42wbct6jZqkJU7T+GyuNOG2QfkKdq4Z
         xu+pKqRmJkd1TR19gxRRssThthU1LMgKGE9pnhQcojBDpu8kobwq1Ps0oWoGAEp4j3
         WNaReu1MfULWcOmk72kV3lEt4lV/dA4FNbesIOY4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 84/92] ALSA: echoaudio: Fix potential Oops in snd_echo_resume()
Date:   Thu, 20 Aug 2020 11:22:09 +0200
Message-Id: <20200820091542.011298432@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091537.490965042@linuxfoundation.org>
References: <20200820091537.490965042@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit 5a25de6df789cc805a9b8ba7ab5deef5067af47e ]

Freeing chip on error may lead to an Oops at the next time
the system goes to resume. Fix this by removing all
snd_echo_free() calls on error.

Fixes: 47b5d028fdce8 ("ALSA: Echoaudio - Add suspend support #2")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Link: https://lore.kernel.org/r/20200813074632.17022-1-dinghao.liu@zju.edu.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/echoaudio/echoaudio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index 3ef2b27ebbe8c..f32c55ffffc79 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -2216,7 +2216,6 @@ static int snd_echo_resume(struct device *dev)
 	if (err < 0) {
 		kfree(commpage_bak);
 		dev_err(dev, "resume init_hw err=%d\n", err);
-		snd_echo_free(chip);
 		return err;
 	}
 
@@ -2243,7 +2242,6 @@ static int snd_echo_resume(struct device *dev)
 	if (request_irq(pci->irq, snd_echo_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, chip)) {
 		dev_err(chip->card->dev, "cannot grab irq\n");
-		snd_echo_free(chip);
 		return -EBUSY;
 	}
 	chip->irq = pci->irq;
-- 
2.25.1



