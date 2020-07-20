Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FF2C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E6B122D01
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595259714;
	bh=KS087m6knmPHkIkshHeQow837Jdyt/kSvWAM/RURMO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p2PlreyaSlWW3sErT0HStiO/YO45M3+cyWVRPpfMyDY+ca2olys9Y+iJ8vSeF7m8w
	 KybGlRj/ifjjuW1gZe9sJKgGWk8i7ritogWp8WLGVy8m4Ho52kqonlmNNZ8/wg9jo7
	 7WovrMid3q/n8NKXTSnsMkl/9Xdx+WdVO0yi80+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgGTPlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:41:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729269AbgGTPlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:41:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E12E2064B;
        Mon, 20 Jul 2020 15:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259708;
        bh=KS087m6knmPHkIkshHeQow837Jdyt/kSvWAM/RURMO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PJA6PPcoy+vpCI0ki+/LbCFbBH8HoQ2UrpwKRgz9tjN08ixNgHiyiqovPyqgGPw8l
         MI/yT/CCI1uXHSBljVodjtM37qmchVK6rJLvxuIFlNYDIegoid/vCORBNlYktSLJ4b
         szfw79Iqh4gX60yOrsrgqTvMu1SEBSqLN8bDXsC0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 51/86] Revert "usb/ohci-platform: Fix a warning when hibernating"
Date:   Mon, 20 Jul 2020 17:36:47 +0200
Message-Id: <20200720152755.730521409@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152753.138974850@linuxfoundation.org>
References: <20200720152753.138974850@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 104592a5233d77322c3e527e3925dc7c5a30a6af.

Eugeniu Rosca writes:

On Thu, Jul 09, 2020 at 09:00:23AM +0200, Eugeniu Rosca wrote:
>After integrating v4.14.186 commit 5410d158ca2a50 ("usb/ehci-platform:
>Set PM runtime as active on resume") into downstream v4.14.x, we started
>to consistently experience below panic [1] on every second s2ram of
>R-Car H3 Salvator-X Renesas reference board.
>
>After some investigations, we concluded the following:
> - the issue does not exist in vanilla v5.8-rc4+
> - [bisecting shows that] the panic on v4.14.186 is caused by the lack
>   of v5.6-rc1 commit 987351e1ea7772 ("phy: core: Add consumer device
>   link support"). Getting evidence for that is easy. Reverting
>   987351e1ea7772 in vanilla leads to a similar backtrace [2].
>
>Questions:
> - Backporting 987351e1ea7772 ("phy: core: Add consumer device
>   link support") to v4.14.187 looks challenging enough, so probably not
>   worth it. Anybody to contradict this?
> - Assuming no plans to backport the missing mainline commit to v4.14.x,
>   should the following three v4.14.186 commits be reverted on v4.14.x?
>   * baef809ea497a4 ("usb/ohci-platform: Fix a warning when hibernating")
>   * 9f33eff4958885 ("usb/xhci-plat: Set PM runtime as active on resume")
>   * 5410d158ca2a50 ("usb/ehci-platform: Set PM runtime as active on resume")

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/ohci-platform.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index 9e3fdb1421f75..898b74086c129 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -340,11 +340,6 @@ static int ohci_platform_resume(struct device *dev)
 	}
 
 	ohci_resume(hcd, false);
-
-	pm_runtime_disable(dev);
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
-
 	return 0;
 }
 #endif /* CONFIG_PM_SLEEP */
-- 
2.25.1



