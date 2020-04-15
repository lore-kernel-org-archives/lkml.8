Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2517CC2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 01:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F04C9208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 01:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oqpB2vuB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392516AbgDOBX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 21:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2392505AbgDOBX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 21:23:56 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452C3C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 18:23:55 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id l26so6202976qtc.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 18:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+UiXyULlzq60JcrYizZG5xR6t3RIPIiANzzV8jZ5et4=;
        b=oqpB2vuBxzx65QrcJ0rQHZsF96i4qH7Ccf1rFMcJ6KOnPS2CNK2G/i+chkrdb9a2Ye
         fX6rGMu9RPCe4ZDmyHLd5d4qmhvuPwD0hOrJGwMw5nORi9st6VrLGQ45nlHi2RyMkxHw
         sT0Q/Lq/ib1UjQN672r4x39sYLOTMS6E5jC4JiK68o8u8FG0SJaWourIl4/l/zSoLU8P
         dS5s0Xjb7hinQYUflvWzNAddQsBycWP8wR0GNb8lFPoVv+XGbEik7X6N/9ilApkXTYvX
         vmUWUTbiMWpBvtYwR8BzNY1zoDGx25l3yFRiOgbO4PbrsLgoGMCamPcPhfwY4HOZ7nXo
         MkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+UiXyULlzq60JcrYizZG5xR6t3RIPIiANzzV8jZ5et4=;
        b=lOvx15dhcaQJJzjv9TolT2WtzyknWhM/mD6thxR3OuCQ4tpUaA0KOHEvjEZhEFKW7B
         ER0vSccSZ7LAlJvcosUh4Rc1omNBJs0wa0yH4bT88h9HQZNGRvrq/y2GJJ3afrr1WjKV
         7W0BeEW097mVjnqu2JQUZBYYGaQ7ZKuPP6KFrD9zI26gQGiCNED8/ZlWWi3TeGfUvS3w
         L1MLX5ZwE752yLsjyqMBk0I7ioKzxY76X6Iw1lf9FQP1PSwLjjdaiL/5LNpz+i1wpzJ7
         +f0AUHwFGDOYcKtFU4aAWYxGVeW3/2Os3IRGnQRw5fhiIQ3DNwRvusiPeoGoAcJ7gRJ5
         F29w==
X-Gm-Message-State: AGi0PuaYaMKaXN098h2ZiJH7sPz9aa/gMVv8NLVHcC1p3xYyL0gr+Hl8
        FZ+EMSdaDS4alMAJHN6nJh+DwFZZvDKb/w==
X-Google-Smtp-Source: APiQypJFWJeQvzBXxj3d9pW4mxjnL9s22hQArYDAnHt6z6K0vobYszap9H2qGKlaKJvejbA00rEqZ5icFY1N/w==
X-Received: by 2002:ad4:55c4:: with SMTP id bt4mr2703843qvb.225.1586913833875;
 Tue, 14 Apr 2020 18:23:53 -0700 (PDT)
Date:   Tue, 14 Apr 2020 18:23:20 -0700
Message-Id: <20200415012320.236065-1-jcargill@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH 1/1] KVM: pass through CPUID(0x80000006)
From:   Jon Cargille <jcargill@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Eric Northup <digitaleric@gmail.com>,
        Eric Northup <digitaleric@google.com>,
        Jon Cargille <jcargill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Northup <digitaleric@gmail.com>

Return L2 cache and TLB information to guests.
They could have been set before, but the defaults that KVM returns will be
necessary for usermode that doesn't supply their own CPUID tables.

Signed-off-by: Eric Northup <digitaleric@google.com>
Signed-off-by: Eric Northup <digitaleric@gmail.com>
Signed-off-by: Jon Cargille <jcargill@google.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/cpuid.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index b1c469446b072..4a8d67303a42c 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -734,6 +734,9 @@ static inline int __do_cpuid_func(struct kvm_cpuid_entry2 *entry, u32 function,
 		entry->ecx &= kvm_cpuid_8000_0001_ecx_x86_features;
 		cpuid_mask(&entry->ecx, CPUID_8000_0001_ECX);
 		break;
+	case 0x80000006:
+		/* L2 cache and TLB: pass through host info. */
+		break;
 	case 0x80000007: /* Advanced power management */
 		/* invariant TSC is CPUID.80000007H:EDX[8] */
 		entry->edx &= (1 << 8);
-- 
2.25.1.481.gfbce0eb801-goog

