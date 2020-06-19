Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0452C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0EDD21852
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592578411;
	bh=exxodDtRqqIJtISOg9Z587h8XyV029GVrPWQ8BRcD6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aAElFSFUbsQYlniKADXy9b/C/6nB2NMaRW17bYLMXbTnDU6hrniwb5uLa7xR0lhaz
	 +hH5y1pl61I3byiRIc2kYrpvpJ3VEqIh/eHYVgyPHrHbUSE1TRStqggFq7t4wIj9E7
	 Ai2yD3jZotbmumTzlSH9BwxsWkl8/N8xY8KTzIv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389676AbgFSOx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:53:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389727AbgFSOxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:53:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41729217D8;
        Fri, 19 Jun 2020 14:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578397;
        bh=exxodDtRqqIJtISOg9Z587h8XyV029GVrPWQ8BRcD6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lrHuFXmhdt4jgyDA4a5zN98g/nz9U/n0TuHhdwb/fY9pnaO9mJYL2le8R3maFTowu
         0k+bAxHExciLYVDFJPIIz58aR70iuHWjZcWQt0M2FVLsryKRyO9L8GOB0w12nWKe0J
         nd6b5TYo1D95ebvbxjhJ3MlxCBo5QOm44pQFsMyI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH 4.14 166/190] media: go7007: fix a miss of snd_card_free
Date:   Fri, 19 Jun 2020 16:33:31 +0200
Message-Id: <20200619141642.063117885@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141633.446429600@linuxfoundation.org>
References: <20200619141633.446429600@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

commit 9453264ef58638ce8976121ac44c07a3ef375983 upstream.

go7007_snd_init() misses a snd_card_free() in an error path.
Add the missed call to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
[Salvatore Bonaccorso: Adjust context for backport to versions which do
not contain c0decac19da3 ("media: use strscpy() instead of strlcpy()")
and ba78170ef153 ("media: go7007: Fix misuse of strscpy")]
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/go7007/snd-go7007.c |   35 ++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

--- a/drivers/media/usb/go7007/snd-go7007.c
+++ b/drivers/media/usb/go7007/snd-go7007.c
@@ -243,22 +243,18 @@ int go7007_snd_init(struct go7007 *go)
 	gosnd->capturing = 0;
 	ret = snd_card_new(go->dev, index[dev], id[dev], THIS_MODULE, 0,
 			   &gosnd->card);
-	if (ret < 0) {
-		kfree(gosnd);
-		return ret;
-	}
+	if (ret < 0)
+		goto free_snd;
+
 	ret = snd_device_new(gosnd->card, SNDRV_DEV_LOWLEVEL, go,
 			&go7007_snd_device_ops);
-	if (ret < 0) {
-		kfree(gosnd);
-		return ret;
-	}
+	if (ret < 0)
+		goto free_card;
+
 	ret = snd_pcm_new(gosnd->card, "go7007", 0, 0, 1, &gosnd->pcm);
-	if (ret < 0) {
-		snd_card_free(gosnd->card);
-		kfree(gosnd);
-		return ret;
-	}
+	if (ret < 0)
+		goto free_card;
+
 	strlcpy(gosnd->card->driver, "go7007", sizeof(gosnd->card->driver));
 	strlcpy(gosnd->card->shortname, go->name, sizeof(gosnd->card->driver));
 	strlcpy(gosnd->card->longname, gosnd->card->shortname,
@@ -269,11 +265,8 @@ int go7007_snd_init(struct go7007 *go)
 			&go7007_snd_capture_ops);
 
 	ret = snd_card_register(gosnd->card);
-	if (ret < 0) {
-		snd_card_free(gosnd->card);
-		kfree(gosnd);
-		return ret;
-	}
+	if (ret < 0)
+		goto free_card;
 
 	gosnd->substream = NULL;
 	go->snd_context = gosnd;
@@ -281,6 +274,12 @@ int go7007_snd_init(struct go7007 *go)
 	++dev;
 
 	return 0;
+
+free_card:
+	snd_card_free(gosnd->card);
+free_snd:
+	kfree(gosnd);
+	return ret;
 }
 EXPORT_SYMBOL(go7007_snd_init);
 


