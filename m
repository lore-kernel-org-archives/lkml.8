Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E59C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A343220675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608779;
	bh=eB2Vfxzy40Fy+N44RFewYjT/kwul7/E9Ps4PQCgdhMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oVDjWehiFhT3Ctm7bBLcwiV0AEd3sVWpqGUzjn7Jn5/iQbGwnrzNpef58g/UsyA1p
	 wBe+B+H7mhn9wlDCspKOWxU5em3aw07YYtFOg/hsxD32uc2yw4168Ci8A/NXPTcL+f
	 G0ql2J7dTrTdc8kiMFUm0DZ4Ms+bH0BF9e8lJ5WE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgBMP1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:27:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:40718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728258AbgBMPZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:25:20 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91BE2246B1;
        Thu, 13 Feb 2020 15:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607519;
        bh=eB2Vfxzy40Fy+N44RFewYjT/kwul7/E9Ps4PQCgdhMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QjaB9PUP73bEviv3MI8g4irJ6kp27DpznCY0qXyHaxdE2PW2/xOfe+MV6USQdbJzg
         360twmzFK6ACpObFEoq1z2fSuqgqSnks7Xj81NFdWo0YE8FGPaQbs8DcD/jepg8xPr
         7UKlI/4mbdwAjKnuAIH2IZ58yZH2kuNLESH3t2fk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Finco <nifi@google.com>,
        Marios Pomonis <pomonis@google.com>,
        Andrew Honig <ahonig@google.com>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.14 085/173] KVM: x86: Protect ioapic_read_indirect() from Spectre-v1/L1TF attacks
Date:   Thu, 13 Feb 2020 07:19:48 -0800
Message-Id: <20200213151954.713935395@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151931.677980430@linuxfoundation.org>
References: <20200213151931.677980430@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marios Pomonis <pomonis@google.com>

commit 8c86405f606ca8508b8d9280680166ca26723695 upstream.

This fixes a Spectre-v1/L1TF vulnerability in ioapic_read_indirect().
This function contains index computations based on the
(attacker-controlled) IOREGSEL register.

Fixes: a2c118bfab8b ("KVM: Fix bounds checking in ioapic indirect register reads (CVE-2013-1798)")

Signed-off-by: Nick Finco <nifi@google.com>
Signed-off-by: Marios Pomonis <pomonis@google.com>
Reviewed-by: Andrew Honig <ahonig@google.com>
Cc: stable@vger.kernel.org
Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/ioapic.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

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
@@ -73,13 +74,14 @@ static unsigned long ioapic_read_indirec
 	default:
 		{
 			u32 redir_index = (ioapic->ioregsel - 0x10) >> 1;
-			u64 redir_content;
+			u64 redir_content = ~0ULL;
 
-			if (redir_index < IOAPIC_NUM_PINS)
-				redir_content =
-					ioapic->redirtbl[redir_index].bits;
-			else
-				redir_content = ~0ULL;
+			if (redir_index < IOAPIC_NUM_PINS) {
+				u32 index = array_index_nospec(
+					redir_index, IOAPIC_NUM_PINS);
+
+				redir_content = ioapic->redirtbl[index].bits;
+			}
 
 			result = (ioapic->ioregsel & 0x1) ?
 			    (redir_content >> 32) & 0xffffffff :


