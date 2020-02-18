Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8439C34032
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 03:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A088320836
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 03:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfQkKQAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgBRDNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 22:13:34 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38057 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgBRDNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 22:13:32 -0500
Received: by mail-pg1-f193.google.com with SMTP id d6so10217021pgn.5;
        Mon, 17 Feb 2020 19:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EQI/kEWqaRT05sdkpbc+otag3aOOl2fGYGdTqjeEub0=;
        b=RfQkKQAVEtw73teRP3nMOcC+47nA0yiJ4PiE8RrwCmIBAqJpYsq7mu2qzB+46qjTwC
         1mk9sU9Ne7GvPU88/TiuEHAiMFGe32f/GVMwPwqJQ0EuS44mUrbTgpzW047Ra8mgPQb6
         IuVthqAfXBWP50mkJhsyYZXlYwREhkaEK5ooDyZxoQOInwm0SGFkP50D3F21MSF1D+42
         5jywXnyJPJVd7mVLN2cbNIe/OrhrNHr5rgDYe0bGOR4c+nvuVNiQAWpnIGGvkrf1uroE
         D8GJwoqfLr5rUNAY5Jtp6kW+9VK7CLePxq+ggqtZm5bVCTgd5ab8HyfTbWaQCRPtMuxf
         kgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EQI/kEWqaRT05sdkpbc+otag3aOOl2fGYGdTqjeEub0=;
        b=I3YWtdHhX1zNlJO0OG4i6bDOiET29Mar87J5VB2JzUqToycUWoHc6zBJo97++Kz0V0
         pus+1c91GRBQK/yBwphlbpIEXAu0jmZg4cf60L9DutOUNaoOlOAUFfxbJPgFMGoXxaUH
         qcBrEs5JqHx+QXEzBe/yQqAUAOffuENISremjsTEkQH5fzp2DmYbrKi8sUK/APp205ha
         vaR7mv6e6xzxheueoq6tYUldlqlTgVyP94jElTqf3O7c7kXX25Ps/Os49u72Vuaa7S6e
         pjhmt+3G3ArxC77jVY/FjtBmBK5Cs9Q84kKDvtXLsBPiKIAV4ol5oSujncNfeXsVymMP
         IL6w==
X-Gm-Message-State: APjAAAWnQtQTreird6RlJow24pUcNetBAg5AKpYYNv7+OnEKKb2OYWVO
        R+4/Ct/CK6QEwdDNUpYJEqg=
X-Google-Smtp-Source: APXvYqwnUHiPwKDCgZewpALos3LF//BC5zWLk7GsTKsck7hxFh7pTlxPH2I3QfP2zhB1wSr/zmv7pg==
X-Received: by 2002:a63:5220:: with SMTP id g32mr20411835pgb.116.1581995612091;
        Mon, 17 Feb 2020 19:13:32 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:180::6f94])
        by smtp.gmail.com with ESMTPSA id b18sm1812595pfd.63.2020.02.17.19.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 19:13:31 -0800 (PST)
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
Subject: [PATCH v3 4/5] ARM: dts: aspeed-g5: add vhub port and endpoint properties
Date:   Mon, 17 Feb 2020 19:13:14 -0800
Message-Id: <20200218031315.562-5-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200218031315.562-1-rentao.bupt@gmail.com>
References: <20200218031315.562-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Add "aspeed,vhub-downstream-ports" and "aspeed,vhub-generic-endpoints"
properties to describe supported number of vhub ports and endpoints.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 No changes in v2/v3.
   - It's given v3 to align with the version of the patch series.

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

