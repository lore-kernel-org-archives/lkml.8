Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29145C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F026820781
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551595;
	bh=VQEL4zYdQmOL2lvORooDfGkshP55G+pqZwAq3XpfnQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PFSsJws/M9tAFXwEG9nkyg1+l1nDlZghyHGcT71SyJm93j7esnqbQhxHnIM0FzQHj
	 /f7j+QwR0X291ySvq1E3C1hFEib3ochpVgUUdrI9Xx9nIj4v0WRyijSoKX6C9ir3gV
	 UwUVCfVJ5XHS9mfavuUUZ09d4pYoSzDeMUYEO3uM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731176AbgDVKdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:33:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgDVKY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:24:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A4CB20780;
        Wed, 22 Apr 2020 10:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587551099;
        bh=VQEL4zYdQmOL2lvORooDfGkshP55G+pqZwAq3XpfnQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EM4e2exycSRoKmq7ivMTQ9vTjd9v59/3Lz7W0I1m8agB7W6W2XgX552XcJjQHfGsq
         a+StkuQ0uuPG042TY5/AHHnnjURMJpX8sS4RsoOhhId0CaIfP3DAQktRQhzlxgI2Mm
         QH+BqPUjR3aJpfy6cNmYoFH5605Z8DqsHw/jpFms=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 099/166] platform/x86: intel-hid: fix: Update Tiger Lake ACPI device ID
Date:   Wed, 22 Apr 2020 11:57:06 +0200
Message-Id: <20200422095059.579465770@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095047.669225321@linuxfoundation.org>
References: <20200422095047.669225321@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gayatri Kammela <gayatri.kammela@intel.com>

[ Upstream commit d5764dc597467664a1a70ab66a2314a011aeccd4 ]

Tiger Lake's new unique ACPI device IDs for intel-hid driver is not
valid because of missing 'C' in the ID. Fix the ID by updating it.

After the update, the new ID should now look like
INT1051 --> INTC1051

Fixes: bdd11b654035 ("platform/x86: intel-hid: Add Tiger Lake ACPI device ID")
Suggested-by: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel-hid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-hid.c
index 43d590250228c..9c0e6e0fabdff 100644
--- a/drivers/platform/x86/intel-hid.c
+++ b/drivers/platform/x86/intel-hid.c
@@ -19,8 +19,8 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Alex Hung");
 
 static const struct acpi_device_id intel_hid_ids[] = {
-	{"INT1051", 0},
 	{"INT33D5", 0},
+	{"INTC1051", 0},
 	{"", 0},
 };
 
-- 
2.20.1



