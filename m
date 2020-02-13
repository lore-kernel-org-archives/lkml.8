Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F756C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC5E206ED
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581610174;
	bh=0iu1mtL/dPB7ua2msYJlQENzi50mFh/OXAG/DxLqoTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E+G2i4nq4wkVc0Wp1t8lno+VVEYq0GO7Ch1P6n05wj1/9XSJDt+NMBmyPMrdFprAN
	 0aXqNw6krhbTzlwNvkxXbra3FLiRo8H7CPobsRfcdBaVSczyhQyoz8Hy0fQAuQ3Yqy
	 lXfXRi4mk5BYMQQfr5Xe9f//mWCCbXP6KolvhSC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgBMPWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:22:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:60154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727982AbgBMPWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:22:35 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 342DD24689;
        Thu, 13 Feb 2020 15:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607353;
        bh=0iu1mtL/dPB7ua2msYJlQENzi50mFh/OXAG/DxLqoTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vu2i7SBcP/9LwW0JYBIlwjNdK/hv1JMYdG5av8DsLH81TOHhB86w1C+LLSmFMTI+O
         uGcJapGHpN1JwS+gOQhnDimGmKA0EzkFuuxmvkLSZ9DyjeRyb6vdYYiqlU3x1oowST
         ANG0XlsOkOdO8dglGgaUxgnuCHGvIUrRGNBsEW6M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.4 35/91] KVM: x86: Refactor prefix decoding to prevent Spectre-v1/L1TF attacks
Date:   Thu, 13 Feb 2020 07:19:52 -0800
Message-Id: <20200213151835.142777176@linuxfoundation.org>
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

commit 125ffc5e0a56a3eded608dc51e09d5ebf72cf652 upstream.

This fixes Spectre-v1/L1TF vulnerabilities in
vmx_read_guest_seg_selector(), vmx_read_guest_seg_base(),
vmx_read_guest_seg_limit() and vmx_read_guest_seg_ar().  When
invoked from emulation, these functions contain index computations
based on the (attacker-influenced) segment value.  Using constants
prevents the attack.

Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/emulate.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -5041,16 +5041,28 @@ int x86_decode_insn(struct x86_emulate_c
 				ctxt->ad_bytes = def_ad_bytes ^ 6;
 			break;
 		case 0x26:	/* ES override */
+			has_seg_override = true;
+			ctxt->seg_override = VCPU_SREG_ES;
+			break;
 		case 0x2e:	/* CS override */
+			has_seg_override = true;
+			ctxt->seg_override = VCPU_SREG_CS;
+			break;
 		case 0x36:	/* SS override */
+			has_seg_override = true;
+			ctxt->seg_override = VCPU_SREG_SS;
+			break;
 		case 0x3e:	/* DS override */
 			has_seg_override = true;
-			ctxt->seg_override = (ctxt->b >> 3) & 3;
+			ctxt->seg_override = VCPU_SREG_DS;
 			break;
 		case 0x64:	/* FS override */
+			has_seg_override = true;
+			ctxt->seg_override = VCPU_SREG_FS;
+			break;
 		case 0x65:	/* GS override */
 			has_seg_override = true;
-			ctxt->seg_override = ctxt->b & 7;
+			ctxt->seg_override = VCPU_SREG_GS;
 			break;
 		case 0x40 ... 0x4f: /* REX */
 			if (mode != X86EMUL_MODE_PROT64)


