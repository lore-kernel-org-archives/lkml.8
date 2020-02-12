Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A942C3B188
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FFC21569
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGInGhkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgBLV5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 16:57:32 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45114 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgBLV5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 16:57:31 -0500
Received: by mail-pg1-f194.google.com with SMTP id b9so1774397pgk.12;
        Wed, 12 Feb 2020 13:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fcer5maloVUCbkrSQe8DVkPL6Lk2CjvPvSpxHsxWCA0=;
        b=lGInGhknBbblmThHtOa744jV16eu2Xyt2aJIm0PxY//v6EDHVQoK5BSn+MknS02bMV
         tbA5WHwtJZorWqS04XVWCwpGUBQU+pbfOzlFLHLYtxu40nNkRBDitMK+dVqXc8tARDcO
         BepqoRcl4CHTjalDmGkH5eDUSt9LuKa7irkD/hbmNIT3gDaL5bubldX9qYxCDbQWSKrh
         /9W0WufeNzu/OvP1Hh3lXXAeBj348e2RqbvpWSuAEN8t+BDZ1l7H0vtcCs8DjOeUHm4m
         GP2hqK3qtscWZE3htNBsmE7cXAi4Kn84itEE0Cos0Z+wHhZ8G70Aj+nH+EU7/Qi2/CNe
         QiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fcer5maloVUCbkrSQe8DVkPL6Lk2CjvPvSpxHsxWCA0=;
        b=p2T8St9yC+2oUzBJni3P4ebSPnTQiz7NMHSe/A9zSa/0WhrBM8E32LgqrPB+HgvPp/
         9TxIAOFV1rtIoAmSRSUBphfxjDDqOxDMVJ2RUMPvgtw+BFTwMIK7isPcvVYFhjaTtbVJ
         m7FrQzZHQZ7P099mtmToxS/a3rKior3JDn2jnjuWbpmsFKYAg2rvuSxQP/yOnsVfuDXh
         pS2WcBreKBC4m0FTZvsKjoNCau+DCr7761fMGEmZlwXS/uz9A3mAnKH2TVjNxC/skGjm
         6iOqzAyZIaxJGfoC4H/tvLmxOzfOiIl3CZgnah63DjDo80NYrNGmXYjRzQI+A0qs6mpB
         cJ5A==
X-Gm-Message-State: APjAAAVohl78B9PShLQRWUfOltFF9w6I094XnX89q2JSeu4/HdTisS5b
        mNwcc7EoHFvfsTFqa4jodFc=
X-Google-Smtp-Source: APXvYqxclQ88Laxxq1gwYJEcZ4+1ZPZl3eGG+pqs9MZeB3l0Bz+whOVPNY0gnX+iG+v3p+tsU2Y4Qg==
X-Received: by 2002:aa7:94b0:: with SMTP id a16mr10508433pfl.35.1581544650459;
        Wed, 12 Feb 2020 13:57:30 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:200::3:533f])
        by smtp.gmail.com with ESMTPSA id r6sm214431pfh.91.2020.02.12.13.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 13:57:30 -0800 (PST)
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
Subject: [PATCH v2 3/5] ARM: dts: aspeed-g5: add vhub port and endpoint properties
Date:   Wed, 12 Feb 2020 13:57:15 -0800
Message-Id: <20200212215717.9474-4-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200212215717.9474-1-rentao.bupt@gmail.com>
References: <20200212215717.9474-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Add "aspeed,vhub-downstream-ports" and "aspeed,vhub-generic-endpoints"
properties to describe supported number of vhub ports and endpoints.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 Changes in v2:
   - None. The patch is newly added and it's given v2 to align with
     version of the patch series.

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

