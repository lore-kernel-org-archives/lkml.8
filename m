Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A24C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F36121BE5
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592579108;
	bh=DLm3HKqtq7WOPN88gpHMGYl78gKgJxuxjEldkXM1B6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J3hGFXRH6d1liN8OmTpu0r8hbDDNRvndQEvlQWEXebvC+YeNFnVqDCkiFFOl31Vvl
	 cRekKipKpwdKBzAg2OBfh9oCp2yG1WGDmsf+VnKMOaYsyMm+rIjF96CWpTuDhckIiw
	 Jn3XPmcQjkKVvOXBfoOqIZ6tzQySEXwxPIc6WxHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391247AbgFSPFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391231AbgFSPFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:05:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B701021852;
        Fri, 19 Jun 2020 15:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579103;
        bh=DLm3HKqtq7WOPN88gpHMGYl78gKgJxuxjEldkXM1B6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ws1fq4FxSPUd1CYDu7HUBpA4rihGPHus5DS3KwdGGPbME2A2T/eZ81SmsF2u5uksq
         1VC+O8ze+9m+Mu019vkF3WPzR01HZ2dd3TRXKZyzhjvLR7r/r41jCE1zddxNvaj9L7
         JsC6x5zKMGcthiaYP7yeWS4d6S+b2gPximV7D7Yc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.4 001/261] ACPI: GED: use correct trigger type field in _Exx / _Lxx handling
Date:   Fri, 19 Jun 2020 16:30:12 +0200
Message-Id: <20200619141649.952696332@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141649.878808811@linuxfoundation.org>
References: <20200619141649.878808811@linuxfoundation.org>
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


