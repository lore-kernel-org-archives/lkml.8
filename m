Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26275C3F2D9
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD3920828
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APn8RafP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgCCGX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 01:23:57 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51841 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbgCCGXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 01:23:54 -0500
Received: by mail-pj1-f65.google.com with SMTP id l8so888460pjy.1;
        Mon, 02 Mar 2020 22:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AJWVhyWnEHa+16Vui1urxy6sASoDRCYbuAsm+q77gXs=;
        b=APn8RafPWLC33RJLX6TCTiGRb/43wtYEQOud3T6k/8l5hLjc08tRx5C2qRpMKAeAnA
         ZPB2XlcQcSz9uRgyvmkWsVWp0jwp1wCNBPnad6vFVDVgsCX7qWcBNGDtydlsYjgG13Q+
         JPV+xK6HbibTroJ3PMREqbZCjC2J3dM2lgB5dIEzYSPexKJsny6YxFQDl4qg4QY8BST3
         rHz4Oc+wu/2kDQkW2NZYRd2BfOC2YUuymHLrN3DmnonUFyvtJXl59/oS/JHfUjlQE7xS
         mNtZFeAbRKyTFr7R2IqrYDyjfq/sqh8R3AhV/pFlCnjw23rnbfifPejKh/05DDLnH7v+
         WkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AJWVhyWnEHa+16Vui1urxy6sASoDRCYbuAsm+q77gXs=;
        b=O6eoARwEra95LI3POqrSevGCQBfR+Gtt8s3oR1aRlBZyPSdDiVo5SFrGwgMfDw48js
         /XrXDmRpOOgB/ei7wy1AbKLXyDf95R1Q6cU3mYuwVgHzyMildV5uZ6Lm9woUduohOKIs
         ZI/hkRdAaPYma7He+s3ykshc6i+ohAqlUbZyvduIIV3JnF8JuDrWzlFlJyj2bN8GBvqZ
         lNsPYIjNbFLSRgZ9YsQDDEFiFGwhB4/3U0ewuKyHsyhVtQKOsgXxSuTaJWTK7KYv6GQu
         8yQx1Ytnj8jdrJOnyhYfWcB0v3wwr4TD/l3ejcfQ8rfnWZsEzBb0yB27jLrsVdFHVDk2
         4EVw==
X-Gm-Message-State: ANhLgQ3amvWJFtWA+KBX1mKxrng5YXyHCq6vEglFRJbwTwlPA5/0SpJs
        MVxeRqHVnOuQsx59UnbSIH8=
X-Google-Smtp-Source: ADFU+vu9XHZAPJ11uio30zd0ulJFBhMoXCNmPsvqw6amAMfXgqEAt3txRdMXOBF/hDXaXINhU1En/w==
X-Received: by 2002:a17:90a:fb4d:: with SMTP id iq13mr2332424pjb.165.1583216632735;
        Mon, 02 Mar 2020 22:23:52 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-24-4-25-55.hsd1.ca.comcast.net. [24.4.25.55])
        by smtp.gmail.com with ESMTPSA id k5sm7453526pfp.66.2020.03.02.22.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 22:23:52 -0800 (PST)
From:   rentao.bupt@gmail.com
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v7 5/7] ARM: dts: aspeed-g5: add vhub port and endpoint properties
Date:   Mon,  2 Mar 2020 22:23:34 -0800
Message-Id: <20200303062336.7361-6-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303062336.7361-1-rentao.bupt@gmail.com>
References: <20200303062336.7361-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Add "aspeed,vhub-downstream-ports" and "aspeed,vhub-generic-endpoints"
properties to describe supported number of vhub ports and endpoints.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 No change in v2/v3/v4/v5/v6/v7.
   - It's given v7 to align with the version of the patch series.

 arch/arm/boot/dts/aspeed-g5.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index ebec0fa8baa7..f12ec04d3cbc 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -195,6 +195,8 @@
 			reg = <0x1e6a0000 0x300>;
 			interrupts = <5>;
 			clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
+			aspeed,vhub-downstream-ports = <5>;
+			aspeed,vhub-generic-endpoints = <15>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb2ad_default>;
 			status = "disabled";
-- 
2.17.1

