Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3CCC33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 21:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2C824679
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 21:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nQCoMeg5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgA0VXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 16:23:01 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:54457 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA0VXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 16:23:01 -0500
Received: by mail-pl1-f201.google.com with SMTP id f10so4444803plr.21
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 13:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=M7uDook8T4JuFhQPKzSHd/4CKNgbM46H4EUNpVdKl20=;
        b=nQCoMeg5/E+KDXBiPl89mZrX/Kg1XuVS5rl428w6rs8LyHFj8aVDYpYacV9NcKKeEg
         I5vAbvKzZSe21rKyTDluGc9cKcpMpZvjlp/lhl0vvJ6wENBCcWLDosQ0+D9vhuClnUOI
         upl33DmT7LzNNtkcaKyNxk3VTMVFyXpPXQkWxaHFDPqJj+kFbmmzDcjMseirRMpI0gfK
         ah5uQV/ilEnZmwn2oOiwRRuVjHhWnzXvrDjF4LSsOr9bKaZP3HayadlgPM/BAdgn4TI6
         R00A86ey46B9XNod6zeVEXD6N7ebi95rOqgYc410VknfnRFkZ80cF8yTiUZu9KFYK4zV
         wX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=M7uDook8T4JuFhQPKzSHd/4CKNgbM46H4EUNpVdKl20=;
        b=VsV0y79rgv+MhXPxGMQJtwktrqRihtncLXQExtFZUX+Nhq3tagKEiFkEMWqPif9hlX
         SO0JfruS7EMpL2ix5HjpVa/s+Qbg3q6Q8hH9lJNCOCrhuonR5Trpj4GWqHDX+jWgNmJJ
         Wjxrmq7/mUQLYXEuCjKqw/BIHFsNdJRPTG//RHeaeh2yv3o5mlzHh8z/njQIfut3ZROi
         ExeIYOLKKIy4cf+tnZ+iODxmIRPSMG/jsuIeiyWuvSWMsEC1CZpR2LtXR2EqFCzabdWY
         1H/Nlmtxg4SQ1xvG2pWmbLEqR8ckvSTSluEQSi1igLHPl5q1jNQZBChyqgakZmS3bAnX
         GQUQ==
X-Gm-Message-State: APjAAAXersdYchgZUUrTHFan+zmYavxeBjctm1VhWQAXIzpxhZzMr5A6
        XcqMR0z+dgVZaHQikzy1mXsmW/+ff8pR3Gc=
X-Google-Smtp-Source: APXvYqztwCCBeFLwUdmvoDFFpxL4zFNAytONdjZTYtHWUot99zcOcBOoTdZdb7LJZVxpMkDMsscdqyNegKD5ym8=
X-Received: by 2002:a63:1756:: with SMTP id 22mr21988920pgx.109.1580160180456;
 Mon, 27 Jan 2020 13:23:00 -0800 (PST)
Date:   Mon, 27 Jan 2020 13:22:56 -0800
Message-Id: <20200127212256.194310-1-ehankland@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH] KVM: x86: Fix perfctr WRMSR for running counters
From:   Eric Hankland <ehankland@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Eric Hankland <ehankland@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the logic in intel_pmu_set_msr() for fixed and general purpose
counters. This was recently changed to set pmc->counter without taking
in to account the value of pmc_read_counter() which will be incorrect if
the counter is currently running and non-zero; this changes back to the
old logic which accounted for the value of currently running counters.

Signed-off-by: Eric Hankland <ehankland@google.com>
---
 arch/x86/kvm/vmx/pmu_intel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 34a3a17bb6d7..9bdbe05b599c 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -264,9 +264,10 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 				pmc->counter = data;
 			else
 				pmc->counter = (s32)data;
+			pmc->counter += pmc->counter - pmc_read_counter(pmc);
 			return 0;
 		} else if ((pmc = get_fixed_pmc(pmu, msr))) {
-			pmc->counter = data;
+			pmc->counter += data - pmc_read_counter(pmc);
 			return 0;
 		} else if ((pmc = get_gp_pmc(pmu, msr, MSR_P6_EVNTSEL0))) {
 			if (data == pmc->eventsel)

