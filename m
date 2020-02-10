Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BABC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642F52070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339967;
	bh=u5gjxbGuLQJXByiCbFPs4mdb0PD/2AnCQv8x4gXAxPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AbTq8YeyKqii8aAMEpWpVre8vmrUU3uhuPrtgc6VY/FxMoCVU40ElLTyYomBekjuj
	 dYPJyN5ynO10sLeLaIXLCSoziNoYhRqw6i6RbgIsyv0JILacYZOhAzwYWocRn91rRU
	 hKbB9nawF1tXlyXKlys+anPLZqDWlid76fHDDaOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbgBJNGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:06:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:38940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729576AbgBJMj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:39:57 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 538E92465D;
        Mon, 10 Feb 2020 12:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338397;
        bh=u5gjxbGuLQJXByiCbFPs4mdb0PD/2AnCQv8x4gXAxPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lt5+eZplJcWwm4kW7ymNtmRMTGXg/qsQ0TsI+wAIlAQkpS1Zic2TRGgADnDI3Mlxk
         6TReIbuWvyRm0Zo8kRzC6VjMr4knHDo3Lw05HdkaIlnkDQ1+uw3LekUXzSRKipnVjo
         ryJ0ucf+wddlUGWIk2zi2jJtpTaP85RpzALcTgbM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 5.5 093/367] PCI: keystone: Fix error handling when "num-viewport" DT property is not populated
Date:   Mon, 10 Feb 2020 04:30:06 -0800
Message-Id: <20200210122432.949170583@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kishon Vijay Abraham I <kishon@ti.com>

commit b0de922af53eede340986a2d05b6cd4b6d6efa43 upstream.

Fix error handling when "num-viewport" DT property is not populated.

Fixes: 23284ad677a9 ("PCI: keystone: Add support for PCIe EP in AM654x Platforms")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: stable@vger.kernel.org # v5.2+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/controller/dwc/pci-keystone.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1354,7 +1354,7 @@ static int __init ks_pcie_probe(struct p
 		ret = of_property_read_u32(np, "num-viewport", &num_viewport);
 		if (ret < 0) {
 			dev_err(dev, "unable to read *num-viewport* property\n");
-			return ret;
+			goto err_get_sync;
 		}
 
 		/*


