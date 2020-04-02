Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACF0C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EEF8206F6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="lNlymgKI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389386AbgDBPkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:40:09 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:35031 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388591AbgDBPkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:40:09 -0400
Received: by mail-qv1-f68.google.com with SMTP id q73so1889986qvq.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 08:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PYelBMpM/3QJH1rKStk9XKPwcLOdDKg6wW/AuMLbwA0=;
        b=lNlymgKIirJd7VAjfYBBqRftLBhc6UFUfiuiLaxma5vrER6aASiWEFCmMywJMyOy0k
         kIDZGJS/JcyPGJbWqzFLb3ZypGU+/LSLc+SxxZGyW7+Aa0MsJ0Zkxkvfosuep4srSdPG
         MebPu1XuXHTN9hCyHpf2KRMX9gGegmAuSOwj0jyJB3T+/cHQ8sXXfOA117NUCQw94uoJ
         a6uNqw6Vlf/oi3ADr368GSxVXLzM38IzfW1RCjgUzX19TrxT8I4BptPljilD28rawM6G
         72HG7DZfFcayoxN4BjA8cH0EaK2jVN19iK1Ebem1CJNUP2jGybMBzP6ejISXGkC4LRUc
         kNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PYelBMpM/3QJH1rKStk9XKPwcLOdDKg6wW/AuMLbwA0=;
        b=gTqSB0ivZsR5g8CN6SkNKifo0ESLCnY65czo3sh6XPHUN0NcEpillQu0UXNPrIssJl
         eUt+t+RDEgRq53dt0KT2F8Iu7Rq/d1ctg9/o21L3/VjS/MiNuLD80t6HL3danj5+CpCV
         JwixCrWo0wT2kYkvCiAfWbXWyaPb1N8hjguDa15N5MvENA3PUb0mr0uZ2VFsGk1k1a35
         Q/BhoyclP9e7Yue4FmpeFHM8l93MR3V6qLWBWzZ2u+sAtgbemhqccEaDSXicwKJINJBG
         VxkY0SBcstu93xazCTmz7sA9m6yyX29Ji0VpzbawRXrA378IVyCBObhTzLrZtqOEi9ZC
         ZmfA==
X-Gm-Message-State: AGi0PuZmWVW2jbKYHi3YONyq5t9NQKG6juZOFuAUdb1Tq7ezi1Rbbptj
        VxkzYrtcHwj6roE6+rjtcVJdv6mmlhphJA==
X-Google-Smtp-Source: APiQypI9is3KJbPY3xl6sirQXhgEy8iEvNue4xUMKbvI46xXBmbp9jGdyrp8NAfqhBcHwxpEFMSMrQ==
X-Received: by 2002:ad4:5012:: with SMTP id s18mr3982997qvo.162.1585842008226;
        Thu, 02 Apr 2020 08:40:08 -0700 (PDT)
Received: from ovpn-66-203.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id n46sm4069873qtb.48.2020.04.02.08.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 08:40:07 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     pbonzini@redhat.com
Cc:     sean.j.christopherson@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] x86/kvm: fix a missing-prototypes "vmread_error"
Date:   Thu,  2 Apr 2020 11:39:55 -0400
Message-Id: <20200402153955.1695-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 842f4be95899 ("KVM: VMX: Add a trampoline to fix VMREAD error
handling") removed the declaration of vmread_error() causes a W=1 build
failure with KVM_WERROR=y. Fix it by adding it back.

arch/x86/kvm/vmx/vmx.c:359:17: error: no previous prototype for 'vmread_error' [-Werror=missing-prototypes]
 asmlinkage void vmread_error(unsigned long field, bool fault)
                 ^~~~~~~~~~~~

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/x86/kvm/vmx/ops.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/vmx/ops.h b/arch/x86/kvm/vmx/ops.h
index 09b0937d56b1..19717d0a1100 100644
--- a/arch/x86/kvm/vmx/ops.h
+++ b/arch/x86/kvm/vmx/ops.h
@@ -12,6 +12,7 @@
 
 #define __ex(x) __kvm_handle_fault_on_reboot(x)
 
+asmlinkage void vmread_error(unsigned long field, bool fault);
 __attribute__((regparm(0))) void vmread_error_trampoline(unsigned long field,
 							 bool fault);
 void vmwrite_error(unsigned long field, unsigned long value);
-- 
2.21.0 (Apple Git-122.2)

