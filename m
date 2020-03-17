Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11924C3F2CE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB87F20735
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584442752;
	bh=OU9xDqI8khvrH0/UAQuDU7o9+9nS5Mv0gt/KO/bBxt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z4ChtRfUL7SstWfw8NYTRtSxHlSD1iox2ePC/1LdgN2/KGFtdV4UMktWnEIDRV6+r
	 JKybzeO1AsEXYo2PNQLQGBz7Bcamoy9Z2SBoUoxw04HNGnD1IcKCzQACxP8aiiMq5z
	 EfmCSKm5W7cBnZrCoQ6CeHEP+8B6fb5tLFCs47Qg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgCQK7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:59:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbgCQK7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:59:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E324D205ED;
        Tue, 17 Mar 2020 10:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584442746;
        bh=OU9xDqI8khvrH0/UAQuDU7o9+9nS5Mv0gt/KO/bBxt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wlssJw53MD9FdP4Wz+wNKsexjGRn3AUvsfzpb1d2l4g0zXkM67AMuD3Ay3e5N85IZ
         MVJof3J5C7zRV0TBAJkPIqQNyeD83WOE4lw5epreg/B3dgBxNI91nrt+zqeY5h3W/x
         zVrLWBxUlw+SKjEyj0kpMF5+XTT/1eNWjO7rmJUY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH 4.19 66/89] x86/mce: Fix logic and comments around MSR_PPIN_CTL
Date:   Tue, 17 Mar 2020 11:55:15 +0100
Message-Id: <20200317103307.545529204@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103259.744774526@linuxfoundation.org>
References: <20200317103259.744774526@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Luck <tony.luck@intel.com>

commit 59b5809655bdafb0767d3fd00a3e41711aab07e6 upstream.

There are two implemented bits in the PPIN_CTL MSR:

Bit 0: LockOut (R/WO)
      Set 1 to prevent further writes to MSR_PPIN_CTL.

Bit 1: Enable_PPIN (R/W)
       If 1, enables MSR_PPIN to be accessible using RDMSR.
       If 0, an attempt to read MSR_PPIN will cause #GP.

So there are four defined values:
	0: PPIN is disabled, PPIN_CTL may be updated
	1: PPIN is disabled. PPIN_CTL is locked against updates
	2: PPIN is enabled. PPIN_CTL may be updated
	3: PPIN is enabled. PPIN_CTL is locked against updates

Code would only enable the X86_FEATURE_INTEL_PPIN feature for case "2".
When it should have done so for both case "2" and case "3".

Fix the final test to just check for the enable bit. Also fix some of
the other comments in this function.

Fixes: 3f5a7896a509 ("x86/mce: Include the PPIN in MCE records when available")
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: <stable@vger.kernel.org>
Link: https://lkml.kernel.org/r/20200226011737.9958-1-tony.luck@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/mcheck/mce_intel.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/arch/x86/kernel/cpu/mcheck/mce_intel.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_intel.c
@@ -489,17 +489,18 @@ static void intel_ppin_init(struct cpuin
 			return;
 
 		if ((val & 3UL) == 1UL) {
-			/* PPIN available but disabled: */
+			/* PPIN locked in disabled mode */
 			return;
 		}
 
-		/* If PPIN is disabled, but not locked, try to enable: */
-		if (!(val & 3UL)) {
+		/* If PPIN is disabled, try to enable */
+		if (!(val & 2UL)) {
 			wrmsrl_safe(MSR_PPIN_CTL,  val | 2UL);
 			rdmsrl_safe(MSR_PPIN_CTL, &val);
 		}
 
-		if ((val & 3UL) == 2UL)
+		/* Is the enable bit set? */
+		if (val & 2UL)
 			set_cpu_cap(c, X86_FEATURE_INTEL_PPIN);
 	}
 }


