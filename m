Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83FEC3F2D8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3AE20842
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqlaEXXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbgCCOd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:33:29 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36375 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729301AbgCCOd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:33:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583246006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dxS31utg7cSHnx9gNHaxFkSn2ndxJH0EWB8zmNbHHaU=;
        b=CqlaEXXoa2daZwG94Lcs8dINQMTVoirUW5iFDIs6fd7/oc0OBAEjJ9pzudBy9c5HgUV78z
        lgb4OiA/5w5lJ3roLotr5DYmGQCcxwe+HEYhNQiJJeGuPrLNbm1kcDXywmHW4U49ISgGuU
        4xXGif9hzQfkGqg5oegbL/RrKLTGVkA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-eovxoltzNCGDaJN_BDeZSg-1; Tue, 03 Mar 2020 09:33:22 -0500
X-MC-Unique: eovxoltzNCGDaJN_BDeZSg-1
Received: by mail-wr1-f69.google.com with SMTP id z16so1287785wrm.15
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 06:33:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dxS31utg7cSHnx9gNHaxFkSn2ndxJH0EWB8zmNbHHaU=;
        b=jKS4ErGAn4pgQSBxXfWg9Yjp508vaNQ6Mp3h63lQN89upThg1dPbvdeWdie6bPY+DQ
         DAc/Hln0CPN0cYGciqD1hKQUSIWcEwhzP5RZD8wwjL+kH6CDBHmkM9uBC7FAcyo85ErF
         ZK7vKNBiQr7ktNIZzZwdQ8choTm2EaDzmDIU4Kc4d+IVfh8sb2vnPvCYxxSzC27tJoh/
         W9ZsRXX0gdXO4KLptmeAtg5WMNdGiUga0XiX6k0LRJ4/GxC3MszzW0W7Xiho8vGISW8G
         v3YYa9+CjPLOCOR7i8q5QehXzOtQSMOcOm9+7krImJTTsvUW3rUdoWbut/ZsV56MSuRX
         bayA==
X-Gm-Message-State: ANhLgQ2wwphKkgclJmjQc6AHOH+Yiv2IpYEFcBrWs/pto58X44LpK5mR
        xLiANomrhjEFIeFsj+mpKVJZCx4EHJUUQAsmFstHZ2mDHb28pm1uieTuKaPCjTVoQ5tUx7LgoRj
        TlC0jAhb5lEFyeCDF91iK5eHr
X-Received: by 2002:a7b:c450:: with SMTP id l16mr4305708wmi.166.1583246001724;
        Tue, 03 Mar 2020 06:33:21 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuiwZKiPNPSbaEdU6EDWlISiPkShkWhFvcHlJsEDXIDIJkikpcwOOHzE0oUhcxilTPbMtZMXw==
X-Received: by 2002:a7b:c450:: with SMTP id l16mr4305694wmi.166.1583246001555;
        Tue, 03 Mar 2020 06:33:21 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id s5sm32248504wru.39.2020.03.03.06.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 06:33:20 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Bandan Das <bsd@redhat.com>, Oliver Upton <oupton@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] KVM: x86: remove stale comment from struct x86_emulate_ctxt
Date:   Tue,  3 Mar 2020 15:33:16 +0100
Message-Id: <20200303143316.834912-3-vkuznets@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200303143316.834912-1-vkuznets@redhat.com>
References: <20200303143316.834912-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c44b4c6ab80e ("KVM: emulate: clean up initializations in
init_decode_cache") did some field shuffling and instead of
[opcode_len, _regs) started clearing [has_seg_override, modrm).
The comment about clearing fields altogether is not true anymore.

Fixes: c44b4c6ab80e ("KVM: emulate: clean up initializations in init_decode_cache")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/kvm_emulate.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_emulate.h b/arch/x86/include/asm/kvm_emulate.h
index 2a8f2bd2e5cf..c06e8353efd3 100644
--- a/arch/x86/include/asm/kvm_emulate.h
+++ b/arch/x86/include/asm/kvm_emulate.h
@@ -360,7 +360,6 @@ struct x86_emulate_ctxt {
 	u64 d;
 	unsigned long _eip;
 	struct operand memop;
-	/* Fields above regs are cleared together. */
 	unsigned long _regs[NR_VCPU_REGS];
 	struct operand *memopp;
 	struct fetch_cache fetch;
-- 
2.24.1

