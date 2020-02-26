Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E021BC4BA32
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B5624650
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWyxVPh+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgBZXEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 18:04:11 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40233 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbgBZXEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 18:04:09 -0500
Received: by mail-pj1-f65.google.com with SMTP id 12so286946pjb.5;
        Wed, 26 Feb 2020 15:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d+bBE66toMnZI0qXloRJj6VMGyPFgJVsaJU4ycVPU64=;
        b=QWyxVPh+GD1LDDT6SRxgMhM8owHq1R0CxkEM31q0omdXqtjG3RrJxc0WHgK6rk/MMP
         ttIHaK93ze6IblKQAw4FEvQw9q0UdX9mDb22a+ACFhjTsCe65J7N8TEnKSnrYYkpnKoQ
         zsZpBxZvLAV8/4zNQ6QG5wPgVNF5Z+TKmp9Zv2bWYLHcVQ4tnYSFMbEOD4tFr+AQOewF
         N7h/EA/n3qXZw8+cj03pwIggUWsonWYcIhegU5td6OApxHCkmyUAxIKru9tyZLgb6nZa
         6o2+aXBiK8jD7CzidCFVQkhhD3V06zH2D4dIHpVFYUJmMm7xAE2ydtFwnqBA9PX4B4Ns
         kL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d+bBE66toMnZI0qXloRJj6VMGyPFgJVsaJU4ycVPU64=;
        b=K+Jb3JyjltT8OCbQxYpI9jv67vEzdbUs7BMv2uDRfO6bXmF/emb98DxLW+QJ7UJfU1
         q5J4Dc/4AO1wDKjyvkaCwDZxrn3goZIoE++rSblgqj+PZwQTGBJbN8RSqOwPJgEAtbuc
         vk79zzkVYvNYprrm++xrNn6nSdHppkqIoxtQ0m1f8DtWJLgZ+hlWANKOuhRN/nzmt4wf
         DcI5u/pCmcR4QcZb6gWzhWiyRIN76pb4V5PM6DmAE5YUnSmuQATA2frFF2D8kvMxsF4d
         MFk8xtwzF3hWahhKNTFm62vnMTGCQV1yH+mvQfrNGOHSwvsSvQQTzG9NL3DpdaRkIOPk
         URqQ==
X-Gm-Message-State: APjAAAVW7tMOjMYCrOpM42B+5pYKNNjjMucWv+ORN6OHN3pKLZw1zdba
        rgY/zlzAK5jSxoC5aX8xFCQ=
X-Google-Smtp-Source: APXvYqwW65QAzOMxMHBU9B9LDutGbRm3cSxix5+RauaRaxCzui4CM12rCFWbLrzg/6Aiok32X6FXHQ==
X-Received: by 2002:a17:90a:d103:: with SMTP id l3mr1597711pju.116.1582758248654;
        Wed, 26 Feb 2020 15:04:08 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:500::7:5ebf])
        by smtp.gmail.com with ESMTPSA id 3sm3912621pjg.27.2020.02.26.15.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 15:04:08 -0800 (PST)
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
Subject: [PATCH v4 5/7] ARM: dts: aspeed-g5: add vhub port and endpoint properties
Date:   Wed, 26 Feb 2020 15:03:44 -0800
Message-Id: <20200226230346.672-6-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200226230346.672-1-rentao.bupt@gmail.com>
References: <20200226230346.672-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Add "aspeed,vhub-downstream-ports" and "aspeed,vhub-generic-endpoints"
properties to describe supported number of vhub ports and endpoints.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 No change in v2/v3/v4.
   - It's given v4 to align with the version of the patch series.

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

