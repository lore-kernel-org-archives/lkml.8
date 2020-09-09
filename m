Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4FFC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4890520C09
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599670614;
	bh=EYgkON9WK+YOtTQ//Z7US9lvuUlSByEmJKos/ZeBw4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y34tyQ2rUDaqQ5wYqOrIUMmFXS20AF8ncA/KvY5674ztG21TtRSZ1AfwVCJ2Dhwcv
	 OKrR8SEP+1yFinW/RmxZExJq9nwNUnsZJA3p8YDneEreYv7R7JqKa3ji3ybX4vjVRX
	 RNT7LereDGADQb57l01bXam7wOLLzcz8bCLDnnoM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731097AbgIIQ4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:56:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730436AbgIIPvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:51:21 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49925221EA;
        Wed,  9 Sep 2020 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599660665;
        bh=EYgkON9WK+YOtTQ//Z7US9lvuUlSByEmJKos/ZeBw4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QKUzWVqyHcDZO3aslNuJfH3lLVyd40A6D+hAKDtJ0XzSsyqLsDIlXj4CHHlXi4PT5
         xpYOZgCqCyMsLqvuW9Y6jZsaG5nxDElK1e3qYvzfRum0VUcuh2YIhExg0oKuBZMbX9
         aMQUuN2DkqlNzJQWo4JmiYD2ohCDKOXotzK2J4Sc=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kG0oR-00DUX8-Ds; Wed, 09 Sep 2020 16:11:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/30] docs: add some new files to their respective index.rst files
Date:   Wed,  9 Sep 2020 16:10:45 +0200
Message-Id: <9fd4d04f0d122ff38b5342a0098d99cc2f546652.1599660067.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were some new file additions for Kernel 5.7 and 5.8
that weren't added at the corresponding index file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/nvdimm/index.rst   | 1 +
 Documentation/firmware-guide/acpi/index.rst | 1 +
 Documentation/hwmon/index.rst               | 1 +
 Documentation/vm/index.rst                  | 1 +
 4 files changed, 4 insertions(+)

diff --git a/Documentation/driver-api/nvdimm/index.rst b/Documentation/driver-api/nvdimm/index.rst
index a4f8f98aeb94..5863bd04f056 100644
--- a/Documentation/driver-api/nvdimm/index.rst
+++ b/Documentation/driver-api/nvdimm/index.rst
@@ -10,3 +10,4 @@ Non-Volatile Memory Device (NVDIMM)
    nvdimm
    btt
    security
+   firmware-activate
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index ad3b5afdae77..f72b5f1769fb 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -26,3 +26,4 @@ ACPI Support
    lpit
    video_extension
    extcon-intel-int3496
+   intel-pmc-mux
diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index af064a9ad42f..a926f1abaec3 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -159,6 +159,7 @@ Hardware Monitoring Kernel Drivers
    smsc47b397
    smsc47m192
    smsc47m1
+   sparx5-temp
    tc654
    tc74
    thmc50
diff --git a/Documentation/vm/index.rst b/Documentation/vm/index.rst
index 611140ffef7e..eff5fbd492d0 100644
--- a/Documentation/vm/index.rst
+++ b/Documentation/vm/index.rst
@@ -29,6 +29,7 @@ descriptions of data structures and algorithms.
    :maxdepth: 1
 
    active_mm
+   arch_pgtable_helpers
    balance
    cleancache
    free_page_reporting
-- 
2.26.2

