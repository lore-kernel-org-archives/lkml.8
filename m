Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91712C54FCC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6282B2078E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="kxQ9fcFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgDTHMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 03:12:35 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:58892 "EHLO
        vultr.net.flygoat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgDTHMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 03:12:35 -0400
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id B7A1520C7E;
        Mon, 20 Apr 2020 07:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1587366752; bh=1ni7V2KVE9MknDP4f9hczijTI6TI6s7uclRiTdIqcpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kxQ9fcFfuGwyQAlL0SBOY9EXY/jwSt5K3Wl2FGyOzlhWgzQgv3bu+3KwtQNmIW8Wt
         ditpsAPeT7OK5Y5atMvUwt0kqqd56FuPrusBF5WgyrjckNZQD8zIa4o6Yfgkd6CZOH
         3ekMfJ54qS3zJ9f1iW/dQu0rbQB6yve4Z+36QAoiqgq0ly8464rSM6zEs/j5P0FQhz
         bO/h0hh59EJ9osGFreFpiu6bZRzQlhd7UoEqSJMe2sJ2N88uRLyMb3wtQKxowNOvg0
         sop/ecLF0Rp/yfYbz+qUJHZd9jV2BD2ZE/PazJ7W55TVXdG29+qWEF4AYLgN5qEEcs
         dwwZOokLkRQ8w==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Paul Burton <paulburton@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] PCI: OF: Don't remap iospace on unsupported platform
Date:   Mon, 20 Apr 2020 15:12:07 +0800
Message-Id: <20200420071220.155357-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200330114239.1112759-1-jiaxun.yang@flygoat.com>
References: <20200330114239.1112759-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some platforms don't support iospace remapping
like MIPS. However, our PCI code will try to remap iospace
unconditionally and reject io resources on these platforms.

So we should remove iospace remapping check and use a range
check instead on these platforms.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
--
v4: Fix a typo in commit message.
---
 drivers/pci/of.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 81ceeaa6f1d5..36e8761b66c6 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -547,12 +547,21 @@ int pci_parse_request_of_pci_ranges(struct device *dev,
 
 		switch (resource_type(res)) {
 		case IORESOURCE_IO:
+#if defined(PCI_IOBASE) && defined(CONFIG_MMU)
 			err = devm_pci_remap_iospace(dev, res, iobase);
 			if (err) {
 				dev_warn(dev, "error %d: failed to map resource %pR\n",
 					 err, res);
 				resource_list_destroy_entry(win);
 			}
+#else
+			/* Simply check if IO is inside the range */
+			if (res->end > IO_SPACE_LIMIT) {
+				dev_warn(dev, "resource %pR out of the IO range\n",
+					res);
+				resource_list_destroy_entry(win);
+			}
+#endif
 			break;
 		case IORESOURCE_MEM:
 			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
-- 
2.26.0.rc2

