Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9455BC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 700BE206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tt2cnsD4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgD1Jic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 05:38:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46403 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727042AbgD1Jic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 05:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588066711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GHLz6Oma6lnEz6CF59eL8wv63IEd2b1tFMZIgRE44RQ=;
        b=Tt2cnsD4DBQ55O+KUHkCMUX5UfPNmX7uH0qvHVPp5a4Pb1Di2l2x908kyCyxJPA6f8ArnM
        idH7o406pMXD4I16kQJbQTnYX17+TWMq2ZLyh+VLAYgjkF8mq1QbaN27fDlZUpdxUK/7qm
        k12lbjEfNFFioXJkQKl6LLWAV5UZw9c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-wRDLAkrVNEKM_0pgMl--kQ-1; Tue, 28 Apr 2020 05:38:29 -0400
X-MC-Unique: wRDLAkrVNEKM_0pgMl--kQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CFB418B6426;
        Tue, 28 Apr 2020 09:38:28 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD9375D715;
        Tue, 28 Apr 2020 09:38:25 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH v2 0/3] x86/idt: Minor alloc_intr_gate() sanitization
Date:   Tue, 28 Apr 2020 11:38:21 +0200
Message-Id: <20200428093824.1451532-1-vkuznets@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a successor of "[PATCH] x86/idt: Keep spurious entries uns=
et
in system_vectors".

The original issue I tried to address was that /proc/interrupts output
was always containing all possible system vectors, including non allocate=
d
ones (e.g. 'Hypervisor callback interrupts' on bare metal). Thomas
suggested to expand this cosmetic change to making alloc_intr_gate()
__init.

Vitaly Kuznetsov (3):
  x86/xen: Split HVM vector callback setup and interrupt gate allocation
  x86/idt: Annotate alloc_intr_gate() with __init
  x86/idt: Keep spurious entries unset in system_vectors

 arch/x86/kernel/idt.c            | 22 ++++++++++++++++++----
 arch/x86/xen/suspend_hvm.c       |  2 +-
 arch/x86/xen/xen-ops.h           |  2 +-
 drivers/xen/events/events_base.c | 28 +++++++++++++++++-----------
 4 files changed, 37 insertions(+), 17 deletions(-)

--=20
2.25.3

