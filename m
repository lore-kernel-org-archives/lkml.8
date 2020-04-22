Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89A6C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BEBC20774
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587553419;
	bh=Obv2RGH5YaGvCgQQFtLrRO8YWKPExsVOknJMAtx0uhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KG9WdtuvMEojRqiHc/IMqV96B/gkqxv2eeFEkqpCC6Xf6JlAzuNT+WU4oxVxJ0/0c
	 bjMRnblf5wX3b01NruIwFlaRDgoUWmtljfouTkKrfxRtSUQg9nVOlB8a+fHGpPrDGj
	 PaBjoWQujOupvpsoOvtExDmO9Ydt0rjI4tjGKR4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732490AbgDVLDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:03:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbgDVJ7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 05:59:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C15820776;
        Wed, 22 Apr 2020 09:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587549589;
        bh=Obv2RGH5YaGvCgQQFtLrRO8YWKPExsVOknJMAtx0uhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Aa/qydBOaK0jQLvzixequzbexnxjOWpo0+cqTvuS+mMmnlT4jcB4s4Zf/EVyxTG87
         nljGBGzvKzTKy0OH1l5nlFEBi9toZwRymmTsC8b1OP2Y+0ClTfAt9Th6Bbfh90gzpy
         9n1BeNL//EkYQxJCYHfD8QbfoLDnY3qBCgNLldlc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 4.4 026/100] thermal: devfreq_cooling: inline all stubs for CONFIG_DEVFREQ_THERMAL=n
Date:   Wed, 22 Apr 2020 11:55:56 +0200
Message-Id: <20200422095027.507589459@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095022.476101261@linuxfoundation.org>
References: <20200422095022.476101261@linuxfoundation.org>
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
@@ -53,7 +53,7 @@ void devfreq_cooling_unregister(struct t
 
 #else /* !CONFIG_DEVFREQ_THERMAL */
 
-struct thermal_cooling_device *
+static inline struct thermal_cooling_device *
 of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 				  struct devfreq_cooling_power *dfc_power)
 {


