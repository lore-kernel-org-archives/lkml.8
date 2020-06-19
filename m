Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5259C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98A8E2067D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592584792;
	bh=0OKIr2uFeL+aPj9HYYJ5A7Jy8u310+7d7c2yOooviI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EThgblLxo9GuWcHqd2o7NWu00dccVFI20FNqZ3NHxIRLJLFL9p1bsZcFHqaeJlFFl
	 67P6N9aMoR+23ffz8VEYvfWyJCKYiftU+rtrsfww1BmG3MzHNs3g46a2GE0fj0CUtZ
	 Ivin27ZZKjGfKoLOMN08YkwAcd17MBZptmNmVlAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395290AbgFSQjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:39:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388820AbgFSOqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:46:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A15C20A8B;
        Fri, 19 Jun 2020 14:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577975;
        bh=0OKIr2uFeL+aPj9HYYJ5A7Jy8u310+7d7c2yOooviI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nhFkWvMuRfolml6aARdQWCDXVJIhHio+BAsbv1YVRj9QpLkj4jQW7kQdOrD6VOzvN
         48hHZXK+zenthOPORC/iTiwBBBQf8DvVLKkVvwUjKc7N2l2ZS2mPR0D3VcQ8gPDK1/
         Cokx4P2r6J8cupaXe2jHnwwCJ+w6Ew2OC5qCpe0I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.14 027/190] ACPI: CPPC: Fix reference count leak in acpi_cppc_processor_probe()
Date:   Fri, 19 Jun 2020 16:31:12 +0200
Message-Id: <20200619141634.882070177@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141633.446429600@linuxfoundation.org>
References: <20200619141633.446429600@linuxfoundation.org>
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
 drivers/acpi/cppc_acpi.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -800,6 +800,7 @@ int acpi_cppc_processor_probe(struct acp
 			"acpi_cppc");
 	if (ret) {
 		per_cpu(cpc_desc_ptr, pr->id) = NULL;
+		kobject_put(&cpc_ptr->kobj);
 		goto out_free;
 	}
 


