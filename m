Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5524C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1768222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="UGS4CVZe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388656AbgBNQLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:11:41 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.168]:34182 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391571AbgBNQKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:10:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1581696638;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=RzFvreAROfD8+Za4+h0pzFXVuRYDasxapojPV71TMVg=;
        b=UGS4CVZespYZ0uCisY3LWO0PZnLe7Ngh77CmMpZl+Jsf4FnKJuFo9/bsmiIFLTPyQd
        lZ3cm25jJ+vaFbsFZSenKS9WlMsfrjtMDB643pxCLxGF1azQ+MIcXyBdrmts5fgNeksl
        /tiOEEUiXyc/QJk8LOJ5/ibhIW5Eq9ke7dQGdHoLqchMOUE9GHjyT2mG6LSdkbhkUd+b
        YcSdIjvjW6ScmyL7KETKTQLppMUGtk7ja8jk9lVbfAyq8auBgb+8ZiJcF4xCHC0GWShf
        Zc4OlgxwqnTjwFv4eQPEhm97FeFPcUKVu4vaav4uLbAzEi+XXJgys6lKdgmfW48sG3GF
        FaUg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2M7OMfsfQx3"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 46.1.12 DYNA|AUTH)
        with ESMTPSA id U06217w1EGARFkx
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 14 Feb 2020 17:10:27 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Paul Boddie <paul@boddie.org.uk>,
        Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Andi Kleen <ak@linux.intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Kees Cook <keescook@chromium.org>
Cc:     devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Subject: [PATCH v2 02/12] MIPS: DTS: jz4780: add #includes for irq.h and gpio.h
Date:   Fri, 14 Feb 2020 17:10:14 +0100
Message-Id: <9d1791de4af5fb669441b3b7c1cf3f7515490d67.1581696624.git.hns@goldelico.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1581696624.git.hns@goldelico.com>
References: <cover.1581696624.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The constants from irq.h and gpio.h can be used in the
jz4780.dtsi and derived DTS like ci20.dts.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index f928329b034b..112a24deff71 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <dt-bindings/clock/jz4780-cgu.h>
 #include <dt-bindings/dma/jz4780-dma.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	#address-cells = <1>;
-- 
2.23.0

