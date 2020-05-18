Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4C5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF6CE207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589825250;
	bh=tAt1cr0a+MsZFss6QR0805je8mZPTx//0IaCX7J2qMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KcRl0kX9m7emssjP6hgmhhVrwklEk2279D1Q5NNSzJ7XOK4DuUtDnhkYQYBmSW9s8
	 bzmpOvuFOrD+mouFZOkjJoxmCMrWRGUPq195ftuE2m6ctdKzcrJ8V9936MxziD3V1k
	 8Ch3ALj036tLC0bXjMDN1SuIeqfUk719b81ORZ68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbgERSH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:07:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732304AbgERSHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:07:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7FD820715;
        Mon, 18 May 2020 18:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589825242;
        bh=tAt1cr0a+MsZFss6QR0805je8mZPTx//0IaCX7J2qMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I1ygG2a0GIdJX1Jarrppf4HQ1ctvNW1NS9R0GaBv3l/Bkc1IEAd2BPAymQhCDShsy
         V8hqUg/7x2C+NONW1Lkji2lr+Ex6yIwLrQnDvxsUD9lUzg0a5gLCfrQx+9EIQZHl3M
         6oiVQCmNWnU2Z1FSQFGEkq8RjZlKtRl156jCB/1A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 5.6 186/194] powerpc/ima: Fix secure boot rules in ima arch policy
Date:   Mon, 18 May 2020 19:37:56 +0200
Message-Id: <20200518173546.947786203@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173531.455604187@linuxfoundation.org>
References: <20200518173531.455604187@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nayna Jain <nayna@linux.ibm.com>

commit fa4f3f56ccd28ac031ab275e673ed4098855fed4 upstream.

To prevent verifying the kernel module appended signature
twice (finit_module), once by the module_sig_check() and again by IMA,
powerpc secure boot rules define an IMA architecture specific policy
rule only if CONFIG_MODULE_SIG_FORCE is not enabled. This,
unfortunately, does not take into account the ability of enabling
"sig_enforce" on the boot command line (module.sig_enforce=1).

Including the IMA module appraise rule results in failing the
finit_module syscall, unless the module signing public key is loaded
onto the IMA keyring.

This patch fixes secure boot policy rules to be based on
CONFIG_MODULE_SIG instead.

Fixes: 4238fad366a6 ("powerpc/ima: Add support to initialize ima policy rules")
Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Link: https://lore.kernel.org/r/1588342612-14532-1-git-send-email-nayna@linux.ibm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/ima_arch.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/powerpc/kernel/ima_arch.c
+++ b/arch/powerpc/kernel/ima_arch.c
@@ -19,12 +19,12 @@ bool arch_ima_get_secureboot(void)
  * to be stored as an xattr or as an appended signature.
  *
  * To avoid duplicate signature verification as much as possible, the IMA
- * policy rule for module appraisal is added only if CONFIG_MODULE_SIG_FORCE
+ * policy rule for module appraisal is added only if CONFIG_MODULE_SIG
  * is not enabled.
  */
 static const char *const secure_rules[] = {
 	"appraise func=KEXEC_KERNEL_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
-#ifndef CONFIG_MODULE_SIG_FORCE
+#ifndef CONFIG_MODULE_SIG
 	"appraise func=MODULE_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
 #endif
 	NULL
@@ -50,7 +50,7 @@ static const char *const secure_and_trus
 	"measure func=KEXEC_KERNEL_CHECK template=ima-modsig",
 	"measure func=MODULE_CHECK template=ima-modsig",
 	"appraise func=KEXEC_KERNEL_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
-#ifndef CONFIG_MODULE_SIG_FORCE
+#ifndef CONFIG_MODULE_SIG
 	"appraise func=MODULE_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
 #endif
 	NULL


