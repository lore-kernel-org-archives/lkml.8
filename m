Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5A4C35241
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 05:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB252075E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 05:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YqVP5RP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgAYFDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 00:03:02 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44479 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgAYFDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 00:03:02 -0500
Received: by mail-pg1-f196.google.com with SMTP id x7so2174444pgl.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 21:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=05BwadZAGfXvZZEsxjYXT6rUqTTFlTQilEFLvptCJPo=;
        b=YqVP5RP5xWZB4sBJe1HZmHil9OccC9kl0tb3x7bCu9FXcd3tLyp/E4T+9HCW29SFiH
         /R9M1zD7d+9dK50ijCitMnpwNHvthrOgqaPSCINcxLd3uWupPEqxFwzNeK4rSmJfFwNq
         sUT/Lp79stAriASB+JUvBFs9zWbljhPJ/M7HI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=05BwadZAGfXvZZEsxjYXT6rUqTTFlTQilEFLvptCJPo=;
        b=Q/hDslcuPscgPhwCAFPNCnj2UgwAa5OB0LW/0jVeLIsqL7nI+nYXqDoOtcK+Eiy/hh
         E7qGcREjgc9g7jFSUVErxN0dti+++DlbkG/iJCGr2dqNoixx6oEmyAxfDEMQ8ZsI3I8X
         2rOx9RsQ0GnVfbugoz7oy2QZUluMGmHaFmpDilPaCSZOJaWXvRwM5W+UCu5Fe7xa5Jx6
         htTEN+g8Ry3Xhpmwp+yjrlM8GW0e86ZBOtHzhvSOuywizt//6bfjWD02a3rpxfeqIokD
         1QGjhDygeAJvE+ySkr/w5t/vYvUmG6JP6q65qIqnC1duYX4KNnpprJmzg3NEpByOAmSq
         ZuBQ==
X-Gm-Message-State: APjAAAVwA1onWXxetDWuX56x5felsluNBfTkC4u9cLWQ6RlHBYZD6jFO
        tm54UyxwzZtniOaBBp8WtNlXiA==
X-Google-Smtp-Source: APXvYqxK+vtPL+z8xvYRLD8IJT1FQr68iAfYTPHNHxqoHdUX5xJ5q8BUhQoyEnM+MfyCkMYQBqJrIg==
X-Received: by 2002:a62:7681:: with SMTP id r123mr6479112pfc.169.1579928581217;
        Fri, 24 Jan 2020 21:03:01 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id u12sm7896585pfm.165.2020.01.24.21.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 21:03:00 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Jitao Shi <jitao.shi@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel: Fix boe,tv101wum-n53 htotal timing
Date:   Sat, 25 Jan 2020 13:02:56 +0800
Message-Id: <20200125050256.107404-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The datasheet suggests 60 for tHFP, so let's adjust the number
accordingly.

This also makes the framerate be 60Hz as intended:
159916.0 * 1000 / ((1200 + 80 + 24 + 60)*(1920 + 20 + 4 + 10))
=> 60.00 Hz

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

---

This also matches the values that we use in our chromeos-4.19
vendor kernel.

Applies on top or drm-misc/drm-misc-next.

 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index 01faf8597700005..48a164257d18c35 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -645,7 +645,7 @@ static const struct drm_display_mode boe_tv101wum_n53_default_mode = {
 	.hdisplay = 1200,
 	.hsync_start = 1200 + 80,
 	.hsync_end = 1200 + 80 + 24,
-	.htotal = 1200 + 80 + 24 + 40,
+	.htotal = 1200 + 80 + 24 + 60,
 	.vdisplay = 1920,
 	.vsync_start = 1920 + 20,
 	.vsync_end = 1920 + 20 + 4,
-- 
2.25.0.341.g760bfbb309-goog

