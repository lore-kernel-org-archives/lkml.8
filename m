Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9911DC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65F622054F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgHSM2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbgHSM2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:28:42 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D158C061383
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 05:28:42 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id HQUf230184C55Sk06QUf0Z; Wed, 19 Aug 2020 14:28:39 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k8NCp-00029M-8S; Wed, 19 Aug 2020 14:28:39 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k8NCp-0004oL-5F; Wed, 19 Aug 2020 14:28:39 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] h8300: dts: Fix /chosen:stdout-path
Date:   Wed, 19 Aug 2020 14:28:38 +0200
Message-Id: <20200819122838.18452-1-geert+renesas@glider.be>
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
Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
---
v2:
  - Add Reviewed-by.
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

