Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC71BC3F2CE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 02:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960562469B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 02:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbgB1CuB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 21:50:01 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:39058 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726943AbgB1CuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 21:50:01 -0500
Received: from mr2.cc.vt.edu (mr2.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:90:e077:bf22])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 01S2o0hU004054
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 21:50:00 -0500
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 01S2ntdx004420
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 21:50:00 -0500
Received: by mail-qv1-f71.google.com with SMTP id m6so377988qvo.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 18:50:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version
         :content-id:content-transfer-encoding:date:message-id;
        bh=TMxAIoujXzqS3798HgNWfd0wXc3IAjXqWU595ApRFSw=;
        b=NbgkmNErYbrfiWJGF6pPbvKyIgOTStBu9ue/Huvsz5mYRmGE3+hkJMHNgNDFoQmmQz
         ijMF/YoyGLeyGfbo5waf2dCqiCYUx3ppv3631YfoSvQMBwy9mrvu0LL38WGu51CraKn9
         4iRLxgg67bP/xrrXXQ4km3j+rOjLtCpJzLeC0zpZSUtQ1NuL0/wwVcPZNstLamFVK2A4
         oZUbvGuC5ehoLr17ZHpuDjdyWuWZv9wW/NMLC5lxw+VG82c1ip/nrXhmM1daNcwYnlxa
         Yv+p/6g8CX3RvVx8n2auX2geMOBb6ds2pRKEX857wUumVW7dHD7r8FCjrUicMR0CERcp
         QIIA==
X-Gm-Message-State: APjAAAWzw5Keq5DUJfekJPbKlKlFw9RslsgnZGET+AYppPSxzxiJW1Ub
        J55TWScrUonGTkYjphtB85J0XCmHEHaSiU0/hsp8EwAXxeu8qK8W+vwHVGHqbWCWAsuHNMiODvV
        gCU4HhhVQQ8OVuoDInw9pd+w2ld0Ni4znlAg=
X-Received: by 2002:a37:6111:: with SMTP id v17mr2544753qkb.210.1582858195018;
        Thu, 27 Feb 2020 18:49:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqxqpvtFlPmXpm9FoxRteLLKVlXXhcaTG1YqTU72QLXMBBhjrUVYf45oDs0UAE5r0eZa9rO8Kg==
X-Received: by 2002:a37:6111:: with SMTP id v17mr2544735qkb.210.1582858194753;
        Thu, 27 Feb 2020 18:49:54 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id t4sm4300738qkm.82.2020.02.27.18.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 18:49:53 -0800 (PST)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: nVMX: allow compiling with W=1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <263440.1582858192.1@turing-police>
Content-Transfer-Encoding: 8BIT
Date:   Thu, 27 Feb 2020 21:49:52 -0500
Message-ID: <263441.1582858192@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compile error with CONFIG_KVM_INTEL=y and W=1:

  CC      arch/x86/kvm/vmx/vmx.o
arch/x86/kvm/vmx/vmx.c:68:32: error: 'vmx_cpu_id' defined but not used [-Werror=unused-const-variable=]
   68 | static const struct x86_cpu_id vmx_cpu_id[] = {
      |                                ^~~~~~~~~~
cc1: all warnings being treated as errors

When building with =y, the MODULE_DEVICE_TABLE macro doesn't generate a
reference to the structure (or any code at all).  This makes W=1 compiles
unhappy.

Wrap both in a #ifdef to avoid the issue.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 40a1467d1655..5c2fc2177b0d 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -65,11 +65,13 @@
 MODULE_AUTHOR("Qumranet");
 MODULE_LICENSE("GPL");
 
+#ifdef MODULE
 static const struct x86_cpu_id vmx_cpu_id[] = {
 	X86_FEATURE_MATCH(X86_FEATURE_VMX),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, vmx_cpu_id);
+#endif
 
 bool __read_mostly enable_vpid = 1;
 module_param_named(vpid, enable_vpid, bool, 0444);

