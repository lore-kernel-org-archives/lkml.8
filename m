Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DBDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0497C206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="BCBMwrmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbgEVMxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 08:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729852AbgEVMwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 08:52:23 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7141C08C5C9
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 05:52:22 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v16so12502693ljc.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 05:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CZiTRxJYlwT1JI2O16YcOTpTGTvsIt3/iftpkk7xc8A=;
        b=BCBMwrmxMDVQ8OtO/KzaGXdCQjeM5F3cHHB0vfwb+cvf3Z9A3LDLjE7FRdVA24erc1
         AwGxByPjg3hQAFjypKvSVkWdRRBvKLHfBx29kditdFzk85rwJq1bXca7C6+N6UmBzHt2
         OXnkj1PjOYNeHoVV4Ifh9uH4tgA161gjedRNrQL0TngxOBh8LfMvjqFNZWSE5EVvQVjf
         /MPNmP2sqqH6b4eEbAFXnNVzihJ3KDwwxVKCXR3tgnkR35deNmWrXA6h1mMyzS88L//S
         C5oUjasf0WZz8yTkaFbxXPLdszje883xE+ngP1PTwL+ClRS5mxxgTFJiVccDWlLid61Z
         YBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CZiTRxJYlwT1JI2O16YcOTpTGTvsIt3/iftpkk7xc8A=;
        b=FkXh601SVwEkepOutwUtmz/4SbGupuAKfjzR9MBqjydo6OtX4hJq7u9YWWJBM5inoi
         uRNliPpFpxDk08UgyRIajotcsCCi0TC8oDWRDmzxxSoyaM9LzyP83E9JkwppNrOeIKTV
         F0AFbTH1PMj5+csXzjFjvZQJV9tGSc79OSmn700/MQDMyyx3LEvOLzLO1QGAbQ+luwak
         r+mXljQTbE33WK19r4ttFOH0L5+I2VT25Adu2XkWFvgWxBqGdHYmdg/n1Rf9pvBEnrjw
         ArpSXGDx7y2Hj/biQPh7T4SiBYnuFMPKxWGR1Hefx1QZqNhFzuk1dN74L1pLheZ2sPvK
         uNIA==
X-Gm-Message-State: AOAM533ncRE9JXwY/JlOaIaEioc62gBtfGGMFhYjG8k3y/1UpkvXa3cx
        gIF4CUUQLc6MsYrcW6a4ButiaQ==
X-Google-Smtp-Source: ABdhPJxTEKdBkbnDP1WqaMmPg43HON2muTRB5YapI1uWS4rRjwdDOETM87HycrYnjbyjjuXd8HuRsw==
X-Received: by 2002:a2e:6e17:: with SMTP id j23mr7349735ljc.106.1590151941240;
        Fri, 22 May 2020 05:52:21 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id e18sm343155lja.55.2020.05.22.05.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 05:52:20 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id D8584102056; Fri, 22 May 2020 15:52:19 +0300 (+03)
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
Subject: [RFC 08/16] KVM: x86: Use GUP for page walk instead of __get_user()
Date:   Fri, 22 May 2020 15:52:06 +0300
Message-Id: <20200522125214.31348-9-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522125214.31348-1-kirill.shutemov@linux.intel.com>
References: <20200522125214.31348-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The user mapping doesn't have the page mapping for protected memory.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kvm/mmu/paging_tmpl.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 9bdf9b7d9a96..ef0c5bc8ad7e 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -400,8 +400,14 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 			goto error;
 
 		ptep_user = (pt_element_t __user *)((void *)host_addr + offset);
-		if (unlikely(__get_user(pte, ptep_user)))
-			goto error;
+		if (vcpu->kvm->mem_protected) {
+			if (copy_from_guest(&pte, host_addr + offset,
+					    sizeof(pte)))
+				goto error;
+		} else {
+			if (unlikely(__get_user(pte, ptep_user)))
+				goto error;
+		}
 		walker->ptep_user[walker->level - 1] = ptep_user;
 
 		trace_kvm_mmu_paging_element(pte, walker->level);
-- 
2.26.2

