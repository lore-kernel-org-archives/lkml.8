Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43570C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16174218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942566;
	bh=ggRepalI9rxSZiHeWYpAhYBIqtEyUblOEGC0s7+G0Lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y4/L84iW5BFcFR8RbnsBrp98Yzs2tPa82PeDoxN6yvYSLnTC2J8MIiAPPeF1BlhED
	 HItyBqZpWDSS0RI3jDy2CewHzWZ893PJI9FO7NyGcV6fRcUVPy6rIZpVs4Rk9sUAKN
	 096pKXk3752CN1D7+hEWncGb7GJqe1mLVMO9KRRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbgEHM4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:56:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730391AbgEHM4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:56:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D9282054F;
        Fri,  8 May 2020 12:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942562;
        bh=ggRepalI9rxSZiHeWYpAhYBIqtEyUblOEGC0s7+G0Lw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WW4cRIDJJ6wiH5Oh9FAOFGJvrk3rRUfunoBdUIVbWoY+WxAkHY4BlD3SbWICiiZ8f
         HClrEL0yfv0OgkVakmp1cKH42mBLb3Oe0dBvuAD/yCGpdyc5MfZVEFXYj9SAlfWHMd
         8dxS91qXbtORLFUUn6xFOpe54nVaLlbVPWRJGdnE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.6 44/49] x86/kvm: fix a missing-prototypes "vmread_error"
Date:   Fri,  8 May 2020 14:36:01 +0200
Message-Id: <20200508123049.001191211@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123042.775047422@linuxfoundation.org>
References: <20200508123042.775047422@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qian Cai <cai@lca.pw>

commit 514ccc194971d0649e4e7ec8a9b3a6e33561d7bf upstream.

The commit 842f4be95899 ("KVM: VMX: Add a trampoline to fix VMREAD error
handling") removed the declaration of vmread_error() causes a W=1 build
failure with KVM_WERROR=y. Fix it by adding it back.

arch/x86/kvm/vmx/vmx.c:359:17: error: no previous prototype for 'vmread_error' [-Werror=missing-prototypes]
 asmlinkage void vmread_error(unsigned long field, bool fault)
                 ^~~~~~~~~~~~

Signed-off-by: Qian Cai <cai@lca.pw>
Message-Id: <20200402153955.1695-1-cai@lca.pw>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx/ops.h |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/kvm/vmx/ops.h
+++ b/arch/x86/kvm/vmx/ops.h
@@ -12,6 +12,7 @@
 
 #define __ex(x) __kvm_handle_fault_on_reboot(x)
 
+asmlinkage void vmread_error(unsigned long field, bool fault);
 __attribute__((regparm(0))) void vmread_error_trampoline(unsigned long field,
 							 bool fault);
 void vmwrite_error(unsigned long field, unsigned long value);


