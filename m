Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CA6C35666
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 19:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36BB7206ED
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 19:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IHiDd7qE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgBWTZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 14:25:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30719 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726302AbgBWTZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 14:25:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582485929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WdAkDw0jQFrUByye8xgaI8zjWL8waIYULZhRupYTANc=;
        b=IHiDd7qEhNAlRXdbCLWd6kDDeMjk9G36AlsvrsrfM+CmgCviaibZSQ0b7z6aXGVyE9oIZH
        oxc2Fpz3iEPli3LQUlN8aefXsOD0NJs/YFKT/rTLY/kP5Kdh6j4SPGI+qr3JURwvprZkDD
        A4ZM5qfqHG6f755Y9ys0iQi0FA7y0j0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-2r8xQ-VeOtOrXPcYfZce8A-1; Sun, 23 Feb 2020 14:25:26 -0500
X-MC-Unique: 2r8xQ-VeOtOrXPcYfZce8A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F1BF107ACC5;
        Sun, 23 Feb 2020 19:25:24 +0000 (UTC)
Received: from mail (ovpn-120-118.rdu2.redhat.com [10.10.120.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C33A5C1B2;
        Sun, 23 Feb 2020 19:25:21 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rafael Aquini <aquini@redhat.com>,
        Mark Salter <msalter@redhat.com>
Cc:     Jon Masters <jcm@jonmasters.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        Michal Hocko <mhocko@kernel.org>, QI Fuli <qi.fuli@fujitsu.com>
Subject: [PATCH 1/3] mm: use_mm: fix for arches checking mm_users to optimize TLB flushes
Date:   Sun, 23 Feb 2020 14:25:18 -0500
Message-Id: <20200223192520.20808-2-aarcange@redhat.com>
In-Reply-To: <20200223192520.20808-1-aarcange@redhat.com>
References: <20200223192520.20808-1-aarcange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

