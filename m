Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5BDC2BB54
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47592074B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586255191;
	bh=xmrT11w54ApBz4oohIkiyxhRNgVs9VCTrvI+89Llllc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=04T4HrAScgbEsOBx619g+IsPoqILtDAv+nfc+eAYc65wjrrtn6tl/BOZVMNZgEp+7
	 4MwFLgltnLSMnFQKyxyDqH+IDvpDROgjjqv6bzyNdLsI2kgZBUN+e+KLorTXKseR0q
	 zIcDhaEFM8PK5/9tddDxFJSeDpVblFKwVQnIin9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbgDGK03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:26:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729149AbgDGK00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:26:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CD3620644;
        Tue,  7 Apr 2020 10:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586255185;
        bh=xmrT11w54ApBz4oohIkiyxhRNgVs9VCTrvI+89Llllc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qP4Qmt0aXMrBd764FdPSgPQMUtkKzmm3+G+XZE1vbGEobYXMDpNWT3P2W+abAPvUB
         ZYGeXHFZPRJ0NQzBOIvi0h3a6WUTwa4v75cY5VW5AIGOWC2bvbb0Yn+YKq4EvQe8nE
         yrkkRBneJnHj8mY5MmdzeTNRUFLHtcNbXH8VKjfY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kelsey Skunberg <kelsey.skunberg@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 5.6 18/29] PCI: sysfs: Revert "rescan" file renames
Date:   Tue,  7 Apr 2020 12:22:15 +0200
Message-Id: <20200407101454.240534387@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200407101452.046058399@linuxfoundation.org>
References: <20200407101452.046058399@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kelsey Skunberg <kelsey.skunberg@gmail.com>

commit bd641fd8303a371e789e924291086268256766b0 upstream.

We changed these sysfs filenames:

  .../pci_bus/<domain:bus>/rescan  ->  .../pci_bus/<domain:bus>/bus_rescan
  .../<domain:bus:dev.fn>/rescan   ->  .../<domain:bus:dev.fn>/dev_rescan

and Ruslan reported [1] that this broke a userspace application.

Revert these name changes so both files are named "rescan" again.

Note that we have to use __ATTR() to assign custom C symbols, i.e.,
"struct device_attribute <symbol>".

[1] https://lore.kernel.org/r/CAB=otbSYozS-ZfxB0nCiNnxcbqxwrHOSYxJJtDKa63KzXbXgpw@mail.gmail.com

[bhelgaas: commit log, use __ATTR() both places so we don't have to rename
the attributes]
Fixes: 8bdfa145f582 ("PCI: sysfs: Define device attributes with DEVICE_ATTR*()")
Fixes: 4e2b79436e4f ("PCI: sysfs: Change DEVICE_ATTR() to DEVICE_ATTR_WO()")
Link: https://lore.kernel.org/r/20200325151708.32612-1-skunberg.kelsey@gmail.com
Signed-off-by: Kelsey Skunberg <kelsey.skunberg@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org	# v5.4+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/pci-sysfs.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -464,7 +464,8 @@ static ssize_t dev_rescan_store(struct d
 	}
 	return count;
 }
-static DEVICE_ATTR_WO(dev_rescan);
+static struct device_attribute dev_attr_dev_rescan = __ATTR(rescan, 0200, NULL,
+							    dev_rescan_store);
 
 static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
@@ -501,7 +502,8 @@ static ssize_t bus_rescan_store(struct d
 	}
 	return count;
 }
-static DEVICE_ATTR_WO(bus_rescan);
+static struct device_attribute dev_attr_bus_rescan = __ATTR(rescan, 0200, NULL,
+							    bus_rescan_store);
 
 #if defined(CONFIG_PM) && defined(CONFIG_ACPI)
 static ssize_t d3cold_allowed_store(struct device *dev,


