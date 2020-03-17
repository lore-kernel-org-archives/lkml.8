Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9E2C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B035620736
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443630;
	bh=B4tdeLKm7NZ6cqVXu4gpvNgoZu6YVSYkH/hYD/HE9x4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XprjmNjFMjPfwW/4EqepHMOM6qTgTOo3Tb7or0R01msauNLOGm9oiQ1XkUXnmnYTr
	 U5O9wrMBDYNbdnfT8CKc6DS0Pn+EpIxiyBeF/0GbJsb0hPtd4EGTMenRfhugb+8Nm/
	 RVU8AMfiNIIH/Ypm84jShXtnmwdTBodsaoONL/XA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbgCQLNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:13:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729519AbgCQLNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:13:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8997D205ED;
        Tue, 17 Mar 2020 11:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443624;
        bh=B4tdeLKm7NZ6cqVXu4gpvNgoZu6YVSYkH/hYD/HE9x4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KWvCMHybV3wde+jauvLe6PQlzEhRtEori7esNYgQ9PuWrartvEgTLna3/MVntEbFh
         4pKd23vHqWZrdZQXxa2Rptzt6Mv7HDf75yWzRhy7H1Orcdn7aDHPdzc+f1Burs8Z9C
         I/UWv6DWLgfC0FEuoAOygIh+r9LPfTIlpIGzJVk4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 5.5 146/151] iommu/vt-d: Fix the wrong printing in RHSA parsing
Date:   Tue, 17 Mar 2020 11:55:56 +0100
Message-Id: <20200317103337.160117071@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103326.593639086@linuxfoundation.org>
References: <20200317103326.593639086@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenzhong Duan <zhenzhong.duan@gmail.com>

commit b0bb0c22c4db623f2e7b1a471596fbf1c22c6dc5 upstream.

When base address in RHSA structure doesn't match base address in
each DRHD structure, the base address in last DRHD is printed out.

This doesn't make sense when there are multiple DRHD units, fix it
by printing the buggy RHSA's base address.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
Fixes: fd0c8894893cb ("intel-iommu: Set a more specific taint flag for invalid BIOS DMAR tables")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/dmar.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -475,7 +475,7 @@ static int dmar_parse_one_rhsa(struct ac
 	pr_warn(FW_BUG
 		"Your BIOS is broken; RHSA refers to non-existent DMAR unit at %llx\n"
 		"BIOS vendor: %s; Ver: %s; Product Version: %s\n",
-		drhd->reg_base_addr,
+		rhsa->base_address,
 		dmi_get_system_info(DMI_BIOS_VENDOR),
 		dmi_get_system_info(DMI_BIOS_VERSION),
 		dmi_get_system_info(DMI_PRODUCT_VERSION));


