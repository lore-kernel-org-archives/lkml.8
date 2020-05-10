Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025D7C54E4B
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 16:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFFB220820
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 16:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="henRzJnu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbgEJQ4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 12:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729246AbgEJQz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 12:55:56 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52125C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 09:55:56 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id h4so15441818wmb.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 09:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QVJ+1fAj4aJcfIzG7KLUGxoLD4NHFj6b20tXq5SEIa4=;
        b=henRzJnuYReSCrFO8dT8/0yYkackqR7nMOzx+CWB4oeFTv+AEszy5e9EDWTTCZQRpu
         uXNji3zyuyRcjh6FpWhtXxFTODH/BlKbRc8ad91BkmERYkTJZXs1TUCg1YV2dQ6h798p
         o77l3IGx2Fv0gJ36qFihNpy/RYpdw1TT4FDh49jdB4Evh6940qKAV+Bmx97B2kSe7BnI
         dCFjplGGED5nzeXyp08yRQ2NxSlyPU1UC7Kwi8lu9Bn/mjRrz3tj3jtNxdd+Mo026ucw
         aeW8Re/ql4XxYQSuHsC6lLidLn8xVp6oKGL1AumKlgVuNfsPyG8aOhDVtXeBGQBqGVQW
         wJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QVJ+1fAj4aJcfIzG7KLUGxoLD4NHFj6b20tXq5SEIa4=;
        b=PW7t+IDFtGjWrAC3ypuWlJAO9HVclXN+nVU/eRv3kOY3RXTdi4SMbUrFD3ZNy7eYvB
         5GCGtn3TGo0HZj8lrr5EbbtYXTw0IfAQqJBZ3J6OXpGH8nfK/OBQtfYjIqd49wDgEtIX
         SXzdIk7eyf7H8gbNkvh+PQSUAjRyqIL/Yp0WlEsJEYURdcgBvjgT1UqZS3LIIf5WfYC5
         MdbPEEfbCosoJoa1OtPkeggP/n0QTdmh6kfHDi2cwhjwlsPligqAoWlavnUkDkbcnHqp
         DiXa0StD2hsYOBUloljnyoLyJCpKaHNx/2t47kqc3I/ZBEgfvOQLftByVwb0La/BbrPC
         UyiQ==
X-Gm-Message-State: AGi0PuYBgNi7Z7BNtVo9kQP+VM3Im5KcsLgMDU8nFaLNkbDeuah3YwG5
        XldEGPk6tsIN+dlvcz3wE7wu1M+kjpI=
X-Google-Smtp-Source: APiQypK2evGKLkliWXP4Ao/8KEZGZEAKSrvQQOjhvUGgeRvZRYLGZZbaiAPW9psfNBrE9jGOqSgWnA==
X-Received: by 2002:a1c:4304:: with SMTP id q4mr28949907wma.152.1589129754970;
        Sun, 10 May 2020 09:55:54 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:1cc8:b1f1:a2b8:a1ee])
        by smtp.gmail.com with ESMTPSA id g15sm13637670wrp.96.2020.05.10.09.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 09:55:54 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 12/15] arm64: defconfig: Enable devfreq cooling device
Date:   Sun, 10 May 2020 18:55:35 +0200
Message-Id: <20200510165538.19720-13-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200510165538.19720-1-peron.clem@gmail.com>
References: <20200510165538.19720-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devfreq cooling device framework is used in Panfrost
to throttle GPU in order to regulate its temperature.

Enable this driver for ARM64 SoC.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 66941024418c..42d85c2c0945 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -496,6 +496,7 @@ CONFIG_SENSORS_INA2XX=m
 CONFIG_SENSORS_INA3221=m
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
+CONFIG_DEVFREQ_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
 CONFIG_QORIQ_THERMAL=m
 CONFIG_SUN8I_THERMAL=y
-- 
2.20.1

