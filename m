Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0A6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 808D3206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="GtiEZ4n1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbgEVMx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 08:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729847AbgEVMwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 08:52:22 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B049C08C5C7
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 05:52:22 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z18so12439362lji.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 05:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TRTK9a5mpqTDY5ZfccpPpqg6MJ7UvrTh0xOAXZSLOT0=;
        b=GtiEZ4n19ouyAizgKUR7+QtiVY5GOsdnqMTjHrIb62L5xETehoiRwghxpTXWAFsud/
         mzMElUVEBDDRWzoET4wNfdBr+wjaqzM/XIt1wcZOSbxfJkSXPhaXh78G/xODWbBkjHWI
         Ml2DHUVIQJ87N1mWdC9TF590bqRjFqLm61X3ZvCMq8khw6tLBA9ohicbe26vEv2hL8U5
         4F9TmwyGNQDDzBo+XOMmQUHnWmvDEW6nCGxTzjxiqD3j423EdCtU2NM74RLdpHP02Q1T
         BbVYwG/7tf+sGDZcMWGVGYeXypePS7/N7EB2aXkxTZ+AwJIqmQ4ZMG6MMGqCPisBllWD
         ayxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TRTK9a5mpqTDY5ZfccpPpqg6MJ7UvrTh0xOAXZSLOT0=;
        b=MTSoSNimbQK8Wcni7qRf/FelS9DWJaycefL+gRYuuf9gyBrQF8lXT0bCq93Y9QCh0S
         BzGuzCOjkoCtLUimvWZ5RpFjBAfHyzlonIRBi4qeIVQgfHD6RSi1PBDmqPIS+Xnm4Oam
         C4Tg1r6IiM7wr386z7dfpoIE+2pTr6VieAUvIRpKDt3R41NkrZ6VB5xWaU7coVOuFFRd
         KlvExuq9PMo2lU+X1yNmEZoC4v7CxjIQgr4/g/WZtK6dK09QNj0QQUoO9Pw7PM/DAZbd
         aZcUlqGf4BPObmc/9YMGU1N+2l/ye7jMUVsUgf4Iy+l2NlV5vI9+HopPhzHvs5ArLv0y
         iumA==
X-Gm-Message-State: AOAM533gwiciOqQ6fTvfYUQCBaJmP83IX/s4BHsUkS73UwfiJz2sFUon
        0h+PXL5Vtq/0vBIvSKxsDDC0wA==
X-Google-Smtp-Source: ABdhPJxgD8Uk4BEWMvgEPW1VD/uD+DbfKpa/h/WYtV9wQd/dZu3w9fynzecAsTLspWi1RmapCaP6QQ==
X-Received: by 2002:a2e:9f43:: with SMTP id v3mr7757905ljk.285.1590151940948;
        Fri, 22 May 2020 05:52:20 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id n8sm2401340lfb.20.2020.05.22.05.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 05:52:20 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id C0A1C102053; Fri, 22 May 2020 15:52:19 +0300 (+03)
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFC 05/16] x86/kvm: Make VirtIO use DMA API in KVM guest
Date:   Fri, 22 May 2020 15:52:03 +0300
Message-Id: <20200522125214.31348-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522125214.31348-1-kirill.shutemov@linux.intel.com>
References: <20200522125214.31348-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VirtIO for KVM is a primary way to provide IO. All memory that used for
communication with the host has to be marked as shared.

The easiest way to archive that is to use DMA API that already knows how
to deal with shared memory.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 drivers/virtio/virtio_ring.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 58b96baa8d48..bd9c56160107 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -12,6 +12,7 @@
 #include <linux/hrtimer.h>
 #include <linux/dma-mapping.h>
 #include <xen/xen.h>
+#include <asm/kvm_para.h>
 
 #ifdef DEBUG
 /* For development, we want to crash whenever the ring is screwed. */
@@ -255,6 +256,9 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
 	if (xen_domain())
 		return true;
 
+	if (kvm_mem_protected())
+		return true;
+
 	return false;
 }
 
-- 
2.26.2

