Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6905C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C1A20842
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338260;
	bh=eB2Vfxzy40Fy+N44RFewYjT/kwul7/E9Ps4PQCgdhMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u+eZlbfdNMRae1dhrhRP0I2MotLGFprO5B2SLO3K+aF+wv3bJHix5svBVaxOwCWvq
	 FB8147H+BYZeqioniq1p+Tqtz9+lh+SC+G7vVA6RgFIndvlD3BDfLHM44kupfvovE/
	 LHNeLbcAumLABuKBSmZeJz4t5MLP7GL1zhdLLKPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgBJMhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:37:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:55012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728325AbgBJMgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:36:18 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D49421739;
        Mon, 10 Feb 2020 12:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338178;
        bh=eB2Vfxzy40Fy+N44RFewYjT/kwul7/E9Ps4PQCgdhMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F4vo316ZJNWItaOM5buuFYeLjrNZhLSDsaoRcAjo1p26RW+j83RIRZavyzX9plBOk
         3UMIC4O2AGmSNxCEbqZF+po8zkm2MsDzeAgEXOHXIyXw7V22jyLc/ZfdYuNBdS/YL+
         jkn2xI5D6swvIogYLipvW8lpy3YP9yRpgZ/Negyc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Finco <nifi@google.com>,
        Marios Pomonis <pomonis@google.com>,
        Andrew Honig <ahonig@google.com>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 131/195] KVM: x86: Protect ioapic_read_indirect() from Spectre-v1/L1TF attacks
Date:   Mon, 10 Feb 2020 04:33:09 -0800
Message-Id: <20200210122318.140850578@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
References: <20200210122305.731206734@linuxfoundation.org>
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


