Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA96BC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7F692067D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rEH/qBTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbgGMOuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730231AbgGMOuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:50:01 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9B0C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:50:00 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 17so13432695wmo.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aFwIxeC0MRqXJsoytVI2+bLE6Gwn1R4iqaYqzA7pZ0g=;
        b=rEH/qBTmc+y3WcbvEW5HE26Q7gP5vAFhKpId5HT7gUQfO9PJnht02sjqO5L70L31iM
         yFxfvi1mawGzA4mETQv/ji+tb6meLxCOLAMRWqf65Zft1eLgi5AbY6x3Cl6vR6DeUoj6
         3Lz1+tt/VtQkJBfasqV5U56xpJcndeMGD8C9FTYFAYHu4tQHtV8/0Q8zfL7OcpYFfdJk
         9cszBFYkqWFCTApiN1+H3IdQs1I30swZDgm/PAcGWJ7OerUZBbLHUVTzIaFiH5DQ6R6k
         WoeP+HvgvUfvsbCcfx4DbBFI9NqJ1LTZTRbOrpjxmj6m0C1y9VgiRtxud86pekb1EQNf
         eohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aFwIxeC0MRqXJsoytVI2+bLE6Gwn1R4iqaYqzA7pZ0g=;
        b=egmZhdKZ3nl0IWOBTI4I7pabUxDpMYWzth/76rAtxYI5c1ef87/MDcPRmZgl5Qxtsu
         OaeFsjObzD9tZO4sUx+J5IWdN/7J7Vxg4aapdiOgu5ZiQlxANbyqB7dLoKHL/vY5Gjrw
         6mnxd3rMLQ7A1ggCeGuwOCmM7zoTuy67oR1MV474fXu78JN9bUhuEqQ8ihp17c22vjhN
         rX6hOMN4lLVnIcNhmr0GIqzn5rvMxar1fbtnr3DqWhXdx/uBzTlH+wFBQELs39oFHDSX
         79uYNOl4hen76Pk+vIITTW/tBGU6brjd9NJiI4NTWFbmlv0MaUEIbaLo33ICpXr85IYS
         kDwA==
X-Gm-Message-State: AOAM533YaDA28umotP0U2CTlwSr49sH99aZ/eAM83c0zyeMQvn6QNYku
        ublEDgfgot+XAcZbS6LEfy3lPw==
X-Google-Smtp-Source: ABdhPJzRrpYQLlGQ0j8eOJpUthd5lhnK5oJBTKSQmesAb1tkkf+veB/fF9ViLbgb7E7HlUT8v+xyWQ==
X-Received: by 2002:a1c:7fd7:: with SMTP id a206mr321234wmd.104.1594651799733;
        Mon, 13 Jul 2020 07:49:59 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id o29sm26207756wra.5.2020.07.13.07.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 07:49:59 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH 24/25] pinctrl: mvebu: pinctrl-armada-37xx: Update documentation block for 'struct armada_37xx_pin_group'
Date:   Mon, 13 Jul 2020 15:49:29 +0100
Message-Id: <20200713144930.1034632-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713144930.1034632-1-lee.jones@linaro.org>
References: <20200713144930.1034632-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct misspellings and provide missing entries.

Fixes the following W=1 kernel build warning(s):

 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c:68: warning: Function parameter or member 'start_pin' not described in 'armada_37xx_pin_group'
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c:68: warning: Function parameter or member 'val' not described in 'armada_37xx_pin_group'
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c:68: warning: Function parameter or member 'extra_pin' not described in 'armada_37xx_pin_group'
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c:68: warning: Function parameter or member 'extra_npins' not described in 'armada_37xx_pin_group'

Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index 5f125bd6279dd..953126bf6657b 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -45,13 +45,14 @@
  * The pins of a pinmux groups are composed of one or two groups of contiguous
  * pins.
  * @name:	Name of the pin group, used to lookup the group.
- * @start_pins:	Index of the first pin of the main range of pins belonging to
+ * @start_pin:	Index of the first pin of the main range of pins belonging to
  *		the group
  * @npins:	Number of pins included in the first range
  * @reg_mask:	Bit mask matching the group in the selection register
- * @extra_pins:	Index of the first pin of the optional second range of pins
+ * @val:	Value to write to the registers for a given function
+ * @extra_pin:	Index of the first pin of the optional second range of pins
  *		belonging to the group
- * @npins:	Number of pins included in the second optional range
+ * @extra_npins:Number of pins included in the second optional range
  * @funcs:	A list of pinmux functions that can be selected for this group.
  * @pins:	List of the pins included in the group
  */
-- 
2.25.1

