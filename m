Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A34C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA1820B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586490419;
	bh=u8YqO5KRkDMJkvpaDUQlB5lQevXHKx6UCjjbjXQemGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FvO0mbEV3OVeMp68D0SBxxruAq0cKweyoEl1dnKw0XX2PeQtJILw9stnfAp2TgryC
	 QHyUldBkHdht15LrC/FbhcN8UxtvdaB6w4oaQWmTHE0abkC0Uv86Lm2SVsM1kyw9q3
	 8Omk3zXoRsBNY/SeJYDOWxpIcNTh0AV6UE+3BCG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgDJDq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 23:46:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbgDJDqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 23:46:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CED320BED;
        Fri, 10 Apr 2020 03:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586490409;
        bh=u8YqO5KRkDMJkvpaDUQlB5lQevXHKx6UCjjbjXQemGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FyehbGI3uKjc/GZqo3fKv7NKyuTxGogTcBsEaUy737dVauoUXEbgJKYQlQREV76dY
         DieQNIysfQ3M/iI/FTUHFWwlRULY0rOlYo3PwI+OMG6t7CBzkbDX6vkZYArM0jkoXl
         zJE5lVgAYyBOiGla1b0Pxr/9Vz9jsx+Q3f78jtG8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mohammad Rasim <mohammad.rasim96@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 5.6 11/68] media: arm64: dts: amlogic: add rc-videostrong-kii-pro keymap
Date:   Thu,  9 Apr 2020 23:45:36 -0400
Message-Id: <20200410034634.7731-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200410034634.7731-1-sashal@kernel.org>
References: <20200410034634.7731-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mohammad Rasim <mohammad.rasim96@gmail.com>

[ Upstream commit 806d06161af045dba29f3c7747550c93b2ea3ca9 ]

videostrong kii pro comes with a nec rc, add the keymap to the dts

Signed-off-by: Mohammad Rasim <mohammad.rasim96@gmail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
index 2f1f829450a29..6c9cc45fb417e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
@@ -76,3 +76,7 @@
 		};
 	};
 };
+
+&ir {
+	linux,rc-map-name = "rc-videostrong-kii-pro";
+};
-- 
2.20.1

