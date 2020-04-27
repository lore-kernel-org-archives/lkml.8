Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D12C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41DBB206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvNNv/co"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgD0Nk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 09:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbgD0Nku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 09:40:50 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E3CC0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 06:40:50 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k1so20636781wrx.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 06:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HsHK9y0GL9/8Kp1lq4dl22la5baTSZpqCWLJ4R7b1d8=;
        b=bvNNv/coGQwtz6bglmhoEFGQeNrnsBIaXBjjnub6HRiiFqVJHHcf3srmeXdkOJqFgv
         vNa3kK4G6apoNQENR6qz/uPwIKBA90ZJF6/la9vYinvJZdHZR2O/Xv8riO4Sl0HfWyki
         M/IQFDGv9e5zZ1u8gR8PxQvoC28Mshm/gtL1N9200B7lw1pxVumGDsI8JXz+bCVhWhpL
         TH6gs3LiW7Txlk9o4e98JprWUIimun7eSfb7iB5xNWNpJFGCzKLh8T3qwrufQHH8GtkK
         eq4EJkuM/0CWWCN9GWqZp1B9rz6WqDl2JbW9iRA8Pw55iHyRbBS5phWBoYfdt5Gpy8Ei
         0DOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HsHK9y0GL9/8Kp1lq4dl22la5baTSZpqCWLJ4R7b1d8=;
        b=Si8PTYXmuzkrdOSbrajh5FNzK0bGmgPe04ZKxS6ErdmQo9eZ4QzFi33h8/15/6uCwv
         O5bujN6/8FW3gXffItbti6+MrGH2pi7ONf6Ell6ZfT19s36xQojLxHMHE2ck/79h6+WP
         PENLrJKhOL9p6uK2GdTc9TKg0aCGtvy6PQmpeyUzi+oX3el4FxPsLZGog7+e/+fgA+pt
         usPvYKCpkWkeBblv8wY1wA8wyaCXwlaNgf+5brGcs6tEeDFkdzlcGIv+A3kH1lSPX8jH
         +5OOUvBCJfoZRzE9hgQI6qyhunxui4gydu6mVBL9/3HkTWuVvYQSC9oHEsXL5I5dFUXr
         Ch6A==
X-Gm-Message-State: AGi0PuZY8pY8DrMo/ZF5oTtLeyC6IeGeN8IDRgJpr4nPhlUxrxyTMBDa
        jhGKA1ka1HzDNWkB5iVUjXU=
X-Google-Smtp-Source: APiQypIiO4KsC066dkupF2hUWSNHdQ/YFtWDO4yT2K2Eh/66bW28IM5dPBE4nk0mIdNwY3gDWHuxQw==
X-Received: by 2002:a5d:5651:: with SMTP id j17mr26810575wrw.406.1587994849457;
        Mon, 27 Apr 2020 06:40:49 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id g186sm16290640wme.7.2020.04.27.06.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 06:40:48 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
X-Google-Original-From: Max Krummenacher <max.krummenacher@toradex.com>
List-Id: <soc.lore.kernel.org>
To:     Max Krummenacher <max.krummenacher@toradex.com>, soc@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Olof Johansson <olof@lixom.net>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v3 4/5] arm64: defconfig: add MEDIA_PLATFORM_SUPPORT
Date:   Mon, 27 Apr 2020 15:40:02 +0200
Message-Id: <20200427134003.45188-5-max.krummenacher@toradex.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200427134003.45188-1-max.krummenacher@toradex.com>
References: <20200427134003.45188-1-max.krummenacher@toradex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 06b93644f4d1 ("media: Kconfig: add an option to filter in/out
platform drivers") adds a new Kconfig symbol which now hides drivers
currently enabled in the arm64 defconfig. Enable it to get those
drivers back.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>


---

Changes in v3:
- new patch: added 'arm64: defconfig: add MEDIA_PLATFORM_SUPPORT' now
  needed for some enabled drivers or these drivers will silently not
  be built.

Changes in v2: None

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b8259814065dc..472aa82b9feee 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -569,6 +569,7 @@ CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
 CONFIG_MEDIA_SDR_SUPPORT=y
 CONFIG_MEDIA_CONTROLLER=y
 CONFIG_VIDEO_V4L2_SUBDEV_API=y
+CONFIG_MEDIA_PLATFORM_SUPPORT=y
 # CONFIG_DVB_NET is not set
 CONFIG_MEDIA_USB_SUPPORT=y
 CONFIG_USB_VIDEO_CLASS=m
-- 
2.20.1

