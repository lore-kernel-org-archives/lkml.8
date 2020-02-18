Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B4EC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13EE924677
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582056031;
	bh=7M1vMXCQS5hu++7duI5JtqPDkix7ApqrdOPr8r1xcB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EvAIPo7YcLq6oYJNz/TaOUxojs2bVG/kZgeWJ7uwPrh25olPV7hwg8E+NmG8NeX2Z
	 fVSharSOZ7+Re+1hqKvaroOESNuK3LM4P6CSKSk5ptLRIpZ4sFXmPB01EuwkRmoezh
	 nOczgc/R/aExk1n5KawCKa+V96S8a5T+z1e1YBpU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgBRUAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:00:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:39554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728095AbgBRUAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:00:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFC6C24672;
        Tue, 18 Feb 2020 20:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582056022;
        bh=7M1vMXCQS5hu++7duI5JtqPDkix7ApqrdOPr8r1xcB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fEeFe9vshpK5BlJpxgjtc/aA6uUSD+LPvbcw5VA12oMi0OLoLCFhOQDxRAlU8ukG6
         +PS/1VZGkWO3YPCBP5RVG0BcgbyWcdo5EntAGEgcgZLAnOpIyKnWTUgeOiivhW4IqW
         az4ovi+y3gzQDBaJS+M1Ks2zN5HxXLhVhOZoaDvE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Upton <oupton@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.4 57/66] KVM: x86: Mask off reserved bit from #DB exception payload
Date:   Tue, 18 Feb 2020 20:55:24 +0100
Message-Id: <20200218190433.347254952@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200218190428.035153861@linuxfoundation.org>
References: <20200218190428.035153861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Upton <oupton@google.com>

commit 307f1cfa269657c63cfe2c932386fcc24684d9dd upstream.

KVM defines the #DB payload as compatible with the 'pending debug
exceptions' field under VMX, not DR6. Mask off bit 12 when applying the
payload to DR6, as it is reserved on DR6 but not the 'pending debug
exceptions' field.

Fixes: f10c729ff965 ("kvm: vmx: Defer setting of DR6 until #DB delivery")
Signed-off-by: Oliver Upton <oupton@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -445,6 +445,14 @@ void kvm_deliver_exception_payload(struc
 		 * for #DB exceptions under VMX.
 		 */
 		vcpu->arch.dr6 ^= payload & DR6_RTM;
+
+		/*
+		 * The #DB payload is defined as compatible with the 'pending
+		 * debug exceptions' field under VMX, not DR6. While bit 12 is
+		 * defined in the 'pending debug exceptions' field (enabled
+		 * breakpoint), it is reserved and must be zero in DR6.
+		 */
+		vcpu->arch.dr6 &= ~BIT(12);
 		break;
 	case PF_VECTOR:
 		vcpu->arch.cr2 = payload;


