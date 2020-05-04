Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6717FC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 22:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 423FC206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 22:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5MjTEka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgEDWGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 18:06:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26629 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726291AbgEDWGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 18:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588629972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ldiUHTo4H9fOXrlK9CdJK+WOClXBqbBS4tE+9OydXYY=;
        b=L5MjTEkanNOZ7Enp+O6rAlTi4fu/Qw2VOyXYtM95dze+2RLqmXjHP5NCWsKq9B4jDY6Nki
        j3S1u86dwC0M5G0x1iCGUNHjbB9vKc0M9IHmXqac+/6sjLVTzi2V98KvPnQ4FE+FrWuXJ6
        FlU0NkpllTiUFDDklLDOSEuZMGFOVxk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-XFtL33lHMY2IQ-76_oqLfg-1; Mon, 04 May 2020 18:06:11 -0400
X-MC-Unique: XFtL33lHMY2IQ-76_oqLfg-1
Received: by mail-qt1-f199.google.com with SMTP id g55so1179848qtk.14
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 15:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ldiUHTo4H9fOXrlK9CdJK+WOClXBqbBS4tE+9OydXYY=;
        b=fVcFY3XA57nfdHamAlCNKSU9OCu++XVb4ZJ6Gej3N9tex3KRrbd3anfSnJjA4NFXD2
         Ude4BQrKdQ4ZZO1+a/8qwWDeUDswZmEvD96EUglUa3fAqo3e5jm3iUIupwW+TMPyT1O4
         RbnD9HrThAOeOpbDuC7YqgJ5Foeb0YoFFJ3ySuTObX2uQvC7nuHscka6a/PqsEQkwl9U
         a1yY74WwCTJDX/5xB1fN+4xCOoKKeWWDe/U2r4ZQhrxqISIeKPmUMjRqYvYo7pzmy7I6
         CmBuxw4k8HLPxjKCTI2+Blz1nzwI9C5492oqEsRBJnwqJUjMkadD6hwU5LSVtWK65q3i
         IDTQ==
X-Gm-Message-State: AGi0PuZNK+XYOoNKWe2FPyrp0gHaAOC/5SnEoeqem4YALWPUycdr3t35
        KZEOpyxfvBgrdfDc3TPV/TWUKDzzMZqhutmYCYW6eXnEqSL+43PSWVlPceSutJSfB/sI1iqtXlx
        PFrMi6PfeW0bVTC2fBX4Krivb
X-Received: by 2002:a37:9ed5:: with SMTP id h204mr526775qke.446.1588629970541;
        Mon, 04 May 2020 15:06:10 -0700 (PDT)
X-Google-Smtp-Source: APiQypI5ratxafcXWdXR+7DiDQCFg9ET2QsWxNKpq+Gblz9ExXQG316TfcD4OkoqLvruQxBYtCMisg==
X-Received: by 2002:a37:9ed5:: with SMTP id h204mr526742qke.446.1588629970165;
        Mon, 04 May 2020 15:06:10 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id w18sm279534qkw.113.2020.05.04.15.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 15:06:09 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH] KVM: selftests: Fix build for evmcs.h
Date:   Mon,  4 May 2020 18:06:07 -0400
Message-Id: <20200504220607.99627-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got this error when building kvm selftests:

/usr/bin/ld: /home/xz/git/linux/tools/testing/selftests/kvm/libkvm.a(vmx.o):/home/xz/git/linux/tools/testing/selftests/kvm/include/evmcs.h:222: multiple definition of `current_evmcs'; /tmp/cco1G48P.o:/home/xz/git/linux/tools/testing/selftests/kvm/include/evmcs.h:222: first defined here
/usr/bin/ld: /home/xz/git/linux/tools/testing/selftests/kvm/libkvm.a(vmx.o):/home/xz/git/linux/tools/testing/selftests/kvm/include/evmcs.h:223: multiple definition of `current_vp_assist'; /tmp/cco1G48P.o:/home/xz/git/linux/tools/testing/selftests/kvm/include/evmcs.h:223: first defined here

I think it's because evmcs.h is included both in a test file and a lib file so
the structs have multiple declarations when linking.  After all it's not a good
habit to declare structs in the header files.

Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---

I initially thought it was something about my GCC 10 upgrade that I recently
did to my laptop - gcc10 even fails the build of the latest kernel after
all (though it turns out to be a kernel bug on build system rather than a gcc
bug). but I'm not sure about this one...
---
 tools/testing/selftests/kvm/include/evmcs.h  | 4 ++--
 tools/testing/selftests/kvm/lib/x86_64/vmx.c | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/evmcs.h b/tools/testing/selftests/kvm/include/evmcs.h
index d8f4d6bfe05d..a034438b6266 100644
--- a/tools/testing/selftests/kvm/include/evmcs.h
+++ b/tools/testing/selftests/kvm/include/evmcs.h
@@ -219,8 +219,8 @@ struct hv_enlightened_vmcs {
 #define HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_MASK	\
 		(~((1ull << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT) - 1))
 
-struct hv_enlightened_vmcs *current_evmcs;
-struct hv_vp_assist_page *current_vp_assist;
+extern struct hv_enlightened_vmcs *current_evmcs;
+extern struct hv_vp_assist_page *current_vp_assist;
 
 int vcpu_enable_evmcs(struct kvm_vm *vm, int vcpu_id);
 
diff --git a/tools/testing/selftests/kvm/lib/x86_64/vmx.c b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
index 6f17f69394be..4ae104f6ce69 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
@@ -17,6 +17,9 @@
 
 bool enable_evmcs;
 
+struct hv_enlightened_vmcs *current_evmcs;
+struct hv_vp_assist_page *current_vp_assist;
+
 struct eptPageTableEntry {
 	uint64_t readable:1;
 	uint64_t writable:1;
-- 
2.26.2

