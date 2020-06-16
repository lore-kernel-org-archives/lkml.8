Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E82C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EB0E21473
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592322506;
	bh=gGUmW2DrTIls4lFdQDuM1ToOLsMmr9KRvqtR7zLRIM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gL3G1sKCTBfIsgCgNfAwXJm6tX9l1Rw0RrJuDaZ48hsWjl8D4YSxCcTT4zcQsIbUL
	 Fxt9h9/OkMl9hMeJyWMGpo28dnfXNCDWOyEok1jJcyorImplByf5MknXcZPyikKyta
	 qesLssNmN/8wyXibT2BOODiTZqdXu2wwhdtLoaHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731714AbgFPPsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:48:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729390AbgFPPsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:48:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25D832071A;
        Tue, 16 Jun 2020 15:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322493;
        bh=gGUmW2DrTIls4lFdQDuM1ToOLsMmr9KRvqtR7zLRIM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GoOowpgi8676TT45hwS1OLm/ys21b8ht9A6rW2NDUmWpD07oNxqdGwtMio1stqT+l
         vlpZGxAVzuIYl1afY1lDavakwcIADskwrROO5B5viLTlXmVKb/1ZZTRLgmXTXT7CIc
         aHBIWVp7j/Yn5PWH4v4rWDsxCtfL6TMJe/iBVtbs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        kbuild test robot <lkp@intel.com>,
        Alexey Charkov <alchark@gmail.com>,
        Paul Mundt <lethal@linux-sh.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 5.7 124/163] video: vt8500lcdfb: fix fallthrough warning
Date:   Tue, 16 Jun 2020 17:34:58 +0200
Message-Id: <20200616153112.750913113@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.849127260@linuxfoundation.org>
References: <20200616153106.849127260@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>

commit 1c49f35e9e9156273124a0cfd38b57f7a7d4828f upstream.

Fix following warning:
vt8500lcdfb.c: In function 'vt8500lcd_blank':
vt8500lcdfb.c:229:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
      if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR ||
         ^
vt8500lcdfb.c:233:2: note: here
     case FB_BLANK_UNBLANK:
     ^~~~

Adding a simple "fallthrough;" fixed the warning.
The fix was build tested.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reported-by: kbuild test robot <lkp@intel.com>
Fixes: e41f1a989408 ("fbdev: Implement simple blanking in pseudocolor modes for vt8500lcdfb")
Cc: Alexey Charkov <alchark@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: <stable@vger.kernel.org> # v2.6.38+
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200412202143.GA26948@ravnborg.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/vt8500lcdfb.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/video/fbdev/vt8500lcdfb.c
+++ b/drivers/video/fbdev/vt8500lcdfb.c
@@ -230,6 +230,7 @@ static int vt8500lcd_blank(int blank, st
 		    info->fix.visual == FB_VISUAL_STATIC_PSEUDOCOLOR)
 			for (i = 0; i < 256; i++)
 				vt8500lcd_setcolreg(i, 0, 0, 0, 0, info);
+		fallthrough;
 	case FB_BLANK_UNBLANK:
 		if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR ||
 		    info->fix.visual == FB_VISUAL_STATIC_PSEUDOCOLOR)


