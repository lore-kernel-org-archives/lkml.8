Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7587FC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46FD32220B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587043893;
	bh=wgY92Up2hqj3U3bxEm7of4dFDNE/XdwTMo46DQJ7BiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nmRdA8kzzewl+wg0T1OUthIQi+3VJWwFjlNl+ffjt6TNNgiMeiSITE+A/aYeNwTbH
	 HDafaGU3AZGBZDRvxip4GNzpD+3e9zfDywO+KmS0A/jpV62StwR0NOLmQ02zsI6vmC
	 Zo9qfSAKkK5wFqe4u3FzGHUUlR8m7S2famyyMmBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896610AbgDPNbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:31:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895714AbgDPN2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:28:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 268F821BE5;
        Thu, 16 Apr 2020 13:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587043695;
        bh=wgY92Up2hqj3U3bxEm7of4dFDNE/XdwTMo46DQJ7BiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j7nLaaFULL2DL5XTBgFixTFEQUSkjptBXM2PCPv4uF1Mx/7peMckAZN6U7EtY+nTD
         6Hq0MuCnWFMGWDZVSTXh7G9zv9ez/osJLXaa7CMr3bBXG8NYtL4niQw48aGWAjWV2U
         K4LUgcjsFA4K3qyK9JoZsp3IuvvHsrogZUHCMW/A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 4.19 061/146] thermal: devfreq_cooling: inline all stubs for CONFIG_DEVFREQ_THERMAL=n
Date:   Thu, 16 Apr 2020 15:23:22 +0200
Message-Id: <20200416131251.230752850@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131242.353444678@linuxfoundation.org>
References: <20200416131242.353444678@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

commit 3f5b9959041e0db6dacbea80bb833bff5900999f upstream.

When CONFIG_DEVFREQ_THERMAL is disabled all functions except
of_devfreq_cooling_register_power() were already inlined. Also inline
the last function to avoid compile errors when multiple drivers call
of_devfreq_cooling_register_power() when CONFIG_DEVFREQ_THERMAL is not
set. Compilation failed with the following message:
  multiple definition of `of_devfreq_cooling_register_power'
(which then lists all usages of of_devfreq_cooling_register_power())

Thomas Zimmermann reported this problem [0] on a kernel config with
CONFIG_DRM_LIMA={m,y}, CONFIG_DRM_PANFROST={m,y} and
CONFIG_DEVFREQ_THERMAL=n after both, the lima and panfrost drivers
gained devfreq cooling support.

[0] https://www.spinics.net/lists/dri-devel/msg252825.html

Fixes: a76caf55e5b356 ("thermal: Add devfreq cooling")
Cc: stable@vger.kernel.org
Reported-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Tested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200403205133.1101808-1-martin.blumenstingl@googlemail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/devfreq_cooling.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/devfreq_cooling.h
+++ b/include/linux/devfreq_cooling.h
@@ -75,7 +75,7 @@ void devfreq_cooling_unregister(struct t
 
 #else /* !CONFIG_DEVFREQ_THERMAL */
 
-struct thermal_cooling_device *
+static inline struct thermal_cooling_device *
 of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 				  struct devfreq_cooling_power *dfc_power)
 {


