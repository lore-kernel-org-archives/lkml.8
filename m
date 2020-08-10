Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A331C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C92C22BEA
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597073018;
	bh=RgTeBxgnOs0aVVwj1kr1fdrTxJepd/TLEECd97S0y50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RFtjoA58FXI5BBVlBccUg5x9QNz9UZHqqtAyXLtXkD7JhM/uAlgby3qxSMJeB4nqJ
	 kxJ4eagLg3acyBGKpt8vRC2GNazTw1zq/RtpqeaL4lDfHlexzxWhucKpUJ4As3usw2
	 1pZKlWcgs9HviQ+2jdBTpITR6KhJ289wU27TlYLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgHJPXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:23:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728348AbgHJPXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:23:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 268CB20782;
        Mon, 10 Aug 2020 15:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073013;
        bh=RgTeBxgnOs0aVVwj1kr1fdrTxJepd/TLEECd97S0y50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MYj9n3y4KISxXCHdOoz35ifQHykX5zIyxDG/QIBV7CP+wZm2SMm0ydpQsN7VfyD8C
         hRQXrzi44vtIRrBzoQI6cxT9JXJf/VSztN08Kzym9gSLvZIe9zu61mlmFu7b/8xEg7
         vH9k9gJqK76ao1985ZUK2EA4VRbumdGS3H8uWOYA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Wang <hui.wang@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.7 06/79] Revert "ALSA: hda: call runtime_allow() for all hda controllers"
Date:   Mon, 10 Aug 2020 17:20:25 +0200
Message-Id: <20200810151812.444141840@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151812.114485777@linuxfoundation.org>
References: <20200810151812.114485777@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Wang <hui.wang@canonical.com>

commit 07c9983b567d0ef33aefc063299de95a987e12a8 upstream.

This reverts commit 9a6418487b56 ("ALSA: hda: call runtime_allow()
for all hda controllers").

The reverted patch already introduced some regressions on some
machines:
 - on gemini-lake machines, the error of "azx_get_response timeout"
   happens in the hda driver.
 - on the machines with alc662 codec, the audio jack detection doesn't
   work anymore.

Fixes: 9a6418487b56 ("ALSA: hda: call runtime_allow() for all hda controllers")
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=208511
Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
Link: https://lore.kernel.org/r/20200803064638.6139-1-hui.wang@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_intel.c |    1 -
 1 file changed, 1 deletion(-)

--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2354,7 +2354,6 @@ static int azx_probe_continue(struct azx
 
 	if (azx_has_pm_runtime(chip)) {
 		pm_runtime_use_autosuspend(&pci->dev);
-		pm_runtime_allow(&pci->dev);
 		pm_runtime_put_autosuspend(&pci->dev);
 	}
 


