Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6000C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B509022B4E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753367;
	bh=wK9fWThdt8e9v/LekLsO50V3r3jLsXqpzR3MmGqsBRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o1h9nbHY1lU1001kLVBzPKFDuFMCRXczLEEZ6ZGS1GQOUo6zDj2N854dfuVYdgs8C
	 7xgXL/8F3GCSpZgqXbCws/HVYq1iMd2mG9imSNM53uBYtsfFcmd4Xg/qwzOheP/d3N
	 j1uYMFoRPZFKr5SvQ19Nl63HyzscY+V2EQ/u+Cnc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbgGNTCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:02:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731201AbgGNS6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:58:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6A4122B37;
        Tue, 14 Jul 2020 18:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594753098;
        bh=wK9fWThdt8e9v/LekLsO50V3r3jLsXqpzR3MmGqsBRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VE90RK10rMQESuKQ9FhimVxBUyGRUHb4X7QmaSAkHD7+nVh8y8xst9pnkuqXwNilh
         QPHQLJWnhY5kprGBpVO7BaVEEVapxOP2dIH+XCNuZuGAMZwSuBveUF+NXWqqMH/bAd
         YPd7hJbJ0ZfJ4z+DPedfJ+WR/OFAjtNY3lhV/Bf0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Scull <ascull@google.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 5.7 118/166] KVM: arm64: Stop clobbering x0 for HVC_SOFT_RESTART
Date:   Tue, 14 Jul 2020 20:44:43 +0200
Message-Id: <20200714184121.484474611@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Scull <ascull@google.com>

commit b9e10d4a6c9f5cbe6369ce2c17ebc67d2e5a4be5 upstream.

HVC_SOFT_RESTART is given values for x0-2 that it should installed
before exiting to the new address so should not set x0 to stub HVC
success or failure code.

Fixes: af42f20480bf1 ("arm64: hyp-stub: Zero x0 on successful stub handling")
Cc: stable@vger.kernel.org
Signed-off-by: Andrew Scull <ascull@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200706095259.1338221-1-ascull@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kvm/hyp-init.S |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/arch/arm64/kvm/hyp-init.S
+++ b/arch/arm64/kvm/hyp-init.S
@@ -136,11 +136,15 @@ SYM_CODE_START(__kvm_handle_stub_hvc)
 
 1:	cmp	x0, #HVC_RESET_VECTORS
 	b.ne	1f
-reset:
+
 	/*
-	 * Reset kvm back to the hyp stub. Do not clobber x0-x4 in
-	 * case we coming via HVC_SOFT_RESTART.
+	 * Set the HVC_RESET_VECTORS return code before entering the common
+	 * path so that we do not clobber x0-x2 in case we are coming via
+	 * HVC_SOFT_RESTART.
 	 */
+	mov	x0, xzr
+reset:
+	/* Reset kvm back to the hyp stub. */
 	mrs	x5, sctlr_el2
 	mov_q	x6, SCTLR_ELx_FLAGS
 	bic	x5, x5, x6		// Clear SCTL_M and etc
@@ -151,7 +155,6 @@ reset:
 	/* Install stub vectors */
 	adr_l	x5, __hyp_stub_vectors
 	msr	vbar_el2, x5
-	mov	x0, xzr
 	eret
 
 1:	/* Bad stub call */


