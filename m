Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7268BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D3F621941
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592945016;
	bh=CJ083IVgLP9GqjBfSwURkEeG+mnOiHoUbB+DadhHC68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FAwd7e2sB+/oBTWDnLEwy3xlojVgfCao2TPceOfx021to7Vb+/HuPLAzL794MdWwf
	 qk6hEmTjwx5DgbF9/3R3Sg85EgPu43S9zQvcrjzfPez6D9uIeCeVRP5EwRNL25/309
	 X7715ZcfNmfwGm23xVIgImpX2ZT1uygO2dUQ0OWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403921AbgFWUnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:43:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392521AbgFWUn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:43:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB4312070E;
        Tue, 23 Jun 2020 20:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592945006;
        bh=CJ083IVgLP9GqjBfSwURkEeG+mnOiHoUbB+DadhHC68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fpFtYUd9T4XXEG5CuxQDI7TEL9eDbUJzR4GfLLT/tDpSUjPMkqeI77fnunmh7/uc2
         jl4kUdWt8R2ypQvnWP01J81JrSOGoYn412oUCdeC3k0e/Kk60TVevtwJODNVoAWZtK
         OOEAWE2CGCXMH7vzuTzk+qfJh9BWRfNBEUdIPhHE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kunal Joshi <kunal1.joshi@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.19 197/206] drm/i915/icl+: Fix hotplug interrupt disabling after storm detection
Date:   Tue, 23 Jun 2020 21:58:45 +0200
Message-Id: <20200623195326.725268150@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Imre Deak <imre.deak@intel.com>

commit a3005c2edf7e8c3478880db1ca84028a2b6819bb upstream.

Atm, hotplug interrupts on TypeC ports are left enabled after detecting
an interrupt storm, fix this.

Reported-by: Kunal Joshi <kunal1.joshi@intel.com>
Bugzilla: https://gitlab.freedesktop.org/drm/intel/-/issues/1964
Cc: Kunal Joshi <kunal1.joshi@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Imre Deak <imre.deak@intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200612121731.19596-1-imre.deak@intel.com
(cherry picked from commit 587a87b9d7e94927edcdea018565bc1939381eb1)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/i915_irq.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/i915/i915_irq.c
+++ b/drivers/gpu/drm/i915/i915_irq.c
@@ -3821,6 +3821,7 @@ static void gen11_hpd_irq_setup(struct d
 
 	val = I915_READ(GEN11_DE_HPD_IMR);
 	val &= ~hotplug_irqs;
+	val |= ~enabled_irqs & hotplug_irqs;
 	I915_WRITE(GEN11_DE_HPD_IMR, val);
 	POSTING_READ(GEN11_DE_HPD_IMR);
 


