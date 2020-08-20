Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC18C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6A3220738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597919015;
	bh=XNKaTE2ci2wFaOo4QSprTRSo8NpV/zmGFkbk4YYhCi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qMKqTxatBOElUSljCTcd0pJnZuRjTQ6Gy5TyX14Rn0hYpaaFLa1CUsrmVrRod0GTQ
	 CW451aHqspVSbsbCCCB6TpHhedLy6AYXsec9VbXunbOI5QGvDlDRtW6RGikliNSfdM
	 h0Nfot/e+ZtmjO9yVPm4U0YSp9J1u55msI+QPOp4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731754AbgHTKXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:23:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731702AbgHTKXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:23:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3292020658;
        Thu, 20 Aug 2020 10:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918995;
        bh=XNKaTE2ci2wFaOo4QSprTRSo8NpV/zmGFkbk4YYhCi8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y/3x/9kexqwD34pd4is5DHFXJoM2rJ/l6KOE9SiQ70cNakf1e5GLYP+YY5q+Fmirh
         aHo/lWLDs4dqeK0jMXq3gHqm6d8Gv1TDI8FNFm1LZB7/IASzAz8wPL6Zv52dIaxXao
         eC63QkW5K8FX2MNwyAVqPKFX5xm4ZtPeCJsnHUmA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 146/149] ALSA: echoaudio: Fix potential Oops in snd_echo_resume()
Date:   Thu, 20 Aug 2020 11:23:43 +0200
Message-Id: <20200820092132.765048462@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820092125.688850368@linuxfoundation.org>
References: <20200820092125.688850368@linuxfoundation.org>
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
index d73ee11a32bd0..db14ee43e461a 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -2215,7 +2215,6 @@ static int snd_echo_resume(struct device *dev)
 	if (err < 0) {
 		kfree(commpage_bak);
 		dev_err(dev, "resume init_hw err=%d\n", err);
-		snd_echo_free(chip);
 		return err;
 	}
 
@@ -2242,7 +2241,6 @@ static int snd_echo_resume(struct device *dev)
 	if (request_irq(pci->irq, snd_echo_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, chip)) {
 		dev_err(chip->card->dev, "cannot grab irq\n");
-		snd_echo_free(chip);
 		return -EBUSY;
 	}
 	chip->irq = pci->irq;
-- 
2.25.1



