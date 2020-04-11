Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF773C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 05:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F21020757
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 05:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzy2yr4D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgDKFlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 01:41:49 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42620 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgDKFls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 01:41:48 -0400
Received: by mail-io1-f66.google.com with SMTP id y17so3769109iow.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 22:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qbhTq4qHCTksR6oQAJveSfFw7jxUl+wvefeSj00JCLM=;
        b=kzy2yr4Dmx9NuGCeaSsu2gzVwIJ2EHeCtmw1x9dUxPY1eA5JomXZVILNeOPEJqyZn4
         jHoiqFwE/DTPMFm/QecbFJqxy+HTUxQl/Z8Ht+OyYbHuppHrCoqqtiH+tthWu/mVKCe/
         r5IbpHgA80vQuvWB5wuVQK/DWhnzZmJECk0GyhQ6OlVVYB6P6TnlJ10YIPKlF5deUJng
         u+wDc0QnFJOk+AfJ0tJ4eFmBXJrtoHtQp2pW+DqM/4Ltb4uRgH4ZeNEvu4+dt3bKRP8u
         JZG0Az6O8HXo6eZ3T5tW4PmBxuDZZ+8kkItOrxbuNrwx2rvzt9LpgOZ8v3e1YKakbRh+
         Xxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qbhTq4qHCTksR6oQAJveSfFw7jxUl+wvefeSj00JCLM=;
        b=M1JR+lFUBgMav1WKL9Lt42iJ6TpMUGRauNcTILxnmsRuJE9VzS6P4bkS+5XMRu+vh/
         FvlOriKgG8btpdMom3YlVqf+WPYdRBrKHgF8ItqVQUvF6M1WjABul873C/VTytCR1taz
         FGgD64fy6zXpPxaiCaXnfN2XSPLSPFJIHKfCbSsQBKkH559pRDJJVFU3IGUqpK7URPfg
         7enNQxmCOU0QzoU2Dg6yQS5lx7SD+mF/aKBUHWav1e1dPbcpERVeWqqDEuQtjGBrc++R
         p6aF+iB6F4/5zKqSLKXGLIFHl3Bfk4WTnBaqKr/HYK9OrixK51guC5naZeXqvg2bT66w
         Jf2w==
X-Gm-Message-State: AGi0PubjpmGb6jPuOsLikNtInvbM5jDg2V/V3TW8pGnPGJOiEov/itIe
        p/2t6re3hxpfrT0+TT1KOwUAPkN2
X-Google-Smtp-Source: APiQypLqwxq/a73h8fxo8w3kbfd3+Vckw7Tzg5z7HxJi1eg50lKzsiGHM3926fu34oXzQTJg0F0sPA==
X-Received: by 2002:a05:6602:2342:: with SMTP id r2mr7285961iot.177.1586583708599;
        Fri, 10 Apr 2020 22:41:48 -0700 (PDT)
Received: from james-x399.localdomain (97-118-146-253.hlrn.qwest.net. [97.118.146.253])
        by smtp.gmail.com with ESMTPSA id z17sm1469137iln.34.2020.04.10.22.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 22:41:47 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH] component: Silence bind error on -EPROBE_DEFER
Date:   Fri, 10 Apr 2020 23:41:06 -0600
Message-Id: <20200411054106.25366-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a component fails to bind due to -EPROBE_DEFER we should not log an
error as this is not a real failure.

Fixes:
vc4-drm soc:gpu: failed to bind 3f902000.hdmi (ops vc4_hdmi_ops): -517
vc4-drm soc:gpu: master bind failed: -517

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/base/component.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index e97704104784..157c6c790578 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -256,7 +256,8 @@ static int try_to_bring_up_master(struct master *master,
 	ret = master->ops->bind(master->dev);
 	if (ret < 0) {
 		devres_release_group(master->dev, NULL);
-		dev_info(master->dev, "master bind failed: %d\n", ret);
+		if (ret != -EPROBE_DEFER)
+			dev_info(master->dev, "master bind failed: %d\n", ret);
 		return ret;
 	}
 
@@ -611,8 +612,10 @@ static int component_bind(struct component *component, struct master *master,
 		devres_release_group(component->dev, NULL);
 		devres_release_group(master->dev, NULL);
 
-		dev_err(master->dev, "failed to bind %s (ops %ps): %d\n",
-			dev_name(component->dev), component->ops, ret);
+		if (ret != -EPROBE_DEFER) {
+			dev_err(master->dev, "failed to bind %s (ops %ps): %d\n",
+				dev_name(component->dev), component->ops, ret);
+		}
 	}
 
 	return ret;
-- 
2.20.1

