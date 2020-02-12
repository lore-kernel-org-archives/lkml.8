Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896D0C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C99820848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPAjur7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbgBLV5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 16:57:47 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37358 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbgBLV5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 16:57:30 -0500
Received: by mail-pf1-f193.google.com with SMTP id p14so1904717pfn.4;
        Wed, 12 Feb 2020 13:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LujJUjQ6vuT9G1EH+1pDyua8gOLBQgmZvKNk8hNJ9k0=;
        b=MPAjur7KT+S3e/RyXoOYVbFEWxns16KwM8HtVFLFbze0TsYdYTuesbZNNY2bk02IoZ
         ZuaV49erEXTa4kSHbtQfXsdMWALFe62RXBtBPNiaN72SZT5DHSAsJJi0NlRYragOnGYP
         1fbBF0Qs16S3kfMCkMEnZmj+ANywWu9Uc7HssHh+eKhiumdJbPzywGr6BjidTDNN2Pq5
         hTOmtt761oUh9PnqlgxbiXnA3hM0mvo/j2NnYWfrIFHsu5fRcvLGwCsnAk7dORnnYGZS
         B8YYjG/UyPLdCKhuShOuy3iHL+5DbTZhnpMJbrnKDD7PBqwIRxSKb+cCdXiRrYeSWH21
         ZB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LujJUjQ6vuT9G1EH+1pDyua8gOLBQgmZvKNk8hNJ9k0=;
        b=QQhlfh2w73ThI/ExNwIMlKfZqwklXa2OaWi6vE0vKrVFAigj2fUyjyvvFab9gVwBnt
         G62cR/rPSmX5L5m2M3JQB5xwbgEoEjcQR538KVtTJQdd/oqJeac1gX4wnPJpYHG/Chim
         vxdOeFYKG4lViEspenMlDBeiv9onULrXtLDht5dd0xlJ7XwH48kfKXBFf02X4Ne3VXlc
         9USkCJT8v+N1CdKKNEMEGOp9Qzs2MTsPvYWwkqodqTMOcB793TIJj2Ug52nS4O7mtDLE
         Cni8YVVYuGnRI2/8me8GHp4OvMsZqedHLak1zNZHoQtjPK8dQZyAK/NJTS0LR/X8Yh4I
         K4aQ==
X-Gm-Message-State: APjAAAUvmQPrWtmPvpaIvj3tCrd9Vy/KQ7b6NnyazrwX/wjsXpBrvmqM
        qVwtUI2OFOcUJqPPPMNRnoo=
X-Google-Smtp-Source: APXvYqwxq2f7iaRQZmppOXJZwE6uWhP+IzhUAMdPNDCYHFIN2eO34CAldrpvS6sjiyK8XBjPcrxsHQ==
X-Received: by 2002:a62:a515:: with SMTP id v21mr10731828pfm.128.1581544649121;
        Wed, 12 Feb 2020 13:57:29 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:200::3:533f])
        by smtp.gmail.com with ESMTPSA id r6sm214431pfh.91.2020.02.12.13.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 13:57:28 -0800 (PST)
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
Subject: [PATCH v2 2/5] ARM: dts: aspeed-g4: add vhub port and endpoint properties
Date:   Wed, 12 Feb 2020 13:57:14 -0800
Message-Id: <20200212215717.9474-3-rentao.bupt@gmail.com>
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

 arch/arm/boot/dts/aspeed-g4.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 807a0fc20670..8e04303e8514 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -164,6 +164,8 @@
 			reg = <0x1e6a0000 0x300>;
 			interrupts = <5>;
 			clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
+			aspeed,vhub-downstream-ports = <5>;
+			aspeed,vhub-generic-endpoints = <15>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb2d_default>;
 			status = "disabled";
-- 
2.17.1

