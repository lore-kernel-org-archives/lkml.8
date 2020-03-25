Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE9DC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CCCB20772
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbgCYJxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:53:32 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:46026 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbgCYJxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 05:53:30 -0400
Received: from ramsan ([84.195.182.253])
        by andre.telenet-ops.be with bizsmtp
        id JZtT2200Z5USYZQ01ZtTcR; Wed, 25 Mar 2020 10:53:28 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jH2j1-0002u2-Nd; Wed, 25 Mar 2020 10:53:27 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jH2j1-0002q8-Kg; Wed, 25 Mar 2020 10:53:27 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     devicetree@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] h8300: dts: Fix /chosen:stdout-path
Date:   Wed, 25 Mar 2020 10:53:26 +0100
Message-Id: <20200325095326.10875-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    arch/h8300/boot/dts/h8s_sim.dts:11.3-25: Warning (chosen_node_stdout_path): /chosen:stdout-path: property is not a string
    arch/h8300/boot/dts/h8300h_sim.dts:11.3-25: Warning (chosen_node_stdout_path): /chosen:stdout-path: property is not a string

Drop the angle brackets to fix this.

A similar fix was already applied to arch/h8300/boot/dts/edosk2674.dts
in commit 780ffcd51cb28717 ("h8300: register address fix").

Fixes: 38d6bded13084d50 ("h8300: devicetree source")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/h8300/boot/dts/h8300h_sim.dts | 2 +-
 arch/h8300/boot/dts/h8s_sim.dts    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/h8300/boot/dts/h8300h_sim.dts b/arch/h8300/boot/dts/h8300h_sim.dts
index 595398b9d0180a80..e1d4d9b7f6b40c04 100644
--- a/arch/h8300/boot/dts/h8300h_sim.dts
+++ b/arch/h8300/boot/dts/h8300h_sim.dts
@@ -8,7 +8,7 @@
 
 	chosen {
 		bootargs = "earlyprintk=h8300-sim";
-		stdout-path = <&sci0>;
+		stdout-path = &sci0;
 	};
 	aliases {
 		serial0 = &sci0;
diff --git a/arch/h8300/boot/dts/h8s_sim.dts b/arch/h8300/boot/dts/h8s_sim.dts
index 932cc3c5a81bcdd2..4848e40e607ecc1d 100644
--- a/arch/h8300/boot/dts/h8s_sim.dts
+++ b/arch/h8300/boot/dts/h8s_sim.dts
@@ -8,7 +8,7 @@
 
 	chosen {
 		bootargs = "earlyprintk=h8300-sim";
-		stdout-path = <&sci0>;
+		stdout-path = &sci0;
 	};
 	aliases {
 		serial0 = &sci0;
-- 
2.17.1

