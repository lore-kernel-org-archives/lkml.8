Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F4FC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7252072B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217570;
	bh=SsX/k2xeN4IXLK0x1RYt3G4o6ggs1tN8WKdreVTRxjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q9+x7Eb3RvMCWy1MjYuoBHPG7kU/8ybcEwB/pA6Hq7hJuzL4wDH1SJjlyDvjYynfI
	 O1UKrDOSwvwu3iI6DINlIjscQsL3MD3ZcwEDC13Gr6hWbc1qK+PzT3u4IHFJsHzR3Z
	 qYSTlv3usI454mhta78sX3AI/LMU547MN1X1D85w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404206AbgAPXct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:32:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:42298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391596AbgAPXcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:32:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BCA72073A;
        Thu, 16 Jan 2020 23:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217560;
        bh=SsX/k2xeN4IXLK0x1RYt3G4o6ggs1tN8WKdreVTRxjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HnjJ+jYSkTlQgRwCeTpgW79WcRw5tSmQpf/0CKBSD/nsKkgkfGpPWOknMFhv941ML
         trSDVDh6MTmoOPpp/jpmRI84Veq3wbaH2pq5rAxGGXHnzSNur8dKi1rUwJNQBpnIoT
         MzRCq9oulU78PLmfyyKfwiTygOpgGudOh4TM4PiU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Jonathan Yong <jonathan.yong@intel.com>
Subject: [PATCH 4.14 48/71] PCI/PTM: Remove spurious "d" from granularity message
Date:   Fri, 17 Jan 2020 00:18:46 +0100
Message-Id: <20200116231716.342882466@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231709.377772748@linuxfoundation.org>
References: <20200116231709.377772748@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

commit 127a7709495db52a41012deaebbb7afc231dad91 upstream.

The granularity message has an extra "d":

  pci 0000:02:00.0: PTM enabled, 4dns granularity

Remove the "d" so the message is simply "PTM enabled, 4ns granularity".

Fixes: 8b2ec318eece ("PCI: Add PTM clock granularity information")
Link: https://lore.kernel.org/r/20191106222420.10216-2-helgaas@kernel.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Cc: Jonathan Yong <jonathan.yong@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/pcie/ptm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -29,7 +29,7 @@ static void pci_ptm_info(struct pci_dev
 		snprintf(clock_desc, sizeof(clock_desc), ">254ns");
 		break;
 	default:
-		snprintf(clock_desc, sizeof(clock_desc), "%udns",
+		snprintf(clock_desc, sizeof(clock_desc), "%uns",
 			 dev->ptm_granularity);
 		break;
 	}


