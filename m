Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD22C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 661CD2065C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNKC5K6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390294AbgEMSww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 14:52:52 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57671 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390263AbgEMSwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 14:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589395967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=wHSBbB5/QZT/EwoeOOweY77s6h/009zkbzY0iSlBYP8=;
        b=XNKC5K6G/mfo8AKKLTtuLBsXi/K+dlZeEVFIiRACByhsrnRXasb7YTzsY1V4W2ugxgU08z
        xJy3I8u4dE9fdEMh5VjEqzqJ+Amm7uMgWU5XazNwhZIw9ioxd3Jk3dLu4UCt0ekk3yhBt7
        FvyuNjMCYscxLr3EACtDbHkKCbTBYzM=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-65YgdnZGO9CHMQl_Qezs1A-1; Wed, 13 May 2020 14:52:46 -0400
X-MC-Unique: 65YgdnZGO9CHMQl_Qezs1A-1
Received: by mail-pg1-f199.google.com with SMTP id y4so321187pgo.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 11:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wHSBbB5/QZT/EwoeOOweY77s6h/009zkbzY0iSlBYP8=;
        b=EtFhrkcOPrkYkVd0KC05aF4a4fk21lUAZAJDGu8Z2u5k1UBRGFfjE1Emap62L7vbwU
         CuHoQZ/phCIn0j7YXWuTVLpNWoNUJw52SNNEMJAiFOIyQnbKlR1OurrxEboYLvjx8bVl
         SLIFLAInoIOA/m7s59wPOoVaVkvZsOUl0ZefhEHHRcMPpcTsjrjb+sqEgfJ3J6FMYARi
         Zm0zHGifD261UXtn5rH6LjSxHQPsyKAsMXDimOwC3i3PltRmmL9xOCBDZ8pt3webeai4
         Q8L6ca8RKSF9CEYrf0acLX775DNmjbP9E6bTaDfR9mb9poBMqrdOKhFhSAyN+FyfSx2E
         YZcQ==
X-Gm-Message-State: AOAM530isrOT7gjF5s5I0tbMD4PFuBfZXL4OHKTGDLsX48fc21OuPlYD
        woZtgkXErL29JJQspIYlKjbM+mHxmuXdtnnvXtjvQRUoiK//jrTpFWHUG48/8X7x6jhf2BdY2uP
        z/m9FSTDQlkrSyV5BESwCVfMg
X-Received: by 2002:aa7:82d4:: with SMTP id f20mr638950pfn.253.1589395964832;
        Wed, 13 May 2020 11:52:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5Sglv3QSN2AQ8L8vX+EbHi2Jv4mN3LxBZJj8ZVFGF26HEK+cSiLoq/r1EcEne4FxQ9u0lwQ==
X-Received: by 2002:aa7:82d4:: with SMTP id f20mr638933pfn.253.1589395964561;
        Wed, 13 May 2020 11:52:44 -0700 (PDT)
Received: from localhost ([122.177.166.225])
        by smtp.gmail.com with ESMTPSA id d2sm230168pfa.164.2020.05.13.11.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 11:52:43 -0700 (PDT)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc:     bhsharma@redhat.com, bhupesh.linux@gmail.com,
        Boris Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dave Anderson <anderson@redhat.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
Subject: [PATCH v6 1/2] crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS' to vmcoreinfo
Date:   Thu, 14 May 2020 00:22:36 +0530
Message-Id: <1589395957-24628-2-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589395957-24628-1-git-send-email-bhsharma@redhat.com>
References: <1589395957-24628-1-git-send-email-bhsharma@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now user-space tools like 'makedumpfile' and 'crash' need to rely
on a best-guess method of determining value of 'MAX_PHYSMEM_BITS'
supported by underlying kernel.

This value is used in user-space code to calculate the bit-space
required to store a section for SPARESMEM (similar to the existing
calculation method used in the kernel implementation):

  #define SECTIONS_SHIFT    (MAX_PHYSMEM_BITS - SECTION_SIZE_BITS)

Now, regressions have been reported in user-space utilities
like 'makedumpfile' and 'crash' on arm64, with the recently added
kernel support for 52-bit physical address space, as there is
no clear method of determining this value in user-space
(other than reading kernel CONFIG flags).

As per suggestion from makedumpfile maintainer (Kazu), it makes more
sense to append 'MAX_PHYSMEM_BITS' to vmcoreinfo in the core code itself
rather than in arch-specific code, so that the user-space code for other
archs can also benefit from this addition to the vmcoreinfo and use it
as a standard way of determining 'SECTIONS_SHIFT' value in user-land.

A reference 'makedumpfile' implementation which reads the
'MAX_PHYSMEM_BITS' value from vmcoreinfo in a arch-independent fashion
is available here:

While at it also update vmcoreinfo documentation for 'MAX_PHYSMEM_BITS'
variable being added to vmcoreinfo.

'MAX_PHYSMEM_BITS' defines the maximum supported physical address
space memory.

Cc: Boris Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dave Anderson <anderson@redhat.com>
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: x86@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
Tested-by: John Donnelly <john.p.donnelly@oracle.com>
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 Documentation/admin-guide/kdump/vmcoreinfo.rst | 5 +++++
 kernel/crash_core.c                            | 1 +
 2 files changed, 6 insertions(+)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index e4ee8b2db604..2a632020f809 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -93,6 +93,11 @@ It exists in the sparse memory mapping model, and it is also somewhat
 similar to the mem_map variable, both of them are used to translate an
 address.
 
+MAX_PHYSMEM_BITS
+----------------
+
+Defines the maximum supported physical address space memory.
+
 page
 ----
 
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 9f1557b98468..18175687133a 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -413,6 +413,7 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
 	VMCOREINFO_STRUCT_SIZE(mem_section);
 	VMCOREINFO_OFFSET(mem_section, section_mem_map);
+	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
 #endif
 	VMCOREINFO_STRUCT_SIZE(page);
 	VMCOREINFO_STRUCT_SIZE(pglist_data);
-- 
2.7.4

