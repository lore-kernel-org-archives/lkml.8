Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0F1C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A754208C3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNGEwCDk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgCIPwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 11:52:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20041 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727178AbgCIPwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 11:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583769152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x4pW19833p+fXxfsFrvmy67Ky5HT38eac4OMiKrYje0=;
        b=GNGEwCDkqyMJTEsy4OasSV6g2ugCYJHbvCBxmesyXBRhruQIjuGx6Q0gOGchq5LXmYZ84u
        WIHfQJmRXNdzUaXifmd78w8eMyS4e3WSG32xdLufkzbjMAiVZyXOkobGXTwNX/d3m4sU5P
        d1fW0xeNQRGgApkxQmwTYdXGUcNIKuw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-sf5GRUvdOMiemnBjk6C13Q-1; Mon, 09 Mar 2020 11:52:31 -0400
X-MC-Unique: sf5GRUvdOMiemnBjk6C13Q-1
Received: by mail-wr1-f70.google.com with SMTP id z13so511028wrv.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 08:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x4pW19833p+fXxfsFrvmy67Ky5HT38eac4OMiKrYje0=;
        b=IWoYQaUPjxG6YFW9+mn3lY+wxJDXfh/RdhUm0YWhbWotkX7YPFcgJf5ayDnljX+IhO
         TAZUjkqIT+kNtjcm2RtNG0CoFjpQKGxMm9+gjgpT+A0UpCgnZeJHGFxR+ATi0FAEOhu3
         JCAGgLqOur7LCejTAkcav1yL8C/RAVat2uurfN4vCqM2UbHClJmnp9NGlUdbDJo2FPJp
         vg2+KzKMxt0Mh+d2Xk8R5FEJjfaZEYLmXYsLJIqvW3PALI8DuHyegGSPn0Xkftge67vB
         oWGu78r2edfoKA+l1XVof4M0UTCBdADE7P/ygCRIx7o6ct90rWKh75skEoCpcYricUJy
         Oc1w==
X-Gm-Message-State: ANhLgQ3NO4VLHXLWgxGCrK1kw8fdk5rTy3LjKoU9pAAgnETMeEbKJgnJ
        QJ39ZfJzgHI23Jcme9/CDIkY7t9b64xRU/PdYK4ZUGgOUzSenMQZ3ApXp11IBXdX1SKIogW9kTq
        Wp9HQYJ0S17xMN4XsoEvyAzdp
X-Received: by 2002:adf:ed86:: with SMTP id c6mr18930575wro.53.1583769149845;
        Mon, 09 Mar 2020 08:52:29 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtNpfvkJjRTfTeKbLF72oykUGIlVbTuKMnR5vx+0KBXL7IxXEBsEWk1uSdTmYa4hf4LFzVGKg==
X-Received: by 2002:adf:ed86:: with SMTP id c6mr18930552wro.53.1583769149663;
        Mon, 09 Mar 2020 08:52:29 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q4sm17294521wro.56.2020.03.09.08.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 08:52:28 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liran Alon <liran.alon@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: [PATCH 4/6] KVM: selftests: define and use EVMCS_VERSION
Date:   Mon,  9 Mar 2020 16:52:14 +0100
Message-Id: <20200309155216.204752-5-vkuznets@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309155216.204752-1-vkuznets@redhat.com>
References: <20200309155216.204752-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM allows to use revision_id from MSR_IA32_VMX_BASIC as eVMCS revision_id
to workaround a bug in genuine Hyper-V (see the comment in
nested_vmx_handle_enlightened_vmptrld()), this shouldn't be used by
default. Switch to using KVM_EVMCS_VERSION(1).

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 tools/testing/selftests/kvm/include/evmcs.h  | 2 ++
 tools/testing/selftests/kvm/lib/x86_64/vmx.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/evmcs.h b/tools/testing/selftests/kvm/include/evmcs.h
index 4912d23844bc..d8f4d6bfe05d 100644
--- a/tools/testing/selftests/kvm/include/evmcs.h
+++ b/tools/testing/selftests/kvm/include/evmcs.h
@@ -16,6 +16,8 @@
 #define u32 uint32_t
 #define u64 uint64_t
 
+#define EVMCS_VERSION 1
+
 extern bool enable_evmcs;
 
 struct hv_vp_assist_page {
diff --git a/tools/testing/selftests/kvm/lib/x86_64/vmx.c b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
index 7aaa99ca4dbc..1efbfa18f184 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
@@ -191,7 +191,7 @@ bool load_vmcs(struct vmx_pages *vmx)
 		if (evmcs_vmptrld(vmx->enlightened_vmcs_gpa,
 				  vmx->enlightened_vmcs))
 			return false;
-		current_evmcs->revision_id = vmcs_revision();
+		current_evmcs->revision_id = EVMCS_VERSION;
 	}
 
 	return true;
-- 
2.24.1

