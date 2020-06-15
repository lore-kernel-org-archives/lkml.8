Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0A3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 827852067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="MlWYFLP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgFOG6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbgFOG6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:58:13 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDC7C061A0E;
        Sun, 14 Jun 2020 23:58:13 -0700 (PDT)
Received: from zn.tnic (p200300ec2f063c003187a4190bac43a1.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:3c00:3187:a419:bac:43a1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 605D21EC035B;
        Mon, 15 Jun 2020 08:58:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592204289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CR5WZsxSRd8wp7PRr2IddZUw7c7yYSIxMJrU72FZPyc=;
        b=MlWYFLP9sJ5Q7JUJ8QL5SNrTmi0dnIhtDAbSg4yv0XgSfFC//8sn49UW1FcqR0+ba765zB
        ysLDXkylZK/hPafkdc9cWvkKAwG3U96CsGRgMcdzHCWK0jblIHgzr/FErfaviIqI+X3haH
        ZbTW6iKntgeylRmrGPqsgu20AYPMoOY=
Date:   Mon, 15 Jun 2020 08:58:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Anthony Steinhauser <asteinhauser@google.com>
Cc:     linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/speculation: Merge one test in
 spectre_v2_user_select_mitigation()
Message-ID: <20200615065806.GB14668@zn.tnic>
References: <159169282952.17951.3529693809120577424.tip-bot2@tip-bot2>
 <20200611140951.GD30352@zn.tnic>
 <CAN_oZf16odNhpY6_LqkVY2wpy90jKM9-vgKo4LE8OJ-QTDCKiw@mail.gmail.com>
 <20200611154356.GE30352@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200611154356.GE30352@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(dropping stable@ from Cc).

---

Merge the test whether the CPU supports STIBP into the test which
determines whether STIBP is required. Thus try to simplify what is
already an insane logic.

Remove a superfluous newline in a comment, while at it.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Anthony Steinhauser <asteinhauser@google.com>
---
 arch/x86/kernel/cpu/bugs.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 0b71970d2d3d..7beaefa9d198 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -763,10 +763,12 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
 	}
 
 	/*
-	 * If enhanced IBRS is enabled or SMT impossible, STIBP is not
+	 * If no STIBP, enhanced IBRS is enabled or SMT impossible, STIBP is not
 	 * required.
 	 */
-	if (!smt_possible || spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
+	if (!boot_cpu_has(X86_FEATURE_STIBP) ||
+	    !smt_possible ||
+	    spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
 		return;
 
 	/*
@@ -778,12 +780,6 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
 	    boot_cpu_has(X86_FEATURE_AMD_STIBP_ALWAYS_ON))
 		mode = SPECTRE_V2_USER_STRICT_PREFERRED;
 
-	/*
-	 * If STIBP is not available, clear the STIBP mode.
-	 */
-	if (!boot_cpu_has(X86_FEATURE_STIBP))
-		mode = SPECTRE_V2_USER_NONE;
-
 	spectre_v2_user_stibp = mode;
 
 set_mode:
@@ -1270,7 +1266,6 @@ static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
 		 * Indirect branch speculation is always disabled in strict
 		 * mode. It can neither be enabled if it was force-disabled
 		 * by a  previous prctl call.
-
 		 */
 		if (spectre_v2_user_ibpb == SPECTRE_V2_USER_STRICT ||
 		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
-- 
2.21.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
