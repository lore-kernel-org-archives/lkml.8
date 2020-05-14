Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0DDC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 655D32065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589483024;
	bh=0R8mz2R+nq6sMxuEDlBQl2ByD9/WeJn9V11MB1lxkeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ix46svWlSWmJ2aDGLP0o2muiAvJpZWMwjqZm3jFVRST4jpCueLLkyURiMtPWv3VKg
	 9MfI2yhc5twxq0eNcxTxZnKrJGpxNicYY5zoRekIrH9JKH1evUKTPdX2lEbTMlAEQI
	 RzytKwklNPFNGKFvIvUJtKrfdHgMrEF8FuGmLx7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbgENSym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 14:54:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729024AbgENSyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:54:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE5D820767;
        Thu, 14 May 2020 18:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482461;
        bh=0R8mz2R+nq6sMxuEDlBQl2ByD9/WeJn9V11MB1lxkeo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ueJ3hq/X4UY4CfD+K3V0BrhGuqBUDj1eW5esosSmbVVE8XXFUZiUI95WN0hqtoX0q
         mkz0cXQQMVjM+j7qxBcsMhBCP9uDzAPGFs4N4NT5U7qzAZRs6cS7HwSMjrWG/EEEug
         WxdvLGBmoui/r8ElMkjDSk7SdjL7QJUeQRzy7XKQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thierry Reding <treding@nvidia.com>,
        kbuild test robot <lkp@intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 06/31] phy: tegra: Select USB_COMMON for usb_get_maximum_speed()
Date:   Thu, 14 May 2020 14:53:48 -0400
Message-Id: <20200514185413.20755-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514185413.20755-1-sashal@kernel.org>
References: <20200514185413.20755-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

[ Upstream commit 0d5c9bc7c68009af04bbadf22306467674c6fb90 ]

The usb_get_maximum_speed() function is part of the usb-common module,
so enable it by selecting the corresponding Kconfig symbol.

While at it, also make sure to depend on USB_SUPPORT because USB_PHY
requires that. This can lead to Kconfig conflicts if USB_SUPPORT is not
enabled while attempting to enable PHY_TEGRA_XUSB.

Reported-by: kbuild test robot <lkp@intel.com>
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://lore.kernel.org/r/20200330101038.2422389-1-thierry.reding@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/tegra/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
index a3b1de953fb70..bf4e93b835e91 100644
--- a/drivers/phy/tegra/Kconfig
+++ b/drivers/phy/tegra/Kconfig
@@ -1,6 +1,7 @@
 config PHY_TEGRA_XUSB
 	tristate "NVIDIA Tegra XUSB pad controller driver"
-	depends on ARCH_TEGRA
+	depends on ARCH_TEGRA && USB_SUPPORT
+	select USB_COMMON
 	help
 	  Choose this option if you have an NVIDIA Tegra SoC.
 
-- 
2.20.1

