Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3A7C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FDF92496A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941714;
	bh=o+EBxYd1jlD/bVmEFGJm1hf05//1H6q48EMuC3VG/c8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n9QlD1fzkUJQlmsTob5hif+7AN4Su/rK4iYz7MCFO2gegq8xYqwb0kmwE8Zbc16Aa
	 X36KpagINe2+sbT7zCwHbKGn6ptJCuJl8M4M6HThVDKfezTSq/Vvv9CfaZJ4rFuF56
	 evdww/fC63bG4IYIJfwUyQmBpYc2qqumZ5szNIFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgEHMlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:41:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727094AbgEHMln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:41:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 226AC24970;
        Fri,  8 May 2020 12:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941702;
        bh=o+EBxYd1jlD/bVmEFGJm1hf05//1H6q48EMuC3VG/c8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i7gCdwf46XsPRe2uSvgA1AZZ/u00mo7YcUbAKbD2MWTYBLxwirBIDtGFzHRSgegvA
         QC2RVKEvH1ZEBs9siscaYCO7OmlDDtG0V0QbU1BIFqEk3nNXhEwbNPxwfOvPI9gjFh
         c0WlFaXmVOXM1FooN8ENjfTwAXuZHvlz7qUOGSWM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.4 137/312] Revert "ACPI / LPSS: allow to use specific PM domain during ->probe()"
Date:   Fri,  8 May 2020 14:32:08 +0200
Message-Id: <20200508123134.131597622@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit b5f88dd1d6efc472e35ca1b21a44e662c5422088 upstream.

The specific power domain can't be used in a way provided by the commit
01ac170ba29a, i.e. pointer to platform device is a subject to change during
unbound / bind cycle.

This reverts commit 01ac170ba29a9903ee590e1ef2d8e6b27b49a16c.

Fixes: 3df2da968744 (Revert "ACPI / LPSS: introduce a 'proxy' device to power on LPSS for DMA")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/acpi_lpss.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -704,8 +704,13 @@ static int acpi_lpss_platform_notify(str
 	}
 
 	switch (action) {
-	case BUS_NOTIFY_ADD_DEVICE:
+	case BUS_NOTIFY_BOUND_DRIVER:
 		pdev->dev.pm_domain = &acpi_lpss_pm_domain;
+		break;
+	case BUS_NOTIFY_UNBOUND_DRIVER:
+		pdev->dev.pm_domain = NULL;
+		break;
+	case BUS_NOTIFY_ADD_DEVICE:
 		if (pdata->dev_desc->flags & LPSS_LTR)
 			return sysfs_create_group(&pdev->dev.kobj,
 						  &lpss_attr_group);
@@ -713,7 +718,6 @@ static int acpi_lpss_platform_notify(str
 	case BUS_NOTIFY_DEL_DEVICE:
 		if (pdata->dev_desc->flags & LPSS_LTR)
 			sysfs_remove_group(&pdev->dev.kobj, &lpss_attr_group);
-		pdev->dev.pm_domain = NULL;
 		break;
 	default:
 		break;


