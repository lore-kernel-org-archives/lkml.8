Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7839C3B18C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FE924649
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581610144;
	bh=B2bVMarKPnm5+9yYUjhpcxjhRquXMS0z1BJxvyGGKqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kXiym3B3yWmriuxLpzLRA71KlC0G3iEhylcn1VKq7BugThVP/L9G5UzK4HoJm3vvh
	 3SxtSyCRq9sZ5yYss5K2pWVA4/pyVKOaBgeGKV3JHjVf4oxFF/YzMhWD2QEWkaDuHb
	 bJ4DXjNUtoIqHMMRtGN4Ag7pH9QWp/k57Cf+P2qw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388464AbgBMQJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:09:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:32972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728173AbgBMPWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:22:53 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C018224699;
        Thu, 13 Feb 2020 15:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607372;
        bh=B2bVMarKPnm5+9yYUjhpcxjhRquXMS0z1BJxvyGGKqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cPvPNFZob8fyI/vsGMvna0Ut8fURnZkzfAwpAlLywSF+r0DowjimhY6RZx6Msl18p
         BU8hXj68WzVnLnR7+irUPplbaLEowOn9xlPDtA+KeKM2ZG7M0S7H0h/d7+POvlUTLM
         FgIhGo2HR05JT98DEN9TwcCb+Xj8FY/CnwZptFS0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Finco <nifi@google.com>,
        Marios Pomonis <pomonis@google.com>,
        Andrew Honig <ahonig@google.com>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.4 38/91] KVM: x86: Protect ioapic_write_indirect() from Spectre-v1/L1TF attacks
Date:   Thu, 13 Feb 2020 07:19:55 -0800
Message-Id: <20200213151836.378006740@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151821.384445454@linuxfoundation.org>
References: <20200213151821.384445454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marios Pomonis <pomonis@google.com>

commit 670564559ca35b439c8d8861fc399451ddf95137 upstream.

This fixes a Spectre-v1/L1TF vulnerability in ioapic_write_indirect().
This function contains index computations based on the
(attacker-controlled) IOREGSEL register.

This patch depends on patch
"KVM: x86: Protect ioapic_read_indirect() from Spectre-v1/L1TF attacks".

Fixes: 70f93dae32ac ("KVM: Use temporary variable to shorten lines.")

Signed-off-by: Nick Finco <nifi@google.com>
Signed-off-by: Marios Pomonis <pomonis@google.com>
Reviewed-by: Andrew Honig <ahonig@google.com>
Cc: stable@vger.kernel.org
Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/ioapic.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -36,6 +36,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/export.h>
+#include <linux/nospec.h>
 #include <asm/processor.h>
 #include <asm/page.h>
 #include <asm/current.h>
@@ -289,6 +290,7 @@ static void ioapic_write_indirect(struct
 		ioapic_debug("change redir index %x val %x\n", index, val);
 		if (index >= IOAPIC_NUM_PINS)
 			return;
+		index = array_index_nospec(index, IOAPIC_NUM_PINS);
 		e = &ioapic->redirtbl[index];
 		mask_before = e->fields.mask;
 		/* Preserve read-only fields */


