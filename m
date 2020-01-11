Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1C4C33CA3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F342064C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578737148;
	bh=ToLPPtJfE+wN/2xv6SeS8tOQ77wFmdJQl3445EtNQdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PFjLTMuskYRnDBbx6UGcMHMB3oXNKul5mxUlu+iSoMRTlGUHqPkkwgCnRrcQuXglW
	 LgcEqMHHnBiawhQlHZqtq4Xag8SSuhW4PoQ8SBiDEIqnO+72L4/coIZASNZ1XDm7pJ
	 rNZ9lJ9wldjHo6OoIsgMuVUjeBCey97Yq55lIJlA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbgAKKFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:05:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:39168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729337AbgAKKFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:05:46 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D11920848;
        Sat, 11 Jan 2020 10:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578737146;
        bh=ToLPPtJfE+wN/2xv6SeS8tOQ77wFmdJQl3445EtNQdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eIGdm2tpn7iosXMUYgFZ55oRdpz0CO0zGRMst/kb2bdEVTD3m4LpJ+OBx9nvZb6nC
         GSy9eFhZxbWTWobia4AGYZcWNIGJqxxpmnd3yE2YAaDAl6X47ZDCCA42hBpiVc+BIL
         vICU0VdSQu+rpEe0lcYW9nZESLej7scT976ZS/KE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 65/91] ARM: dts: am437x-gp/epos-evm: fix panel compatible
Date:   Sat, 11 Jan 2020 10:49:58 +0100
Message-Id: <20200111094909.153116596@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094844.748507863@linuxfoundation.org>
References: <20200111094844.748507863@linuxfoundation.org>
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
index 957840cc7b78..b55c094893c6 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -79,7 +79,7 @@
 		};
 
 	lcd0: display {
-		compatible = "osddisplays,osd057T0559-34ts", "panel-dpi";
+		compatible = "osddisplays,osd070t1718-19ts", "panel-dpi";
 		label = "lcd";
 
 		panel-timing {
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 9d35c3f07cad..21918807c9f6 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -41,7 +41,7 @@
 	};
 
 	lcd0: display {
-		compatible = "osddisplays,osd057T0559-34ts", "panel-dpi";
+		compatible = "osddisplays,osd070t1718-19ts", "panel-dpi";
 		label = "lcd";
 
 		panel-timing {
-- 
2.20.1



