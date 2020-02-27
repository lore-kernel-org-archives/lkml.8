Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305BCC3F36D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05EDF24691
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812809;
	bh=vWzft6iXMgkRnXYQuvyI6///l4U8QipwJKJjcyBU2gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eaUC5/7wpnp08RfawbGOUcy6OPGHcDyQgQxxsxy/0SMmILqIUGudjp9FQtXK/Zi9r
	 Ebh6KwR7Pn6CH00UA2P3P1CJ5TQHHZHPZlDSHY3oHYSXlKe00GdiXHjGrLrm/dT8OV
	 LighISt7sQGBvw+kBLuBw2M9PEb1UtjzngxQkFJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388966AbgB0ON1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:13:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:52250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388963AbgB0ONW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:13:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E680620801;
        Thu, 27 Feb 2020 14:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812801;
        bh=vWzft6iXMgkRnXYQuvyI6///l4U8QipwJKJjcyBU2gg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R+dDjgK7EirOdW3EM7uPXUQ/MKX9w4yj9SnNl8dGNVv2DIxLCMGhVT1CDngBC6bew
         GuKQkzrAeDs8qdCGRmuFuCdDA95Na8jR3LB5GU6WLknsShDKa80lNJzKUS8X3DAI46
         YfBimYbWVJohSphvjPJ7OLdQ/8zj7QJW7NsxBK18=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jerry Snitselaar <jsnitsel@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 5.5 003/150] iommu/vt-d: Move deferred device attachment into helper function
Date:   Thu, 27 Feb 2020 14:35:40 +0100
Message-Id: <20200227132233.267931001@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132232.815448360@linuxfoundation.org>
References: <20200227132232.815448360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

commit 034d98cc0cdcde2415c6f598fa9125e3eaa02569 upstream.

Move the code that does the deferred device attachment into a separate
helper function.

Fixes: 1ee0186b9a12 ("iommu/vt-d: Refactor find_domain() helper")
Cc: stable@vger.kernel.org # v5.5
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/intel-iommu.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2440,16 +2440,20 @@ static struct dmar_domain *find_domain(s
 	return NULL;
 }
 
-static struct dmar_domain *deferred_attach_domain(struct device *dev)
+static void do_deferred_attach(struct device *dev)
 {
-	if (unlikely(attach_deferred(dev))) {
-		struct iommu_domain *domain;
+	struct iommu_domain *domain;
+
+	dev->archdata.iommu = NULL;
+	domain = iommu_get_domain_for_dev(dev);
+	if (domain)
+		intel_iommu_attach_device(domain, dev);
+}
 
-		dev->archdata.iommu = NULL;
-		domain = iommu_get_domain_for_dev(dev);
-		if (domain)
-			intel_iommu_attach_device(domain, dev);
-	}
+static struct dmar_domain *deferred_attach_domain(struct device *dev)
+{
+	if (unlikely(attach_deferred(dev)))
+		do_deferred_attach(dev);
 
 	return find_domain(dev);
 }


