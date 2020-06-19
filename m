Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749ECC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B99321852
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592578713;
	bh=68jEasm7EoE4IDZuosu/vsoPdotMv2Vt4mpm1i3ukTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NV2elYNpD7keI9VfKovE1ArKPnwh9G0M7QqAsgjfh2xvBAvcSA2/2WZ7LEz7wY7iZ
	 DV/jt2+pBxNnjjIiGevk0DI8HPMZ7mef6pKKA1cRd3onAl64nl9ofD2pwIQjjPbuFS
	 UFwEZzT7Xc24NcZs8V2NjeAziQCssVIp4Yy2VVl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390407AbgFSO6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:58:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390375AbgFSO6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:58:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 481B121852;
        Fri, 19 Jun 2020 14:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578701;
        bh=68jEasm7EoE4IDZuosu/vsoPdotMv2Vt4mpm1i3ukTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CnAQwSOakQxPSiBSGk38adBBjOyXhBuAK6MGw4NAf3BwgCGwqgK9azgcLWOVoLvcG
         xtQk8LLdXclThkhCC6vLB3dklBPLFjMq9uf16XDE2rd4teBdSBHqABk3enNASJUqD4
         Eoky1EVYAHATqycsqa1c6QfAPNWWSx9AVZmTX/es=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.19 093/267] ACPI: GED: use correct trigger type field in _Exx / _Lxx handling
Date:   Fri, 19 Jun 2020 16:31:18 +0200
Message-Id: <20200619141653.330672568@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
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
@@ -103,7 +103,7 @@ static acpi_status acpi_ged_request_inte
 		trigger = p->triggering;
 	} else {
 		gsi = pext->interrupts[0];
-		trigger = p->triggering;
+		trigger = pext->triggering;
 	}
 
 	irq = r.start;


