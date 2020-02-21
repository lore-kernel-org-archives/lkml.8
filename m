Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329E8C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00B624670
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582271403;
	bh=Xdz5g+eobi2ZEQdasmCypMVgaHUhILG5k0/pdY3tblI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bJ8o+YNOVKRfu491OhIN2RH9HzgYyAWxv6n6veugSINlBE8KPTXcP5MqabaRtSpE0
	 RXQyIZb9xP23kzdA8RCMj1/zeU0u+H5+85ogkpDZLLmJ4wmg8jfnSHrJLtko2ENHIo
	 t9H8poQ4PRffHo5wx4DIVnF2LJNj8h7krfYT6yF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbgBUHuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:50:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:46716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728802AbgBUHuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:50:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BF2B24670;
        Fri, 21 Feb 2020 07:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271399;
        bh=Xdz5g+eobi2ZEQdasmCypMVgaHUhILG5k0/pdY3tblI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZUW3XcRDgm5zWTfcEJrenV7zFvsGEVVrOgvj/yZEpNyc5+JJtN35Q9IOZtghzKZP3
         G7s6985JJr6jIsuJAR0Oxi2pTbfNarPK2MM3jeJYgxy8FZdo/gV1bbCROlwBUYrtmu
         1R9m/qsbhoInCMhLbFaLdxg13FgRcVdtwVHDb39A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 150/399] ALSA: usx2y: Adjust indentation in snd_usX2Y_hwdep_dsp_status
Date:   Fri, 21 Feb 2020 08:37:55 +0100
Message-Id: <20200221072417.075883008@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit df4654bd6e42125d9b85ce3a26eaca2935290b98 ]

Clang warns:

../sound/usb/usx2y/usX2Yhwdep.c:122:3: warning: misleading indentation;
statement is not part of the previous 'if' [-Wmisleading-indentation]
        info->version = USX2Y_DRIVER_VERSION;
        ^
../sound/usb/usx2y/usX2Yhwdep.c:120:2: note: previous statement is here
        if (us428->chip_status & USX2Y_STAT_CHIP_INIT)
        ^
1 warning generated.

This warning occurs because there is a space before the tab on this
line. Remove it so that the indentation is consistent with the Linux
kernel coding style and clang no longer warns.

This was introduced before the beginning of git history so no fixes tag.

Link: https://github.com/ClangBuiltLinux/linux/issues/831
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Link: https://lore.kernel.org/r/20191218034257.54535-1-natechancellor@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/usx2y/usX2Yhwdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/usx2y/usX2Yhwdep.c b/sound/usb/usx2y/usX2Yhwdep.c
index d1caa8ed9e681..9985fc139487b 100644
--- a/sound/usb/usx2y/usX2Yhwdep.c
+++ b/sound/usb/usx2y/usX2Yhwdep.c
@@ -119,7 +119,7 @@ static int snd_usX2Y_hwdep_dsp_status(struct snd_hwdep *hw,
 	info->num_dsps = 2;		// 0: Prepad Data, 1: FPGA Code
 	if (us428->chip_status & USX2Y_STAT_CHIP_INIT)
 		info->chip_ready = 1;
- 	info->version = USX2Y_DRIVER_VERSION; 
+	info->version = USX2Y_DRIVER_VERSION;
 	return 0;
 }
 
-- 
2.20.1



