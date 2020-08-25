Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECBAC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF6F720786
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fdQK1ZhN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgHYPUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgHYPUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 11:20:39 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0DCC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 08:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ENFgYq2det3TbaKrOxz6iT496d9fQlJUs9aH/gy1mek=; b=fdQK1ZhNC+bUU186LjBNw/dv/S
        6tuWfa8JvNSy62lFo1WGM0FKljnJGeAka02oLi2Y9Db9NkDbWZC6FLFOYb8udjMYWhLw/8gihhDdb
        +ieOqpgxAsaLJEcWGLr1QzooQG38jz7fkeKAb0Ov+NSmBl0j6TpcvbQ332PriZ9eny3AmkLhi1rB5
        QN8JT+ZpsJo0K4dfV09m1DVHYd4EOpJMNNx6OWPDWxmiojhjBBeoyF4yoTYBOBdGlNCyln20Sal0V
        LcjXU++nZNE6bd4OSXe3YDMz0/GYCq0XaUJUR8S1NrN3sYk9LABcXpb12ztwA+aWpx8p4YAFGD88Q
        r9QHSocA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAakR-0007Uv-Qu; Tue, 25 Aug 2020 15:20:32 +0000
To:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Dan Williams <dan.j.williams@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH mmotm] x86/numa: fix build when CONFIG_ACPI is not set
Message-ID: <70e5ee34-9809-a997-7b49-499e4be61307@infradead.org>
Date:   Tue, 25 Aug 2020 08:20:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build errors when CONFIG_ACPI is not set/enabled by adding
<acpi/acpi_numa.h> in the #else (!CONFIG_ACPI) block.

../arch/x86/mm/numa.c: In function ‘numa_setup’:
../arch/x86/mm/numa.c:43:3: error: implicit declaration of function ‘disable_srat’; did you mean ‘disable_irq’? [-Werror=implicit-function-declaration]
   disable_srat();
   ^~~~~~~~~~~~
../arch/x86/mm/numa.c:45:3: error: implicit declaration of function ‘disable_hmat’; did you mean ‘disable_dma’? [-Werror=implicit-function-declaration]
   disable_hmat();
   ^~~~~~~~~~~~


Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/acpi.h |    2 ++
 1 file changed, 2 insertions(+)

--- mmotm-2020-0824-1606.orig/include/linux/acpi.h
+++ mmotm-2020-0824-1606/include/linux/acpi.h
@@ -709,6 +709,8 @@ static inline u64 acpi_arch_get_root_poi
 #define ACPI_HANDLE_FWNODE(fwnode)	(NULL)
 #define ACPI_DEVICE_CLASS(_cls, _msk)	.cls = (0), .cls_msk = (0),
 
+#include <acpi/acpi_numa.h>
+
 struct fwnode_handle;
 
 static inline bool acpi_dev_found(const char *hid)

