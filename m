Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012BFC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE82B20715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589825402;
	bh=rMY9VnLpl8TAjaYJ3H7+fGfo4xlYfKw+RZr2xkmtW38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bZS4BdOrbJzNRN/WdfGcE0rqHiPuh2cV3ntA3bPOlWdc8eqFfEt9mDBGrbttqHwB9
	 YXhFWxaZC18L9xlSSGrRCVi/N044kn0WL+lVYXvTze6Ff4S8h8KsqBDltarSxiP4Bn
	 yijjWiuY/O6MFRXFqC+kNVYwEFjYaPMt0e09HwJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733113AbgERSGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:06:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733098AbgERSGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:06:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FE5220853;
        Mon, 18 May 2020 18:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589825162;
        bh=rMY9VnLpl8TAjaYJ3H7+fGfo4xlYfKw+RZr2xkmtW38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cw+kU7K7XRtZTlRiu6cZdkJ2A6wkwEreeUUOCiojMacZjvGj/mDphKkIOEmqMoe3r
         SSRGLThidrLTGV2Wox71/ruriJG2aNe+bF7BnH0qrzUgDUoR6hMnP55dtP1rchOlQ7
         Vcay5EzrD5eSjKbrxa2JE7EPWm5a9Coj9U0s+TAw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Imre Deak <imre.deak@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 5.6 153/194] drm/i915/tgl+: Fix interrupt handling for DP AUX transactions
Date:   Mon, 18 May 2020 19:37:23 +0200
Message-Id: <20200518173543.985344600@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173531.455604187@linuxfoundation.org>
References: <20200518173531.455604187@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Imre Deak <imre.deak@intel.com>

commit 4457a9db2bdec2360ddb15242341696108167886 upstream.

Unmask/enable AUX interrupts on all ports on TGL+. So far the interrupts
worked only on port A, which meant each transaction on other ports took
10ms.

Cc: <stable@vger.kernel.org> # v5.4+
Signed-off-by: Imre Deak <imre.deak@intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200504075828.20348-1-imre.deak@intel.com
(cherry picked from commit 054318c7e35f1d7d06b216143fff5f32405047ee)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/i915_irq.c |   16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

--- a/drivers/gpu/drm/i915/i915_irq.c
+++ b/drivers/gpu/drm/i915/i915_irq.c
@@ -3324,7 +3324,7 @@ static void gen8_de_irq_postinstall(stru
 	u32 de_pipe_masked = gen8_de_pipe_fault_mask(dev_priv) |
 		GEN8_PIPE_CDCLK_CRC_DONE;
 	u32 de_pipe_enables;
-	u32 de_port_masked = GEN8_AUX_CHANNEL_A;
+	u32 de_port_masked = gen8_de_port_aux_mask(dev_priv);
 	u32 de_port_enables;
 	u32 de_misc_masked = GEN8_DE_EDP_PSR;
 	enum pipe pipe;
@@ -3332,18 +3332,8 @@ static void gen8_de_irq_postinstall(stru
 	if (INTEL_GEN(dev_priv) <= 10)
 		de_misc_masked |= GEN8_DE_MISC_GSE;
 
-	if (INTEL_GEN(dev_priv) >= 9) {
-		de_port_masked |= GEN9_AUX_CHANNEL_B | GEN9_AUX_CHANNEL_C |
-				  GEN9_AUX_CHANNEL_D;
-		if (IS_GEN9_LP(dev_priv))
-			de_port_masked |= BXT_DE_PORT_GMBUS;
-	}
-
-	if (INTEL_GEN(dev_priv) >= 11)
-		de_port_masked |= ICL_AUX_CHANNEL_E;
-
-	if (IS_CNL_WITH_PORT_F(dev_priv) || INTEL_GEN(dev_priv) >= 11)
-		de_port_masked |= CNL_AUX_CHANNEL_F;
+	if (IS_GEN9_LP(dev_priv))
+		de_port_masked |= BXT_DE_PORT_GMBUS;
 
 	de_pipe_enables = de_pipe_masked | GEN8_PIPE_VBLANK |
 					   GEN8_PIPE_FIFO_UNDERRUN;


