Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1D9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D62A20888
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590579437;
	bh=cSNlxUzk0MNNvImhPNGTduznUBJKKonX/iJwL6eba6Q=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Cd2t9T9VQyrX740rEyOx9BqoAk5mSbGg/9YMR3STrGIXjc5AFxYFenPR18la7MbKi
	 NmhDCj/kBfJyDPgrat6K/jr+qnIOjIgkoLLjK9K1DZJhXNHoAfI9AgQP6z2LJhsVb0
	 hUk/ICrEw5zMWDpye7KRUd+ytmkeaZ+rRf2LK89E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgE0LhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:37:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729506AbgE0LhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:37:11 -0400
Received: from e123331-lin.nice.arm.com (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47E26207D3;
        Wed, 27 May 2020 11:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590579431;
        bh=cSNlxUzk0MNNvImhPNGTduznUBJKKonX/iJwL6eba6Q=;
        h=From:To:Cc:Subject:Date:From;
        b=0lpjpCJAUvcWP3uE4bzBhrb1CA4JE/+j20vdEJ0Q6Fp4IY9X6hEQtgOfF7Afvxlco
         vGO/CTH/IHkSy0OUAGM+PQysna3MWvxqFur8ScxiLHNtdjBmmpgx/yczMKU/zL2w5N
         23nDZ6TZpQFACmCdjUZASBxc4dzprJIau03znPaM=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-acpi@vger.kernel.org
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] ACPI: GED: use correct trigger type field in  _Exx / _Lxx handling
Date:   Wed, 27 May 2020 13:37:00 +0200
Message-Id: <20200527113700.3579-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ea6f3af4c5e63f69 ("ACPI: GED: add support for _Exx / _Lxx handler
methods") added a reference to the 'triggering' field of either the
normal or the extended ACPI IRQ resource struct, but inadvertently used
the wrong pointer in the latter case. Note that both pointers refer to the
same union, and the 'triggering' field appears at the same offset in both
struct types, so it currently happens to work by accident. But let's fix
it nonetheless

Fixes: ea6f3af4c5e63f69 ("ACPI: GED: add support for _Exx / _Lxx handler methods")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/acpi/evged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/evged.c b/drivers/acpi/evged.c
index 6d7a522952bf..ccd900690b6f 100644
--- a/drivers/acpi/evged.c
+++ b/drivers/acpi/evged.c
@@ -94,7 +94,7 @@ static acpi_status acpi_ged_request_interrupt(struct acpi_resource *ares,
 		trigger = p->triggering;
 	} else {
 		gsi = pext->interrupts[0];
-		trigger = p->triggering;
+		trigger = pext->triggering;
 	}
 
 	irq = r.start;
-- 
2.17.1

