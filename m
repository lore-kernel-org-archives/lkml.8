Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E6BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B566525478
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTVxwjJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731432AbgFVHiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 03:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731354AbgFVHiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 03:38:54 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BB8C061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 00:38:53 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id i16so11927377qtr.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 00:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pFf+0uM7OhIyngSgu5Yj3nmTerq75fKAoaRpUy4UdZc=;
        b=bTVxwjJv+BTutnnXMZTcEX3+yPsFy6WBiq161bQHyVik5hKmDYVz6l3cXO9z35R9M7
         ycQUCVSiaYVFbU6w+1WTRaBAZV9ldva9qanfc1jYpovqrquAv4/jL1+xXqTJAcoeou+o
         PMLpwjGVL0NKZuj9lg1bwKpePJCe5tULsWUfkWfwapaMcELKPAhQ2LPuerMI+rpMbSgf
         u0hUvagxULfqU5kCvRVB016gWF1LgC3hLeScJ/VigNKOGXvCrndZyv+jix5YCMWZXDqz
         aQLT3gkFHPkujKYdmcrstb7SGKFiQhap0PPmpiazbezehuq/szKbWCDJRgkPbizzx3dj
         pFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pFf+0uM7OhIyngSgu5Yj3nmTerq75fKAoaRpUy4UdZc=;
        b=rZFHRrQJ5J5KOnyj1U8kztK/WEDhHXAKsCE2SefTHkDTXJu7ZIQaNDaxha6syv+WId
         I8pUrS4hbBH6McBYHlXgFTpqSxQo01LiE95D48jJLZljLIqLdtBD2kkkr+DCk0zRaQBD
         gvCjQohz43xHFY4WGUP3rreLyzAiI4v3LHUy0cav0rQPJmy9kDmxYlywhcnTAtmIb4fW
         vZafEFtgbg1o5CG36oYfEPnzQ7I6ZcM1vSIYRPBRcu8GQmQhMpHktj8aVHHdUKfRn2z/
         rTSdL2yqPEP0xBEiprCuusSONBREoy7D3m3OXylV8+zgZTDHxrYzhYilrzs64d0c5ZoE
         J9rw==
X-Gm-Message-State: AOAM531aJiUaZC3IKz3ZNpNml0nKbMK4cE7v6GXJehbul0VPjVbkN6Qq
        uMRu/AOFHZ3L5WJJTuxJneA=
X-Google-Smtp-Source: ABdhPJyOjIb0iw1iEKpl95OKmTjBr1Oy0RUGpwzNGuopcAG0sGqjFXgoB4uVMm0o57J4Hut2uISUIQ==
X-Received: by 2002:ac8:3f75:: with SMTP id w50mr9210884qtk.123.1592811532729;
        Mon, 22 Jun 2020 00:38:52 -0700 (PDT)
Received: from ip-172-31-24-31.ec2.internal (ec2-54-234-246-66.compute-1.amazonaws.com. [54.234.246.66])
        by smtp.gmail.com with ESMTPSA id p26sm632325qkm.76.2020.06.22.00.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 00:38:52 -0700 (PDT)
From:   "Rodolfo C. Villordo" <rodolfovillordo@gmail.com>
Cc:     rodolfovillordo@gmail.com, Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>, Richard Yeh <rcy@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: gasket: replace symbolic permissions
Date:   Mon, 22 Jun 2020 07:36:12 +0000
Message-Id: <20200622073612.12282-1-rodolfovillordo@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+               .attr = __ATTR(_name, S_IRUGO, _show_function, NULL),          \
warning detected by checkpatch.pl

Unable to use __ATTR_RO(). Driver has multiple files using the same show
function:

$ grep GASKET_SYSFS_RO drivers/staging/gasket/*
drivers/staging/gasket/apex_driver.c:   GASKET_SYSFS_RO(node_0_page_table_entries, sysfs_show,
drivers/staging/gasket/apex_driver.c:   GASKET_SYSFS_RO(node_0_simple_page_table_entries, sysfs_show,
drivers/staging/gasket/apex_driver.c:   GASKET_SYSFS_RO(node_0_num_mapped_pages, sysfs_show,
drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(bar_offsets, gasket_sysfs_data_show, ATTR_BAR_OFFSETS),
drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(bar_sizes, gasket_sysfs_data_show, ATTR_BAR_SIZES),
drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(driver_version, gasket_sysfs_data_show,
drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(framework_version, gasket_sysfs_data_show,
drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(device_type, gasket_sysfs_data_show, ATTR_DEVICE_TYPE),
drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(revision, gasket_sysfs_data_show,
drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(pci_address, gasket_sysfs_data_show, ATTR_PCI_ADDRESS),
drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(status, gasket_sysfs_data_show, ATTR_STATUS),
drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(is_device_owned, gasket_sysfs_data_show,
drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(device_owner, gasket_sysfs_data_show,
drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(write_open_count, gasket_sysfs_data_show,
drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(reset_count, gasket_sysfs_data_show, ATTR_RESET_COUNT),
drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(user_mem_ranges, gasket_sysfs_data_show,
drivers/staging/gasket/gasket_interrupt.c:      GASKET_SYSFS_RO(interrupt_counts, interrupt_sysfs_show,

Signed-off-by: Rodolfo C. Villordo <rodolfovillordo@gmail.com>
---
 drivers/staging/gasket/gasket_sysfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_sysfs.h b/drivers/staging/gasket/gasket_sysfs.h
index ab5aa351d555..d5e167dfbe76 100644
--- a/drivers/staging/gasket/gasket_sysfs.h
+++ b/drivers/staging/gasket/gasket_sysfs.h
@@ -71,7 +71,7 @@ struct gasket_sysfs_attribute {
 
 #define GASKET_SYSFS_RO(_name, _show_function, _attr_type)                     \
 	{                                                                      \
-		.attr = __ATTR(_name, S_IRUGO, _show_function, NULL),          \
+		.attr = __ATTR(_name, 0444, _show_function, NULL),          \
 		.data.attr_type = _attr_type                                   \
 	}
 
-- 
2.17.1

