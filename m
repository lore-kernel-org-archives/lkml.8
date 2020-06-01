Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C68C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A7B207BC
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XeshdPlP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgFAM1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 08:27:23 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53825 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725838AbgFAM1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 08:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591014441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Zo6RuHp2sjoLM+K5Td7Eh7/Ep0BrLjWQwrY5C7jL79M=;
        b=XeshdPlPLKGcw5sclTzArjmXGOL6OufWjrv9WQHQ12zqrg0PkaRDHX04bHt4IaIypI+nkL
        kTyP6WqvRlEu4pR1GuEwniWx68WNEzJytbhHQvxiaTxaZb+p686qWpBg7kniBIHdWBNWpp
        vaIKplqL0a0Nv0M2X1sa+0ynoZFBszs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-vZ4ihf78PEKhbHIbqXvL9Q-1; Mon, 01 Jun 2020 08:27:17 -0400
X-MC-Unique: vZ4ihf78PEKhbHIbqXvL9Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00D6680B73A;
        Mon,  1 Jun 2020 12:27:16 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E5A27E7F1;
        Mon,  1 Jun 2020 12:27:13 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH] xen: Fix build with recent suspend_hvm.c changes
Date:   Mon,  1 Jun 2020 14:27:11 +0200
Message-Id: <20200601122711.222696-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild test robot reports the following issues with some randconfig build:
...
In file included from ./include/xen/interface/hvm/params.h:24,
                 from ./include/xen/hvm.h:6,
                 from arch/x86/xen/suspend_hvm.c:5:
./include/xen/interface/hvm/hvm_op.h:29:5: error: unknown type name ‘domid_t’
   29 |     domid_t  domid;    /* IN */
      |     ^~~~~~~
./include/xen/interface/hvm/hvm_op.h:33:1: warning: data definition has no
  type or storage class
   33 | DEFINE_GUEST_HANDLE_STRUCT(xen_hvm_param);
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/xen/interface/hvm/hvm_op.h:33:1: error: type defaults to ‘int’ in
  declaration of ‘DEFINE_GUEST_HANDLE_STRUCT’ [-Werror=implicit-int]
...

These definitions are in xen/interface/xen.h, add the include to hvm.h.

Fixes: 28447ea41542 ("xen: Move xen_setup_callback_vector() definition to include/xen/hvm.h")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
- I'm failing to see why this was compiling when 28447ea41542 ("xen: Move
 xen_setup_callback_vector() definition to include/xen/hvm.h") was
 submitted, just keeping playing whack-a-mole game fixing the immediate
 issue, thanks kbuild robot for the report!
---
 include/xen/hvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/xen/hvm.h b/include/xen/hvm.h
index b7fd7fc9ad41..7cf0c529ab4a 100644
--- a/include/xen/hvm.h
+++ b/include/xen/hvm.h
@@ -3,6 +3,7 @@
 #ifndef XEN_HVM_H__
 #define XEN_HVM_H__
 
+#include <xen/interface/xen.h>
 #include <xen/interface/hvm/params.h>
 #include <asm/xen/hypercall.h>
 
-- 
2.25.4

