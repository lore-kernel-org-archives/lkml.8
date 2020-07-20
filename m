Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBDEC433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D03822CBB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595259511;
	bh=RAHLpt3HfUk8J/dPVuswzuUxY8jEpznTGdNieIWYCMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tNKWSCxRwgZ4GYJo44kfAZlJKUE6fNYJ27J9/hhJDGBCKAY39ubIk36chyoXQnAqz
	 491fNBv25vTvdNgbWu1dfuGS4DYDMAm1NBkKO+1Ug4pSc7usM7abi8dizHaSzJgZul
	 Dg3Bs01TFyAvmxbeilapdElfMzsnbp7VQXPdQcOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgGTPia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:38:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728435AbgGTPi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:38:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D2A822CB2;
        Mon, 20 Jul 2020 15:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259506;
        bh=RAHLpt3HfUk8J/dPVuswzuUxY8jEpznTGdNieIWYCMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DMYR2IzzjLm12cgrILbbqQix5Fx+/pHnyJfqa12EUD5urRk1ZAdfYpnFKXBHFFigQ
         ddArB2XjhJy2XSZayBGjRioFKuPKWxfj0hZakTVR9OTHbAebRrHX1nwKEWHdnqhkj5
         y+oarSxxPoOZZk7yEoHeu5TnB5LBii+mw83qUrlg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 32/58] Revert "usb/ohci-platform: Fix a warning when hibernating"
Date:   Mon, 20 Jul 2020 17:36:48 +0200
Message-Id: <20200720152748.754669910@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152747.127988571@linuxfoundation.org>
References: <20200720152747.127988571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 652def4c63b99029fe8b898740f97329c26a2fd3.

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
index 0e5580e6f35cb..c2669f185f658 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -339,11 +339,6 @@ static int ohci_platform_resume(struct device *dev)
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



