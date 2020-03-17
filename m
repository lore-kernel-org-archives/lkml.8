Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EA4C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD862071C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443015;
	bh=yfZlrWQM7Q5UXqWR4WSIxJyzLFS2OHtF2DfjtMz1FEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jvdav3/REXewa45PIoK1Mtal3yhf7zH6op6NqA6kiimCsr9VXKJLaUA98agCEFViB
	 QH4+CQMI8aplalfGsY8Mv28ncLxaoEsV+TWx/NZHwjAIx3IFA/j+Cul5EJ+qpXrxE8
	 /wIDCSmOP27T99QzAaNo5V47VHZxur7FcfTBydO8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgCQLDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:03:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728113AbgCQLD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:03:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 877D420658;
        Tue, 17 Mar 2020 11:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443007;
        bh=yfZlrWQM7Q5UXqWR4WSIxJyzLFS2OHtF2DfjtMz1FEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NB+6F1BwFobV68dmV4+EujW4O9nWd0bG7YxUXk1ohPu8tcma9X7PO6nc9JRr5jL4D
         7BuhKbBf+2KIAlaPJXcgJ+wpdiu7o11wZLI2GxTTk76K2eKxnMWKYvOZ4kmQOpCUGp
         0HYnvgGJi4l+F5yrypMkQHRr4sSL43zv0pFri8J8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 5.4 063/123] iommu/vt-d: quirk_ioat_snb_local_iommu: replace WARN_TAINT with pr_warn + add_taint
Date:   Tue, 17 Mar 2020 11:54:50 +0100
Message-Id: <20200317103314.040716840@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103307.343627747@linuxfoundation.org>
References: <20200317103307.343627747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit 81ee85d0462410de8eeeec1b9761941fd6ed8c7b upstream.

Quoting from the comment describing the WARN functions in
include/asm-generic/bug.h:

 * WARN(), WARN_ON(), WARN_ON_ONCE, and so on can be used to report
 * significant kernel issues that need prompt attention if they should ever
 * appear at runtime.
 *
 * Do not use these macros when checking for invalid external inputs

The (buggy) firmware tables which the dmar code was calling WARN_TAINT
for really are invalid external inputs. They are not under the kernel's
control and the issues in them cannot be fixed by a kernel update.
So logging a backtrace, which invites bug reports to be filed about this,
is not helpful.

Fixes: 556ab45f9a77 ("ioat2: catch and recover from broken vtd configurations v6")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20200309182510.373875-1-hdegoede@redhat.com
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=701847
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/intel-iommu.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4129,10 +4129,11 @@ static void quirk_ioat_snb_local_iommu(s
 
 	/* we know that the this iommu should be at offset 0xa000 from vtbar */
 	drhd = dmar_find_matched_drhd_unit(pdev);
-	if (WARN_TAINT_ONCE(!drhd || drhd->reg_base_addr - vtbar != 0xa000,
-			    TAINT_FIRMWARE_WORKAROUND,
-			    "BIOS assigned incorrect VT-d unit for Intel(R) QuickData Technology device\n"))
+	if (!drhd || drhd->reg_base_addr - vtbar != 0xa000) {
+		pr_warn_once(FW_BUG "BIOS assigned incorrect VT-d unit for Intel(R) QuickData Technology device\n");
+		add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
 		pdev->dev.archdata.iommu = DUMMY_DEVICE_DOMAIN_INFO;
+	}
 }
 DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IOAT_SNB, quirk_ioat_snb_local_iommu);
 


