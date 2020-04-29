Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1991CC83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA2852070B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rF05JE99"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgD2KG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgD2KGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 06:06:53 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFEAC03C1AD;
        Wed, 29 Apr 2020 03:06:52 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id h4so1354937wmb.4;
        Wed, 29 Apr 2020 03:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K7tV0HkT7HrwkRP5DztAp91Q49aDaAWOUuwdASD/KEg=;
        b=rF05JE99smwY21LygzHWkyP9ZOixx+Xowt/nid3jshRTyRymbu4qrcFO6C1wAH7yYR
         +rVY7f3hwXkj4x9/XcJOBXh/Kx328F92FSKgjv8OihGSJFMMonzEGsPHWux91FYj1haW
         KZ0UzIeecYZ40m4aC3wU5T3Rgafjdc3NmLMiDWHug5CUvYBxpq5EDH6UzwgShT2d0J9Q
         huYLXsuln4s9W+5xOe9sD7HngHevHno1QR/NgLGG6Iv9ttCKeuluqe/uoJI9rPexhMBz
         9VU041oytVG54JyrzKKIOnW4hpf+bRzTPqPDFhiDwJzJphaE3HMEaitRo31sb/tlA/xf
         nx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K7tV0HkT7HrwkRP5DztAp91Q49aDaAWOUuwdASD/KEg=;
        b=WeK4wsaUF6JKTTOFaVfKssY4+MxQTyoce17gbl6OejGv8gV15YftRQKHV5xhFnAPCy
         zcKJvWycnzkv9SleEVTcRRveEACu4Oy6oUKDynFK7wZqvBAozvJBSzU30tI6La5gt1TR
         0zFCFWVd+XXpvQod80i1AHHV+uJVjtek/HKn0sT5Znc3k0AAT7RzdWE0SR+ZA4TUFox0
         5Xsi59ec6ffkyphETcw5pIR7U3U45saTPLJvsXprhU4qDOz+EkLpDnI/m7uQfRuW8zRl
         gd1MklDslTni3rqi1NpNmyHHx3s+klsZg6Zqta24lc/BcUeUVM/X/bufTwK/2kDtWfVI
         Klyg==
X-Gm-Message-State: AGi0PuY4XUqGgd+F6GPVL6hqAa/ZS4m8+XkktVFE73G8AqBnndgvBPYm
        2hJRy0e3HI7rgm8fjAyDk94SI2xwF+cu
X-Google-Smtp-Source: APiQypLpS2S0arKeoQ1LomvTgUgegpl97drINHcjvkKeuRGh7izrg5b2ownig4pnsowwRP/3kTZpMw==
X-Received: by 2002:a05:600c:2dcf:: with SMTP id e15mr2497790wmh.171.1588154811040;
        Wed, 29 Apr 2020 03:06:51 -0700 (PDT)
Received: from ninjahost.lan (host-2-102-14-195.as13285.net. [2.102.14.195])
        by smtp.gmail.com with ESMTPSA id 1sm7205478wmi.0.2020.04.29.03.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 03:06:50 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "Jacky.Cao@sony.com" <Jacky.Cao@sony.com>,
        linux-usb@vger.kernel.org (open list:USB GADGET/PERIPHERAL SUBSYSTEM)
Subject: [PATCH 5/6] USB: dummy-hcd: Add missing annotation for set_link_state()
Date:   Wed, 29 Apr 2020 11:05:27 +0100
Message-Id: <20200429100529.19645-6-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200429100529.19645-1-jbi.octave@gmail.com>
References: <0/6>
 <20200429100529.19645-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at set_link_state()

warning: context imbalance in set_link_state() - unexpected unlock

The root cause is the missing annotation at set_link_state()
Add the missing __must_hold(&dum->lock)

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/usb/gadget/udc/dummy_hcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index 4c9d1e49d5ed..c07ddf11e137 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -427,6 +427,7 @@ static void set_link_state_by_speed(struct dummy_hcd *dum_hcd)
 
 /* caller must hold lock */
 static void set_link_state(struct dummy_hcd *dum_hcd)
+	__must_hold(&dum->lock)
 {
 	struct dummy *dum = dum_hcd->dum;
 	unsigned int power_bit;
-- 
2.25.3

