Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408B2C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F4EC206EF
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTaZ4112"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgIAMHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 08:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgIAL5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:57:08 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5E7C061244;
        Tue,  1 Sep 2020 04:57:06 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 2so501784pjx.5;
        Tue, 01 Sep 2020 04:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mFkdWLKZl5wBoxMfTFXNzpq7BQ7hhrLO443ZFVNRdhM=;
        b=mTaZ4112TNRS4prIcuvRmJGJGSj4Hytxxx3g67T2HWEmdGS4Sar2bnfqM2bCTXhXpF
         Ry6cpqaOTNxTH8V+QfxX/MS3ddxvv998ZwMfAGxPXd0VEiJHdyDF5X7YIvg7neqDRF+9
         W5W3i9KBK2Uj+mJgyBIM91ipOGUBQxGPHE1bPANxntAh3EHs8RXG0TiuidiZzhf+lOnd
         0LbCzi2uRJf5lwFUvo+93vHEuhMbGq+q900kmTiwBGzMp854HFB9DdamMTsxsavhGqgx
         yNxbPRK5GOAxuYDmsHh+emMvtbjwQWTrkhrHCSoLpDNjDRfzx3GC8e0BdInIo29II0mf
         XJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mFkdWLKZl5wBoxMfTFXNzpq7BQ7hhrLO443ZFVNRdhM=;
        b=Md3ZCFH7MM8iRUOOUnKcepozyUAay5Ii1GEsInAMgKpY0MTNvvZnLI5emeYRUobCaK
         S9kAL3Ug+AQcMZSnb1NnNzwC5liHdyocRDMWbVH3v3rkzIsv2iNJlWxWagYbo6IQ0rwP
         golc+jbR4sqCjtedXR/K0mYiJXJi50aLIvPrtOrq/GpV1SLz2m1H4gqMmGVpjILg0qZM
         s7Jbs6iW+s+h5BSJx/z/oNxbATtK0RKq3FCQT55p7OgO3WHGasglFCMRddJrrjo27b+U
         MJr1Jv6Lb1sUO4whAr4Xeqg7uGgPV9wCCH+xHJg/apcYW+SRtwhiwnto1SVGQpkWudWO
         Ea2A==
X-Gm-Message-State: AOAM53382FZhfY8VTZfkM4Bvcb6MccCUQfst2w+/GdxiPnOvX2fRQDQN
        G/JPxmyESGEiPQm6rbuCT28=
X-Google-Smtp-Source: ABdhPJyIQFi+pQHQd7e1qoPG/l//rgpUvJ3nMYPB/HrYM4gbDtdJ2ivUedp4aXBUx+gVH4xyRFj2EA==
X-Received: by 2002:a17:90a:5298:: with SMTP id w24mr1161850pjh.221.1598961426409;
        Tue, 01 Sep 2020 04:57:06 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.65])
        by smtp.gmail.com with ESMTPSA id r2sm1854621pga.94.2020.09.01.04.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 04:57:06 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     pbonzini@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sean.j.christopherson@intel.com, jmattson@google.com,
        junaids@google.com, bgardon@google.com, vkuznets@redhat.com,
        xiaoguangrong.eric@gmail.com, kernellwp@gmail.com,
        lihaiwei.kernel@gmail.com, Yulei Zhang <yulei.kernel@gmail.com>,
        Yulei Zhang <yuleixzhang@tencent.com>
Subject: [RFC V2 9/9] Handle certain mmu exposed functions properly while turn on direct build EPT mode
Date:   Tue,  1 Sep 2020 19:57:47 +0800
Message-Id: <e179ea944f30d6a83a02ef17f2f2a367a3b7fedf.1598868204.git.yulei.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1598868203.git.yulei.kernel@gmail.com>
References: <cover.1598868203.git.yulei.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yulei Zhang <yulei.kernel@gmail.com>

Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 arch/x86/kvm/mmu/mmu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6639d9c7012e..35bd87bf965f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1719,6 +1719,9 @@ bool kvm_mmu_slot_gfn_write_protect(struct kvm *kvm,
 	int i;
 	bool write_protected = false;
 
+	if (kvm->arch.global_root_hpa)
+		return write_protected;
+
 	for (i = PG_LEVEL_4K; i <= KVM_MAX_HUGEPAGE_LEVEL; ++i) {
 		rmap_head = __gfn_to_rmap(gfn, i, slot);
 		write_protected |= __rmap_write_protect(kvm, rmap_head, true);
@@ -5862,6 +5865,9 @@ static void kvm_zap_obsolete_pages(struct kvm *kvm)
  */
 static void kvm_mmu_zap_all_fast(struct kvm *kvm)
 {
+	if (kvm->arch.global_root_hpa)
+		return;
+
 	lockdep_assert_held(&kvm->slots_lock);
 
 	spin_lock(&kvm->mmu_lock);
@@ -5924,6 +5930,9 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 	struct kvm_memory_slot *memslot;
 	int i;
 
+	if (kvm->arch.global_root_hpa)
+		return;
+
 	spin_lock(&kvm->mmu_lock);
 	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
 		slots = __kvm_memslots(kvm, i);
-- 
2.17.1

