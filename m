Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED2AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9442920663
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mM0dkv5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgFEOVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729029AbgFEOVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:21:25 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFA4C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 07:21:24 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u5so5202971pgn.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 07:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=yGP/Kfk+N8F8iZAeQuKesLiAArFiMOYLOk6KSc6Id+U=;
        b=mM0dkv5fgPUEDI5+Ig/8tYdMEQmoq5Dzw8QTDcSds5R0+fQNHXb4dUYu1nC+79LLo5
         AASqF7MxiF78fW0sLSHZTi7h9+wBVO8sWFHgviQ/Eb398TEPl1k94wIUW4Oxz2pozRcS
         qXcKXSCrV1kTgEZCQM4OOzAsC2tk6MzytRuZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=yGP/Kfk+N8F8iZAeQuKesLiAArFiMOYLOk6KSc6Id+U=;
        b=Q4CB1iZWMPissc/Ge0KWSRLyzyZbFFeuo+r01+di4YTv86baGadzOcIFmVOe0y80h3
         cLs8K1kR5N57r1u+mEY8K97RoID7ZxsVMlQnsHzLoSMRcyS1NjM4M0wNfq9BAzM2xtU/
         IRpTKt6pOpLMFntbowOln/Yqz2+VgHmOE1XWVrFt25eyFb6GWOmuw17xT9zoaXTVMlX7
         tDkAhc2ZLy/JHqSm3TQeQKg7n02dLnDJcm78xJ6WJTH7CA3v/40Msc5IUgzmtegDnXXp
         Cx/UiqFmc8znIePefW09VtiRAqa2Bc6CawJKw0VHtAIdD0Kb70b1KdMyFCUFkWMX+FIZ
         Gaiw==
X-Gm-Message-State: AOAM533iS8uEKnvPlBSkuKKIAEESFmI8W/fFBeOmy7ic/L+8zUYKBBMp
        suIteAxTg1R0ZRGbBLVK5af/Mw==
X-Google-Smtp-Source: ABdhPJwKFbHKpewYCO4uc2+sCQtwLv9h6tPVlXqTY10U5LySFMOcXvTJZbnlv1WBth8q9WueJjPOZw==
X-Received: by 2002:a63:3347:: with SMTP id z68mr10089302pgz.61.1591366883923;
        Fri, 05 Jun 2020 07:21:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x191sm7750890pfd.37.2020.06.05.07.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 07:21:23 -0700 (PDT)
Date:   Fri, 5 Jun 2020 07:21:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Joe Perches <joe@perches.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: ethtool: Fix comment mentioning typo in IS_ENABLED()
Message-ID: <202006050720.D741B4C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has no code changes, but it's a typo noticed in other clean-ups,
so we might as well fix it. IS_ENABLED() takes full names, and should
have the "CONFIG_" prefix.

Reported-by: Joe Perches <joe@perches.com>
Link: https://lore.kernel.org/lkml/b08611018fdb6d88757c6008a5c02fa0e07b32fb.camel@perches.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/ethtool_netlink.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ethtool_netlink.h b/include/linux/ethtool_netlink.h
index 8fbe4f97ffad..1e7bf78cb382 100644
--- a/include/linux/ethtool_netlink.h
+++ b/include/linux/ethtool_netlink.h
@@ -67,5 +67,5 @@ static inline int ethnl_cable_test_step(struct phy_device *phydev, u32 first,
 {
 	return -EOPNOTSUPP;
 }
-#endif /* IS_ENABLED(ETHTOOL_NETLINK) */
+#endif /* IS_ENABLED(CONFIG_ETHTOOL_NETLINK) */
 #endif /* _LINUX_ETHTOOL_NETLINK_H_ */
-- 
2.25.1


-- 
Kees Cook
