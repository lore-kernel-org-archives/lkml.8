Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A27C3567B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE5020801
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813849;
	bh=kK7tM/QqgcC+v4N+ijRzV5CC218hvODOXjIg38K2DPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MwNl7Its8P2if+IQGvEoeWOmCoZSLpImTQ/eD4c3OCbxWCbAdbBPVI5w8EkW5sv6j
	 9NeNc1BWqhBPEQ4OOOlrHcnvKrNq9nIbHvM+2KuglKYNRXE2zIGWRCZWQ/n2DWM3Ma
	 bnrUxBCTCP4PPTLplOCS7+NEEetoBBZ8VlZNBYBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387622AbgB0OEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:04:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:40664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387584AbgB0OE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:04:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77C8321556;
        Thu, 27 Feb 2020 14:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812265;
        bh=kK7tM/QqgcC+v4N+ijRzV5CC218hvODOXjIg38K2DPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b7M90tUIgjR3ZD3mBZV+BMVgaBaUxqV3ARFpmM5H9bv2aTYEVyxpXNZimkqnGEOZG
         WGhbH5nmxJDhYXEdaGfQhixguj+HC38OzkBNx7U4Ra23nRz5z+La45wov/58OH6FnD
         5NS5weobpiqfVPxpNQjLA3TLyAC5mnIibw8aHyxI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zenghui Yu <yuzenghui@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.19 48/97] genirq/irqdomain: Make sure all irq domain flags are distinct
Date:   Thu, 27 Feb 2020 14:36:56 +0100
Message-Id: <20200227132222.454692653@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132214.553656188@linuxfoundation.org>
References: <20200227132214.553656188@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zenghui Yu <yuzenghui@huawei.com>

commit 2546287c5fb363a0165933ae2181c92f03e701d0 upstream.

This was noticed when printing debugfs for MSIs on my ARM64 server.  The
new dstate IRQD_MSI_NOMASK_QUIRK came out surprisingly while it should only
be the x86 stuff for the time being...

The new MSI quirk flag uses the same bit as IRQ_DOMAIN_NAME_ALLOCATED which
is oddly defined as bit 6 for no good reason.

Switch it to the non used bit 1.

Fixes: 6f1a4891a592 ("x86/apic/msi: Plug non-maskable MSI affinity race")
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20200221020725.2038-1-yuzenghui@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/irqdomain.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -188,7 +188,7 @@ enum {
 	IRQ_DOMAIN_FLAG_HIERARCHY	= (1 << 0),
 
 	/* Irq domain name was allocated in __irq_domain_add() */
-	IRQ_DOMAIN_NAME_ALLOCATED	= (1 << 6),
+	IRQ_DOMAIN_NAME_ALLOCATED	= (1 << 1),
 
 	/* Irq domain is an IPI domain with virq per cpu */
 	IRQ_DOMAIN_FLAG_IPI_PER_CPU	= (1 << 2),


