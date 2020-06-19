Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C06C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C80920771
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592582118;
	bh=DLm3HKqtq7WOPN88gpHMGYl78gKgJxuxjEldkXM1B6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RcT23eNwgk/pKd7FiB5GddBGEYpf4n42qDAqVBwwaBdceEbC7dXd152BrXYZ4wEuo
	 H5/6q1uAc9XGCDn1Fx6qsfy1oPn0q6M62MNuhNasRNikh0xec4aonujPKZcJUC/jSC
	 uC4lvpbVj1+/wgDKBFxmG8hO9iZYukQj7vHnKVcM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392843AbgFSPVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:21:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392485AbgFSPQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:16:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBD072080C;
        Fri, 19 Jun 2020 15:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579799;
        bh=DLm3HKqtq7WOPN88gpHMGYl78gKgJxuxjEldkXM1B6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UNBV8Wwh8UXhiQLfhz9YUHfFDrW4xmhJZPBumzuh7usLzy1ySl6UEHpGBFLk+255J
         lnzavpORwhZmKq+AJB6mX1FQkqm8KzJWmS1AqWTlt5jN3pjbZFarCkiUlLBsaJs9/T
         L5eg7kruANGh9cbwJx+YQi0WZS1uHqT3GpkOsQc8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.7 001/376] ACPI: GED: use correct trigger type field in _Exx / _Lxx handling
Date:   Fri, 19 Jun 2020 16:28:39 +0200
Message-Id: <20200619141710.427881447@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

commit e5c399b0bd6490c12c0af2a9eaa9d7cd805d52c9 upstream.

Commit ea6f3af4c5e63f69 ("ACPI: GED: add support for _Exx / _Lxx handler
methods") added a reference to the 'triggering' field of either the
normal or the extended ACPI IRQ resource struct, but inadvertently used
the wrong pointer in the latter case. Note that both pointers refer to the
same union, and the 'triggering' field appears at the same offset in both
struct types, so it currently happens to work by accident. But let's fix
it nonetheless

Fixes: ea6f3af4c5e63f69 ("ACPI: GED: add support for _Exx / _Lxx handler methods")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/evged.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/acpi/evged.c
+++ b/drivers/acpi/evged.c
@@ -94,7 +94,7 @@ static acpi_status acpi_ged_request_inte
 		trigger = p->triggering;
 	} else {
 		gsi = pext->interrupts[0];
-		trigger = p->triggering;
+		trigger = pext->triggering;
 	}
 
 	irq = r.start;


