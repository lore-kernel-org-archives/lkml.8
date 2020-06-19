Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68C0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88BF320DD4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592577384;
	bh=1LmcsPC1zCe33YrGdpNY/3BxDcgXlzzZqRGqsdz1Bbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CQ2bSQ4IFLycRQBrwIvMwpmF3ha2GUOnE7XPq4eW/wYkpsE5dGX/y0pm0V861pnx5
	 4FsGuNaq3i2BMuvvgZYC6HzyKWD07hefkGuAgojwMkzK/IGdTwwZw+bKLCWJ6jWq1D
	 5FtMLPyfCub+8M/iY2lf3tD3yDK4WlakLdvr/pOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387515AbgFSOgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:36:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387489AbgFSOgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:36:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8305F208B8;
        Fri, 19 Jun 2020 14:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577375;
        bh=1LmcsPC1zCe33YrGdpNY/3BxDcgXlzzZqRGqsdz1Bbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U3BB0E8ldFzQeti2Ne3GnnO6sT0K51OMgDL6BHzvfBrPWDCuk8OB5M8b63fcMbJOG
         /8yTUpHWLCztlaZMjIzIfL2+8AKHvBa00xP4gDSb+W7yrx2YIFgUuj2snJB6JYE3in
         OBeJ23Leyu/BCJaIFpzb97HZ6JmD+gAOS36+Ht5U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anthony Steinhauser <asteinhauser@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 025/101] x86/speculation: PR_SPEC_FORCE_DISABLE enforcement for indirect branches.
Date:   Fri, 19 Jun 2020 16:32:14 +0200
Message-Id: <20200619141615.407629372@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141614.001544111@linuxfoundation.org>
References: <20200619141614.001544111@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anthony Steinhauser <asteinhauser@google.com>

[ Upstream commit 4d8df8cbb9156b0a0ab3f802b80cb5db57acc0bf ]

Currently, it is possible to enable indirect branch speculation even after
it was force-disabled using the PR_SPEC_FORCE_DISABLE option. Moreover, the
PR_GET_SPECULATION_CTRL command gives afterwards an incorrect result
(force-disabled when it is in fact enabled). This also is inconsistent
vs. STIBP and the documention which cleary states that
PR_SPEC_FORCE_DISABLE cannot be undone.

Fix this by actually enforcing force-disabled indirect branch
speculation. PR_SPEC_ENABLE called after PR_SPEC_FORCE_DISABLE now fails
with -EPERM as described in the documentation.

Fixes: 9137bb27e60e ("x86/speculation: Add prctl() control for indirect branch speculation")
Signed-off-by: Anthony Steinhauser <asteinhauser@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 94e10898126a..2d2631f9a519 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1232,11 +1232,14 @@ static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
 			return 0;
 		/*
 		 * Indirect branch speculation is always disabled in strict
-		 * mode.
+		 * mode. It can neither be enabled if it was force-disabled
+		 * by a  previous prctl call.
+
 		 */
 		if (spectre_v2_user_ibpb == SPECTRE_V2_USER_STRICT ||
 		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
-		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED)
+		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED ||
+		    task_spec_ib_force_disable(task))
 			return -EPERM;
 		task_clear_spec_ib_disable(task);
 		task_update_spec_tif(task);
-- 
2.25.1



