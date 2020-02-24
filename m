Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FF3C38BE0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC8E20838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPoqAQiy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgBXS4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:56:41 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46132 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbgBXS4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 13:56:41 -0500
Received: by mail-wr1-f66.google.com with SMTP id g4so5330103wro.13;
        Mon, 24 Feb 2020 10:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ikUxpzI8l8qLhpgwUreS4zCEikhxIlpjQqZTs40gy+Q=;
        b=LPoqAQiyQUYmQEjLUtNJRXXF95mlhD6culiLLXq2+V48pb7tcg8xVE1JVzOsCZzR3q
         6ZoTNMn44iYy8n99BLwbZLIGRbvu+pVbHnf8hlO4b9mcu7zTzZZVM6hOz/0Rs+ufMsaj
         7fJaejhn3uOoMLoMYoBVLiBJoOEXDSYLVvjBl5zWuepRBfYBVrupHMPgCOpv9NZ8rsBv
         1tclil5HeWMM/VS1O3l0vmAAfSFx8gqN2ctGN7zjIYbfwDxaALv7IZNtlEqqK/MghrWh
         Qc/GxcmQavOeD/r5R6LoQU//usivbBx/NShEm/Sbic64RkW19ObPjKT3VOvtxhMYpqqz
         foeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=ikUxpzI8l8qLhpgwUreS4zCEikhxIlpjQqZTs40gy+Q=;
        b=kTnPfGda3SW5D6Hq7ZmydUHjW5G3MRkEbDK1Ludhqym2qG4IrPsi90moF4fy8juiV1
         fQNzD+gM9m19y2+cthMDk0FM9ZD1D0TlLf5DPW88PII7l0snTQ5tmUkC28SpZdGZLmZe
         MZDN3NWxkRARS5Y5s5Ov2JVeIU9H+xR6u9dE3xqcvyTGyTqcSNH9oz9dV9k+1eOyyFmu
         qbDzaSx8ToCDFcy2RzTFcCbOBExsqpHhgnVRBzAotVly3ZMXbA2meY6wdyPy699fdeh0
         Vxmg6uwLrgbY5/NnU0nDydcmJc1ZP+uZIFDkOVINVhIdhoVZqeEpl+9o/oKgzFga1xQC
         rE/w==
X-Gm-Message-State: APjAAAXS+cBPO5HWrFsMt1H8j3Qy1Id6NqJ7hz/hy7/KirPE9k/+eNTA
        rTFkIO2YmSesNQ1dkkF4XYjLJqi8
X-Google-Smtp-Source: APXvYqzcRZQ6vWYKezVnQ0bBJdnNMViVoXcqthvKgokYnE68Ic9fZmFLOIM6SSm7tYQMGARVOgYmAA==
X-Received: by 2002:a5d:4acb:: with SMTP id y11mr39392176wrs.111.1582570599273;
        Mon, 24 Feb 2020 10:56:39 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id z8sm19900838wrv.74.2020.02.24.10.56.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Feb 2020 10:56:38 -0800 (PST)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     oupton@google.com, stable@vger.kernel.org
Subject: [FYI PATCH 1/3] KVM: nVMX: Don't emulate instructions in guest mode
Date:   Mon, 24 Feb 2020 19:56:34 +0100
Message-Id: <1582570596-45387-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582570596-45387-1-git-send-email-pbonzini@redhat.com>
References: <1582570596-45387-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmx_check_intercept is not yet fully implemented. To avoid emulating
instructions disallowed by the L1 hypervisor, refuse to emulate
instructions by default.

Cc: stable@vger.kernel.org
[Made commit, added commit msg - Oliver]
Signed-off-by: Oliver Upton <oupton@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index dcca514ffd42..5801a86f9c24 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7164,7 +7164,7 @@ static int vmx_check_intercept(struct kvm_vcpu *vcpu,
 	}
 
 	/* TODO: check more intercepts... */
-	return X86EMUL_CONTINUE;
+	return X86EMUL_UNHANDLEABLE;
 }
 
 #ifdef CONFIG_X86_64
-- 
1.8.3.1


