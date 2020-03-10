Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08488C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C581124696
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844926;
	bh=C+HJCjviyH1A1CSTchRT9JaxPT7lIg3IqjLlN11Ho9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F4HVR/qM/bGnTCrVhhb94VEp7kx8F7wtqBqPOBfTln12NISPwkVBLIfoNNr3Y7J06
	 E+j074h26xIADHGb1ZyK0C24U7PY8kWyuJZ0UH0GoNtpBYhfm1akos8Zj3P9GZUngO
	 yKI2jPn3s2frArPU91woxh/iTzIZmvD+0Og3xsUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgCJMz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:55:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729489AbgCJMzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:55:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FC422253D;
        Tue, 10 Mar 2020 12:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844923;
        bh=C+HJCjviyH1A1CSTchRT9JaxPT7lIg3IqjLlN11Ho9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OoGYPhTh+aeqMzr6MP0WK+7GF29rSpuwzuynWPOv9q7e2xYWdT2T4sltDhEIwdvge
         R9UQ/4YUbQHKS9ro4pfFwOIoR0eApCv7LaGmzSo0fp4PXCFNxa0zRBvg6J1RPibZKb
         49y+asAzsrlPWLu6OfXf0UcZ04gW6T5iGsj3w7Hc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5.4 168/168] efi: READ_ONCE rng seed size before munmap
Date:   Tue, 10 Mar 2020 13:40:14 +0100
Message-Id: <20200310123652.552138329@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason A. Donenfeld <Jason@zx2c4.com>

commit be36f9e7517e17810ec369626a128d7948942259 upstream.

This function is consistent with using size instead of seed->size
(except for one place that this patch fixes), but it reads seed->size
without using READ_ONCE, which means the compiler might still do
something unwanted. So, this commit simply adds the READ_ONCE
wrapper.

Fixes: 636259880a7e ("efi: Add support for seeding the RNG from a UEFI ...")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-efi@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200217123354.21140-1-Jason@zx2c4.com
Link: https://lore.kernel.org/r/20200221084849.26878-5-ardb@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/firmware/efi/efi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -544,7 +544,7 @@ int __init efi_config_parse_tables(void
 
 		seed = early_memremap(efi.rng_seed, sizeof(*seed));
 		if (seed != NULL) {
-			size = seed->size;
+			size = READ_ONCE(seed->size);
 			early_memunmap(seed, sizeof(*seed));
 		} else {
 			pr_err("Could not map UEFI random seed!\n");
@@ -554,7 +554,7 @@ int __init efi_config_parse_tables(void
 					      sizeof(*seed) + size);
 			if (seed != NULL) {
 				pr_notice("seeding entropy pool\n");
-				add_bootloader_randomness(seed->bits, seed->size);
+				add_bootloader_randomness(seed->bits, size);
 				early_memunmap(seed, sizeof(*seed) + size);
 			} else {
 				pr_err("Could not map UEFI random seed!\n");


