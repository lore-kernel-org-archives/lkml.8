Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD13C35250
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 22:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3CDF217BA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 22:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CNzMrAp2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgBGWfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 17:35:30 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27191 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727068AbgBGWf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 17:35:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581114927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8BwOjosBD3aan9vZqA1/XtTiViONk3Y9UUF8NI7mgRo=;
        b=CNzMrAp2t/XbYnhlGTPEcX3kqBU20BSZ7NvTW7ANuCfz5/NU7xnQyyammZfzuiOCw6W4zG
        pfMhX6vkk0PYqzGU0nPU6tp3OgtUk04KFl9PoXLdAAnjPwnf0iAkkFwgQaWaSu4pAa3+77
        mWY0fL5vQ4UdtBIevg8QxjOoTCZNmQ4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-E8XtL9cOMPaR6BfvHgdSvQ-1; Fri, 07 Feb 2020 17:35:26 -0500
X-MC-Unique: E8XtL9cOMPaR6BfvHgdSvQ-1
Received: by mail-qk1-f198.google.com with SMTP id d134so500985qkc.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 14:35:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8BwOjosBD3aan9vZqA1/XtTiViONk3Y9UUF8NI7mgRo=;
        b=YB3m1PHnTBIEMfnkXEkQmjU9PYZv9GT8sLctitylBwB2dccdlwq+fJpRHdT8R6XLLl
         /ZdrErAGQnAtXAudAdoxt2Z1gJplM9ahZl41tS/ihHGpn5zDQ45ztIWh/W1okRfiQzjz
         lu31Io506+F5PyXB2JbOYMz0iZHXzXX/a4NzKd8mLm/8K5ghNSuJfzZAnA+qweP1YvNW
         wisJZGoBkD0Vp5v2sw2hwvGwhWVrUbstLeJ/Rnd73lMIOV5jTvLkOPpQyy/mMLbHukvo
         4qQx8J0yyLEEtFqaqWmlHwvLBPDQVfkDedWnFWcE4M5Uiw728gAeCpOQ+zH9BCNmMTd+
         IoJw==
X-Gm-Message-State: APjAAAXXyhtzBVzdMGDCLFDqQT3x8COMpIBjOW/OjAqfW19KK7lGyr4Q
        fYMMub4c3ny73Isqt7VU6Tm8d6gFI8OhNiGtHu2XVhYQvfRlDPH0hqNf4ZQHHAJebhzr3sgzFVU
        wzdbKAlUZRznKBdS0Iqy+4B87
X-Received: by 2002:aed:3e13:: with SMTP id l19mr560579qtf.103.1581114925267;
        Fri, 07 Feb 2020 14:35:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqyVTvI4slEe315nMe8hBROEAYdieeZun635Z6BLpraphf59wQM9cy4oqH/UIWzzvIngWXEG9g==
X-Received: by 2002:aed:3e13:: with SMTP id l19mr560554qtf.103.1581114925041;
        Fri, 07 Feb 2020 14:35:25 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id u12sm2178736qtj.84.2020.02.07.14.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 14:35:24 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-mips@vger.kernel.org, peterx@redhat.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH RFC 1/4] KVM: Provide kvm_flush_remote_tlbs_common()
Date:   Fri,  7 Feb 2020 17:35:17 -0500
Message-Id: <20200207223520.735523-2-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207223520.735523-1-peterx@redhat.com>
References: <20200207223520.735523-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's exactly kvm_flush_remote_tlbs() now but a internal wrapper of the
common code path.  With this, an arch can then optionally select
CONFIG_HAVE_KVM_ARCH_TLB_FLUSH_ALL=y and will be able to use the
common flushing code.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/kvm_host.h |  1 +
 virt/kvm/kvm_main.c      | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6d5331b0d937..915df64125f9 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -798,6 +798,7 @@ int kvm_vcpu_yield_to(struct kvm_vcpu *target);
 void kvm_vcpu_on_spin(struct kvm_vcpu *vcpu, bool usermode_vcpu_not_eligible);
 
 void kvm_flush_remote_tlbs(struct kvm *kvm);
+void kvm_flush_remote_tlbs_common(struct kvm *kvm);
 void kvm_reload_remote_mmus(struct kvm *kvm);
 
 bool kvm_make_vcpus_request_mask(struct kvm *kvm, unsigned int req,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index eb3709d55139..9c7b39b7bb21 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -302,8 +302,7 @@ bool kvm_make_all_cpus_request(struct kvm *kvm, unsigned int req)
 	return called;
 }
 
-#ifndef CONFIG_HAVE_KVM_ARCH_TLB_FLUSH_ALL
-void kvm_flush_remote_tlbs(struct kvm *kvm)
+void kvm_flush_remote_tlbs_common(struct kvm *kvm)
 {
 	/*
 	 * Read tlbs_dirty before setting KVM_REQ_TLB_FLUSH in
@@ -327,6 +326,13 @@ void kvm_flush_remote_tlbs(struct kvm *kvm)
 		++kvm->stat.remote_tlb_flush;
 	cmpxchg(&kvm->tlbs_dirty, dirty_count, 0);
 }
+EXPORT_SYMBOL_GPL(kvm_flush_remote_tlbs_common);
+
+#ifndef CONFIG_HAVE_KVM_ARCH_TLB_FLUSH_ALL
+void kvm_flush_remote_tlbs(struct kvm *kvm)
+{
+	kvm_flush_remote_tlbs_common(kvm);
+}
 EXPORT_SYMBOL_GPL(kvm_flush_remote_tlbs);
 #endif
 
-- 
2.24.1

