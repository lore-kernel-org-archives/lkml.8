Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072A1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 10:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D666420663
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 10:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RSKfeGf9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgG2KwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 06:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgG2KwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 06:52:22 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FCDC0619D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 03:52:22 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u12so28954954ybj.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 03:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1dEDkzJYgjVVqjEitEFw8gql6+YijucNn9liE79fC9Y=;
        b=RSKfeGf9Tc8fWQxZ4X1HkI78UZCWzGntRi0jHX+IEnH1Q/X9kFEtjIoV0ao1Z7zPzQ
         SctVYpFlXipUMxmg7TUcDkIdMoL3MSQe1Cp/a8Uk8VHiPtdS5jJDoVJi9MnfK04VGyUa
         SHRPv4r0O7cUm5el3oRqGg3cxMGg1ILyRpzNV87e4Z3/tKIS8aJfqmHaVUfn+MAV3Yq1
         9PCncfxRGm1PfrI8bwieCB64IPE3lgWvBor1/IW5/tsQIBDTEVwKEJ3oFDt7YNKCFaLT
         uibC36G5IOO92SZxOM6c1Dab2n4IcW7WSB+4at0soR/SdGDsWNu4Yn8FKdAzJ6kTLsvn
         Dj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1dEDkzJYgjVVqjEitEFw8gql6+YijucNn9liE79fC9Y=;
        b=cTfMH1wpIRMskunMDD+ABFKZ8diOiPyicnlhVWoOWZDWNW+eOcyKuk1edGFQw68SJh
         +9gUDeEqr0MIN03AXAzqd3ygeQ4ovDfnZjWais3jOQZ9QqAcsMnbdwehZufOJgTGzU/9
         0JpDAarYV4B8kwnzpO0dJC1uDF1o7UAdPWaJQ0YZ2gckYLRNVDGfdL89hq0DBlMRPgT8
         L8EiJ4QiJBYQ0Px7B162rmySyNe38EoKIkHCUjKx1ArWC/dVBEaRcJc4Pd3h6p0XQCUe
         JNgDfH2UKGp3snw0GelrJYLpwihNEuVsYSWsmdWQg2wKfaYbKllQPRzH4YDgWJSa9XFX
         PmZQ==
X-Gm-Message-State: AOAM533m49xz3NBuaalspKe/mpF+wQ7IG9lnxf+sAJtUeCc4p0BLq+P0
        AWX5+KEy9Phq+VIzNI52vmSMCyF2+kJOzxCYAD6+OIKQ9WxCSZEL0ztLTFRXDjvH6E/yxZxWz/9
        S1OAKAHPZ8pSME/uEqZD0FGG5+nGj4LPGzVROLnRucB84A00ObE1EOlMGDTzcAe6CIbF891GTND
        pzjmAh
X-Google-Smtp-Source: ABdhPJwj5lvf4V0uvdTHSJkirttuUeG8fFpWdpvC1DaLU46CPoF33NuKmHFazzu2oCnwzH6jLEByoaxKibjTtv6i
X-Received: by 2002:a25:9785:: with SMTP id i5mr3506413ybo.255.1596019941451;
 Wed, 29 Jul 2020 03:52:21 -0700 (PDT)
Date:   Wed, 29 Jul 2020 20:52:04 +1000
In-Reply-To: <20200729105206.2991064-1-victording@google.com>
Message-Id: <20200729205144.1.I8556c0b9b6f75bf3121989f5641c33e694fff8d9@changeid>
Mime-Version: 1.0
References: <20200729105206.2991064-1-victording@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH 1/3] x86/msr-index: sort AMD RAPL MSRs by address
From:   Victor Ding <victording@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Victor Ding <victording@google.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jan Beulich <jbeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vineela Tummalapalli <vineela.tummalapalli@intel.com>,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSRs in the rest of this file are sorted by their addresses; fixing the
two outliers.

No functional changes.

Signed-off-by: Victor Ding <victording@google.com>
---

 arch/x86/include/asm/msr-index.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index e8370e64a155..c5e92317356e 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -305,8 +305,8 @@
 #define MSR_PP1_ENERGY_STATUS		0x00000641
 #define MSR_PP1_POLICY			0x00000642
 
-#define MSR_AMD_PKG_ENERGY_STATUS	0xc001029b
 #define MSR_AMD_RAPL_POWER_UNIT		0xc0010299
+#define MSR_AMD_PKG_ENERGY_STATUS	0xc001029b
 
 /* Config TDP MSRs */
 #define MSR_CONFIG_TDP_NOMINAL		0x00000648
-- 
2.28.0.rc0.142.g3c755180ce-goog

