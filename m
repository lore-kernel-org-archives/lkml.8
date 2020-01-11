Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6D2C33CA4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892CB2077C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578737803;
	bh=2LVKP5wHC3Q3pLHcTk7kp0vNarcQe3gdDziwMZJxLoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fNJIDhN4rmTtKt7Ic+O+mJXX6sr8aUwsMj7LcoLKQ7bZ9HVCIzXU82yEGLJQQAVTM
	 y91qCMYmtJV6rSLftt2crn+j8fnNyt8R5ezIdoxKvBlH9OJbXHmcmjdCMPuGFceQ1D
	 Rp2A6hdYgyP3pK3nNOYpOe+sMrfKP1V8I9ZSIgac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbgAKKQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:16:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:60036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729229AbgAKKQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:16:40 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DB6F20880;
        Sat, 11 Jan 2020 10:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578737800;
        bh=2LVKP5wHC3Q3pLHcTk7kp0vNarcQe3gdDziwMZJxLoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AW8tcJ3TTnt95HYAlg77cS7M3B6He3LBBMfjT0lraA5oHsqoGj4SOxNQXHl8B0ygC
         rF+qb4dg26fAMpy/snA73uzDY0D0lvxqmmBNFM7s+iY8MrHPGnVx1DSvcMkJ9b1p89
         Dah+MIksNabk37YhllPlf8KjsW1cBsUQI1oATvyE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 30/84] ARM: dts: am437x-gp/epos-evm: fix panel compatible
Date:   Sat, 11 Jan 2020 10:50:07 +0100
Message-Id: <20200111094857.563138226@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094845.328046411@linuxfoundation.org>
References: <20200111094845.328046411@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

[ Upstream commit c6b16761c6908d3dc167a0a566578b4b0b972905 ]

The LCD panel on AM4 GP EVMs and ePOS boards seems to be
osd070t1718-19ts. The current dts files say osd057T0559-34ts. Possibly
the panel has changed since the early EVMs, or there has been a mistake
with the panel type.

Update the DT files accordingly.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am437x-gp-evm.dts  | 2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 5b97c20c5ed4..8a17eca2bc97 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -83,7 +83,7 @@
 		};
 
 	lcd0: display {
-		compatible = "osddisplays,osd057T0559-34ts", "panel-dpi";
+		compatible = "osddisplays,osd070t1718-19ts", "panel-dpi";
 		label = "lcd";
 
 		backlight = <&lcd_bl>;
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 6502d3397653..12735cf9674b 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -45,7 +45,7 @@
 	};
 
 	lcd0: display {
-		compatible = "osddisplays,osd057T0559-34ts", "panel-dpi";
+		compatible = "osddisplays,osd070t1718-19ts", "panel-dpi";
 		label = "lcd";
 
 		backlight = <&lcd_bl>;
-- 
2.20.1



