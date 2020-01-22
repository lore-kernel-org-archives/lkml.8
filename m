Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237CEC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4D024125
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699708;
	bh=h8sx2xo0z7T3FSXddIZF9RsNeBzBBAyDoxqFCf02lMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e0jK/R7Mke6zhhJNPau01c+WB84N/iG/YjgUodEOwH6DVxAlOLb9Vrb6pcZNPyhCb
	 1sYVIlZZehmEVZ7SIgY2BpAIkwYiWAv+8Mlv8vDMNexlky98yoW+hjHGXXTMmMgXnQ
	 t4+OTJoM2Wy/XVMXBemy+kKWhtzj7LvgNekZ288w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731572AbgAVN20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:28:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:50640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729475AbgAVN2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:28:24 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1D302467B;
        Wed, 22 Jan 2020 13:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699703;
        bh=h8sx2xo0z7T3FSXddIZF9RsNeBzBBAyDoxqFCf02lMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JMCoy8BO7ZxRR40iaEOdzA1QiXXq/V1Ydqh0zPP+8/uSs80c5hSD7KnOkwti512Ch
         Ht3+iUV3fkTezjd4UHOsz/HyrQezf7dFQYiNaGOVclB4yvMB4pGjOqE/x6VBeCd+Cf
         SyNhgOLFZbkYx0qijx+vvMVFY3QGYrDbZAwMrWPc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5.4 191/222] ARM: dts: Fix sgx sysconfig register for omap4
Date:   Wed, 22 Jan 2020 10:29:37 +0100
Message-Id: <20200122092847.355229972@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

commit 3e5c3c41ae925458150273e2f74ffbf999530c5f upstream.

Looks like we've had the sgx sysconfig register and revision register
always wrong for omap4, including the old platform data. Let's fix the
offsets to what the TRM says. Otherwise the sgx module may never idle
depending on the state of the real sysconfig register.

Fixes: d23a163ebe5a ("ARM: dts: Add nodes for missing omap4 interconnect target modules")
Cc: H. Nikolaus Schaller <hns@goldelico.com>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/omap4.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -330,8 +330,8 @@
 
 		target-module@56000000 {
 			compatible = "ti,sysc-omap4", "ti,sysc";
-			reg = <0x5601fc00 0x4>,
-			      <0x5601fc10 0x4>;
+			reg = <0x5600fe00 0x4>,
+			      <0x5600fe10 0x4>;
 			reg-names = "rev", "sysc";
 			ti,sysc-midle = <SYSC_IDLE_FORCE>,
 					<SYSC_IDLE_NO>,


