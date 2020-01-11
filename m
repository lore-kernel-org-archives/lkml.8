Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB4EC33CA4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B459205F4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578738407;
	bh=wBvesqRv6+JFHdNYD/+gWe4AyEM41kdiYVzP5Y+yzNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XLhA3YC24YxzxMnU0DJvDIaKFf7LFES4YbLH29ROw90wGLsaMNZ91HqC4jrAxKhTb
	 kKXcCPy4Ykac2csuTcvXIwloRaB0lBKqe+xJnolDu9JFEVFqsOp0ZZYGWlW8sxhDZ8
	 hLtYufQamkRxPWvI1gnxbnux0TY5I50TcJxUO+mk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbgAKK0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:26:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:59802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730771AbgAKK0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:26:45 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0F762082E;
        Sat, 11 Jan 2020 10:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578738404;
        bh=wBvesqRv6+JFHdNYD/+gWe4AyEM41kdiYVzP5Y+yzNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aecLYT+K9yU/9r/8UTY65TuFeotjhetZvQZqmOKofUOlrS7oLAMC0MMlcaJ/DaJQv
         xkqFj+uenVgrALYOrCAGLYT5H29MXMQeNvuwwdCALCemAFUUQFY2n+ngGdN89D43xD
         IbVxkwr1Cn1Ew7k/voD24gUDNKeWM7GJ8Ccmqp4o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Stefan=20B=C3=BChler?= <source@stbuehler.de>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 070/165] cfg80211: fix double-free after changing network namespace
Date:   Sat, 11 Jan 2020 10:49:49 +0100
Message-Id: <20200111094927.003403037@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094921.347491861@linuxfoundation.org>
References: <20200111094921.347491861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Bühler <source@stbuehler.de>

[ Upstream commit 56cb31e185adb61f930743a9b70e700a43625386 ]

If wdev->wext.keys was initialized it didn't get reset to NULL on
unregister (and it doesn't get set in cfg80211_init_wdev either), but
wdev is reused if unregister was triggered through
cfg80211_switch_netns.

The next unregister (for whatever reason) will try to free
wdev->wext.keys again.

Signed-off-by: Stefan Bühler <source@stbuehler.de>
Link: https://lore.kernel.org/r/20191126100543.782023-1-stefan.buehler@tik.uni-stuttgart.de
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 350513744575..3e25229a059d 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1102,6 +1102,7 @@ static void __cfg80211_unregister_wdev(struct wireless_dev *wdev, bool sync)
 
 #ifdef CONFIG_CFG80211_WEXT
 	kzfree(wdev->wext.keys);
+	wdev->wext.keys = NULL;
 #endif
 	/* only initialized if we have a netdev */
 	if (wdev->netdev)
-- 
2.20.1



