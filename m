Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2CBC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 20:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E3020720
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 20:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ff6oMpOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgBCURx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 15:17:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53037 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726250AbgBCURx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 15:17:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580761072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WdAkDw0jQFrUByye8xgaI8zjWL8waIYULZhRupYTANc=;
        b=Ff6oMpOKcL3QUT9K5r+MDf8YHMPc5daoEolmcrmPWAn+DlHcGWUo4GbUq7jiiDDc1INTyl
        iDh3j3bxmrdBBnuiJtrFCdPKAl99mnyg+E/ucHdHge1xVabE8LzgVJqsDc21swKojzICu3
        5YXsAwCvrulDv2vsBkAYNtlnQHchuyw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-LVTmi57UP5CtwO7-hrd4wA-1; Mon, 03 Feb 2020 15:17:50 -0500
X-MC-Unique: LVTmi57UP5CtwO7-hrd4wA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B667D13E5;
        Mon,  3 Feb 2020 20:17:48 +0000 (UTC)
Received: from mail (ovpn-120-67.rdu2.redhat.com [10.10.120.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D78B1001B09;
        Mon,  3 Feb 2020 20:17:46 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jon Masters <jcm@jonmasters.org>,
        Rafael Aquini <aquini@redhat.com>,
        Mark Salter <msalter@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] mm: use_mm: fix for arches checking mm_users to optimize TLB flushes
Date:   Mon,  3 Feb 2020 15:17:44 -0500
Message-Id: <20200203201745.29986-2-aarcange@redhat.com>
In-Reply-To: <20200203201745.29986-1-aarcange@redhat.com>
References: <20200203201745.29986-1-aarcange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alpha, ia64, mips, powerpc, sh, sparc are relying on a check on
mm->mm_users to know if they can skip some remote TLB flushes for
single threaded processes.

Most callers of use_mm() tend to invoke mmget_not_zero() or
get_task_mm() before use_mm() to ensure the mm will remain alive in
between use_mm() and unuse_mm().

Some callers however don't increase mm_users and they instead rely on
serialization in __mmput() to ensure the mm will remain alive in
between use_mm() and unuse_mm(). Not increasing mm_users during
use_mm() is however unsafe for aforementioned arch TLB flushes
optimizations. So either mmget()/mmput() should be added to the
problematic callers of use_mm()/unuse_mm() or we can embed them in
use_mm()/unuse_mm() which is more robust.

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 mm/mmu_context.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/mmu_context.c b/mm/mmu_context.c
index 3e612ae748e9..ced0e1218c0f 100644
--- a/mm/mmu_context.c
+++ b/mm/mmu_context.c
@@ -30,6 +30,7 @@ void use_mm(struct mm_struct *mm)
 		mmgrab(mm);
 		tsk->active_mm =3D mm;
 	}
+	mmget(mm);
 	tsk->mm =3D mm;
 	switch_mm(active_mm, mm, tsk);
 	task_unlock(tsk);
@@ -57,6 +58,7 @@ void unuse_mm(struct mm_struct *mm)
 	task_lock(tsk);
 	sync_mm_rss(mm);
 	tsk->mm =3D NULL;
+	mmput(mm);
 	/* active_mm is still 'mm' */
 	enter_lazy_tlb(mm, tsk);
 	task_unlock(tsk);

