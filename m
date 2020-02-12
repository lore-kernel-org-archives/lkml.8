Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12F9C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C159120675
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H1jHkzVf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgBLLEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:04:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37220 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727347AbgBLLEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 06:04:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581505474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=adywfWdVjvKQEdzkL3wNz16CH2RMtcYzjA3EP8nYGYg=;
        b=H1jHkzVfdT9gwwncozqWEnJz5gTdHt11CVQ0yCQxQs41bcPyzdVCUPJz+QYR6Q3jSysif9
        4JyPXPDS/j7YMt9lF8MmaZFOtxFUb1jC40X5YT3HXrYIsnavJJlR1onh9SLfH1i4Fb3RsP
        86klN1KweD996Kt9DDbcWQllL01JT5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-Y6ThY3jeNY-8TpMpg-ZMmg-1; Wed, 12 Feb 2020 06:04:32 -0500
X-MC-Unique: Y6ThY3jeNY-8TpMpg-ZMmg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DF00801E67;
        Wed, 12 Feb 2020 11:04:31 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-206.pek2.redhat.com [10.72.12.206])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C62F626FA9;
        Wed, 12 Feb 2020 11:04:28 +0000 (UTC)
Date:   Wed, 12 Feb 2020 19:04:24 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
Subject: [PATCH] x86/kexec: do not reserve kexec setup_data in kexec e820
 table
Message-ID: <20200212110424.GA2938@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The e820 table for kexec kernel always takes setup_data as reserved.
It is reasonable for the setup_data passed by the 1st kernel boot loader,
for example SETUP_PCI etc.  But SETUP_EFI is used by kexec itself to
enable EFI in 2nd kernel, also kexec setups it every time. Thus it
is pointless to reserve kexec prepared setup_data.

1st physical boot: no SETUP_EFI
kexec load new kernel and prepare a SETUP_EFI setup_data, then reboot
 -> 2nd kernel sees SETUP_EFI, reserves in both e820 and kexec e820
    another kexec load prepare a new SETUP_EFI, then reboot
    -> 3rd kernel has two SETUP_EFI ranges reserved
       -> and so on..

Thus skip SETUP_EFI while reserving setup_data for kexec kernel.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 arch/x86/kernel/e820.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-x86.orig/arch/x86/kernel/e820.c
+++ linux-x86/arch/x86/kernel/e820.c
@@ -999,7 +999,9 @@ void __init e820__reserve_setup_data(voi
 	while (pa_data) {
 		data = early_memremap(pa_data, sizeof(*data));
 		e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
-		e820__range_update_kexec(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
+		/* Skip kexec passed setup_data */
+		if (data->type != SETUP_EFI)
+			e820__range_update_kexec(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
 
 		if (data->type == SETUP_INDIRECT &&
 		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {

