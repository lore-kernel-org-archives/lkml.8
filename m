Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DB5C47258
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D43520707
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615188;
	bh=GZXs/27IPQdcxPnSRMLXpJDcuFGzqUfF4jVTSEXs3i8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mUNndItJPpCeBT18lflB8DpUYPnqVefrR8is/nBoHC7frQI/U6JH+e29kh1+AtUkw
	 o69vE7NeNh8FkTESzk/ETO7wEZ9S3atzZM89BkOWEGu2VAWnN6fEy6OX40PAxJl3hO
	 rvDodahrHbOi+MCCc7aroOa9K7f9TZ4YS+f11ts4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbgEDR7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:59:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730861AbgEDR7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:59:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45FD0207DD;
        Mon,  4 May 2020 17:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615184;
        bh=GZXs/27IPQdcxPnSRMLXpJDcuFGzqUfF4jVTSEXs3i8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fBoTmO4P9LWCevdXLgA0JrXh89BbD+DzCu5sxuicFI2lVfIQaOLKy9yyISuvd+r3D
         jeyTzP9qR95vnNqPnBvaeH7f1RQBN2goKbAmifnWW+ajV29KPEc9hsfqISUrFL4isT
         BNK6sktNs0uh9arrbFvYY64lio/+tVgMo9Ih/THo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wu Bo <wubo40@huawei.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 06/18] ALSA: hda/hdmi: fix without unlocked before return
Date:   Mon,  4 May 2020 19:57:16 +0200
Message-Id: <20200504165443.451800031@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165442.028485341@linuxfoundation.org>
References: <20200504165442.028485341@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wu Bo <wubo40@huawei.com>

commit a2f647240998aa49632fb09b01388fdf2b87acfc upstream.

Fix the following coccicheck warning:
sound/pci/hda/patch_hdmi.c:1852:2-8: preceding lock on line 1846

After add sanity check to pass klockwork check,
The spdif_mutex should be unlock before return true
in check_non_pcm_per_cvt().

Fixes: 960a581e22d9 ("ALSA: hda: fix some klockwork scan warnings")
Signed-off-by: Wu Bo <wubo40@huawei.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/1587907042-694161-1-git-send-email-wubo40@huawei.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_hdmi.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1699,8 +1699,10 @@ static bool check_non_pcm_per_cvt(struct
 	/* Add sanity check to pass klockwork check.
 	 * This should never happen.
 	 */
-	if (WARN_ON(spdif == NULL))
+	if (WARN_ON(spdif == NULL)) {
+		mutex_unlock(&codec->spdif_mutex);
 		return true;
+	}
 	non_pcm = !!(spdif->status & IEC958_AES0_NONAUDIO);
 	mutex_unlock(&codec->spdif_mutex);
 	return non_pcm;


