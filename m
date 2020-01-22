Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803B2C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C9A24686
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686088;
	bh=1AI0GKeVFPui5D7Xd+X1N/rgXNMOMBvlax163fQ8wHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WgP7XzmJ6j0ScINxQ3D/8ojlvYB3ZS02IYGtxUvx2NSZdqQKPNgbrU3I3MJq/81eq
	 9ZmR3N9Eq8hIm3XzfhyQu60IJ/ByCSPgYTVfpgUzFl4WFJ9iMwoOgZjHPSqAWIHlHi
	 bUEn3X1tLjzS5i55cxerFAksCklcKXcXF6nl8NUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387569AbgAVJl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:41:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:60614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387544AbgAVJlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:41:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8ED724680;
        Wed, 22 Jan 2020 09:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579686075;
        bh=1AI0GKeVFPui5D7Xd+X1N/rgXNMOMBvlax163fQ8wHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CSR1EbKtYwjV7+FEsp/zWbLnvadWTnkXdI7IHUf1uKPAHIBDro9GWYjEj7lMSoxLW
         2BRKNkZFppD2o+yRdqOBxiKZ4m5wK9DuPg6I/tN7EAANjhIF+bgDqlOpbgsnCU7g4Z
         Nv7haWVxONy8ggZJCSrTN24nkU5Id5Tiy9+ye8v4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH 4.19 034/103] x86/CPU/AMD: Ensure clearing of SME/SEV features is maintained
Date:   Wed, 22 Jan 2020 10:28:50 +0100
Message-Id: <20200122092808.971627907@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092803.587683021@linuxfoundation.org>
References: <20200122092803.587683021@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Lendacky <thomas.lendacky@amd.com>

commit a006483b2f97af685f0e60f3a547c9ad4c9b9e94 upstream.

If the SME and SEV features are present via CPUID, but memory encryption
support is not enabled (MSR 0xC001_0010[23]), the feature flags are cleared
using clear_cpu_cap(). However, if get_cpu_cap() is later called, these
feature flags will be reset back to present, which is not desired.

Change from using clear_cpu_cap() to setup_clear_cpu_cap() so that the
clearing of the flags is maintained.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: <stable@vger.kernel.org> # 4.16.x-
Link: https://lkml.kernel.org/r/226de90a703c3c0be5a49565047905ac4e94e8f3.1579125915.git.thomas.lendacky@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/amd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -609,9 +609,9 @@ static void early_detect_mem_encrypt(str
 		return;
 
 clear_all:
-		clear_cpu_cap(c, X86_FEATURE_SME);
+		setup_clear_cpu_cap(X86_FEATURE_SME);
 clear_sev:
-		clear_cpu_cap(c, X86_FEATURE_SEV);
+		setup_clear_cpu_cap(X86_FEATURE_SEV);
 	}
 }
 


