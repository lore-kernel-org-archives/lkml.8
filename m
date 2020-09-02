Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F037C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 254CB206EB
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFaTkRn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgIBSM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbgIBSMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:12:47 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1A4C061245;
        Wed,  2 Sep 2020 11:12:47 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id o68so100993pfg.2;
        Wed, 02 Sep 2020 11:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fbE2EUKf0dDLSVGA9OtlMJM3jKWz2OtHZG+cbWW1EL4=;
        b=aFaTkRn3zQxjMusTi+ps6zxErseC+lODmABkMhmreSjKkO+Q0RTfSjbysZ76viWYw9
         1ifooaitbz0ScX9rJZ8O7BHLglA+i4SF95xhL0HcBnCJV67Wnxmv2IBQQYNcyhVzEK2j
         ldwRgLblDjwmQafROVxYajTOSA7B7OAIHHtvQBIENAxOVC7NU/olpFo+qWKXd0zNL/w1
         ZITuUNbLYODeREV0JG+T93B5p/f+WdXVueyFslItxdwareKCmwwPraCgAdkiOyzRSgA/
         q7ZMsRpltne8yvmRjcA3Aj4WH7x/uj8qz5bWtvT+FAxHTTB/nUFA6LJ3vbuTw//dyDO+
         tRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fbE2EUKf0dDLSVGA9OtlMJM3jKWz2OtHZG+cbWW1EL4=;
        b=K64lSr11dfwiB+gMBfRJKVPFETRYNoyRBnmhD0EeL4Otz41Z2GT5uH2Zghd3r0cKCU
         cKnZCx9dj4q2jkcSDBjaEhPfnvu16JzCHMnINQvmGnoxXHnvTAzmVgxupVWIv7oSwcNo
         TX30poMq3FsgyR7l0382BKk1lGFNPoT49zKc6iSFQWDiUi5pXsu8+qhOUva78NL98T2y
         t+78o0Bfltb+YBGdHwB7iUka2PjK1gzdq3Jq4HwuQMg/8uYJFJLAKArETTHos6IU+cN5
         ljAmBnupLzsCHHkPbCExZLUw/aHkveNILrq5iJG4aCH4iRjedw1gtsJuuvWvvohEfF+E
         4U4w==
X-Gm-Message-State: AOAM53138+HJOeJIqdb7uyqpGzDZaGy9cPUA2OLSTxSIT/1dyw6vGHKV
        +kB1+W5nwN4syjtEe94X7JBGKRnhacE=
X-Google-Smtp-Source: ABdhPJwmA4fxLfM8pxgx4LqnAQ1g0nJtb0xAFYxTvFhDlnWTdFtJqRHDCGzaD4UVPJyph4XlEMIYIw==
X-Received: by 2002:a62:7551:: with SMTP id q78mr4415121pfc.140.1599070366505;
        Wed, 02 Sep 2020 11:12:46 -0700 (PDT)
Received: from localhost.localdomain (cpe-172-112-234-200.socal.res.rr.com. [172.112.234.200])
        by smtp.gmail.com with ESMTPSA id u123sm148993pfb.209.2020.09.02.11.12.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Sep 2020 11:12:46 -0700 (PDT)
From:   lindsey.stanpoor@gmail.com
To:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org, heiko@sntech.de,
        balbi@kernel.org, cnemo@tutanota.com
Subject: [PATCH v4 4/4] arm64: dts: rockchip: enable rk3328-rock64 usb3 nodes
Date:   Wed,  2 Sep 2020 11:12:34 -0700
Message-Id: <20200902181234.13955-4-lindsey.stanpoor@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902181234.13955-1-lindsey.stanpoor@gmail.com>
References: <20200902181234.13955-1-lindsey.stanpoor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cameron Nemo <cnemo@tutanota.com>

Enable USB3 nodes for the rk3328-based PINE Rock64 board.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Cameron Nemo <cnemo@tutanota.com>
---
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index 86cfb5c50a94..0cbf59efcef0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -384,6 +384,15 @@ &usb20_otg {
 	status = "okay";
 };
 
+&usbdrd3 {
+	status = "okay";
+};
+
+&usbdrd_dwc3 {
+	dr_mode = "host";
+	status = "okay";
+};
+
 &usb_host0_ehci {
 	status = "okay";
 };
-- 
2.28.0

