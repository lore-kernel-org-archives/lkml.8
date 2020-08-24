Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6CCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F7F32087D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258683;
	bh=jRgIWyY0b4yL1+iU+rEN7X0YTkrV7SA7WEWwegKb4Wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YFRuKOlnji3ogEHI/Rsv3V4QBmZuMaTvKE2dK2TVExai651fGI/LvPaW17N0I6eGt
	 hVg2HUfkRsjv2Cx6WCrIZmtL3oQtUb6OyXw0DOS9nlgSLjCgNlFhgipKXEHdeV+BOw
	 0B4uDckaJqnRu7NIXqjzDc8WdQ+RK4aOT9EDrIFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgHXIol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:44:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728426AbgHXIog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:44:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B0E62087D;
        Mon, 24 Aug 2020 08:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258675;
        bh=jRgIWyY0b4yL1+iU+rEN7X0YTkrV7SA7WEWwegKb4Wo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GLv05kR1lWE6WrE5AooVSyROBQkbsFuDzjoOdbFbz1UxliK6VrA8nFGiD/kdj+VVa
         0C0OjG/Pc+2FzCsoAP2pE/Swlgfa5GZhfEs/E+9gla8cn+ANU8Hub44fWspLRXbO5M
         lCfowSlWWve5nuTwNU4cvBDWoDTHQYIOn3vE7Xho=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 104/124] Fix build error when CONFIG_ACPI is not set/enabled:
Date:   Mon, 24 Aug 2020 10:30:38 +0200
Message-Id: <20200824082414.534832195@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082409.368269240@linuxfoundation.org>
References: <20200824082409.368269240@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit ee87e1557c42dc9c2da11c38e11b87c311569853 ]

../arch/x86/pci/xen.c: In function ‘pci_xen_init’:
../arch/x86/pci/xen.c:410:2: error: implicit declaration of function ‘acpi_noirq_set’; did you mean ‘acpi_irq_get’? [-Werror=implicit-function-declaration]
  acpi_noirq_set();

Fixes: 88e9ca161c13 ("xen/pci: Use acpi_noirq_set() helper to avoid #ifdef")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: xen-devel@lists.xenproject.org
Cc: linux-pci@vger.kernel.org
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/pci/xen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 91220cc258547..5c11ae66b5d8e 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -26,6 +26,7 @@
 #include <asm/xen/pci.h>
 #include <asm/xen/cpuid.h>
 #include <asm/apic.h>
+#include <asm/acpi.h>
 #include <asm/i8259.h>
 
 static int xen_pcifront_enable_irq(struct pci_dev *dev)
-- 
2.25.1



