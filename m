Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02513C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2853206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592585333;
	bh=M85F/UrtNErsoLcE7Il0r35NAriyOMgFIdxGy9MPaiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oIkmydY8RoeFYRy6LgFCYqv3fvuh1kN0Sm4KGO2Vg6TKHVqxJ9ATtXpeZ1cXBx/Ai
	 lsyF0Flc70NHQ8FPxtYg2Y+TCDCU6/GYzn3Uggg4PwypKPrjlc3bIjH5fzhEllLQrG
	 +OTPbog2jBaM8NgJRlGKGhpFahG+A7azY4iaJX3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405761AbgFSQss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:48:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733300AbgFSOkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:40:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E313721548;
        Fri, 19 Jun 2020 14:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577608;
        bh=M85F/UrtNErsoLcE7Il0r35NAriyOMgFIdxGy9MPaiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aS2rU+o4D4AjZh1Gv1bNULuOQ3R7Iz+PZWpAs55FErrt6GOv9urh1ISUJRfcdgySz
         PxZ0rvN5W00Qsi/EDUTmFINkeJSErwvEIQtHybUW0BDJcArgBvcLVEjJOcYppspAZp
         dMOyaLaKYN3Ph8NZKWV2AMi3B2rLDpblVWtxlTa4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.9 017/128] ACPI: CPPC: Fix reference count leak in acpi_cppc_processor_probe()
Date:   Fri, 19 Jun 2020 16:31:51 +0200
Message-Id: <20200619141621.066742251@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141620.148019466@linuxfoundation.org>
References: <20200619141620.148019466@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

commit 4d8be4bc94f74bb7d096e1c2e44457b530d5a170 upstream.

kobject_init_and_add() takes reference even when it fails.
If this function returns an error, kobject_put() must be called to
properly clean up the memory associated with the object. Previous
commit "b8eb718348b8" fixed a similar problem.

Fixes: 158c998ea44b ("ACPI / CPPC: add sysfs support to compute delivered performance")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
Cc: 4.10+ <stable@vger.kernel.org> # 4.10+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/cppc_acpi.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -793,8 +793,10 @@ int acpi_cppc_processor_probe(struct acp
 
 	ret = kobject_init_and_add(&cpc_ptr->kobj, &cppc_ktype, &cpu_dev->kobj,
 			"acpi_cppc");
-	if (ret)
+	if (ret) {
+		kobject_put(&cpc_ptr->kobj);
 		goto out_free;
+	}
 
 	kfree(output.pointer);
 	return 0;


