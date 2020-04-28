Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFADC83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CE2020730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgD1VcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:32:04 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:34793 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgD1VcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:32:03 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mhl8Y-1iycqy1vmK-00dk8x; Tue, 28 Apr 2020 23:31:40 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <treding@nvidia.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/rockchip: cdn-dp-core: Make cdn_dp_core_suspend/resume __maybe_unused
Date:   Tue, 28 Apr 2020 23:31:24 +0200
Message-Id: <20200428213138.3171708-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9gben41GuxcER2oeB9wYFmmawlgPoyYBUHJXzEFjF9Cabdyd6zx
 UnQqpKoIlMMhMSJMpuySRnALm9dHkuP2ohqYNq/f1dDi8rb7CkJYGeWWaT5DbF2erglp9jy
 3dnGb8OeECJrvFGIXwYVDOrV/PXlOVyafv0VaeEy3uA6RtW2Vo4Iu93RlK6TbIOJRrhZw1c
 pp3XMgxlBaX9JAjUHxR9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PpL1chTksEs=:0aWKAbC6CW1CMI3dzP5Gzu
 BZBRqPxP6Abvzmlu7WERc3rgNnMtcHirhasII1DlkqCVt16q0C+fZ8ue4ruuVX8oCISwbyejA
 p2pHgv1AGbewbLj49YMiETFtVQr9Sl42j5XNtq26eUN94I514lrIGZD7o1m2Rc0sc1x1oKjSY
 RpRmcczTirgb8KYRp+O+SDikXS47dme+T96VaQefBAviX3IvR/+TSM6GojVBgTJlq5ie5y4UB
 zFkmoty+bLSedIJn1bva4MxZTHT40+E0CYFs6LZT0vpgA9SxoKEtNPTSNL+56QiXAnr89Rv0J
 DwV1btZHMLgKyGI6a1C5nI7NESiwwQw2ztp5fF1mmfGrJTQQqiBlvHLxQBhQxG4nFd7ZxQBnl
 L86RYJUU5WUbaImD6KV9niyjczw2Y1AI358s0LJ/uJtgggdHgLCMfryNoLWVuskP5+f22cyNx
 eUJlm6EmNQiyl0sJm0VWBwDPQFD4AGHrIpx2XNUr9OIcYWTm+R47zrZUjyvvHaBJEqEqTosIx
 mJ8/KbmpbhepBJDPF6EVgTjeRFmTUa96uvRZiF7u5B+iBewkNpfrfBQVNXAl0Jbbm0kGRSHbO
 nuTDJrxKieLaOefJUke5OeRUY6uMWXHarOOSTwhoERccYSorX5lDGViY+UdD0ef0x6uaWI79D
 TatCoGF3WzbWrR5UumEiT/5sqJ/nsG3XIh+2k6NhJpqNy+/Nw1Ri7VvUgtuAg+6PB958HPY7B
 V3Sgnel9PC8tBoXnYABhIfwxsbE8OFYsb4ABLxGS+AIYVNAkqRnSAtm86mZK6UXxLzsIBrD7s
 NU4xcEH1iZsFiksRG/EuB6b1CocT//Y2QGhYlyuQ0fa7KdIh1A=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the new static annotation, the compiler warns when the functions
are actually unused:

drivers/gpu/drm/rockchip/cdn-dp-core.c:1123:12: error: 'cdn_dp_resume' defined but not used [-Werror=unused-function]
 1123 | static int cdn_dp_resume(struct device *dev)
      |            ^~~~~~~~~~~~~

Mark them __maybe_unused to suppress that warning as well.

Fixes: 7c49abb4c2f8 ("drm/rockchip: cdn-dp-core: Make cdn_dp_core_suspend/resume static")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/rockchip/cdn-dp-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index c634b95b50f7..1cde98c6b0e6 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -1106,7 +1106,7 @@ static const struct component_ops cdn_dp_component_ops = {
 	.unbind = cdn_dp_unbind,
 };
 
-static int cdn_dp_suspend(struct device *dev)
+static __maybe_unused int cdn_dp_suspend(struct device *dev)
 {
 	struct cdn_dp_device *dp = dev_get_drvdata(dev);
 	int ret = 0;
@@ -1120,7 +1120,7 @@ static int cdn_dp_suspend(struct device *dev)
 	return ret;
 }
 
-static int cdn_dp_resume(struct device *dev)
+static __maybe_unused int cdn_dp_resume(struct device *dev)
 {
 	struct cdn_dp_device *dp = dev_get_drvdata(dev);
 
-- 
2.26.0

